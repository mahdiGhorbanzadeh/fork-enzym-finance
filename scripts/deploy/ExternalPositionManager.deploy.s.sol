// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "forge-std/console.sol";

import "./../../contracts/release/extensions/external-position-manager/ExternalPositionManager.sol";


contract DeployExternalPositionManager is Script {

    address public constant fundDeployer = 0x98bEe2E5F168CF46bD8D51AC6d2a4a6149885c23;
    address public constant externalPositionFactory = 0x98bEe2E5F168CF46bD8D51AC6d2a4a6149885c23;
    address public constant policyManager = 0x98bEe2E5F168CF46bD8D51AC6d2a4a6149885c23;


    function run() external returns (address) {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        ExternalPositionManager externalPositionManager = new ExternalPositionManager(fundDeployer,externalPositionFactory,policyManager);

        vm.stopBroadcast();

        return (address(externalPositionManager));

    }
}