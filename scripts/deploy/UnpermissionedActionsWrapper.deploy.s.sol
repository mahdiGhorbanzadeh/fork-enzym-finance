// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "forge-std/Script.sol";
import "./../../contracts/release/peripheral/UnpermissionedActionsWrapper.sol";
import "forge-std/console.sol";

contract DeployUnpermissionedActionsWrapper is Script {

    address public constant feeManager = 0x7484e83F5220b18DeD1C94ca288b1431890d1435; // replace with actual address


    function run() external returns (address) {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        UnpermissionedActionsWrapper unpermissionedActionsWrapper = new UnpermissionedActionsWrapper(
            feeManager
        );

        vm.stopBroadcast();

        return (address(unpermissionedActionsWrapper));

    }
}
