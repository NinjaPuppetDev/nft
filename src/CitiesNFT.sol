// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract CitiesNFT is ERC721 {
    //Error
    error CitiesNFT__UnableToFlipCitiesIfnotOwner();

    uint256 private s_tokenCounter;
    string private s_city;
    string private s_beach;

    enum Season {
        City,
        Beach
    }

    mapping(uint256 => Season) private s_tokenIdToSeason;

    event CreatedNft(uint256 indexed tokenId);

    constructor(
        string memory city,
        string memory beach
    ) ERC721("CitiesNFT", "CT") {
        s_tokenCounter = 0;
        s_city = city;
        s_beach = beach;
    }

    function mintNft() public {
        uint256 tokenCounter = s_tokenCounter;
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter = s_tokenCounter + 1;
        emit CreatedNft(tokenCounter);
    }

    function flipSeason(uint256 tokenId) public {
        if (
            getApproved(tokenId) != msg.sender && ownerOf(tokenId) != msg.sender
        ) {
            revert CitiesNFT__UnableToFlipCitiesIfnotOwner();
        }
        if (s_tokenIdToSeason[tokenId] == Season.City) {
            s_tokenIdToSeason[tokenId] = Season.Beach;
        } else s_tokenIdToSeason[tokenId] = Season.City;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        string memory imageURI = s_city;

        if (s_tokenIdToSeason[tokenId] == Season.Beach) {
            imageURI = s_beach;
        }
        return
            string(
                abi.encodePacked(
                    _baseURI(),
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name":"',
                                name(),
                                '", "description":"An NFT for the seasons of the year", "attributes":[{"trait_type": "season", "value":100}], "image": "',
                                imageURI,
                                '"}'
                            )
                        )
                    )
                )
            );
    }
}
