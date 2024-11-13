// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "./../../../contracts/release/core/fund-deployer/IFundDeployer.sol";
import "forge-std/console.sol";


contract SetProtocolFeeTracker is Script {

    address public constant fundDeployer = 0xa6246ee1F20Db8A256867332EfB89d2e9f81900E;

    address public constant protocolFeeTracker = 0x7dB0BE38AfDEC678e98Ea75FD699AEF0a4925aD3;

    function run() external {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        IFundDeployer fundDeployer = IFundDeployer(fundDeployer);

        fundDeployer.setProtocolFeeTracker(protocolFeeTracker);

        vm.stopBroadcast();

    }
}