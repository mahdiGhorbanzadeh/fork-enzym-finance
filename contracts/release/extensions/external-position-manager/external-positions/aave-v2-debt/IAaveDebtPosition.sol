// SPDX-License-Identifier: GPL-3.0

/*
    This file is part of the Enzyme Protocol.
    (c) Enzyme Foundation <security@enzyme.finance>
    For the full license information, please view the LICENSE
    file that was distributed with this source code.
*/

import {IExternalPosition} from "../../IExternalPosition.sol";

pragma solidity >=0.6.0 <0.9.0;

/// @title IAaveDebtPosition Interface
/// @author Enzyme Foundation <security@enzyme.finance>
interface IAaveDebtPosition is IExternalPosition {
    enum Actions {
        AddCollateral,
        RemoveCollateral,
        Borrow,
        RepayBorrow,
        ClaimRewards
    }

    function getDebtTokenForBorrowedAsset(address) external view returns (address);
}