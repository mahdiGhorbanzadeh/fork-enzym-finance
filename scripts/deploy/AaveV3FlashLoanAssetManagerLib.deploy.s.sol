// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "./../../contracts/persistent/smart-accounts/aave-v3-flash-loan-asset-manager/AaveV3FlashLoanAssetManagerLib.sol";
import "forge-std/console.sol";

contract DeployAaveV3FlashLoanAssetManagerLib is Script {

    address public constant aavePoolAddressProviderAddress = 0xa97684ead0e402dC232d5A977953DF7ECBaB3CDb; // replace with actual address
    uint16 public constant aaveReferralCode = 0; // replace with actual referral code


    function run() external returns (address) {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        AaveV3FlashLoanAssetManagerLib aaveV3FlashLoanAssetManagerLib = new AaveV3FlashLoanAssetManagerLib(
            aavePoolAddressProviderAddress,
            aaveReferralCode
        );

        vm.stopBroadcast();

        return (address(aaveV3FlashLoanAssetManagerLib));

    }
}
