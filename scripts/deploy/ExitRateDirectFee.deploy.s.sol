// SPDX-License-Identifier: MIT
pragma solidity >=0.6.11 <0.8.20;

import "forge-std/Script.sol";
import "./../../contracts/release/extensions/fee-manager/fees/ExitRateDirectFee.sol";
import "forge-std/console.sol";


contract DeployExitRateDirectFee is Script {

    address public constant feeManager = 0x7484e83F5220b18DeD1C94ca288b1431890d1435; // provided address


    function run() external returns (address) {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        ExitRateDirectFee exitRateDirectFee = new ExitRateDirectFee(
            feeManager
        );

        vm.stopBroadcast();

        return (address(exitRateDirectFee));

    }
}
