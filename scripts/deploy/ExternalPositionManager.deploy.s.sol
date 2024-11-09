// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "forge-std/console.sol";

import "./../../contracts/release/extensions/external-position-manager/ExternalPositionManager.sol";


contract DeployExternalPositionManager is Script {

    address public constant fundDeployer = 0xa6246ee1F20Db8A256867332EfB89d2e9f81900E;
    address public constant externalPositionFactory = 0xf09b06989B5A389d966A2273978e8996621d4ad1;
    address public constant policyManager = 0x05800e3dA32C809A5B8183a8534FF70F9550099c;


    function run() external returns (address) {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        ExternalPositionManager externalPositionManager = new ExternalPositionManager(fundDeployer,externalPositionFactory,policyManager);

        vm.stopBroadcast();

        return (address(externalPositionManager));

    }
}