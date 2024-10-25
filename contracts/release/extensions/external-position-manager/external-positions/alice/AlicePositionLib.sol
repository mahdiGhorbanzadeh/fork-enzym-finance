// SPDX-License-Identifier: GPL-3.0

/*
    This file is part of the Enzyme Protocol.
    (c) Enzyme Foundation <security@enzyme.finance>
    For the full license information, please view the LICENSE
    file that was distributed with this source code.
*/

pragma solidity 0.8.19;

import {Address} from "openzeppelin-solc-0.8/utils/Address.sol";
import {IAliceOrderManager} from "../../../../../external-interfaces/IAliceOrderManager.sol";
import {IERC20} from "../../../../../external-interfaces/IERC20.sol";
import {IWETH} from "../../../../../external-interfaces/IWETH.sol";
import {AddressArrayLib} from "../../../../../utils/0.8.19/AddressArrayLib.sol";
import {Uint256ArrayLib} from "../../../../../utils/0.8.19/Uint256ArrayLib.sol";
import {AssetHelpers} from "../../../../../utils/0.8.19/AssetHelpers.sol";
import {WrappedSafeERC20 as SafeERC20} from "../../../../../utils/0.8.19/open-zeppelin/WrappedSafeERC20.sol";
import {AlicePositionLibBase1} from "./bases/AlicePositionLibBase1.sol";
import {IAlicePosition} from "./IAlicePosition.sol";

