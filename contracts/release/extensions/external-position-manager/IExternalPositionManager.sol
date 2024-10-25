// SPDX-License-Identifier: GPL-3.0

/*
    This file is part of the Enzyme Protocol.

    (c) Enzyme Foundation <security@enzyme.finance>

    For the full license information, please view the LICENSE
    file that was distributed with this source code.
*/

pragma solidity >=0.6.0 <0.9.0;

/// @title IExternalPositionManager interface
/// @author Enzyme Foundation <security@enzyme.finance>
/// @notice Interface for the ExternalPositionManager
interface IExternalPositionManager {
    struct ExternalPositionTypeInfo {
        address parser;
        address lib;
    }

    enum ExternalPositionManagerActions {
        CreateExternalPosition,
        CallOnExternalPosition,
        RemoveExternalPosition,
        ReactivateExternalPosition
    }

    function getExternalPositionFactory() external view returns (address externalPositionFactory_);

    function getExternalPositionLibForType(uint256 _typeId) external view returns (address lib_);

    function getExternalPositionParserForType(uint256 _typeId) external view returns (address parser_);

    function getPolicyManager() external view returns (address policyManager_);

    function updateExternalPositionTypesInfo(
        uint256[] memory _typeIds,
        address[] memory _libs,
        address[] memory _parsers
    ) external;
}
