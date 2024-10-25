// SPDX-License-Identifier: GPL-3.0

/*
    This file is part of the Enzyme Protocol.

    (c) Enzyme Foundation <security@enzyme.finance>

    For the full license information, please view the LICENSE
    file that was distributed with this source code.
*/

pragma solidity 0.6.12;

import {IFeeManager} from "../IFeeManager.sol";
import {ExitRateFeeBase} from "./utils/ExitRateFeeBase.sol";

/// @title ExitRateBurnFee Contract
/// @author Enzyme Foundation <security@enzyme.finance>
/// @notice An ExitRateFee that burns the fee shares
contract ExitRateBurnFee is ExitRateFeeBase {
    constructor(address _feeManager) public ExitRateFeeBase(_feeManager, IFeeManager.SettlementType.Burn) {}
}
