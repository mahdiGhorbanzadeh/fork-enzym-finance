// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "./../../contracts/persistent/single-asset-redemption-queue/SingleAssetRedemptionQueueFactory.sol";
import "forge-std/console.sol";


contract DeploySingleAssetRedemptionQueueFactory is Script {

    address public constant libAddress = 0x1481EDB3cAd94162F328B5460d9c702Ed1F3A06c;

    function run() external returns (address) {

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        // Deploy the SingleAssetRedemptionQueueFactory contract
        SingleAssetRedemptionQueueFactory factory = new SingleAssetRedemptionQueueFactory(
            libAddress
        );

        vm.stopBroadcast();

        console.log("Deployed SingleAssetRedemptionQueueFactory at:", address(factory));

        return address(factory);
    }
}
