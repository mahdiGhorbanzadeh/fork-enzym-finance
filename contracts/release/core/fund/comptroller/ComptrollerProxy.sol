// SPDX-License-Identifier: GPL-3.0

/*
    This file is part of the Enzyme Protocol.

    (c) Enzyme Foundation <security@enzyme.finance>

    For the full license information, please view the LICENSE
    file that was distributed with this source code.
*/

pragma solidity 0.8.19;

import {NonUpgradableProxy} from "../../../../utils/0.8.19/NonUpgradableProxy.sol";

/// @title ComptrollerProxy Contract
/// @author Enzyme Foundation <security@enzyme.finance>
/// @notice A proxy contract for all ComptrollerProxy instances
contract ComptrollerProxy is NonUpgradableProxy {
    constructor(bytes memory _constructData, address _comptrollerLib)
        NonUpgradableProxy(_constructData, _comptrollerLib)
    {}
}
