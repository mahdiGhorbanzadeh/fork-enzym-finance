// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "./../../../contracts/release/infrastructure/value-interpreter/IValueInterpreter.sol";
import "forge-std/console.sol";


contract SetEthUsd is Script {

    address public constant valueInterpreterAddress = 0xC5fE9A6daCFDA03fE3C8BC9816aba4BE3B7acf99;


    function run() external {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        IValueInterpreter valueInterpreter = IValueInterpreter(valueInterpreterAddress);

        valueInterpreter.setEthUsdAggregator(0x639Fe6ab55C921f74e7fac1ee960C0B6293ba612);

        vm.stopBroadcast();

    }
}



