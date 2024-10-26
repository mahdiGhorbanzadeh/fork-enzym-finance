// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "forge-std/Script.sol";
import "./../../contracts/persistent/off-chain/fund-value-calculator/FundValueCalculatorRouter.sol";
import "forge-std/console.sol";

contract DeployFundValueCalculatorRouter is Script {

    address public constant dispatcher = 0x98bEe2E5F168CF46bD8D51AC6d2a4a6149885c23;
    address[] public fundDeployers = [0x965851be9F05cb5Af2583a1D2286164934fe7DdA];
    address[] public fundValueCalculators = [0x2Cf76EfF8eA4D52ed4F32c559c8ef9998B6E39c6];


    function run() external returns (address) {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        FundValueCalculatorRouter fundValueCalculatorRouter = new FundValueCalculatorRouter(dispatcher,fundDeployers,fundValueCalculators);

        vm.stopBroadcast();

        return (address(fundValueCalculatorRouter));

    }
}