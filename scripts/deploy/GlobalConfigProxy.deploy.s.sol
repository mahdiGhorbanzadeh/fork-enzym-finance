// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "forge-std/Script.sol";
import "./../../contracts/persistent/global-config/GlobalConfigProxy.sol";
import "forge-std/console.sol";


contract DeployGlobalConfigProxy is Script {

    address public constant globalConfigLib = 0x906F682c2B521804bb7de11854bEca25fd50863C;

    bytes public constructData = hex"19ab453c00000000000000000000000098bee2e5f168cf46bd8d51ac6d2a4a6149885c23";


    function run() external returns (address) {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        GlobalConfigProxy globalConfigProxy = new GlobalConfigProxy(constructData,globalConfigLib);

        vm.stopBroadcast();

        return (address(globalConfigProxy));

    }
}