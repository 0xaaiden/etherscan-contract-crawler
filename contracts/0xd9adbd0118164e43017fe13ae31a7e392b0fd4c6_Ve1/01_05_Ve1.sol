// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Velella #1
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

/////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                         //
//                                                                                         //
//                                                                                         //
//                                                                                         //
//                                               ╓▒░░▒▒╥╖                                  //
//                                             ▒░▒▒░╢▓╫▓▒▓W                                //
//                                           ▒▒▒▒▒▒▒▒║▓▓▓▓▓▓╗                              //
//                                         ▒▒▒╫▓▒▒░╙▒▒╫╫▓▓▓▓╣▓,                            //
//                                       ╓╖▒▒╣▓▓╣▒╢H▒▒▒▒▓▓▓▓▓▓▓▄                           //
//                                      ╖▒╢╢▓▓▓▓▒╣▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓                          //
//                                    .░╢╫▓▓▓▓▓╓╫╣▒▒▒▒╢╣▒▒▓▓▓▓▓▓▓▓                         //
//                                   ╓▒║╫▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒╢▒▓▓▓▓▓██▓µ                       //
//                                  ╔╬▒╖╙╬▓▓▓▓▓▓▓▓╢▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓█,                      //
//                                 ╒ ░╥╫▓▓▄╙▓▓▓▓▓▓▓▓▓▓╣╬▓▒▒▒▒╢▓▓▓▓▓▓▓,                     //
//                                ]▒▒▒╬▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓╫╬╣▓▓╣╣╢╢▓▓▓▓▓▓▒                     //
//                                ╫╫▒▒▓╣╫▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓╢▓╣╢╢▓▓▓▓▓▓▓                    //
//                               ]▒▒▓╣╬╣╣╣╢▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓╢╣╣▓▓╣▓▓▓▓██▓                   //
//                               ╝╨╢▓▓▓▓D╣▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▓▌                  //
//                              ]╖▓▓▓▄▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓                  //
//                              ]▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ ,               //
//                              ▐▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▌                //
//                              ╫▀▀╢╢╣╬▓▓╣╣╢╣╣╣╣╢╢╢▓╣▓▓▓▓▓╢╢╣▓▓▓▓▓█▓▓▓▓▓▓▓▓W   ,,,         //
//             ` ~            <░░        `╙╨Ñ▓╣▒╣▒╢▒╢╢▓▓╣▓╢╣╢▒▓▓▓▓╣╣╢╢▓▓▓▓▓▓▓▓▓M           //
//                   ╙ "^─~~╓▒    ╖╖@╢╣▓╝▒╜▒▒┐.     ░░╨╢╣╣▓▓▓▓▓▓▓▒╣▓▓▓▓▓▓╣▓▓▓▓,            //
//                         ╣░░,╢░]▒╢▓▓▓▓▓╣@@╣@@╣╣╢║║▒╣╢╫╫╫╣▓▓▓▓╢▒▒▒╖▒▒╢╢▓▓▓▓██▓▓▓╖ ⌐,,,    //
//                        ▓▒▒▒ ╖▒║▓▓▓█████▓▓▓╫╣╢╢╢╣╢▓╣╣╢╢╢╫▓▓▓▓▓▓╣@╢╢╢╢▒▒╢╢▓▓▓▓▓▓▓▓,       //
//                        ║[email protected]@▓▓▓▓█████████▓▓▓╢╢╢╢║▒▒▒▒▒▒╢╢▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓╣▓▓       //
//                         ▓██▓▓██████████▀▀▀▀▀████████████████████▓▓▓▓▓╢▓▓▓▓▓Ñ▓▓╣╢▓       //
//                        ╫▓▓▓▓█████████▓▓▓▒▒▒╖.,░▒▓█████████████████████▌╣╢╢╣▒▒▒▒╨        //
//                        ▐██▓███████▓▓▓▓▓▓▓▓▓╣╢╣╣╫▓▓█████████████████████▀█▒▒▒▒▒`         //
//                          "▀▓▀▀█████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓████████████████▀▀▀╣▒▒▒▒`           //
//                               `▀    ▀▓▓▓▓▓▓▓▓▓▓▓▓▓▓████████████▀/`▀*──*`  ╙▒            //
//                                           ` ╙╜   `  j███████▀▀▐c`    ,     ▒            //
//                                                     ▒▓▓██'                 `            //
//                                                     ▒/Ü▌   `                            //
//                                                    /Γ]r                                 //
//                                                   ƒ ,⌐                                  //
//                                                  ┌  ^                                   //
//                                                                                         //
//                                                                                         //
//                                                                                         //
//                                                                                         //
/////////////////////////////////////////////////////////////////////////////////////////////


contract Ve1 is ERC721Creator {
    constructor() ERC721Creator("Velella #1", "Ve1") {}
}