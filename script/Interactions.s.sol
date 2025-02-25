// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {NFTERC721} from "../src/ERC721NFT.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract Interactions is Script {
    string constant PUG =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function run() external {
        address mostReceltyDeployed = DevOpsTools.get_most_recent_deployment(
            "NFTERC721",
            block.chainid
        );
        mintNftOnContract(mostReceltyDeployed);
    }

    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        NFTERC721(contractAddress).mintNft(PUG);
        vm.stopBroadcast();
    }
}
