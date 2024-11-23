

    // SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import "./../../../contracts/release/core/fund/comptroller/IComptroller.sol";
 
// Comptroller Proxy Address: 0x83e434872C1b57e91F89a8782cA1a432Da840b7f
// Vault Proxy Address: 0x017D527775e3447fE6E17175f1D8aD4f49FC849D


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

    address public constant depositWrapper = 0x162575E9317884467dc14a7981cdFE78142E8b72;


    function run() external {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        IDepositWrapper depositWrapperI = IDepositWrapper(depositWrapper);
   
        IComptroller comptrollerProxy = IComptroller(0x83e434872C1b57e91F89a8782cA1a432Da840b7f); // Cast the address to IComptroller
        uint256 minSharesQuantity = 0.000000000000001 ether; // Minimum shares expected
        address exchange = address(0);//0xDEF171Fe48CF0115B1d80b88dc8eAB59176FEe57; // Exchange address (e.g., Paraswap)
        address exchangeApproveTarget = address(0); // Approval target
        bytes memory exchangeData = "";
        uint256 exchangeMinReceived = 0.000000000000001 ether; // Minimum USDT expected


 


    depositWrapperI.exchangeEthAndBuyShares{
            value: 0.00001 ether // Send 3.3 ETH as the input
        }(
       comptrollerProxy,minSharesQuantity,exchange,exchangeApproveTarget,exchangeData,exchangeMinReceived
        );

        vm.stopBroadcast();

    }
}
