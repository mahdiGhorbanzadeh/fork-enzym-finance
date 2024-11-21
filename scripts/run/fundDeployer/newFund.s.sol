pragma solidity 0.8.19; 
 
import "forge-std/Script.sol"; 
import "forge-std/console.sol"; 
 
 
interface IFundDeployer { 
    function setVaultLib(address _vaultLib) external; 
    function getVaultLib() external view returns (address vaultLib_); 
    function setReleaseLive() external; 

    function createNewFund(
        address _fundOwner,
        string calldata _fundName,
        string calldata _fundSymbol,
        address _denominationAsset,
        uint256 _sharesActionTimelock,
        bytes calldata _feeManagerConfigData,
        bytes calldata _policyManagerConfigData
    ) external returns (address comptrollerProxy_, address vaultProxy_);
 
} 
 
interface IComptroller { 
    
    struct ConfigInput { 
        address denominationAsset; 
        uint256 sharesActionTimelock; 
        bytes feeManagerConfigData; 
        bytes policyManagerConfigData; 
        ExtensionConfigInput[] extensionsConfig; 
    } 
 
    struct ExtensionConfigInput { 
        address extension; 
        bytes configData; 
    } 
} 
 


 
contract NewFund is Script { 
 
    address public constant fundDeployer = 0x36dA4B48F8a2c6B5628d444F97f8eDb1b19f9b9d; 
 
    address public constant fundOwner = 0xaE87F9BD09895f1aA21c5023b61EcD85Eba515D1; 
 
    function run() external { 
         
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY"); 
         
        vm.startBroadcast(deployerPrivateKey); 
 
        IFundDeployer fundDeployer = IFundDeployer(fundDeployer); 
 
        string memory fundName = "Test Fund2"; 
        string memory fundSymbol = "TFTT"; 
 
        address denominationAsset = 0x82aF49447D8a07e3bd95BD0d56f35241523fBab1; 
        uint256 sharesActionTimelock = 0; 
         
        bytes memory feeManagerConfigData =""; 
        bytes memory policyManagerConfigData =""; 
 
        
        (address comptrollerProxy, address vaultProxy) = fundDeployer.createNewFund( 
            fundOwner, 
            fundName, 
            fundSymbol, 
            denominationAsset,
            sharesActionTimelock,
            feeManagerConfigData,
            policyManagerConfigData
        ); 
 
        console.log("Comptroller Proxy Address:", comptrollerProxy); 
        console.log("Vault Proxy Address:", vaultProxy); 
 
        vm.stopBroadcast(); 
 
    } 
}