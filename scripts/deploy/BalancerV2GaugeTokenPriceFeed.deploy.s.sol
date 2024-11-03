// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "forge-std/Script.sol";
import "./../../contracts/release/infrastructure/price-feeds/derivatives/feeds/BalancerV2GaugeTokenPriceFeed.sol";
import "forge-std/console.sol";



contract DeployBalancerV2GaugeTokenPriceFeed is Script {

    function run() external returns (address) {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        BalancerV2GaugeTokenPriceFeed balancerV2GaugeTokenPriceFeed = new BalancerV2GaugeTokenPriceFeed();

        vm.stopBroadcast();

        return (address(balancerV2GaugeTokenPriceFeed));

    }
}
