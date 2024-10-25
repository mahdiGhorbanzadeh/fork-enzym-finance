// SPDX-License-Identifier: GPL-3.0

/*
    This file is part of the Enzyme Protocol.

    (c) Enzyme Foundation <security@enzyme.finance>

    For the full license information, please view the LICENSE
    file that was distributed with this source code.
*/

pragma solidity 0.8.19;

import {GasRelayPaymasterLibBase1} from "./GasRelayPaymasterLibBase1.sol";

/// @title GasRelayPaymasterLibBase2 Contract
/// @author Enzyme Foundation <security@enzyme.finance>
/// @notice A persistent contract containing all required storage variables and events
/// for a GasRelayPaymasterLib
/// @dev DO NOT EDIT CONTRACT ONCE DEPLOYED. If new events or storage are necessary,
/// they should be added to a numbered GasRelayPaymasterLibBaseXXX that inherits the previous base.
/// e.g., `GasRelayPaymasterLibBase2 is GasRelayPaymasterLibBase1`
abstract contract GasRelayPaymasterLibBase2 is GasRelayPaymasterLibBase1 {
    uint256 internal lastDepositTimestamp;
}
