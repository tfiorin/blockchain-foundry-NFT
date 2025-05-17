// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {BasicNFT} from "../src/BasicNFT.sol";
import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {console2} from "forge-std/console2.sol";

contract DeployBasicNFT is Script {
    
    function run() external returns (BasicNFT) {
        
        vm.startBroadcast();
        BasicNFT basicNFT = new BasicNFT("Dogie", "DOG");
        console.log("BasicNFT deployed to: ", address(basicNFT));
        vm.stopBroadcast();

        return basicNFT;
    }
}