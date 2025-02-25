// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test, console} from "../../lib/forge-std/src/Test.sol";
import {CitiesNFT} from "../../src/CitiesNFT.sol";

contract TestCitiesNFT is Test {
    address owner = address(1);
    uint256 tokenId = 1;

    CitiesNFT citiesNFT;
    string public constant CITY_URI =
        "data:application/json;base64,PHN2ZyB3aWR0aD0iODAwIiBoZWlnaHQ9IjYwMCIgdmlld0JveD0iMCAwIDgwMCA2MDAiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CiAgICA8ZGVmcz4KICAgICAgICA8bGluZWFyR3JhZGllbnQgaWQ9InNreUdyYWRpZW50IiB4MT0iMCUiIHkxPSIwJSIgeDI9IjAlIiB5Mj0iMTAwJSI+CiAgICAgICAgICAgIDxzdG9wIG9mZnNldD0iMCUiIHN0b3AtY29sb3I9IiM4N0NFRUIiIC8+CiAgICAgICAgICAgIDxzdG9wIG9mZnNldD0iMTAwJSIgc3RvcC1jb2xvcj0iI0UwRjZGRiIgLz4KICAgICAgICA8L2xpbmVhckdyYWRpZW50PgoKICAgICAgICA8cmFkaWFsR3JhZGllbnQgaWQ9InN1bkdsb3ciPgogICAgICAgICAgICA8c3RvcCBvZmZzZXQ9IjcwJSIgc3RvcC1jb2xvcj0iI0ZGRDcwMCIgLz4KICAgICAgICAgICAgPHN0b3Agb2Zmc2V0PSIxMDAlIiBzdG9wLWNvbG9yPSJ0cmFuc3BhcmVudCIgLz4KICAgICAgICA8L3JhZGlhbEdyYWRpZW50PgoKICAgICAgICA8ZmlsdGVyIGlkPSJ3YXZlRmlsdGVyIj4KICAgICAgICAgICAgPGZlVHVyYnVsZW5jZSB0eXBlPSJmcmFjdGFsTm9pc2UiIGJhc2VGcmVxdWVuY3k9IjAuMDIgMC4wNSIgbnVtT2N0YXZlcz0iMyIgLz4KICAgICAgICAgICAgPGZlRGlzcGxhY2VtZW50TWFwIGluPSJTb3VyY2VHcmFwaGljIiBzY2FsZT0iMyIgLz4KICAgICAgICA8L2ZpbHRlcj4KICAgIDwvZGVmcz4KCiAgICA8IS0tIFNreSAtLT4KICAgIDxyZWN0IHdpZHRoPSI4MDAiIGhlaWdodD0iNjAwIiBmaWxsPSJ1cmwoI3NreUdyYWRpZW50KSIgLz4KCiAgICA8IS0tIFN1biAtLT4KICAgIDxjaXJjbGUgY3g9IjcwMCIgY3k9IjEwMCIgcj0iNTAiIGZpbGw9InVybCgjc3VuR2xvdykiIG9wYWNpdHk9IjAuOCI+CiAgICAgICAgPGFuaW1hdGUgYXR0cmlidXRlTmFtZT0iciIgdmFsdWVzPSI1MDs1NTs1MCIgZHVyPSI4cyIgcmVwZWF0Q291bnQ9ImluZGVmaW5pdGUiIC8+CiAgICA8L2NpcmNsZT4KCiAgICA8IS0tIE9jZWFuIC0tPgogICAgPHBhdGggZD0iTTAgMzAwIFE0MDAgMzIwIDgwMCAzMDAgTDgwMCA2MDAgTDAgNjAwIFoiIGZpbGw9IiM0NjgyQjQiIGZpbHRlcj0idXJsKCN3YXZlRmlsdGVyKSIgLz4KCiAgICA8IS0tIFNhbmQgLS0+CiAgICA8cGF0aCBkPSJNMCA0NTAgUTIwMCA0MzAgNDAwIDQ0MCBRNjAwIDQ1MCA4MDAgNDMwIEw4MDAgNjAwIEwwIDYwMCBaIiBmaWxsPSIjRjRBNDYwIj4KICAgICAgICA8YW5pbWF0ZSBhdHRyaWJ1dGVOYW1lPSJkIiB2YWx1ZXM9IgogICAgICBNMCA0NTAgUTIwMCA0MzAgNDAwIDQ0MCBRNjAwIDQ1MCA4MDAgNDMwIEw4MDAgNjAwIEwwIDYwMCBaOwogICAgICBNMCA0NTAgUTIwMCA0NDAgNDAwIDQzNSBRNjAwIDQ0MCA4MDAgNDQwIEw4MDAgNjAwIEwwIDYwMCBaOwogICAgICBNMCA0NTAgUTIwMCA0MzAgNDAwIDQ0MCBRNjAwIDQ1MCA4MDAgNDMwIEw4MDAgNjAwIEwwIDYwMCBaIiBkdXI9IjZzIiByZXBlYXRDb3VudD0iaW5kZWZpbml0ZSIgLz4KICAgIDwvcGF0aD4KCiAgICA8IS0tIFBhbG0gVHJlZSAtLT4KICAgIDxwYXRoIGQ9Ik0xMDAgNDUwIEMxMjAgMzAwIDE0MCAyNTAgMTUwIDIwMCIgc3Ryb2tlPSIjOEI0NTEzIiBzdHJva2Utd2lkdGg9IjE1IiBzdHJva2UtbGluZWNhcD0icm91bmQiIC8+CiAgICA8cGF0aCBkPSJNMTUwIDIwMCBxLTQwIC01MCAtMjAgLTEwMCBxNjAgMCAyMCAxMDAgcS00MCAtNTAgMCAtMTAwIHE0MCA1MCAwIDEwMCIgZmlsbD0iIzIyOEIyMiIgLz4KCiAgICA8IS0tIENsb3VkcyAtLT4KICAgIDxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKDIwMCAxMDApIj4KICAgICAgICA8Y2lyY2xlIGN4PSI1MCIgY3k9IjMwIiByPSIzMCIgZmlsbD0id2hpdGUiIC8+CiAgICAgICAgPGNpcmNsZSBjeD0iODAiIGN5PSIyMCIgcj0iMjUiIGZpbGw9IndoaXRlIiAvPgogICAgICAgIDxjaXJjbGUgY3g9IjExMCIgY3k9IjMwIiByPSIyOCIgZmlsbD0id2hpdGUiIC8+CiAgICAgICAgPGFuaW1hdGVUcmFuc2Zvcm0gYXR0cmlidXRlTmFtZT0idHJhbnNmb3JtIiB0eXBlPSJ0cmFuc2xhdGUiIHZhbHVlcz0iMjAwIDEwMDsgMjIwIDEwMDsgMjAwIDEwMCIgZHVyPSIxMnMiCiAgICAgICAgICAgIHJlcGVhdENvdW50PSJpbmRlZmluaXRlIiAvPgogICAgPC9nPgoKICAgIDwhLS0gV2F2ZXMgLS0+CiAgICA8ZyBzdHJva2U9IndoaXRlIiBvcGFjaXR5PSIwLjYiPgogICAgICAgIDxwYXRoIGQ9Ik01MCAzMjAgUTE1MCAzMDAgMjUwIDMyMCIgc3Ryb2tlLXdpZHRoPSIyIiBmaWxsPSJub25lIj4KICAgICAgICAgICAgPGFuaW1hdGUgYXR0cmlidXRlTmFtZT0iZCIgdmFsdWVzPSIKICAgICAgICBNNTAgMzIwIFExNTAgMzAwIDI1MCAzMjA7CiAgICAgICAgTTUwIDMyNSBRMTUwIDMwNSAyNTAgMzI1OwogICAgICAgIE01MCAzMjAgUTE1MCAzMDAgMjUwIDMyMCIgZHVyPSIzcyIgcmVwZWF0Q291bnQ9ImluZGVmaW5pdGUiIC8+CiAgICAgICAgPC9wYXRoPgogICAgICAgIDxwYXRoIGQ9Ik0zMDAgMzEwIFE0MDAgMjkwIDUwMCAzMTAiIHN0cm9rZS13aWR0aD0iMiIgZmlsbD0ibm9uZSI+CiAgICAgICAgICAgIDxhbmltYXRlIGF0dHJpYnV0ZU5hbWU9ImQiIHZhbHVlcz0iCiAgICAgICAgTTMwMCAzMTAgUTQwMCAyOTAgNTAwIDMxMDsKICAgICAgICBNMzAwIDMxNSBRNDAwIDI5NSA1MDAgMzE1OwogICAgICAgIE0zMDAgMzEwIFE0MDAgMjkwIDUwMCAzMTAiIGR1cj0iNHMiIHJlcGVhdENvdW50PSJpbmRlZmluaXRlIiAvPgogICAgICAgIDwvcGF0aD4KICAgIDwvZz4KCiAgICA8IS0tIFNlYXNoZWxscyAtLT4KICAgIDxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKDUwMCA1MjApIj4KICAgICAgICA8cGF0aCBkPSJNMCAwIFExMCAtMjAgMjAgMCBRMTAgMTAgMCAwIiBmaWxsPSIjRkZCNkMxIiAvPgogICAgICAgIDxwYXRoIGQ9Ik0zMCA1IFE0MCAtMTUgNTAgNSBRNDAgMTUgMzAgNSIgZmlsbD0id2hpdGUiIC8+CiAgICAgICAgPHBhdGggZD0iTTYwIDAgUTcwIC0yMCA4MCAwIFE3MCAxMCA2MCAwIiBmaWxsPSIjRTZFNkZBIiAvPgogICAgPC9nPgoKICAgIDwhLS0gU2FpbGJvYXQgLS0+CiAgICA8ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSg0MDAgMzUwKSI+CiAgICAgICAgPHBhdGggZD0iTTAgNTAgTDUwIDAgTDAgLTUwIFoiIGZpbGw9IiNGRjQ1MDAiIC8+CiAgICAgICAgPHBhdGggZD0iTTAgNTAgUS0zMCA0MCAtNTAgNjAgTDAgNTAiIGZpbGw9IiM4QjQ1MTMiIC8+CiAgICAgICAgPGFuaW1hdGVNb3Rpb24gcGF0aD0iTTAgMCBRMTAwIC01MCAyMDAgMCBRMzAwIDUwIDQwMCAwIiBkdXI9IjIwcyIgcmVwZWF0Q291bnQ9ImluZGVmaW5pdGUiIC8+CiAgICA8L2c+Cjwvc3ZnPg==";

    string public constant BEACH_URI =
        "data:application/json;base64,PHN2ZyB3aWR0aD0iODAwIiBoZWlnaHQ9IjYwMCIgdmlld0JveD0iMCAwIDgwMCA2MDAiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CiAgICA8ZGVmcz4KICAgICAgICA8bGluZWFyR3JhZGllbnQgaWQ9InNreUdyYWRpZW50IiB4MT0iMCUiIHkxPSIwJSIgeDI9IjAlIiB5Mj0iMTAwJSI+CiAgICAgICAgICAgIDxzdG9wIG9mZnNldD0iMCUiIHN0b3AtY29sb3I9IiM4N0NFRUIiIC8+CiAgICAgICAgICAgIDxzdG9wIG9mZnNldD0iMTAwJSIgc3RvcC1jb2xvcj0iI0UwRjZGRiIgLz4KICAgICAgICA8L2xpbmVhckdyYWRpZW50PgoKICAgICAgICA8cmFkaWFsR3JhZGllbnQgaWQ9InN1bkdsb3ciPgogICAgICAgICAgICA8c3RvcCBvZmZzZXQ9IjcwJSIgc3RvcC1jb2xvcj0iI0ZGRDcwMCIgLz4KICAgICAgICAgICAgPHN0b3Agb2Zmc2V0PSIxMDAlIiBzdG9wLWNvbG9yPSJ0cmFuc3BhcmVudCIgLz4KICAgICAgICA8L3JhZGlhbEdyYWRpZW50PgoKICAgICAgICA8ZmlsdGVyIGlkPSJ3YXZlRmlsdGVyIj4KICAgICAgICAgICAgPGZlVHVyYnVsZW5jZSB0eXBlPSJmcmFjdGFsTm9pc2UiIGJhc2VGcmVxdWVuY3k9IjAuMDIgMC4wNSIgbnVtT2N0YXZlcz0iMyIgLz4KICAgICAgICAgICAgPGZlRGlzcGxhY2VtZW50TWFwIGluPSJTb3VyY2VHcmFwaGljIiBzY2FsZT0iMyIgLz4KICAgICAgICA8L2ZpbHRlcj4KICAgIDwvZGVmcz4KCiAgICA8IS0tIFNreSAtLT4KICAgIDxyZWN0IHdpZHRoPSI4MDAiIGhlaWdodD0iNjAwIiBmaWxsPSJ1cmwoI3NreUdyYWRpZW50KSIgLz4KCiAgICA8IS0tIFN1biAtLT4KICAgIDxjaXJjbGUgY3g9IjcwMCIgY3k9IjEwMCIgcj0iNTAiIGZpbGw9InVybCgjc3VuR2xvdykiIG9wYWNpdHk9IjAuOCI+CiAgICAgICAgPGFuaW1hdGUgYXR0cmlidXRlTmFtZT0iciIgdmFsdWVzPSI1MDs1NTs1MCIgZHVyPSI4cyIgcmVwZWF0Q291bnQ9ImluZGVmaW5pdGUiIC8+CiAgICA8L2NpcmNsZT4KCiAgICA8IS0tIE9jZWFuIC0tPgogICAgPHBhdGggZD0iTTAgMzAwIFE0MDAgMzIwIDgwMCAzMDAgTDgwMCA2MDAgTDAgNjAwIFoiIGZpbGw9IiM0NjgyQjQiIGZpbHRlcj0idXJsKCN3YXZlRmlsdGVyKSIgLz4KCiAgICA8IS0tIFNhbmQgLS0+CiAgICA8cGF0aCBkPSJNMCA0NTAgUTIwMCA0MzAgNDAwIDQ0MCBRNjAwIDQ1MCA4MDAgNDMwIEw4MDAgNjAwIEwwIDYwMCBaIiBmaWxsPSIjRjRBNDYwIj4KICAgICAgICA8YW5pbWF0ZSBhdHRyaWJ1dGVOYW1lPSJkIiB2YWx1ZXM9IgogICAgICBNMCA0NTAgUTIwMCA0MzAgNDAwIDQ0MCBRNjAwIDQ1MCA4MDAgNDMwIEw4MDAgNjAwIEwwIDYwMCBaOwogICAgICBNMCA0NTAgUTIwMCA0NDAgNDAwIDQzNSBRNjAwIDQ0MCA4MDAgNDQwIEw4MDAgNjAwIEwwIDYwMCBaOwogICAgICBNMCA0NTAgUTIwMCA0MzAgNDAwIDQ0MCBRNjAwIDQ1MCA4MDAgNDMwIEw4MDAgNjAwIEwwIDYwMCBaIiBkdXI9IjZzIiByZXBlYXRDb3VudD0iaW5kZWZpbml0ZSIgLz4KICAgIDwvcGF0aD4KCiAgICA8IS0tIFBhbG0gVHJlZSAtLT4KICAgIDxwYXRoIGQ9Ik0xMDAgNDUwIEMxMjAgMzAwIDE0MCAyNTAgMTUwIDIwMCIgc3Ryb2tlPSIjOEI0NTEzIiBzdHJva2Utd2lkdGg9IjE1IiBzdHJva2UtbGluZWNhcD0icm91bmQiIC8+CiAgICA8cGF0aCBkPSJNMTUwIDIwMCBxLTQwIC01MCAtMjAgLTEwMCBxNjAgMCAyMCAxMDAgcS00MCAtNTAgMCAtMTAwIHE0MCA1MCAwIDEwMCIgZmlsbD0iIzIyOEIyMiIgLz4KCiAgICA8IS0tIENsb3VkcyAtLT4KICAgIDxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKDIwMCAxMDApIj4KICAgICAgICA8Y2lyY2xlIGN4PSI1MCIgY3k9IjMwIiByPSIzMCIgZmlsbD0id2hpdGUiIC8+CiAgICAgICAgPGNpcmNsZSBjeD0iODAiIGN5PSIyMCIgcj0iMjUiIGZpbGw9IndoaXRlIiAvPgogICAgICAgIDxjaXJjbGUgY3g9IjExMCIgY3k9IjMwIiByPSIyOCIgZmlsbD0id2hpdGUiIC8+CiAgICAgICAgPGFuaW1hdGVUcmFuc2Zvcm0gYXR0cmlidXRlTmFtZT0idHJhbnNmb3JtIiB0eXBlPSJ0cmFuc2xhdGUiIHZhbHVlcz0iMjAwIDEwMDsgMjIwIDEwMDsgMjAwIDEwMCIgZHVyPSIxMnMiCiAgICAgICAgICAgIHJlcGVhdENvdW50PSJpbmRlZmluaXRlIiAvPgogICAgPC9nPgoKICAgIDwhLS0gV2F2ZXMgLS0+CiAgICA8ZyBzdHJva2U9IndoaXRlIiBvcGFjaXR5PSIwLjYiPgogICAgICAgIDxwYXRoIGQ9Ik01MCAzMjAgUTE1MCAzMDAgMjUwIDMyMCIgc3Ryb2tlLXdpZHRoPSIyIiBmaWxsPSJub25lIj4KICAgICAgICAgICAgPGFuaW1hdGUgYXR0cmlidXRlTmFtZT0iZCIgdmFsdWVzPSIKICAgICAgICBNNTAgMzIwIFExNTAgMzAwIDI1MCAzMjA7CiAgICAgICAgTTUwIDMyNSBRMTUwIDMwNSAyNTAgMzI1OwogICAgICAgIE01MCAzMjAgUTE1MCAzMDAgMjUwIDMyMCIgZHVyPSIzcyIgcmVwZWF0Q291bnQ9ImluZGVmaW5pdGUiIC8+CiAgICAgICAgPC9wYXRoPgogICAgICAgIDxwYXRoIGQ9Ik0zMDAgMzEwIFE0MDAgMjkwIDUwMCAzMTAiIHN0cm9rZS13aWR0aD0iMiIgZmlsbD0ibm9uZSI+CiAgICAgICAgICAgIDxhbmltYXRlIGF0dHJpYnV0ZU5hbWU9ImQiIHZhbHVlcz0iCiAgICAgICAgTTMwMCAzMTAgUTQwMCAyOTAgNTAwIDMxMDsKICAgICAgICBNMzAwIDMxNSBRNDAwIDI5NSA1MDAgMzE1OwogICAgICAgIE0zMDAgMzEwIFE0MDAgMjkwIDUwMCAzMTAiIGR1cj0iNHMiIHJlcGVhdENvdW50PSJpbmRlZmluaXRlIiAvPgogICAgICAgIDwvcGF0aD4KICAgIDwvZz4KCiAgICA8IS0tIFNlYXNoZWxscyAtLT4KICAgIDxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKDUwMCA1MjApIj4KICAgICAgICA8cGF0aCBkPSJNMCAwIFExMCAtMjAgMjAgMCBRMTAgMTAgMCAwIiBmaWxsPSIjRkZCNkMxIiAvPgogICAgICAgIDxwYXRoIGQ9Ik0zMCA1IFE0MCAtMTUgNTAgNSBRNDAgMTUgMzAgNSIgZmlsbD0id2hpdGUiIC8+CiAgICAgICAgPHBhdGggZD0iTTYwIDAgUTcwIC0yMCA4MCAwIFE3MCAxMCA2MCAwIiBmaWxsPSIjRTZFNkZBIiAvPgogICAgPC9nPgoKICAgIDwhLS0gU2FpbGJvYXQgLS0+CiAgICA8ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSg0MDAgMzUwKSI+CiAgICAgICAgPHBhdGggZD0iTTAgNTAgTDUwIDAgTDAgLTUwIFoiIGZpbGw9IiNGRjQ1MDAiIC8+CiAgICAgICAgPHBhdGggZD0iTTAgNTAgUS0zMCA0MCAtNTAgNjAgTDAgNTAiIGZpbGw9IiM4QjQ1MTMiIC8+CiAgICAgICAgPGFuaW1hdGVNb3Rpb24gcGF0aD0iTTAgMCBRMTAwIC01MCAyMDAgMCBRMzAwIDUwIDQwMCAwIiBkdXI9IjIwcyIgcmVwZWF0Q291bnQ9ImluZGVmaW5pdGUiIC8+CiAgICA8L2c+Cjwvc3ZnPg==";

    address USER = makeAddr("user");

    function setUp() public {
        citiesNFT = new CitiesNFT(CITY_URI, BEACH_URI);
    }

    function testDefaultToCity() public {
        vm.prank(USER);
        citiesNFT.mintNft();
        console.log(citiesNFT.tokenURI(0));
    }
}
