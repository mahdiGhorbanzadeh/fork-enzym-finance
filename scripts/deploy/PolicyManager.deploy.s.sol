// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "./../../contracts/release/extensions/policy-manager/PolicyManager.sol";
import "forge-std/console.sol";


contract DeployPolicyManager is Script {

    address public constant fundDeployer = 0xa6246ee1F20Db8A256867332EfB89d2e9f81900E;


    function run() external returns (address) {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        PolicyManager policyManager = new PolicyManager(fundDeployer);

        vm.stopBroadcast();

        return (address(policyManager));

    }
}