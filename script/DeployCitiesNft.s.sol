// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script, console} from "../lib/forge-std/src/Script.sol";
import {CitiesNFT} from "../src/CitiesNFT.sol";
import {Base64} from "../lib/openzeppelin-contracts/contracts/utils/Base64.sol";

contract DeployCitiesNFT is Script {
    function run() external returns (CitiesNFT) {
        string memory citySvg = vm.readFile("./images/city.svg");
        string memory beachSvg = vm.readFile("./images/beach.svg");

        vm.startBroadcast();
        CitiesNFT citiesNFT = new CitiesNFT(
            svgToImageURI(citySvg),
            svgToImageURI(beachSvg)
        );
        vm.stopBroadcast();
        return citiesNFT;
    }

    function svgToImageURI(
        string memory svg
    ) public pure returns (string memory) {
        string memory baseURI = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(
            bytes(string(abi.encodePacked(svg)))
        );
        return string(abi.encodePacked(baseURI, svgBase64Encoded));
    }
}
