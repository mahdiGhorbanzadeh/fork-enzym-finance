// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "forge-std/Script.sol";
import "./../../contracts/release/extensions/fee-manager/fees/EntranceRateDirectFee.sol";
import "forge-std/console.sol";

contract DeployEntranceRateDirectFee is Script {

    address public constant feeManager = 0x7484e83F5220b18DeD1C94ca288b1431890d1435; // provided FeeManager address


    function run() external returns (address) {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        EntranceRateDirectFee entranceRateDirectFee = new EntranceRateDirectFee(
            feeManager
        );

        vm.stopBroadcast();

        return (address(entranceRateDirectFee));

    }
}
