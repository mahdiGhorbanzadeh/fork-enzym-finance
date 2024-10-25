// SPDX-License-Identifier: GPL-3.0

/*
    This file is part of the Enzyme Protocol.

    (c) Enzyme Foundation <security@enzyme.finance>

    For the full license information, please view the LICENSE
    file that was distributed with this source code.
*/

pragma solidity >=0.6.0 <0.9.0;

/// @title IPendleV2PyYtLpOracle Interface
/// @author Enzyme Foundation <security@enzyme.finance>
interface IPendleV2PyYtLpOracle {
    function getLpToSyRate(address _market, uint32 _duration) external view returns (uint256 rate_);

    function getOracleState(address _market, uint32 _duration)
        external
        view
        returns (bool increaseCardinalityRequired_, uint16 cardinalityRequired_, bool oldestObservationSatisfied_);

    function getPtToSyRate(address _market, uint32 _duration) external view returns (uint256 rate_);
}
