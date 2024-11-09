// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "forge-std/Script.sol";
import "./../../contracts/persistent/global-config/GlobalConfigLib.sol";
import "forge-std/console.sol";


contract DeployGlobalConfigLib is Script {

    address public constant fundDeployer = 0xa6246ee1F20Db8A256867332EfB89d2e9f81900E;

    function run() external returns (address) {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        GlobalConfigLib globalConfigLib = new GlobalConfigLib(fundDeployer);

        vm.stopBroadcast();

        return (address(globalConfigLib));

    }
}