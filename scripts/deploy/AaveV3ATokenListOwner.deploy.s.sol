// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "forge-std/Script.sol";
import "./../../contracts/persistent/address-list-registry/address-list-owners/AaveV3ATokenListOwner.sol";
import "forge-std/console.sol";


contract DeployAaveV3ATokenListOwner is Script {

    address public constant addressListRegistry = 0xD3065E02e538076613ff42065cC238495BcDEdA3; // replace with actual address
    string public constant listDescription = "Aave v3: aTokens"; // replace with actual description
    address public constant poolAddressProvider = 0xa97684ead0e402dC232d5A977953DF7ECBaB3CDb; // replace with actual address


    function run() external returns (address) {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        AaveV3ATokenListOwner aaveV3ATokenListOwner = new AaveV3ATokenListOwner(
            addressListRegistry,
            listDescription,
            poolAddressProvider
        );

        vm.stopBroadcast();

        return (address(aaveV3ATokenListOwner));

    }
}
