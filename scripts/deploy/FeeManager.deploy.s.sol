// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "./../../contracts/release/extensions/fee-manager/FeeManager.sol";
import "forge-std/console.sol";


contract DeployFeeManager is Script {

    address public constant fundDeployer = 0x965851be9F05cb5Af2583a1D2286164934fe7DdA;


    function run() external returns (address) {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        FeeManager feeManager = new FeeManager(fundDeployer);

        vm.stopBroadcast();

        return (address(feeManager));

    }
}