// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "forge-std/Script.sol";
import "./../../contracts/persistent/uint-list-registry/UintListRegistry.sol";
import "forge-std/console.sol";


contract DeployUintListRegistry is Script {

    address public constant dispatcher = 0x9fBDE4f4A89847cB0E6bd04F1AEF02AE9778B99C;


    function run() external returns (address) {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        UintListRegistry uintListRegistry = new UintListRegistry(dispatcher);

        vm.stopBroadcast();

        return (address(uintListRegistry));

    }
}