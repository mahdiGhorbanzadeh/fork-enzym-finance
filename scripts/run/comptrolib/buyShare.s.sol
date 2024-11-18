

    // SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "forge-std/console.sol";


interface IComptroller {
   
    function buyShares(uint256 _investmentAmount, uint256 _minSharesQuantity)
        external
        returns (uint256 sharesReceived_);


}

contract BuyShares is Script {

    address public constant comptroller = 0x9CA4577C715F84567cA8b33cfeF96C41A74E10dE;


    function run() external {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        IComptroller comptrollerI = IComptroller(comptroller);
   
    comptrollerI.buyShares(
          100,10
        );

        vm.stopBroadcast();

    }
}
