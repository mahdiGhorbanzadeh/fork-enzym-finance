// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "./../../../contracts/persistent/address-list-registry/IAddressListRegistry.sol";
import "forge-std/console.sol";


contract CreateList is Script {


    address public constant addressListRegistryAddress = 0xD3065E02e538076613ff42065cC238495BcDEdA3;


    // dispatcher
    address public constant owner = 0x9fBDE4f4A89847cB0E6bd04F1AEF02AE9778B99C;

    IAddressListRegistry.UpdateType public constant updateType = IAddressListRegistry.UpdateType.AddAndRemove;

    address[] public _initialItems;

    function run() external {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        IAddressListRegistry addressListRegistry = IAddressListRegistry(addressListRegistryAddress);

        addressListRegistry.createList(owner,updateType,_initialItems);

        vm.stopBroadcast();

    }
}