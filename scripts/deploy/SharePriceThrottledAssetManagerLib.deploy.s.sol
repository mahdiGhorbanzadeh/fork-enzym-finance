// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "./../../contracts/persistent/smart-accounts/share-price-throttled-asset-manager/SharePriceThrottledAssetManagerLib.sol";
import "forge-std/console.sol";

contract DeploySharePriceThrottledAssetManagerLib is Script {

    address public constant addressListRegistry = 0x523874436374599266bD7e22b78712c93d222B23;
    uint256 public constant gsnTrustedForwardersAddressListId = 1269;
    address public constant fundValueCalculatorRouter = 0xb2d826544495276Ef37b854aaD1C062d57e4d2A6;

    function run() external returns (address) {

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        // Deploy the SharePriceThrottledAssetManagerLib contract
        SharePriceThrottledAssetManagerLib assetManagerLib = new SharePriceThrottledAssetManagerLib(
            addressListRegistry,
            gsnTrustedForwardersAddressListId,
            IFundValueCalculator(fundValueCalculatorRouter)
        );

        vm.stopBroadcast();

        console.log("Deployed SharePriceThrottledAssetManagerLib at:", address(assetManagerLib));

        return address(assetManagerLib);
    }
}
