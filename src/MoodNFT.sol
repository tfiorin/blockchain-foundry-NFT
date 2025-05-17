//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNFT is ERC721 {
    uint256 public s_tokenCounter;
    mapping(uint256 => string) private s_tokenIdToURI;
    mapping(NFTState => string) public s_imageToSVG;

    enum NFTState {
        HAPPY,
        SAD
    }

    constructor(string memory _name, string memory _symbol, string memory _sadSVG, string memory _happySVG) ERC721(_name, _symbol) {
        s_tokenCounter = 0;
        s_imageToSVG[NFTState.HAPPY] = _happySVG;
        s_imageToSVG[NFTState.SAD] = _sadSVG;
    }

    function mintNFT(uint moodId) public {
        NFTState mood = moodId == 0 ? NFTState.HAPPY : NFTState.SAD;

        s_tokenIdToURI[s_tokenCounter] = s_imageToSVG[mood];
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        return s_imageToSVG[tokenIdToState(tokenId)];
    }

    function tokenIdToState(uint256 tokenId) internal pure returns (NFTState) {
        return tokenId % 2 == 0 ? NFTState.HAPPY : NFTState.SAD;
    }
}