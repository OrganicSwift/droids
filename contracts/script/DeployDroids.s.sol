// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {Droids} from "../src/Droids.sol";

contract DeployDroids is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address initialOwner = vm.addr(deployerPrivateKey);
        
        console.log("Deploying Droids with owner:", initialOwner);

        vm.startBroadcast(deployerPrivateKey);

        Droids droids = new Droids(initialOwner);
        
        console.log("Droids deployed to:", address(droids));

        vm.stopBroadcast();
    }
}
