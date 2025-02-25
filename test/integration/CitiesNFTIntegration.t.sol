// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test, console} from "../../lib/forge-std/src/Test.sol";
import {CitiesNFT} from "../../src/CitiesNFT.sol";
import {DeployCitiesNFT} from "../../script/DeployCitiesNft.s.sol";

contract TestCitiesNFTDeployIntegration is Test {
    address owner = address(1);
    uint256 tokenId = 1;

    CitiesNFT citiesNFT;
    string public constant BEACH_IMG_URI =
        "data:application/json;base64,eyJuYW1lIjoiQ2l0aWVzTkZUIiwgImRlc2NyaXB0aW9uIjoiQW4gTkZUIGZvciB0aGUgc2Vhc29ucyBvZiB0aGUgeWVhciIsICJhdHRyaWJ1dGVzIjpbeyJ0cmFpdF90eXBlIjogInNlYXNvbiIsICJ2YWx1ZSI6MTAwfV0sICJpbWFnZSI6ICJkYXRhOmltYWdlL3N2Zyt4bWw7YmFzZTY0LFBITjJaeUIzYVdSMGFEMGlPREF3SWlCb1pXbG5hSFE5SWpZd01DSWdkbWxsZDBKdmVEMGlNQ0F3SURnd01DQTJNREFpSUhodGJHNXpQU0pvZEhSd09pOHZkM2QzTG5jekxtOXlaeTh5TURBd0wzTjJaeUkrQ2lBZ0lDQThaR1ZtY3o0S0lDQWdJQ0FnSUNBOGJHbHVaV0Z5UjNKaFpHbGxiblFnYVdROUluTnJlVWR5WVdScFpXNTBJaUI0TVQwaU1DVWlJSGt4UFNJd0pTSWdlREk5SWpBbElpQjVNajBpTVRBd0pTSStDaUFnSUNBZ0lDQWdJQ0FnSUR4emRHOXdJRzltWm5ObGREMGlNQ1VpSUhOMGIzQXRZMjlzYjNJOUlpTTROME5GUlVJaUlDOCtDaUFnSUNBZ0lDQWdJQ0FnSUR4emRHOXdJRzltWm5ObGREMGlNVEF3SlNJZ2MzUnZjQzFqYjJ4dmNqMGlJMFV3UmpaR1JpSWdMejRLSUNBZ0lDQWdJQ0E4TDJ4cGJtVmhja2R5WVdScFpXNTBQZ29LSUNBZ0lDQWdJQ0E4Y21Ga2FXRnNSM0poWkdsbGJuUWdhV1E5SW5OMWJrZHNiM2NpUGdvZ0lDQWdJQ0FnSUNBZ0lDQThjM1J2Y0NCdlptWnpaWFE5SWpjd0pTSWdjM1J2Y0MxamIyeHZjajBpSTBaR1JEY3dNQ0lnTHo0S0lDQWdJQ0FnSUNBZ0lDQWdQSE4wYjNBZ2IyWm1jMlYwUFNJeE1EQWxJaUJ6ZEc5d0xXTnZiRzl5UFNKMGNtRnVjM0JoY21WdWRDSWdMejRLSUNBZ0lDQWdJQ0E4TDNKaFpHbGhiRWR5WVdScFpXNTBQZ29LSUNBZ0lDQWdJQ0E4Wm1sc2RHVnlJR2xrUFNKM1lYWmxSbWxzZEdWeUlqNEtJQ0FnSUNBZ0lDQWdJQ0FnUEdabFZIVnlZblZzWlc1alpTQjBlWEJsUFNKbWNtRmpkR0ZzVG05cGMyVWlJR0poYzJWR2NtVnhkV1Z1WTNrOUlqQXVNRElnTUM0d05TSWdiblZ0VDJOMFlYWmxjejBpTXlJZ0x6NEtJQ0FnSUNBZ0lDQWdJQ0FnUEdabFJHbHpjR3hoWTJWdFpXNTBUV0Z3SUdsdVBTSlRiM1Z5WTJWSGNtRndhR2xqSWlCelkyRnNaVDBpTXlJZ0x6NEtJQ0FnSUNBZ0lDQThMMlpwYkhSbGNqNEtJQ0FnSUR3dlpHVm1jejRLQ2lBZ0lDQThJUzB0SUZOcmVTQXRMVDRLSUNBZ0lEeHlaV04wSUhkcFpIUm9QU0k0TURBaUlHaGxhV2RvZEQwaU5qQXdJaUJtYVd4c1BTSjFjbXdvSTNOcmVVZHlZV1JwWlc1MEtTSWdMejRLQ2lBZ0lDQThJUzB0SUZOMWJpQXRMVDRLSUNBZ0lEeGphWEpqYkdVZ1kzZzlJamN3TUNJZ1kzazlJakV3TUNJZ2NqMGlOVEFpSUdacGJHdzlJblZ5YkNnamMzVnVSMnh2ZHlraUlHOXdZV05wZEhrOUlqQXVPQ0krQ2lBZ0lDQWdJQ0FnUEdGdWFXMWhkR1VnWVhSMGNtbGlkWFJsVG1GdFpUMGljaUlnZG1Gc2RXVnpQU0kxTURzMU5UczFNQ0lnWkhWeVBTSTRjeUlnY21Wd1pXRjBRMjkxYm5ROUltbHVaR1ZtYVc1cGRHVWlJQzgrQ2lBZ0lDQThMMk5wY21Oc1pUNEtDaUFnSUNBOElTMHRJRTlqWldGdUlDMHRQZ29nSUNBZ1BIQmhkR2dnWkQwaVRUQWdNekF3SUZFME1EQWdNekl3SURnd01DQXpNREFnVERnd01DQTJNREFnVERBZ05qQXdJRm9pSUdacGJHdzlJaU0wTmpneVFqUWlJR1pwYkhSbGNqMGlkWEpzS0NOM1lYWmxSbWxzZEdWeUtTSWdMejRLQ2lBZ0lDQThJUzB0SUZOaGJtUWdMUzArQ2lBZ0lDQThjR0YwYUNCa1BTSk5NQ0EwTlRBZ1VUSXdNQ0EwTXpBZ05EQXdJRFEwTUNCUk5qQXdJRFExTUNBNE1EQWdORE13SUV3NE1EQWdOakF3SUV3d0lEWXdNQ0JhSWlCbWFXeHNQU0lqUmpSQk5EWXdJajRLSUNBZ0lDQWdJQ0E4WVc1cGJXRjBaU0JoZEhSeWFXSjFkR1ZPWVcxbFBTSmtJaUIyWVd4MVpYTTlJZ29nSUNBZ0lDQk5NQ0EwTlRBZ1VUSXdNQ0EwTXpBZ05EQXdJRFEwTUNCUk5qQXdJRFExTUNBNE1EQWdORE13SUV3NE1EQWdOakF3SUV3d0lEWXdNQ0JhT3dvZ0lDQWdJQ0JOTUNBME5UQWdVVEl3TUNBME5EQWdOREF3SURRek5TQlJOakF3SURRME1DQTRNREFnTkRRd0lFdzRNREFnTmpBd0lFd3dJRFl3TUNCYU93b2dJQ0FnSUNCTk1DQTBOVEFnVVRJd01DQTBNekFnTkRBd0lEUTBNQ0JSTmpBd0lEUTFNQ0E0TURBZ05ETXdJRXc0TURBZ05qQXdJRXd3SURZd01DQmFJaUJrZFhJOUlqWnpJaUJ5WlhCbFlYUkRiM1Z1ZEQwaWFXNWtaV1pwYm1sMFpTSWdMejRLSUNBZ0lEd3ZjR0YwYUQ0S0NpQWdJQ0E4SVMwdElGQmhiRzBnVkhKbFpTQXRMVDRLSUNBZ0lEeHdZWFJvSUdROUlrMHhNREFnTkRVd0lFTXhNakFnTXpBd0lERTBNQ0F5TlRBZ01UVXdJREl3TUNJZ2MzUnliMnRsUFNJak9FSTBOVEV6SWlCemRISnZhMlV0ZDJsa2RHZzlJakUxSWlCemRISnZhMlV0YkdsdVpXTmhjRDBpY205MWJtUWlJQzgrQ2lBZ0lDQThjR0YwYUNCa1BTSk5NVFV3SURJd01DQnhMVFF3SUMwMU1DQXRNakFnTFRFd01DQnhOakFnTUNBeU1DQXhNREFnY1MwME1DQXROVEFnTUNBdE1UQXdJSEUwTUNBMU1DQXdJREV3TUNJZ1ptbHNiRDBpSXpJeU9FSXlNaUlnTHo0S0NpQWdJQ0E4SVMwdElFTnNiM1ZrY3lBdExUNEtJQ0FnSUR4bklIUnlZVzV6Wm05eWJUMGlkSEpoYm5Oc1lYUmxLREl3TUNBeE1EQXBJajRLSUNBZ0lDQWdJQ0E4WTJseVkyeGxJR040UFNJMU1DSWdZM2s5SWpNd0lpQnlQU0l6TUNJZ1ptbHNiRDBpZDJocGRHVWlJQzgrQ2lBZ0lDQWdJQ0FnUEdOcGNtTnNaU0JqZUQwaU9EQWlJR041UFNJeU1DSWdjajBpTWpVaUlHWnBiR3c5SW5kb2FYUmxJaUF2UGdvZ0lDQWdJQ0FnSUR4amFYSmpiR1VnWTNnOUlqRXhNQ0lnWTNrOUlqTXdJaUJ5UFNJeU9DSWdabWxzYkQwaWQyaHBkR1VpSUM4K0NpQWdJQ0FnSUNBZ1BHRnVhVzFoZEdWVWNtRnVjMlp2Y20wZ1lYUjBjbWxpZFhSbFRtRnRaVDBpZEhKaGJuTm1iM0p0SWlCMGVYQmxQU0owY21GdWMyeGhkR1VpSUhaaGJIVmxjejBpTWpBd0lERXdNRHNnTWpJd0lERXdNRHNnTWpBd0lERXdNQ0lnWkhWeVBTSXhNbk1pQ2lBZ0lDQWdJQ0FnSUNBZ0lISmxjR1ZoZEVOdmRXNTBQU0pwYm1SbFptbHVhWFJsSWlBdlBnb2dJQ0FnUEM5blBnb0tJQ0FnSUR3aExTMGdWMkYyWlhNZ0xTMCtDaUFnSUNBOFp5QnpkSEp2YTJVOUluZG9hWFJsSWlCdmNHRmphWFI1UFNJd0xqWWlQZ29nSUNBZ0lDQWdJRHh3WVhSb0lHUTlJazAxTUNBek1qQWdVVEUxTUNBek1EQWdNalV3SURNeU1DSWdjM1J5YjJ0bExYZHBaSFJvUFNJeUlpQm1hV3hzUFNKdWIyNWxJajRLSUNBZ0lDQWdJQ0FnSUNBZ1BHRnVhVzFoZEdVZ1lYUjBjbWxpZFhSbFRtRnRaVDBpWkNJZ2RtRnNkV1Z6UFNJS0lDQWdJQ0FnSUNCTk5UQWdNekl3SUZFeE5UQWdNekF3SURJMU1DQXpNakE3Q2lBZ0lDQWdJQ0FnVFRVd0lETXlOU0JSTVRVd0lETXdOU0F5TlRBZ016STFPd29nSUNBZ0lDQWdJRTAxTUNBek1qQWdVVEUxTUNBek1EQWdNalV3SURNeU1DSWdaSFZ5UFNJemN5SWdjbVZ3WldGMFEyOTFiblE5SW1sdVpHVm1hVzVwZEdVaUlDOCtDaUFnSUNBZ0lDQWdQQzl3WVhSb1Bnb2dJQ0FnSUNBZ0lEeHdZWFJvSUdROUlrMHpNREFnTXpFd0lGRTBNREFnTWprd0lEVXdNQ0F6TVRBaUlITjBjbTlyWlMxM2FXUjBhRDBpTWlJZ1ptbHNiRDBpYm05dVpTSStDaUFnSUNBZ0lDQWdJQ0FnSUR4aGJtbHRZWFJsSUdGMGRISnBZblYwWlU1aGJXVTlJbVFpSUhaaGJIVmxjejBpQ2lBZ0lDQWdJQ0FnVFRNd01DQXpNVEFnVVRRd01DQXlPVEFnTlRBd0lETXhNRHNLSUNBZ0lDQWdJQ0JOTXpBd0lETXhOU0JSTkRBd0lESTVOU0ExTURBZ016RTFPd29nSUNBZ0lDQWdJRTB6TURBZ016RXdJRkUwTURBZ01qa3dJRFV3TUNBek1UQWlJR1IxY2owaU5ITWlJSEpsY0dWaGRFTnZkVzUwUFNKcGJtUmxabWx1YVhSbElpQXZQZ29nSUNBZ0lDQWdJRHd2Y0dGMGFENEtJQ0FnSUR3dlp6NEtDaUFnSUNBOElTMHRJRk5sWVhOb1pXeHNjeUF0TFQ0S0lDQWdJRHhuSUhSeVlXNXpabTl5YlQwaWRISmhibk5zWVhSbEtEVXdNQ0ExTWpBcElqNEtJQ0FnSUNBZ0lDQThjR0YwYUNCa1BTSk5NQ0F3SUZFeE1DQXRNakFnTWpBZ01DQlJNVEFnTVRBZ01DQXdJaUJtYVd4c1BTSWpSa1pDTmtNeElpQXZQZ29nSUNBZ0lDQWdJRHh3WVhSb0lHUTlJazB6TUNBMUlGRTBNQ0F0TVRVZ05UQWdOU0JSTkRBZ01UVWdNekFnTlNJZ1ptbHNiRDBpZDJocGRHVWlJQzgrQ2lBZ0lDQWdJQ0FnUEhCaGRHZ2daRDBpVFRZd0lEQWdVVGN3SUMweU1DQTRNQ0F3SUZFM01DQXhNQ0EyTUNBd0lpQm1hV3hzUFNJalJUWkZOa1pCSWlBdlBnb2dJQ0FnUEM5blBnb0tJQ0FnSUR3aExTMGdVMkZwYkdKdllYUWdMUzArQ2lBZ0lDQThaeUIwY21GdWMyWnZjbTA5SW5SeVlXNXpiR0YwWlNnME1EQWdNelV3S1NJK0NpQWdJQ0FnSUNBZ1BIQmhkR2dnWkQwaVRUQWdOVEFnVERVd0lEQWdUREFnTFRVd0lGb2lJR1pwYkd3OUlpTkdSalExTURBaUlDOCtDaUFnSUNBZ0lDQWdQSEJoZEdnZ1pEMGlUVEFnTlRBZ1VTMHpNQ0EwTUNBdE5UQWdOakFnVERBZ05UQWlJR1pwYkd3OUlpTTRRalExTVRNaUlDOCtDaUFnSUNBZ0lDQWdQR0Z1YVcxaGRHVk5iM1JwYjI0Z2NHRjBhRDBpVFRBZ01DQlJNVEF3SUMwMU1DQXlNREFnTUNCUk16QXdJRFV3SURRd01DQXdJaUJrZFhJOUlqSXdjeUlnY21Wd1pXRjBRMjkxYm5ROUltbHVaR1ZtYVc1cGRHVWlJQzgrQ2lBZ0lDQThMMmMrQ2p3dmMzWm5QZz09In0=";

    DeployCitiesNFT deployer;

    address USER = makeAddr("user");

    function setUp() public {
        deployer = new DeployCitiesNFT();
        citiesNFT = deployer.run();
    }

    function testDefaultToCityIntegrated() public {
        vm.prank(USER);
        citiesNFT.mintNft();
        console.log(citiesNFT.tokenURI(0));
    }

    function testFlipToken() public {
        vm.prank(USER);
        citiesNFT.mintNft();

        vm.prank(USER);
        citiesNFT.flipSeason(0);

        assert(
            keccak256(abi.encodePacked(citiesNFT.tokenURI(0))) ==
                (keccak256(abi.encodePacked(BEACH_IMG_URI)))
        );
    }
}
