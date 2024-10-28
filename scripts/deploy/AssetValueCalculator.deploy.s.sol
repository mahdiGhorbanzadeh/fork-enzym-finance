// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "forge-std/Script.sol";
import "./../../contracts/release/off-chain/AssetValueCalculator.sol";
import "forge-std/console.sol";


contract DeployAssetValueCalculator is Script {

    address public constant valueInterpreter = 0x829b6B8C7BcF940Ade600adcd32d418635DE5444; // replace with actual address


    function run() external returns (address) {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        AssetValueCalculator assetValueCalculator = new AssetValueCalculator(
            valueInterpreter
        );

        vm.stopBroadcast();

        return (address(assetValueCalculator));

    }
}
