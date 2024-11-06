// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "./../../contracts/persistent/smart-accounts/share-price-throttled-asset-manager/SharePriceThrottledAssetManagerFactory.sol";
import "forge-std/console.sol";

contract DeploySharePriceThrottledAssetManagerFactory is Script {

    address public constant libAddress = 0x12AD91256bF1972aed9CE396e290668E6d9398b2;

    function run() external returns (address) {

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        // Deploy the SharePriceThrottledAssetManagerFactory contract
        SharePriceThrottledAssetManagerFactory factory = new SharePriceThrottledAssetManagerFactory(
            libAddress
        );

        vm.stopBroadcast();

        console.log("Deployed SharePriceThrottledAssetManagerFactory at:", address(factory));

        return address(factory);
    }
}
