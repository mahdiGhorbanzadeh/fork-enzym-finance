// SPDX-License-Identifier: GPL-3.0

/*
    This file is part of the Enzyme Protocol.

    (c) Enzyme Foundation <security@enzyme.finance>

    For the full license information, please view the LICENSE
    file that was distributed with this source code.
*/

// ** DO NOT AUDIT THIS, IT WILL BE REMOVED IN A SUBSEQUENT COMMIT **

pragma solidity >=0.6.0 <0.9.0;

/// @title IBeacon interface
/// @author Enzyme Foundation <security@enzyme.finance>
interface IBeacon {
    function getCanonicalLib() external view returns (address);
}
