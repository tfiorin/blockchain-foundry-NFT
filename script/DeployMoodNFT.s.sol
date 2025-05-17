// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {MoodNFT} from "../src/MoodNFT.sol";
import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployBasicNFT is Script {
  
    function run() external returns (MoodNFT) {

        string memory sadSvg = vm.readFile("./img/sad.svg");
        string memory happySvg = vm.readFile("./img/happy.svg");
        
        vm.startBroadcast();
        MoodNFT moodNft = new MoodNFT("MoodNFT", "MNFT", svgToImageURI(sadSvg), svgToImageURI(happySvg));
        console.log("BasicNFT deployed to: ", address(moodNft));
        vm.stopBroadcast();

        return moodNft;
    }

    function svgToImageURI(string memory svg) public pure returns (string memory) {
        // example:
        // '<svg width="500" height="500" viewBox="0 0 285 350" fill="none" xmlns="http://www.w3.org/2000/svg"><path fill="black" d="M150,0,L75,200,L225,200,Z"></path></svg>'
        // would return ""
        string memory baseURI = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(
            bytes(string(abi.encodePacked(svg))) // Removing unnecessary type castings, this line can be resumed as follows : 'abi.encodePacked(svg)'
        );
        return string(abi.encodePacked(baseURI, svgBase64Encoded));
    }
}