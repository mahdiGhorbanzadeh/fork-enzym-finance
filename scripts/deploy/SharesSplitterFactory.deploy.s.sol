// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "forge-std/Script.sol";
import "./../../contracts/persistent/shares-splitter/SharesSplitterFactory.sol";
import "forge-std/console.sol";

contract DeploySharesSplitterFactory is Script {

    address public constant globalConfigProxy = 0x9F067F5880eef14019d7913829ef4D2111D65935;

    function run() external returns (address) {

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        // Deploy the SharesSplitterFactory contract
        SharesSplitterFactory sharesSplitterFactory = new SharesSplitterFactory(globalConfigProxy);

        vm.stopBroadcast();

        console.log("Deployed SharesSplitterFactory at:", address(sharesSplitterFactory));

        return address(sharesSplitterFactory);
    }
}
