// SPDX-License-Identifier: MIT 
pragma solidity 0.8.19; 
 
import "forge-std/Script.sol"; 
import "forge-std/console.sol"; 
 
import "./../../../contracts/external-interfaces/IERC20.sol"; 
 
contract CheckVaultBalance is Script { 
 
    address public constant Address = 0x82aF49447D8a07e3bd95BD0d56f35241523fBab1; 
  
    function run() external { 
         
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY"); 
         
        vm.startBroadcast(deployerPrivateKey); 
 
        IERC20 wethCon = IERC20(Address);
 
        uint256 res = wethCon.balanceOf(0x017D527775e3447fE6E17175f1D8aD4f49FC849D); 
 
        console.log("res    ", res); 
 
        vm.stopBroadcast(); 
 
    } 
}