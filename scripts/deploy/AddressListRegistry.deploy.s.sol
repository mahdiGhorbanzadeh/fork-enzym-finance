// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "forge-std/Script.sol";
import "./../../contracts/persistent/address-list-registry/AddressListRegistry.sol";
import "forge-std/console.sol";


contract DeployAddressListRegistry is Script {

    address public constant dispatcher = 0x98bEe2E5F168CF46bD8D51AC6d2a4a6149885c23;


    function run() external returns (address) {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        AddressListRegistry addressListRegistry = new AddressListRegistry(dispatcher);

        vm.stopBroadcast();

        return (address(addressListRegistry));

    }
}