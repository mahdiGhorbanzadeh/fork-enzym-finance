// SPDX-License-Identifier: GPL-3.0

/*
    This file is part of the Enzyme Protocol.

    (c) Enzyme Foundation <security@enzyme.finance>

    For the full license information, please view the LICENSE
    file that was distributed with this source code.
*/

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {IAddressListRegistry} from "../../../../../persistent/address-list-registry/IAddressListRegistry.sol";
import {IPolicyManager} from "../../IPolicyManager.sol";
import {AddressListRegistryPolicyBase} from "../utils/0.6.12/AddressListRegistryPolicyBase.sol";

/// @title AllowedAssetsForRedemptionPolicy Contract
/// @author Enzyme Foundation <security@enzyme.finance>
/// @notice A policy that limits assets that can be redeemed by specific asset redemption
contract AllowedAssetsForRedemptionPolicy is AddressListRegistryPolicyBase {
    constructor(address _policyManager, address _addressListRegistry)
        public
        AddressListRegistryPolicyBase(_policyManager, _addressListRegistry)
    {}

    // EXTERNAL FUNCTIONS

    /// @notice Whether or not the policy can be disabled
    /// @return canDisable_ True if the policy can be disabled
    function canDisable() external pure virtual override returns (bool canDisable_) {
        return true;
    }

    /// @notice Provides a constant string identifier for a policy
    /// @return identifier_ The identifier string
    function identifier() external pure override returns (string memory identifier_) {
        return "ALLOWED_ASSETS_FOR_REDEMPTION";
    }

    /// @notice Gets the implemented PolicyHooks for a policy
    /// @return implementedHooks_ The implemented PolicyHooks
    function implementedHooks() external pure override returns (IPolicyManager.PolicyHook[] memory implementedHooks_) {
        implementedHooks_ = new IPolicyManager.PolicyHook[](1);
        implementedHooks_[0] = IPolicyManager.PolicyHook.RedeemSharesForSpecificAssets;

        return implementedHooks_;
    }

    /// @notice Apply the rule with the specified parameters of a PolicyHook
    /// @param _comptrollerProxy The fund's ComptrollerProxy address
    /// @param _encodedArgs Encoded args with which to validate the rule
    /// @return isValid_ True if the rule passes
    /// @dev onlyPolicyManager validation not necessary, as state is not updated and no events are fired
    function validateRule(address _comptrollerProxy, IPolicyManager.PolicyHook, bytes calldata _encodedArgs)
        external
        override
        returns (bool isValid_)
    {
        (,,, address[] memory assets,,) = __decodeRedeemSharesForSpecificAssetsValidationData(_encodedArgs);

        return passesRule(_comptrollerProxy, assets);
    }

    // PUBLIC FUNCTIONS

    /// @notice Checks whether a particular condition passes the rule for a particular fund
    /// @param _comptrollerProxy The fund's ComptrollerProxy address
    /// @param _assets The assets for which to check the rule
    /// @return isValid_ True if the rule passes
    function passesRule(address _comptrollerProxy, address[] memory _assets) public view returns (bool isValid_) {
        return IAddressListRegistry(getAddressListRegistry()).areAllInSomeOfLists(
            getListIdsForFund(_comptrollerProxy), _assets
        );
    }
}