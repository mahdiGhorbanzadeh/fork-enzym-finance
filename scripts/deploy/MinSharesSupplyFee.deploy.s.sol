// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "forge-std/Script.sol";
import "./../../contracts/release/extensions/fee-manager/fees/MinSharesSupplyFee.sol";
import "forge-std/console.sol";

contract DeployMinSharesSupplyFee is Script {

    address public constant feeManager = 0x7484e83F5220b18DeD1C94ca288b1431890d1435; // provided FeeManager address


    function run() external returns (address) {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        MinSharesSupplyFee minSharesSupplyFee = new MinSharesSupplyFee(
            feeManager
        );

        vm.stopBroadcast();

        return (address(minSharesSupplyFee));

    }
}
