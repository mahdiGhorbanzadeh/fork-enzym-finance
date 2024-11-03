// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "./../../contracts/release/infrastructure/price-feeds/derivatives/feeds/ERC4626PriceFeed.sol";
import "forge-std/console.sol";

contract DeployERC4626PriceFeed is Script {

    function run() external returns (address) {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        ERC4626PriceFeed erc4626PriceFeed = new ERC4626PriceFeed();

        vm.stopBroadcast();

        return (address(erc4626PriceFeed));

    }
}
