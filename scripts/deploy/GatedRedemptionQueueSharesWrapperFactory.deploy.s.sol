// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "forge-std/Script.sol";
import "./../../contracts/persistent/shares-wrappers/gated-redemption-queue/GatedRedemptionQueueSharesWrapperFactory.sol";
import "forge-std/console.sol";



contract DeployGatedRedemptionQueueSharesWrapperFactory is Script {

    address public constant dispatcher = 0x98bEe2E5F168CF46bD8D51AC6d2a4a6149885c23;
    address public constant implementation = 0x017f78d4da78010Fa6b4063AE0Ead61A385c7D76;

    function run() external returns (address) {

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        // Deploy the GatedRedemptionQueueSharesWrapperFactory contract
        GatedRedemptionQueueSharesWrapperFactory factory = new GatedRedemptionQueueSharesWrapperFactory(
            dispatcher,
            implementation
        );

        vm.stopBroadcast();

        console.log("Deployed GatedRedemptionQueueSharesWrapperFactory at:", address(factory));

        return address(factory);
    }
}
