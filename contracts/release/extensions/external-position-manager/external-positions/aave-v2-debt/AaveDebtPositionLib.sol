// SPDX-License-Identifier: GPL-3.0

/*
    This file is part of the Enzyme Protocol.
    (c) Enzyme Foundation <security@enzyme.finance>
    For the full license information, please view the LICENSE
    file that was distributed with this source code.
*/

pragma solidity 0.6.12;

import {IAaveV2IncentivesController} from "../../../../../external-interfaces/IAaveV2IncentivesController.sol";
import {IAaveV2LendingPool} from "../../../../../external-interfaces/IAaveV2LendingPool.sol";
import {IAaveV2LendingPoolAddressProvider} from
    "../../../../../external-interfaces/IAaveV2LendingPoolAddressProvider.sol";
import {IAaveV2ProtocolDataProvider} from "../../../../../external-interfaces/IAaveV2ProtocolDataProvider.sol";
import {IERC20} from "../../../../../external-interfaces/IERC20.sol";
import {AddressArrayLib} from "../../../../../utils/0.6.12/AddressArrayLib.sol";
import {AssetHelpers} from "../../../../../utils/0.6.12/AssetHelpers.sol";
import {WrappedSafeERC20 as SafeERC20} from "../../../../../utils/0.6.12/open-zeppelin/WrappedSafeERC20.sol";
import {AaveDebtPositionLibBase1} from "./bases/AaveDebtPositionLibBase1.sol";
import {AaveDebtPositionDataDecoder} from "./AaveDebtPositionDataDecoder.sol";
import {IAaveDebtPosition} from "./IAaveDebtPosition.sol";

