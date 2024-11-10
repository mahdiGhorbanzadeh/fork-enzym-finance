// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "./../../contracts/release/extensions/policy-manager/policies/current-shareholders/NoDepegOnRedeemSharesForSpecificAssetsPolicy.sol";
import "forge-std/console.sol";

contract DeployNoDepegOnRedeemSharesForSpecificAssetsPolicy is Script {

    address public constant policyManagerAddress = 0x05800e3dA32C809A5B8183a8534FF70F9550099c; // provided PolicyManager address
    address public constant valueInterpreter = 0xC5fE9A6daCFDA03fE3C8BC9816aba4BE3B7acf99; // provided ValueInterpreter address


    function run() external returns (address) {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        NoDepegOnRedeemSharesForSpecificAssetsPolicy noDepegPolicy = new NoDepegOnRedeemSharesForSpecificAssetsPolicy(
            policyManagerAddress,
            IValueInterpreter(valueInterpreter)
        );

        vm.stopBroadcast();

        return (address(noDepegPolicy));

    }
}
