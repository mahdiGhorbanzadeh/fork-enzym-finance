// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "./../../contracts/release/core/fund/vault/VaultLib.sol";
import "forge-std/console.sol";

contract DeployVaultLib is Script {

    address public constant externalPositionManager = 0xd503d9C85f3980Ab83edeC10ba5F1a3352B16f5D; // replace with actual address
    address public constant protocolFeeReserve = 0x834937aB9361838552a18745a67f4031244B078D; // replace with actual address
    address public constant protocolFeeTracker = 0x7dB0BE38AfDEC678e98Ea75FD699AEF0a4925aD3; // replace with actual address
    address public constant mlnToken = 0x2222222222222222222222222222222222222222; // replace with actual address
    address public constant mlnBurner = 0x834937aB9361838552a18745a67f4031244B078D; // replace with actual address
    address public constant wethToken = 0x82aF49447D8a07e3bd95BD0d56f35241523fBab1; // replace with actual address
    uint256 public constant positionsLimit = 20; // replace with actual limit


    function run() external returns (address) {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        VaultLib vaultLib = new VaultLib(
            externalPositionManager,
            protocolFeeReserve,
            protocolFeeTracker,
            mlnToken,
            mlnBurner,
            wethToken,
            positionsLimit
        );

        vm.stopBroadcast();

        return (address(vaultLib));

    }
}
