// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "./../../../contracts/persistent/address-list-registry/IAddressListRegistry.sol";
import "forge-std/console.sol";


contract CreateList is Script {


    address public constant addressListRegistryAddress = 0xb8d54C3d0AB1300cbE437ECC14B2baC26603522d;


    IAddressListRegistry.UpdateType public constant updateType = IAddressListRegistry.UpdateType.AddAndRemove;

    address[] public _initialItems;

    function run() external {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        IAddressListRegistry addressListRegistry = IAddressListRegistry(addressListRegistryAddress);

        address ad = addressListRegistry.getListOwner(1);

        console.log("ad    ",ad);

        vm.stopBroadcast();

    }
}