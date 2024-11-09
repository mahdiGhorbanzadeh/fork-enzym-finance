// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "./../../contracts/release/core/fund-deployer/FundDeployer.sol";
import "forge-std/console.sol";


contract DeployFundDeployer is Script {

    address public constant dispatcher = 0x9fBDE4f4A89847cB0E6bd04F1AEF02AE9778B99C;


    function run() external returns (address) {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        FundDeployer fundDeployer = new FundDeployer(dispatcher);

        vm.stopBroadcast();

        return (address(fundDeployer));

    }
}