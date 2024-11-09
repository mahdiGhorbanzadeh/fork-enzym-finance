// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "./../../contracts/release/extensions/integration-manager/IntegrationManager.sol";
import "forge-std/console.sol";


contract DeployIntegrationManager is Script {

    address public constant fundDeployer = 0xa6246ee1F20Db8A256867332EfB89d2e9f81900E;
    address public constant policyManager = 0x05800e3dA32C809A5B8183a8534FF70F9550099c;

    function run() external returns (address) {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        IntegrationManager integrationManager = new IntegrationManager(fundDeployer,policyManager);

        vm.stopBroadcast();

        return (address(integrationManager));
    }
}