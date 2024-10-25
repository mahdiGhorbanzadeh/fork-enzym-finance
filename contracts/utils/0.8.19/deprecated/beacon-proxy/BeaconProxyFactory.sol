// SPDX-License-Identifier: GPL-3.0

/*
    This file is part of the Enzyme Protocol.

    (c) Enzyme Foundation <security@enzyme.finance>

    For the full license information, please view the LICENSE
    file that was distributed with this source code.
*/

// ** DO NOT AUDIT THIS, IT WILL BE REMOVED IN A SUBSEQUENT COMMIT **

pragma solidity 0.8.19;

import {BeaconProxy} from "./BeaconProxy.sol";
import {IBeaconProxyFactory} from "./IBeaconProxyFactory.sol";

/// @title BeaconProxyFactory Contract
/// @author Enzyme Foundation <security@enzyme.finance>
/// @notice Factory contract that deploys beacon proxies
abstract contract BeaconProxyFactory is IBeaconProxyFactory {
    event CanonicalLibSet(address nextCanonicalLib);

    event ProxyDeployed(address indexed caller, address proxy, bytes constructData);

    address private canonicalLib;

    constructor(address _canonicalLib) {
        __setCanonicalLib(_canonicalLib);
    }

    /// @notice Deploys a new proxy instance
    /// @param _constructData The constructor data with which to call `init()` on the deployed proxy
    /// @return proxy_ The proxy address
    function deployProxy(bytes memory _constructData) public override returns (address proxy_) {
        proxy_ = address(new BeaconProxy(_constructData, address(this)));

        emit ProxyDeployed(msg.sender, proxy_, _constructData);

        return proxy_;
    }

    /// @notice Gets the canonical lib used by all proxies
    /// @return canonicalLib_ The canonical lib
    function getCanonicalLib() public view override returns (address canonicalLib_) {
        return canonicalLib;
    }

    /// @notice Gets the contract owner
    /// @return owner_ The contract owner
    function getOwner() public view virtual override returns (address owner_);

    /// @notice Sets the next canonical lib used by all proxies
    /// @param _nextCanonicalLib The next canonical lib
    function setCanonicalLib(address _nextCanonicalLib) public override {
        require(msg.sender == getOwner(), "setCanonicalLib: Only the owner can call this function");

        __setCanonicalLib(_nextCanonicalLib);
    }

    /// @dev Helper to set the next canonical lib
    function __setCanonicalLib(address _nextCanonicalLib) internal {
        canonicalLib = _nextCanonicalLib;

        emit CanonicalLibSet(_nextCanonicalLib);
    }
}
