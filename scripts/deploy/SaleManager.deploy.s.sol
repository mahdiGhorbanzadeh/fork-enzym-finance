// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "forge-std/Script.sol";
import "../../contracts/sale/SaleManager.sol";

contract DeploySaleManager is Script {

    
    address public constant accessRestriction = 0x79e5886ba9815159F8ca1FC91265800A750Fc8bf;
    address public constant lrt = 0xfb7f8A2C0526D01BFB00192781B7a7761841B16C; 

    function run() external returns (address) {
        //we need to declare the sender's private key here to sign the deploy transaction
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        // Deploy the upgradeable contract
        SaleManager landRockerSBT = new SaleManager(accessRestriction,lrt);

        vm.stopBroadcast();

        return (address(landRockerSBT));
    }
}