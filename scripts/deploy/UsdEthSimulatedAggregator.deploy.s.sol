// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "forge-std/Script.sol";
import "./../../contracts/release/infrastructure/price-feeds/primitives/UsdEthSimulatedAggregator.sol";
import "forge-std/console.sol";

contract DeployUsdEthSimulatedAggregator is Script {

    address public constant ethUsdAggregator = 0xF9680D99D6C9589e2a93a78A04A279e509205945; 


    function run() external returns (address) {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        UsdEthSimulatedAggregator usdEthSimulatedAggregator = new UsdEthSimulatedAggregator(
            ethUsdAggregator
        );

        vm.stopBroadcast();

        return (address(usdEthSimulatedAggregator));

    }
}
