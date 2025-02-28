// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: id 89
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                            //
//                                                                                            //
//                                                                                            //
//        ▓▓░  .▀█▓█▓████▓▓██▓████▓▓▓███▓▓▓███▓▓█▓▓▓▓▓▀╜`                 .,,     ─~. .  .    //
//        ▓▓▓▓▄,  `▀▀██████▓████▓▓▓█▓█████████▓▓▓╜╜     .~─ ,,╓╓╖[email protected]@╣@╢╢@▒▒@@@@[email protected]Ñ╢╣╣▓@@╣╬    //
//        ██▓▓▓▓▓╦    `▀█████████▓███████▓▓▓▓▀"  ,╓@@╣╣▓▓▓▓▓▓▓▓▓▓▓╫▓▓▓╣╣╣╢╫▓╣▓▓@╢╣╬╬╣╢╣╣╢▓    //
//        ████▓▓▓▓▓▓▓U    ╙▀█████▓████▓▓▓▓╜  ,╖@╫▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓╣▓▓▓▓▓╬╢╣▓    //
//        ██████▓▓▓█████▄╖,▄g ╙█████▓▓╨╙  ,▄▓▓▓██▓▓▓██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    //
//        ████████▓▓████████▓M,~ "▀▓▒. ╓φ▓███████████▓██▓▓▓█████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    //
//        ██████████▓▓▓██████⌐▀▓▓▓▓▓█▓p  ▐███████████████████████████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    //
//        ████████████▓▓████████████▓▓▒w⌐═]▒▀█████████████████████████████▓▓▓▓▓▓▓▓▓███▓▓█▓    //
//        █████████████▀▀████████████▓╣WÑ▓▓▓▓▓▓▓██████████████████████████████████████████    //
//        █████████████▓████████████▓▓▓▓▓▓▓▓▀▀▀"`▀▀▀▀▀████████████████████████████████████    //
//        ███████████████████████████▓▓██░               `▀███████████████████████████████    //
//        ███████████████████▀▀█████████▓                    ▀████████████████████████████    //
//        ████████████▓▓▀████████████▓▓   ─,                    ▀█████████████████████████    //
//        ███████████▓▓,╫▓███████████▓▓▒░   `░                    ▀███████████████████████    //
//        ██████████▓▓▒▓▓██████████████▓▓▒░   ╙@    ░      `~      ▀██████████████████████    //
//        ██████████▓╫▓███████████████████▓▒▒,  █▄  ▄▒▒╖,    ░≡     "█████████████████████    //
//        █████████▓▓▓█████████████████████▓▓@▒░░██  `"▓▓▓▓╣▒▒▒╢     ▐████████████████████    //
//        ████████▓╫▓████████████████████████▓▓▒▒███▄▄▄▄████▓▓▓▒      ████████████████████    //
//        ███████▌▒▓██████████████████████████▓▓▓█████████████▓▓░  ░▒ ████████████████████    //
//        ███████▒▓███████████████████████████████████████████▓Ñ░░░▒▒`▐███████████████████    //
//        ██████▌▓██████████████████████████████████████████▀░▒▒▒▒▒▒╢`████████████████████    //
//        █████▓▒▓██████████████████████████████████████▓╣▒▒▒▒▒▒▒▒▒▒▌▐████████████████████    //
//        █████▌▓██████████████████████████████████▓▓▓▓▓▓▓▓╣▒╣▓╣▒▒g▀▄█████████████████████    //
//        ████▓▒▓█████████████████████████████████████▓▓▓▓▓▓▓▓▓▓▒▓`███████████████████████    //
//        ████▓▐▓████████████████████████████████████████▓▓▓▓▓▓▓▓█████████████████████████    //
//        ████▓▓▓██████████████████████████████████████████▓▓█████████████████████████████    //
//        ████▌▓██████████████████████████████████████████████████████████████████████████    //
//        ████▓▓██████████████████████████████████████████████████████████████████████████    //
//        ████▌▓██████████████████████████████████████████████████████████████████████████    //
//        ████▌▓██████████████████████████████████████████████████████████████████████████    //
//        ████▌▓▓█████████████████████████████████████████████████████████████████████████    //
//        ████▓▓██████████████████████████████████████████████████████████████████████████    //
//        █████▓▓█████████████████████████████████████████████████████████████████████████    //
//        █████▓▓▓████████████████████████████████████████████████████████████████████████    //
//        ██████▓▓████████████████████████████████████████████████████████████████████████    //
//                                                                                            //
//                                                                                            //
//                                                                                            //
////////////////////////////////////////////////////////////////////////////////////////////////


contract ID89 is ERC721Creator {
    constructor() ERC721Creator("id 89", "ID89") {}
}