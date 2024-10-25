// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "forge-std/Script.sol";
import "../../src/swapAggregator/SwapAggregator.sol";
import {Upgrades} from "openzeppelin-foundry-upgrades/Upgrades.sol";

contract DeploySwapAggregator is Script {
    
    address public constant accessRestriction = 0x79e5886ba9815159F8ca1FC91265800A750Fc8bf;
    address public constant quoter = 0x5e55C9e631FAE526cd4B0526C4818D6e0a9eF0e3;
    address public constant weth = 0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270;


    function run() external returns (address, address) {
        //we need to declare the sender's private key here to sign the deploy transaction
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        // Deploy the upgradeable contract
        address _proxyAddress = Upgrades.deployUUPSProxy(
            "SwapAggregator.sol",
            abi.encodeCall(SwapAggregator.swapAggregatorInitialize, (accessRestriction,quoter,weth))
        );

        // Get the implementation address
        address implementationAddress = Upgrades.getImplementationAddress(
            _proxyAddress
        );

        vm.stopBroadcast();

        return (implementationAddress, _proxyAddress);
    }
}