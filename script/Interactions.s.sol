//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BasicNFT} from "../src/BasicNFT.sol";
import {MoodNFT} from "../src/MoodNFT.sol";

contract MintBasicNFT is Script {

    string public constant PUG_URI =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";
    
    function run() external
    {
        address mostRecentDeployed = DevOpsTools.get_most_recent_deployment("BasicNFT", block.chainid);
        console.log("Most recent deployment of BasicNFT: ", mostRecentDeployed);
        mintNFTOnContract(mostRecentDeployed);
    }

    function mintNFTOnContract(address basicNFTAddress) public {
        vm.startBroadcast();
        BasicNFT(basicNFTAddress).mintNFT(PUG_URI);
        vm.stopBroadcast();
    }
}

enum NFTState {
        HAPPY,
        SAD
    }

contract MintSadMoodNFT is Script {
    
    function run() external
    {
        address mostRecentDeployed = DevOpsTools.get_most_recent_deployment("MoodNFT", block.chainid);
        console.log("Most recent deployment of MoodNFT: ", mostRecentDeployed);
        mintNFTOnContract(mostRecentDeployed);
    }

    function mintNFTOnContract(address moodNFTAddress) public {
        vm.startBroadcast();
        MoodNFT(moodNFTAddress).mintNFT(uint(NFTState.SAD));
        vm.stopBroadcast();
    }
}

contract MintHappyMoodNFT is Script {
    
    function run() external
    {
        address mostRecentDeployed = DevOpsTools.get_most_recent_deployment("MoodNFT", block.chainid);
        console.log("Most recent deployment of MoodNFT: ", mostRecentDeployed);
        mintNFTOnContract(mostRecentDeployed);
    }

    function mintNFTOnContract(address moodNFTAddress) public {
        vm.startBroadcast();
        MoodNFT(moodNFTAddress).mintNFT(uint(NFTState.HAPPY));
        vm.stopBroadcast();
    }
}
