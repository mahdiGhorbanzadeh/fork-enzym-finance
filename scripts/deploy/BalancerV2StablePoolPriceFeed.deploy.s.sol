// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "forge-std/Script.sol";
import "./../../contracts/release/infrastructure/price-feeds/derivatives/feeds/BalancerV2StablePoolPriceFeed.sol";
import "forge-std/console.sol";


contract DeployBalancerV2StablePoolPriceFeed is Script {

    address public constant fundDeployer = 0xa6246ee1F20Db8A256867332EfB89d2e9f81900E; 
    address public constant balancerVault = 0xBA12222222228d8Ba445958a75a0704d566BF2C8;
    address[] public poolFactories;


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
