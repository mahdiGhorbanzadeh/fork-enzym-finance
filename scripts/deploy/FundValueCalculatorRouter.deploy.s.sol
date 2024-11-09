// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "forge-std/Script.sol";
import "./../../contracts/persistent/off-chain/fund-value-calculator/FundValueCalculatorRouter.sol";
import "forge-std/console.sol";

contract DeployFundValueCalculatorRouter is Script {

    address public constant dispatcher = 0x9fBDE4f4A89847cB0E6bd04F1AEF02AE9778B99C;
    address[] public fundDeployers = [0xa6246ee1F20Db8A256867332EfB89d2e9f81900E];
    address[] public fundValueCalculators = [0xECEA991eF246C39Ac6CE5dcAC87f2F8026CFD10a];


    function run() external returns (address) {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        FundValueCalculatorRouter fundValueCalculatorRouter = new FundValueCalculatorRouter(dispatcher,fundDeployers,fundValueCalculators);

        vm.stopBroadcast();

        return (address(fundValueCalculatorRouter));

    }
}