// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "./../../contracts/release/infrastructure/value-interpreter/ValueInterpreter.sol";
import "forge-std/console.sol";


contract DeployValueInterpreter is Script {

    address public constant fundDeployer = 0xa6246ee1F20Db8A256867332EfB89d2e9f81900E;
    address public constant wethToken = 0x82aF49447D8a07e3bd95BD0d56f35241523fBab1;
    uint256 public constant chainlinkStaleRateThreshold = 90000;


    function run() external returns (address) {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        ValueInterpreter valueInterpreter = new ValueInterpreter(fundDeployer,wethToken,chainlinkStaleRateThreshold);

        vm.stopBroadcast();

        return (address(valueInterpreter));

    }
}