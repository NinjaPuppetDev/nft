// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "../../lib/forge-std/src/Test.sol";
import {DeployBasicNft} from "../../script/DeployNft.s.sol";
import {NFTERC721} from "../../src/ERC721NFT.sol";

contract TestERC721 is Test {
    DeployBasicNft public deployer;
    NFTERC721 public nftERC721;
    address public USER = makeAddr("USER");
    string constant PUG =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() public {
        deployer = new DeployBasicNft();
        nftERC721 = new NFTERC721();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "Capibara";
        string memory actualName = nftERC721.name();
        assert(
            keccak256(abi.encodePacked(expectedName)) ==
                (keccak256(abi.encodePacked(actualName)))
        );
    }

    function testCanMint() public {
        vm.prank(USER);

        nftERC721.mintNft(PUG);

        assert(nftERC721.balanceOf(USER) == 1);
        assert(
            keccak256(abi.encodePacked(PUG)) ==
                keccak256(abi.encodePacked(nftERC721.tokenURI(0)))
        );
    }
}
