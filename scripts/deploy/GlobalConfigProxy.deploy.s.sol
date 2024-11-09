// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "forge-std/Script.sol";
import "./../../contracts/persistent/global-config/GlobalConfigProxy.sol";
import "forge-std/console.sol";

contract DeployGlobalConfigProxy is Script {

    address public constant globalConfigLib = 0xE77941f8164B7Ba9F74676ff18F6E6280da2D578;

    bytes public constructData = hex"19ab453c0000000000000000000000009fBDE4f4A89847cB0E6bd04F1AEF02AE9778B99C";


    function run() external returns (address) {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        GlobalConfigProxy globalConfigProxy = new GlobalConfigProxy(constructData,globalConfigLib);

        vm.stopBroadcast();

        return (address(globalConfigProxy));

    }
}