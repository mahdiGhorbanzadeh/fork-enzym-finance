// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "forge-std/Script.sol";
import "./../../contracts/persistent/address-list-registry/address-list-owners/AaveV2ATokenListOwner.sol";
import "forge-std/console.sol";

contract DeployAaveV2ATokenListOwner is Script {

    address public constant addressListRegistry = 0x523874436374599266bD7e22b78712c93d222B23;
    string public constant listDescription = "Aave v2: aTokens";
    address public constant lendingPoolAddressProvider = 0xd05e3E715d945B59290df0ae8eF85c1BdB684744;

    function run() external returns (address) {

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        // Deploy the AaveV2ATokenListOwner contract
        AaveV2ATokenListOwner aTokenListOwner = new AaveV2ATokenListOwner(
            addressListRegistry,
            listDescription,
            lendingPoolAddressProvider
        );

        vm.stopBroadcast();

        console.log("Deployed AaveV2ATokenListOwner at:", address(aTokenListOwner));

        return address(aTokenListOwner);
    }
}
