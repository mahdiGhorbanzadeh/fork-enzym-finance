// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "forge-std/Script.sol";
import "./../../contracts/persistent/protocol-fee-reserve/ProtocolFeeReserveLib.sol";
import "forge-std/console.sol";

contract DeployProtocolFeeReserveProxy is Script {

    address public constant protocolFeeReserveLib = 0xdAFD89F702AF2368dE0C430d59d42378C2fB10C7;
    bytes public constant constructData = "0x19ab453c00000000000000000000000098bee2e5f168cf46bd8d51ac6d2a4a6149885c23";

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
