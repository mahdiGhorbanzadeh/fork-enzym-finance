// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "forge-std/Script.sol";
import "./../../contracts/persistent/dispatcher/Dispatcher.sol";
import "forge-std/console.sol";


contract DeployDispatcher is Script {

    function run() external returns (address) {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        Dispatcher dispatcher = new Dispatcher();

        vm.stopBroadcast();

        return (address(dispatcher));

    }
}