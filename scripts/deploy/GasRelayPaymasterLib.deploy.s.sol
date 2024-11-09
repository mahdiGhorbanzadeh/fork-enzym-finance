// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "./../../contracts/release/infrastructure/gas-relayer/GasRelayPaymasterLib.sol";
import "forge-std/console.sol";


contract DeployGasRelayPaymasterLib is Script {

    address public constant wethToken = 0x82aF49447D8a07e3bd95BD0d56f35241523fBab1; // replace if needed
    address public constant relayHub = 0x0000000000000000000000000000000000000000;
    address public constant trustedForwarder = 0x0000000000000000000000000000000000000000;
    uint256 public constant depositCooldown = 0;
    uint256 public constant depositMaxTotal = 0;
    uint256 public constant relayFeeMaxBase = 0;
    uint256 public constant relayFeeMaxPercent = 0;


    function run() external returns (address) {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        GasRelayPaymasterLib gasRelayPaymasterLib = new GasRelayPaymasterLib(
            wethToken,
            relayHub,
            trustedForwarder,
            depositCooldown,
            depositMaxTotal,
            relayFeeMaxBase,
            relayFeeMaxPercent
        );

        vm.stopBroadcast();

        return (address(gasRelayPaymasterLib));

    }
}
