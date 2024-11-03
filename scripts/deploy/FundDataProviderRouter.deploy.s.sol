// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "forge-std/Script.sol";
import "./../../contracts/persistent/off-chain/fund-data-provider/FundDataProviderRouter.sol";
import "forge-std/console.sol";



contract DeployFundDataProviderRouter is Script {

    address public constant fundValueCalculatorRouter = 0xb2d826544495276Ef37b854aaD1C062d57e4d2A6; // replace with actual address
    address public constant wethToken = 0x7ceB23fD6bC0adD59E62ac25578270cFf1b9f619; // replace with actual address


    function run() external returns (address) {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        FundDataProviderRouter fundDataProviderRouter = new FundDataProviderRouter(
            fundValueCalculatorRouter,
            wethToken
        );

        vm.stopBroadcast();

        return (address(fundDataProviderRouter));

    }
}