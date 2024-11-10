// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "./../../contracts/release/extensions/policy-manager/AllowedAdapterIncomingAssetsPolicy.sol";
import "forge-std/console.sol";


contract DeployAllowedAdapterIncomingAssetsPolicy is Script {

    address public constant policyManager = 0x05800e3dA32C809A5B8183a8534FF70F9550099c; // provided PolicyManager address
    address public constant addressListRegistry = 0xD3065E02e538076613ff42065cC238495BcDEdA3; // provided AddressListRegistry address


    function run() external returns (address) {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        AllowedAdapterIncomingAssetsPolicy allowedAdapterIncomingAssetsPolicy = new AllowedAdapterIncomingAssetsPolicy(
            policyManager,
            addressListRegistry
        );

        vm.stopBroadcast();

        return (address(allowedAdapterIncomingAssetsPolicy));

    }
}
