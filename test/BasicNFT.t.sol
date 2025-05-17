// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {DeployBasicNFT} from "../script/DeployBasicNFT.s.sol";
import {BasicNFT} from "../src/BasicNFT.sol";
import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";

contract BasicNFTTest is Test {
    DeployBasicNFT public deployBasicNFT;
    BasicNFT public basicNFT;
    string public constant PUG_URI =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() public {
        deployBasicNFT = new DeployBasicNFT();
        basicNFT = deployBasicNFT.run();
    }

    function testNameIsCorrect() view public {
        string memory expectedName = "Dogie";
        string memory actualName = basicNFT.name();
        assertEq(expectedName, actualName);
    }

    function testSymbolIsCorrect() view public {
        string memory expectedSymbol = "DOG";
        string memory actualSymbol = basicNFT.symbol();
        assertEq(expectedSymbol, actualSymbol);
    }

    function testCanMintNFT() public {
        vm.startPrank(msg.sender);
        basicNFT.mintNFT(PUG_URI);
        assertEq(basicNFT.s_tokenCounter(), 1);
        assertEq(basicNFT.ownerOf(0), msg.sender);
        assertEq(basicNFT.tokenURI(0), PUG_URI);
        vm.stopPrank();
    }
}