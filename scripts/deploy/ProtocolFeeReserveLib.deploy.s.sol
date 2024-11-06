// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "forge-std/Script.sol";
import "./../../contracts/persistent/protocol-fee-reserve/ProtocolFeeReserveLib.sol";
import "forge-std/console.sol";


contract DeployProtocolFeeReserveLib is Script {

    function run() external returns (address) {

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        // Deploy the ProtocolFeeReserveLib contract
        ProtocolFeeReserveLib protocolFeeReserveLib = new ProtocolFeeReserveLib();

        vm.stopBroadcast();

        console.log("Deployed ProtocolFeeReserveLib at:", address(protocolFeeReserveLib));

        return address(protocolFeeReserveLib);
    }
}
