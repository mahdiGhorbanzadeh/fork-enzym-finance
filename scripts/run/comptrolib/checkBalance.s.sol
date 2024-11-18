// SPDX-License-Identifier: MIT 
pragma solidity 0.8.19; 
 
import "forge-std/Script.sol"; 
import "forge-std/console.sol"; 
 
import "./../../../contracts/external-interfaces/IERC20.sol"; 
 
contract CheckBalance is Script { 
 
    address public constant vaultProxyAddress = 0x057d2D16ddccE13C7DF63C447f2e992a11F29438; 
  
    function run() external { 
         
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY"); 
         
        vm.startBroadcast(deployerPrivateKey); 
 
        IERC20 comptrollerProxy = IERC20(vaultProxyAddress); 
 
        uint256 res = comptrollerProxy.balanceOf(0xaE87F9BD09895f1aA21c5023b61EcD85Eba515D1); 
 
        console.log("res    ", res); 
 
        vm.stopBroadcast(); 
 
    } 
}