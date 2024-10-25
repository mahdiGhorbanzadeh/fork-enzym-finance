// SPDX-License-Identifier: GPL-3.0

/*
    This file is part of the Enzyme Protocol.

    (c) Enzyme Foundation <security@enzyme.finance>

    For the full license information, please view the LICENSE
    file that was distributed with this source code.
*/

pragma solidity >=0.6.0 <0.9.0;
pragma experimental ABIEncoderV2;

import {IVault} from "../vault/IVault.sol";

/// @title IComptroller Interface
/// @author Enzyme Foundation <security@enzyme.finance>
interface IComptroller {
    struct ConfigInput {
        // The asset in which the fund's value should be denominated
        address denominationAsset;
        // A timelock after the last time shares were bought for an account
        // that must expire before that account transfers or redeems their shares
        uint256 sharesActionTimelock;
        // Encoded data for the fees to be enabled for the fund
        bytes feeManagerConfigData;
        // Encoded data for the policies to be enabled for the fund
        bytes policyManagerConfigData;
        // Arbitrary extensions to be enabled for the fund
        ExtensionConfigInput[] extensionsConfig;
    }

    struct ExtensionConfigInput {
        // The extension address
        address extension;
        // Encoded data for the extension-specific config
        bytes configData;
    }

    function activate() external;

    function buyBackProtocolFeeShares(uint256 _sharesAmount) external;

    function buyShares(uint256 _investmentAmount, uint256 _minSharesQuantity)
        external
        returns (uint256 sharesReceived_);

    function buySharesOnBehalf(address _buyer, uint256 _investmentAmount, uint256 _minSharesQuantity)
        external
        returns (uint256 sharesReceived_);

    function calcGav() external returns (uint256 gav_);

    function calcGrossShareValue() external returns (uint256 grossShareValue_);

    function callOnExtension(address _extension, uint256 _actionId, bytes calldata _callArgs) external;

    function deactivate() external;

    function doesAutoProtocolFeeSharesBuyback() external view returns (bool doesAutoBuyback_);

    function getDenominationAsset() external view returns (address denominationAsset_);

    function getDispatcher() external view returns (address dispatcher_);

    function getExtensions() external view returns (address[] memory extensions_);

    function getFeeManager() external view returns (address feeManager_);

    function getFundDeployer() external view returns (address fundDeployer_);

    function getLastSharesBoughtTimestampForAccount(address _who)
        external
        view
        returns (uint256 lastSharesBoughtTimestamp_);

    function getMlnToken() external view returns (address mlnToken_);

    function getPolicyManager() external view returns (address policyManager_);

    function getProtocolFeeReserve() external view returns (address protocolFeeReserve_);

    function getSharesActionTimelock() external view returns (uint256 sharesActionTimelock_);

    function getValueInterpreter() external view returns (address valueInterpreter_);

    function getVaultProxy() external view returns (address vaultProxy_);

    function getWethToken() external view returns (address wethToken_);

    function init(address _vaultProxy, ConfigInput calldata _config) external;

    function isExtension(address _who) external view returns (bool isExtension_);

    function permissionedVaultAction(IVault.VaultAction _action, bytes calldata _actionData) external;

    function preTransferSharesHook(address _sender, address _recipient, uint256 _amount) external;

    function preTransferSharesHookFreelyTransferable(address _sender) external view;

    function redeemSharesForSpecificAssets(
        address _recipient,
        uint256 _sharesQuantity,
        address[] calldata _payoutAssets,
        uint256[] calldata _payoutAssetPercentages
    ) external returns (uint256[] memory payoutAmounts_);

    function redeemSharesInKind(
        address _recipient,
        uint256 _sharesQuantity,
        address[] calldata _additionalAssets,
        address[] calldata _assetsToSkip
    ) external returns (address[] memory payoutAssets_, uint256[] memory payoutAmounts_);

    function setAutoProtocolFeeSharesBuyback(bool _nextAutoProtocolFeeSharesBuyback) external;

    function vaultCallOnContract(address _contract, bytes4 _selector, bytes calldata _encodedArgs)
        external
        returns (bytes memory returnData_);
}
