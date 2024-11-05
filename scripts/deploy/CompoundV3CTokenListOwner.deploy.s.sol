

// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "forge-std/Script.sol";
import "./../../contracts/persistent/address-list-registry/address-list-owners/CompoundV3CTokenListOwner.sol";
import "forge-std/console.sol";


contract DeployCompoundV3CTokenListOwner is Script {

    address public constant addressListRegistry = 0x523874436374599266bD7e22b78712c93d222B23; 
    string public constant listDescription = "Compound v3: cTokens";
    address public constant compoundV3Configurator = 0x83E0F742cAcBE66349E3701B171eE2487a26e738; 


    function run() external returns (address) {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        CompoundV3CTokenListOwner compoundV3CTokenListOwner = new CompoundV3CTokenListOwner(
            addressListRegistry,
            listDescription,
            compoundV3Configurator
        );

        vm.stopBroadcast();

        return (address(compoundV3CTokenListOwner));

    }
}
