// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "forge-std/Script.sol";
import "./../../contracts/release/infrastructure/price-feeds/derivatives/feeds/BalancerV2StablePoolPriceFeed.sol";
import "forge-std/console.sol";


contract DeployBalancerV2StablePoolPriceFeed is Script {

    address public constant fundDeployer = 0x965851be9F05cb5Af2583a1D2286164934fe7DdA; 
    address public constant balancerVault = 0xBA12222222228d8Ba445958a75a0704d566BF2C8;
    address[] public poolFactories = [0x7bc6C0E73EDAa66eF3F6E2f27b0EE8661834c6C9,0x136FD06Fa01eCF624C7F2B3CB15742c1339dC2c4];


    function run() external returns (address) {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        BalancerV2StablePoolPriceFeed balancerV2StablePoolPriceFeed = new BalancerV2StablePoolPriceFeed(
            fundDeployer,
            balancerVault,
            poolFactories
        );

        vm.stopBroadcast();

        return (address(balancerV2StablePoolPriceFeed));

    }
}
