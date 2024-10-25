// SPDX-License-Identifier: GPL-3.0

/*
    This file is part of the Enzyme Protocol.

    (c) Enzyme Foundation <security@enzyme.finance>

    For the full license information, please view the LICENSE
    file that was distributed with this source code.
*/

pragma solidity >=0.6.0 <0.9.0;

/// @title ILidoSteth Interface
/// @author Enzyme Foundation <security@enzyme.finance>
interface ILidoSteth {
    function getPooledEthByShares(uint256 _sharesAmount) external view returns (uint256 ethAmount_);
}
