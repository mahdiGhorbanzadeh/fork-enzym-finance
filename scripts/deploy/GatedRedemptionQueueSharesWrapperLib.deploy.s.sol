// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "forge-std/Script.sol";
import "./../../contracts/persistent/shares-wrappers/gated-redemption-queue/GatedRedemptionQueueSharesWrapperLib.sol";
import "forge-std/console.sol";

contract DeployGatedRedemptionQueueSharesWrapperLib is Script {

    address public constant globalConfigProxy = 0x9F067F5880eef14019d7913829ef4D2111D65935;
    address public constant wrappedNativeAsset = 0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270;

    function run() external returns (address) {

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        // Deploy the GatedRedemptionQueueSharesWrapperLib contract
        GatedRedemptionQueueSharesWrapperLib wrapperLib = new GatedRedemptionQueueSharesWrapperLib(
            globalConfigProxy,
            wrappedNativeAsset
        );

        vm.stopBroadcast();

        console.log("Deployed GatedRedemptionQueueSharesWrapperLib at:", address(wrapperLib));

        return address(wrapperLib);
    }
}
