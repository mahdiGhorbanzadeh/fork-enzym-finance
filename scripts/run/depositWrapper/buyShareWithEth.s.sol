

    // SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import "./../../../contracts/release/core/fund/comptroller/IComptroller.sol";
 
interface IDepositWrapper {
   
    function exchangeEthAndBuyShares(
        IComptroller _comptrollerProxy,
        uint256 _minSharesQuantity,
        address _exchange,
        address _exchangeApproveTarget,
        bytes calldata _exchangeData,
        uint256 _exchangeMinReceived
    ) external payable returns (uint256 sharesReceived_);

}

contract DepositWrapper is Script {

    address public constant depositWrapper = 0xD9a66FB08A0dB016B2478627a4aff7A9E313D07D;


    function run() external {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        IDepositWrapper depositWrapperI = IDepositWrapper(depositWrapper);
   
        IComptroller comptrollerProxy = IComptroller(0x9CA4577C715F84567cA8b33cfeF96C41A74E10dE); // Cast the address to IComptroller
        uint256 minSharesQuantity = 0.000000000000001 ether; // Minimum shares expected
        address exchange = address(0);//0xDEF171Fe48CF0115B1d80b88dc8eAB59176FEe57; // Exchange address (e.g., Paraswap)
        address exchangeApproveTarget = address(0); // Approval target
        bytes memory exchangeData = "";
        uint256 exchangeMinReceived = 0.000000000000001 ether; // Minimum USDT expected


 


    depositWrapperI.exchangeEthAndBuyShares{
            value: 0.00000000000001 ether // Send 3.3 ETH as the input
        }(
       comptrollerProxy,minSharesQuantity,exchange,exchangeApproveTarget,exchangeData,exchangeMinReceived
        );

        vm.stopBroadcast();

    }
}
