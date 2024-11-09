// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "forge-std/Script.sol";
import "./../../contracts/release/off-chain/FundValueCalculator.sol";
import "forge-std/console.sol";


contract DeployFundValueCalculator is Script {

    address public constant feeManager = 0x7484e83F5220b18DeD1C94ca288b1431890d1435;
    address public constant protocolFeeTracker = 0x7dB0BE38AfDEC678e98Ea75FD699AEF0a4925aD3;
    address public constant valueInterpreter = 0xC5fE9A6daCFDA03fE3C8BC9816aba4BE3B7acf99;


    function run() external returns (address) {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        FundValueCalculator valueInterpreter = new FundValueCalculator(feeManager,protocolFeeTracker,valueInterpreter);

        vm.stopBroadcast();

        return (address(valueInterpreter));

    }
}