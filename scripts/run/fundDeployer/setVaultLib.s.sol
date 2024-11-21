// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "./../../../contracts/release/core/fund-deployer/IFundDeployer.sol";
import "forge-std/console.sol";


contract SetVaultLib is Script {

    address public constant fundDeployer = 0x36dA4B48F8a2c6B5628d444F97f8eDb1b19f9b9d;

    address public constant vaultLib = 0xfdc26b5F9cCcfc07F52B9B945150b668830863C0;

    function run() external {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        IFundDeployer fundDeployer = IFundDeployer(fundDeployer);

        fundDeployer.getVaultLib(vaultLib);

        vm.stopBroadcast();

    }
}