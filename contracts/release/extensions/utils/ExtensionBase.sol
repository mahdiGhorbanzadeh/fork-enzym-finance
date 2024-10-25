// SPDX-License-Identifier: GPL-3.0

/*
    This file is part of the Enzyme Protocol.

    (c) Enzyme Foundation <security@enzyme.finance>

    For the full license information, please view the LICENSE
    file that was distributed with this source code.
*/

pragma solidity 0.8.19;

import {IFundDeployer} from "../../core/fund-deployer/IFundDeployer.sol";
import {FundDeployerOwnerMixin} from "../../utils/0.8.19/FundDeployerOwnerMixin.sol";
import {IExtension} from "../IExtension.sol";

/// @title ExtensionBase Contract
/// @author Enzyme Foundation <security@enzyme.finance>
/// @notice Base class for an extension
abstract contract ExtensionBase is IExtension, FundDeployerOwnerMixin {
    event ValidatedVaultProxySetForFund(address indexed comptrollerProxy, address indexed vaultProxy);

    mapping(address => address) internal comptrollerProxyToVaultProxy;

    constructor(address _fundDeployer) FundDeployerOwnerMixin(_fundDeployer) {}

    /// @notice Allows extension to run logic during fund activation
    /// @dev Unimplemented by default, may be overridden.
    function activateForFund() external virtual override {
        return;
    }

    /// @notice Allows extension to run logic during fund deactivation
    /// @dev Unimplemented by default, may be overridden.
    function deactivateForFund() external virtual override {
        return;
    }

    /// @notice Receives calls from ComptrollerLib.callOnExtension()
    /// and dispatches the appropriate action
    /// @dev Unimplemented by default, may be overridden.
    function receiveCallFromComptroller(address, uint256, bytes calldata) external virtual override {
        revert("receiveCallFromComptroller: Unimplemented for Extension");
    }

    /// @notice Allows extension to run logic during fund configuration
    /// @dev Unimplemented by default, may be overridden.
    function setConfigForFund(bytes calldata) external virtual override {
        return;
    }

    /// @dev Helper to store the validated ComptrollerProxy-VaultProxy relation
    function __setValidatedVaultProxy(address _comptrollerProxy) internal returns (address vaultProxy_) {
        vaultProxy_ = IFundDeployer(getFundDeployer()).getVaultProxyForComptrollerProxy(_comptrollerProxy);
        require(vaultProxy_ != address(0), "__setValidatedVaultProxy: Invalid ComptrollerProxy");

        comptrollerProxyToVaultProxy[_comptrollerProxy] = vaultProxy_;

        emit ValidatedVaultProxySetForFund(_comptrollerProxy, vaultProxy_);
    }

    ///////////////////
    // STATE GETTERS //
    ///////////////////

    /// @notice Gets the verified VaultProxy for a given ComptrollerProxy
    /// @param _comptrollerProxy The ComptrollerProxy of the fund
    /// @return vaultProxy_ The VaultProxy of the fund
    function getVaultProxyForFund(address _comptrollerProxy) public view returns (address vaultProxy_) {
        return comptrollerProxyToVaultProxy[_comptrollerProxy];
    }
}
