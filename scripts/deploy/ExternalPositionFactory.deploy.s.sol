// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "forge-std/Script.sol";
import "./../../contracts/persistent/external-positions/ExternalPositionFactory.sol";
import "forge-std/console.sol";


contract DeployExternalPositionFactory is Script {

    address public constant dispatcher = 0x98bEe2E5F168CF46bD8D51AC6d2a4a6149885c23;


    function run() external returns (address) {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        ExternalPositionFactory externalPositionFactory = new ExternalPositionFactory(dispatcher);

        vm.stopBroadcast();

        return (address(externalPositionFactory));

    }
}