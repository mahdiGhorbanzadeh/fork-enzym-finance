// SPDX-License-Identifier: GPL-3.0

/*
    This file is part of the Enzyme Protocol.

    (c) Enzyme Foundation <security@enzyme.finance>

    For the full license information, please view the LICENSE
    file that was distributed with this source code.
*/

// ** DO NOT AUDIT THIS, IT WILL BE REMOVED IN A SUBSEQUENT COMMIT **

import {IBeacon} from "./IBeacon.sol";

pragma solidity >=0.6.0 <0.9.0;

/// @title IBeaconProxyFactory interface
/// @author Enzyme Foundation <security@enzyme.finance>
interface IBeaconProxyFactory is IBeacon {
    function deployProxy(bytes memory _constructData) external returns (address proxy_);

    function getOwner() external view returns (address owner_);

    function setCanonicalLib(address _canonicalLib) external;
}