/// @title AlicePositionLib Contract
/// @author Enzyme Foundation <security@enzyme.finance>
/// @notice An External Position library contract for Alice positions
contract AlicePositionLib is IAlicePosition, AlicePositionLibBase1, AssetHelpers {
    using AddressArrayLib for address[];
    using SafeERC20 for IERC20;
    using Uint256ArrayLib for uint256[];

    address private constant ALICE_NATIVE_ASSET_ADDRESS = 0x0000000000000000000000000000000000000000;
    IAliceOrderManager private immutable ALICE_ORDER_MANAGER;
    IWETH private immutable WRAPPED_NATIVE_TOKEN;

    error InvalidActionId();

    error OrderNotSettledOrCancelled();

    constructor(address _aliceOrderManagerAddress, address _wrappedNativeAssetAddress) {
        ALICE_ORDER_MANAGER = IAliceOrderManager(_aliceOrderManagerAddress);
        WRAPPED_NATIVE_TOKEN = IWETH(_wrappedNativeAssetAddress);
    }

    /// @notice Initializes the external position
    /// @dev Nothing to initialize for this contract
    function init(bytes memory) external override {}

    /// @notice Receives and executes a call from the Vault
    /// @param _actionData Encoded data to execute the action
    function receiveCallFromVault(bytes memory _actionData) external override {
        (uint256 actionId, bytes memory actionArgs) = abi.decode(_actionData, (uint256, bytes));

        if (actionId == uint256(Actions.PlaceOrder)) {
            __placeOrder(actionArgs);
        } else if (actionId == uint256(Actions.Sweep)) {
            __sweep(actionArgs);
        } else if (actionId == uint256(Actions.RefundOrder)) {
            __refundOrder(actionArgs);
        } else {
            revert InvalidActionId();
        }
    }

    /// @dev Helper to place an order on the Alice Order Manager
    function __placeOrder(bytes memory _actionArgs) private {
        IAlicePosition.PlaceOrderActionArgs memory placeOrderArgs =
            abi.decode(_actionArgs, (IAlicePosition.PlaceOrderActionArgs));

        IAliceOrderManager.Instrument memory instrument =
            ALICE_ORDER_MANAGER.getInstrument(placeOrderArgs.instrumentId, true);

        address outgoingAssetAddress = placeOrderArgs.isBuyOrder ? instrument.quote : instrument.base;
        address incomingAssetAddress = placeOrderArgs.isBuyOrder ? instrument.base : instrument.quote;

        uint256 nativeAssetAmount;
        if (outgoingAssetAddress == ALICE_NATIVE_ASSET_ADDRESS) {
            // If spendAsset is the native asset, unwrap WETH.
            nativeAssetAmount = placeOrderArgs.quantityToSell;
            WRAPPED_NATIVE_TOKEN.withdraw(placeOrderArgs.quantityToSell);
        } else {
            // Approve the spend asset
            IERC20(outgoingAssetAddress).safeApprove({
                _spender: address(ALICE_ORDER_MANAGER),
                _value: placeOrderArgs.quantityToSell
            });
        }

        // Place the order
        ALICE_ORDER_MANAGER.placeOrder{value: nativeAssetAmount}({
            _instrumentId: placeOrderArgs.instrumentId,
            _isBuyOrder: placeOrderArgs.isBuyOrder,
            _quantityToSell: placeOrderArgs.quantityToSell,
            _limitAmountToGet: placeOrderArgs.limitAmountToGet
        });

        __addOrder({
            _orderDetails: OrderDetails({
                outgoingAssetAddress: outgoingAssetAddress,
                incomingAssetAddress: incomingAssetAddress,
                outgoingAmount: placeOrderArgs.quantityToSell
            })
        });
    }

    /// @dev Helper to sweep balance from settled or cancelled orders and clear storage
    function __sweep(bytes memory _actionsArgs) private {
        IAlicePosition.SweepActionArgs memory sweepArgs = abi.decode(_actionsArgs, (IAlicePosition.SweepActionArgs));

        for (uint256 i; i < sweepArgs.orderIds.length; i++) {
            uint256 orderId = sweepArgs.orderIds[i];

            if (!__isOrderSettledOrCancelled({_orderId: orderId})) {
                revert OrderNotSettledOrCancelled();
            }

            OrderDetails memory orderDetails = getOrderDetails({_orderId: orderId});

            __removeOrder({_orderId: orderId});

            // If the order is settled or cancelled, the EP could have received:
            // The incomingAsset if the order has been settled
            // The outgoingAsset if the order has been cancelled
            __retrieveAssetBalance({_asset: IERC20(orderDetails.incomingAssetAddress)});
            __retrieveAssetBalance({_asset: IERC20(orderDetails.outgoingAssetAddress)});
        }
    }

    /// @dev Helper to refund an outstanding order
    function __refundOrder(bytes memory _actionsArgs) private {
        IAlicePosition.RefundOrderActionArgs memory refundOrderArgs =
            abi.decode(_actionsArgs, (IAlicePosition.RefundOrderActionArgs));

        OrderDetails memory orderDetails = getOrderDetails({_orderId: refundOrderArgs.orderId});

        // Remove the order from storage
        __removeOrder({_orderId: refundOrderArgs.orderId});

        // Refund the order
        ALICE_ORDER_MANAGER.refundOrder({
            _orderId: refundOrderArgs.orderId,
            _user: address(this),
            _instrumentId: refundOrderArgs.instrumentId,
            _isBuyOrder: refundOrderArgs.isBuyOrder,
            _quantityToSell: refundOrderArgs.quantityToSell,
            _limitAmountToGet: refundOrderArgs.limitAmountToGet,
            _timestamp: refundOrderArgs.timestamp
        });

        // Return the refunded outgoing asset back to the vault
        IERC20 outgoingAsset = IERC20(orderDetails.outgoingAssetAddress);

        if (address(outgoingAsset) == ALICE_NATIVE_ASSET_ADDRESS) {
            Address.sendValue(payable(msg.sender), address(this).balance);
        } else {
            outgoingAsset.safeTransfer(msg.sender, outgoingAsset.balanceOf(address(this)));
        }
    }

    /// @dev Helper to add the orderId to storage
    function __addOrder(OrderDetails memory _orderDetails) private {
        uint256 orderId = ALICE_ORDER_MANAGER.getMostRecentOrderId();

        orderIds.push(orderId);
        orderIdToOrderDetails[orderId] = _orderDetails;

        emit OrderIdAdded(orderId, _orderDetails);
    }

    /// @dev Helper to check whether an order has settled or been cancelled
    function __isOrderSettledOrCancelled(uint256 _orderId) private view returns (bool isSettledOrCancelled_) {
        // When an order has been settled or cancelled, its orderHash getter will throw
        try ALICE_ORDER_MANAGER.getOrderHash({_orderId: _orderId}) {
            return false;
        } catch {
            return true;
        }
    }

    /// @dev Helper to remove the orderId from storage
    function __removeOrder(uint256 _orderId) private {
        orderIds.removeStorageItem(_orderId);

        // Reset the mapping
        delete orderIdToOrderDetails[_orderId];

        emit OrderIdRemoved(_orderId);
    }

    /// @dev Helper to send the balance of an Alice order asset to the Vault
    function __retrieveAssetBalance(IERC20 _asset) private {
        uint256 balance =
            address(_asset) == ALICE_NATIVE_ASSET_ADDRESS ? address(this).balance : _asset.balanceOf(address(this));

        if (balance > 0) {
            // Transfer the asset
            if (address(_asset) == ALICE_NATIVE_ASSET_ADDRESS) {
                Address.sendValue(payable(msg.sender), balance);
            } else {
                _asset.safeTransfer(msg.sender, balance);
            }
        }
    }

    ////////////////////
    // POSITION VALUE //
    ////////////////////

    /// @notice Retrieves the debt assets (negative value) of the external position
    /// @return assets_ Debt assets
    /// @return amounts_ Debt asset amounts
    function getDebtAssets() external view override returns (address[] memory assets_, uint256[] memory amounts_) {}

    /// @notice Retrieves the managed assets (positive value) of the external position
    /// @return assets_ Managed assets
    /// @return amounts_ Managed asset amounts
    /// @dev There are 2 ways that positive value can be contributed to this position
    /// 1. Tokens held by the EP either as a result of order settlements or as a result of order cancellations
    /// 2. Tokens held in pending (unfulfilled and uncancelled) orders
    function getManagedAssets() external view override returns (address[] memory assets_, uint256[] memory amounts_) {
        uint256[] memory orderIdsMem = getOrderIds();

        address[] memory receivableAssets;

        for (uint256 i; i < orderIdsMem.length; i++) {
            OrderDetails memory orderDetails = getOrderDetails({_orderId: orderIdsMem[i]});

            bool settledOrCancelled = __isOrderSettledOrCancelled({_orderId: orderIdsMem[i]});

            // If the order is settled or cancelled, the EP will have received the incomingAsset or the outgoingAsset
            // Incoming assets can be received through order settlements
            // Outgoing assets can be received back through order cancellations
            // We have no way of differentiating between the two, so we must add both to the expected assets
            if (settledOrCancelled) {
                receivableAssets = receivableAssets.addUniqueItem(orderDetails.outgoingAssetAddress);
                receivableAssets = receivableAssets.addUniqueItem(orderDetails.incomingAssetAddress);
            } else {
                // If the order is not settled, value the position for its refundable value
                assets_ = assets_.addItem(
                    orderDetails.outgoingAssetAddress == ALICE_NATIVE_ASSET_ADDRESS
                        ? address(WRAPPED_NATIVE_TOKEN)
                        : orderDetails.outgoingAssetAddress
                );
                amounts_ = amounts_.addItem(orderDetails.outgoingAmount);
            }
        }

        // Check the balance EP balance of each asset that could be received
        for (uint256 i; i < receivableAssets.length; i++) {
            address receivableAssetAddress = receivableAssets[i];

            uint256 balance = receivableAssetAddress == ALICE_NATIVE_ASSET_ADDRESS
                ? address(this).balance
                : IERC20(receivableAssetAddress).balanceOf(address(this));

            if (balance == 0) {
                continue;
            }

            assets_ = assets_.addItem(
                receivableAssetAddress == ALICE_NATIVE_ASSET_ADDRESS
                    ? address(WRAPPED_NATIVE_TOKEN)
                    : receivableAssetAddress
            );
            amounts_ = amounts_.addItem(balance);
        }

        return __aggregateAssetAmounts({_rawAssets: assets_, _rawAmounts: amounts_});
    }

    ///////////////////
    // STATE GETTERS //
    ///////////////////

    /// @notice Get the orderDetails of a specified orderId
    /// @return orderDetails_ The orderDetails
    function getOrderDetails(uint256 _orderId) public view override returns (OrderDetails memory orderDetails_) {
        return orderIdToOrderDetails[_orderId];
    }

    /// @notice Get the pending orderIds of the external position
    /// @return orderIds_ The orderIds
    function getOrderIds() public view override returns (uint256[] memory orderIds_) {
        return orderIds;
    }
}
