// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "forge-std/Script.sol";
import "./../../contracts/release/off-chain/FundValueCalculator.sol";
import "forge-std/console.sol";


contract DeployFundValueCalculator is Script {

    address public constant feeManager = 0xEF73284E0E7729404b75A09a4F6537Ce0E97b40a;
    address public constant protocolFeeTracker = 0xA13779E1c825685dDd376689875AF6FC02191001;
    address public constant valueInterpreter = 0x829b6B8C7BcF940Ade600adcd32d418635DE5444;


    function run() external returns (address) {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        FundValueCalculator valueInterpreter = new FundValueCalculator(feeManager,protocolFeeTracker,valueInterpreter);

        vm.stopBroadcast();

        return (address(valueInterpreter));

    }
}