// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "./../../contracts/release/core/fund-deployer/FundDeployer.sol";
import "forge-std/console.sol";


contract DeployFundDeployer is Script {

    address public constant dispatcher = 0x98bEe2E5F168CF46bD8D51AC6d2a4a6149885c23;


    function run() external returns (address) {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        FundDeployer fundDeployer = new FundDeployer(dispatcher);

        vm.stopBroadcast();

        return (address(fundDeployer));

    }
}