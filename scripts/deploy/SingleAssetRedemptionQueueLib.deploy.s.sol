// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "./../../contracts/persistent/single-asset-redemption-queue/SingleAssetRedemptionQueueLib.sol";
import "forge-std/console.sol";

contract DeploySingleAssetRedemptionQueueLib is Script {

    address public constant addressListRegistry = 0x523874436374599266bD7e22b78712c93d222B23;
    uint256 public constant gsnTrustedForwardersAddressListId = 1269;
    address public constant globalConfigProxy = 0x9F067F5880eef14019d7913829ef4D2111D65935;

    function run() external returns (address) {

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        // Deploy the SingleAssetRedemptionQueueLib contract
        SingleAssetRedemptionQueueLib redemptionQueueLib = new SingleAssetRedemptionQueueLib(
            addressListRegistry,
            gsnTrustedForwardersAddressListId,
            globalConfigProxy
        );

        vm.stopBroadcast();

        console.log("Deployed SingleAssetRedemptionQueueLib at:", address(redemptionQueueLib));

        return address(redemptionQueueLib);
    }
}