/// @title AaveDebtPositionLib Contract
/// @author Enzyme Foundation <security@enzyme.finance>
/// @notice An External Position library contract for Aave debt positions
contract AaveDebtPositionLib is
    AaveDebtPositionLibBase1,
    IAaveDebtPosition,
    AaveDebtPositionDataDecoder,
    AssetHelpers
{
    using AddressArrayLib for address[];
    using SafeERC20 for IERC20;

    uint16 private constant AAVE_REFERRAL_CODE = 158;

    address private immutable AAVE_DATA_PROVIDER;
    address private immutable AAVE_INCENTIVES_CONTROLLER;
    address private immutable AAVE_LENDING_POOL_ADDRESS_PROVIDER;

    uint256 private constant VARIABLE_INTEREST_RATE = 2;

    constructor(address _aaveDataProvider, address _aaveLendingPoolAddressProvider, address _aaveIncentivesController)
        public
    {
        AAVE_DATA_PROVIDER = _aaveDataProvider;
        AAVE_LENDING_POOL_ADDRESS_PROVIDER = _aaveLendingPoolAddressProvider;
        AAVE_INCENTIVES_CONTROLLER = _aaveIncentivesController;
    }

    /// @notice Initializes the external position
    /// @dev Nothing to initialize for this contract
    function init(bytes memory) external override {}

    /// @notice Receives and executes a call from the Vault
    /// @param _actionData Encoded data to execute the action
    function receiveCallFromVault(bytes memory _actionData) external override {
        (uint256 actionId, bytes memory actionArgs) = abi.decode(_actionData, (uint256, bytes));

        if (actionId == uint256(Actions.AddCollateral)) {
            __addCollateralAssets(actionArgs);
        } else if (actionId == uint256(Actions.RemoveCollateral)) {
            __removeCollateralAssets(actionArgs);
        } else if (actionId == uint256(Actions.Borrow)) {
            __borrowAssets(actionArgs);
        } else if (actionId == uint256(Actions.RepayBorrow)) {
            __repayBorrowedAssets(actionArgs);
        } else if (actionId == uint256(Actions.ClaimRewards)) {
            __claimRewards(actionArgs);
        } else {
            revert("receiveCallFromVault: Invalid actionId");
        }
    }

    /// @dev Receives and adds aTokens as collateral
    function __addCollateralAssets(bytes memory actionArgs) private {
        (address[] memory aTokens,) = __decodeAddCollateralActionArgs(actionArgs);

        for (uint256 i; i < aTokens.length; i++) {
            if (!assetIsCollateral(aTokens[i])) {
                collateralAssets.push(aTokens[i]);
                emit CollateralAssetAdded(aTokens[i]);
            }
        }
    }

    /// @dev Borrows assets using the available collateral
    function __borrowAssets(bytes memory actionArgs) private {
        (address[] memory tokens, uint256[] memory amounts) = __decodeBorrowActionArgs(actionArgs);

        address lendingPoolAddress =
            IAaveV2LendingPoolAddressProvider(AAVE_LENDING_POOL_ADDRESS_PROVIDER).getLendingPool();

        for (uint256 i; i < tokens.length; i++) {
            IAaveV2LendingPool(lendingPoolAddress).borrow(
                tokens[i], amounts[i], VARIABLE_INTEREST_RATE, AAVE_REFERRAL_CODE, address(this)
            );

            IERC20(tokens[i]).safeTransfer(msg.sender, amounts[i]);

            if (!assetIsBorrowed(tokens[i])) {
                // Store the debt token as a flag that the token is now a borrowed asset
                (,, address debtToken) =
                    IAaveV2ProtocolDataProvider(AAVE_DATA_PROVIDER).getReserveTokensAddresses(tokens[i]);
                borrowedAssetToDebtToken[tokens[i]] = debtToken;

                borrowedAssets.push(tokens[i]);
                emit BorrowedAssetAdded(tokens[i]);
            }
        }
    }

    /// @dev Claims all rewards accrued and send it to the Vault
    function __claimRewards(bytes memory actionArgs) private {
        address[] memory assets = __decodeClaimRewardsActionArgs(actionArgs);

        IAaveV2IncentivesController(AAVE_INCENTIVES_CONTROLLER).claimRewards(assets, type(uint256).max, msg.sender);
    }

    /// @dev Removes assets from collateral
    function __removeCollateralAssets(bytes memory actionArgs) private {
        (address[] memory aTokens, uint256[] memory amounts) = __decodeRemoveCollateralActionArgs(actionArgs);

        for (uint256 i; i < aTokens.length; i++) {
            require(assetIsCollateral(aTokens[i]), "__removeCollateralAssets: Invalid collateral asset");

            uint256 collateralBalance = IERC20(aTokens[i]).balanceOf(address(this));

            if (amounts[i] == type(uint256).max) {
                amounts[i] = collateralBalance;
            }

            // If the full collateral of an asset is removed, it can be removed from collateral assets
            if (amounts[i] == collateralBalance) {
                collateralAssets.removeStorageItem(aTokens[i]);
                emit CollateralAssetRemoved(aTokens[i]);
            }

            IERC20(aTokens[i]).safeTransfer(msg.sender, amounts[i]);
        }
    }

    /// @dev Repays borrowed assets, reducing the borrow balance
    function __repayBorrowedAssets(bytes memory actionArgs) private {
        (address[] memory tokens, uint256[] memory amounts) = __decodeRepayBorrowActionArgs(actionArgs);

        address lendingPoolAddress =
            IAaveV2LendingPoolAddressProvider(AAVE_LENDING_POOL_ADDRESS_PROVIDER).getLendingPool();

        for (uint256 i; i < tokens.length; i++) {
            require(assetIsBorrowed(tokens[i]), "__repayBorrowedAssets: Invalid borrowed asset");

            __approveAssetMaxAsNeeded(tokens[i], lendingPoolAddress, amounts[i]);

            IAaveV2LendingPool(lendingPoolAddress).repay(tokens[i], amounts[i], VARIABLE_INTEREST_RATE, address(this));

            uint256 remainingBalance = IERC20(tokens[i]).balanceOf(address(this));

            if (remainingBalance > 0) {
                IERC20(tokens[i]).safeTransfer(msg.sender, remainingBalance);
            }

            // Remove borrowed asset state from storage, if there is no remaining borrowed balance
            if (IERC20(getDebtTokenForBorrowedAsset(tokens[i])).balanceOf(address(this)) == 0) {
                delete borrowedAssetToDebtToken[tokens[i]];
                borrowedAssets.removeStorageItem(tokens[i]);
                emit BorrowedAssetRemoved(tokens[i]);
            }
        }
    }

    ////////////////////
    // POSITION VALUE //
    ////////////////////

    /// @notice Retrieves the debt assets (negative value) of the external position
    /// @return assets_ Debt assets
    /// @return amounts_ Debt asset amounts
    function getDebtAssets() external override returns (address[] memory assets_, uint256[] memory amounts_) {
        assets_ = borrowedAssets;
        amounts_ = new uint256[](assets_.length);

        for (uint256 i; i < assets_.length; i++) {
            amounts_[i] = IERC20(getDebtTokenForBorrowedAsset(assets_[i])).balanceOf(address(this));
        }

        return (assets_, amounts_);
    }

    /// @notice Retrieves the managed assets (positive value) of the external position
    /// @return assets_ Managed assets
    /// @return amounts_ Managed asset amounts
    function getManagedAssets() external override returns (address[] memory assets_, uint256[] memory amounts_) {
        assets_ = collateralAssets;
        amounts_ = new uint256[](collateralAssets.length);

        for (uint256 i; i < assets_.length; i++) {
            amounts_[i] = IERC20(assets_[i]).balanceOf(address(this));
        }

        return (assets_, amounts_);
    }

    ///////////////////
    // STATE GETTERS //
    ///////////////////

    /// @dev Checks whether an asset is borrowed
    /// @return isBorrowed_ True if the asset is part of the borrowed assets of the external position
    function assetIsBorrowed(address _asset) public view returns (bool isBorrowed_) {
        return getDebtTokenForBorrowedAsset(_asset) != address(0);
    }

    /// @notice Checks whether an asset is collateral
    /// @return isCollateral_ True if the asset is part of the collateral assets of the external position
    function assetIsCollateral(address _asset) public view returns (bool isCollateral_) {
        return collateralAssets.contains(_asset);
    }

    /// @notice Gets the debt token associated with a specified asset that has been borrowed
    /// @param _borrowedAsset The asset that has been borrowed
    /// @return debtToken_ The associated debt token
    /// @dev Returns empty if _borrowedAsset is not a valid borrowed asset
    function getDebtTokenForBorrowedAsset(address _borrowedAsset) public view override returns (address debtToken_) {
        return borrowedAssetToDebtToken[_borrowedAsset];
    }
}