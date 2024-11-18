// SPDX-License-Identifier: MIT 
pragma solidity 0.8.19; 
 
import "forge-std/Script.sol"; 
import "forge-std/console.sol"; 
 
import "./../../../contracts/release/core/fund/comptroller/IComptroller.sol"; 
 

contract redeemSharesForSpecificAssets is Script { 
 
    address public constant comptrollerProxyAddress = 0x4026Eb6DC8f0e29A3bBf2142e4aB877Dbd57b4D5; 
 
    address public constant recipient = 0xaE87F9BD09895f1aA21c5023b61EcD85Eba515D1; 
    uint256 public sharesQuantity = type(uint256).max; 
    address[] public payoutAssets = [0xFd086bC7CD5C481DCC9C85ebE478A1C0b69FCbb9]; 
    uint256[] public payoutAssetPercentages = [10000]; 
 
    function run() external { 
         
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY"); 
         
        vm.startBroadcast(deployerPrivateKey); 
 
        IComptroller comptrollerProxy = IComptroller(comptrollerProxyAddress); 
 
        address res = comptrollerProxy.getDenominationAsset(); 
 
        console.log("res   ",res); 
 
        comptrollerProxy.redeemSharesForSpecificAssets(recipient,sharesQuantity,payoutAssets,payoutAssetPercentages); 
 
        vm.stopBroadcast(); 
 
    } 
}