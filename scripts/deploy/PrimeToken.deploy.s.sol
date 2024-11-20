// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "forge-std/Script.sol";
import "./../../contracts/release/core/fund/PrimeToken.sol";
import "forge-std/console.sol";

contract DeployPrimeToken is Script {

    string public name = "Prime Trader";
    string public symbol = "PTT";
    address public council = 0xaE87F9BD09895f1aA21c5023b61EcD85Eba515D1;

    function run() external returns (address) {

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        PrimeToken primeToken = new PrimeToken(name,symbol,council);

        vm.stopBroadcast();

        console.log("Deployed primeToken at:", address(primeToken));

        return address(primeToken);
    }
}
