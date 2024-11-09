// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "forge-std/Script.sol";
import "./../../contracts/persistent/protocol-fee-reserve/ProtocolFeeReserveProxy.sol";
import "forge-std/console.sol";

contract DeployProtocolFeeReserveProxy is Script {

    address public constant protocolFeeReserveLib = 0x77BB13961c69746785A5eE2F178ca8148DcAE133;
    bytes public constant constructData = hex"19ab453c0000000000000000000000009fBDE4f4A89847cB0E6bd04F1AEF02AE9778B99C";

    function run() external returns (address) {

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        // Deploy the ProtocolFeeReserveProxy contract
        ProtocolFeeReserveProxy proxy = new ProtocolFeeReserveProxy(
            constructData,
            protocolFeeReserveLib
        );

        vm.stopBroadcast();

        console.log("Deployed ProtocolFeeReserveProxy at:", address(proxy));

        return address(proxy);
    }
}
