// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "./../../contracts/release/infrastructure/value-interpreter/ValueInterpreter.sol";
import "forge-std/console.sol";


contract DeployValueInterpreter is Script {

    address public constant fundDeployer = 0x965851be9F05cb5Af2583a1D2286164934fe7DdA;
    address public constant wethToken = 0x7ceB23fD6bC0adD59E62ac25578270cFf1b9f619;
    uint256 public constant chainlinkStaleRateThreshold = 90000;


    function run() external returns (address) {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        ValueInterpreter valueInterpreter = new ValueInterpreter(fundDeployer,wethToken,chainlinkStaleRateThreshold);

        vm.stopBroadcast();

        return (address(valueInterpreter));

    }
}