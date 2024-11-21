// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "./../../../contracts/persistent/dispatcher/IDispatcher.sol";
import "forge-std/console.sol";


contract SetCurrentFund is Script {

    address public constant dispatcherAddress = 0x282d075e379042142a4657F8e692208Cad9CD574;

    address public constant fundDeployer = 0x36dA4B48F8a2c6B5628d444F97f8eDb1b19f9b9d;

    function run() external {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        IDispatcher dispatcher = IDispatcher(dispatcherAddress);

        dispatcher.setCurrentFundDeployer(fundDeployer);

        vm.stopBroadcast();

    }
}
