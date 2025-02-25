// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {NFTERC721} from "../src/ERC721NFT.sol";

contract DeployBasicNft is Script {
    function run() public returns (NFTERC721) {
        vm.startBroadcast();
        NFTERC721 nftDeployed = new NFTERC721();
        vm.stopBroadcast();
        return nftDeployed;
    }
}
