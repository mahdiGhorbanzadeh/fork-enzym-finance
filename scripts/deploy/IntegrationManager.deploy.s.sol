// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "./../../contracts/release/extensions/integration-manager/IntegrationManager.sol";
import "forge-std/console.sol";


contract DeployIntegrationManager is Script {

    address public constant fundDeployer = 0x965851be9F05cb5Af2583a1D2286164934fe7DdA;
    address public constant policyManager = 0xf67AFC8911Bc9F72Ae85a81c455e7bBDf85C3E1F;

    function run() external returns (address) {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        IntegrationManager integrationManager = new IntegrationManager(fundDeployer,policyManager);

        vm.stopBroadcast();

        return (address(integrationManager));
    }
}