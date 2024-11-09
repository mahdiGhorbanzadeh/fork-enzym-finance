// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "forge-std/Script.sol";
import "./../../contracts/persistent/external-positions/ExternalPositionFactory.sol";
import "forge-std/console.sol";


contract DeployExternalPositionFactory is Script {

    address public constant dispatcher = 0x9fBDE4f4A89847cB0E6bd04F1AEF02AE9778B99C;


    function run() external returns (address) {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        ExternalPositionFactory externalPositionFactory = new ExternalPositionFactory(dispatcher);

        vm.stopBroadcast();

        return (address(externalPositionFactory));

    }
}