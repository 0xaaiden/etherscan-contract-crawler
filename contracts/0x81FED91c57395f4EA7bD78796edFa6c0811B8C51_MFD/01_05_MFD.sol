// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Melody Figments
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                            //
//                                                                                                            //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMFD    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNKKKKOO0KWMMMMMMMMFD    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMW0olkkl'...'c0WMMMMMMFD    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMKl..kXl       ;KMMMMMMFD    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWO,  ;XXc       ;XMMMMMMFD    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWO'   ;KW0c.   .:0WMMMMMMFD    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMK,    .xWMWKOkOKWMMMMMMMMFD    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWo      .kWMMMMMMMMMMMMMMMFD    //
//    MMMMMMMMMMMMMWWWNNNNNNNXXKK00OXWMMWNKOkkO0KNMMMMMMMMMWX0OkkOKNWMMMMMMWWN0,       .oXNNWWMMMMMMMMMMFD    //
//    MMMMMMMMMMWKkddxOko;'....... .oNN0x:.     .,l0WMMNXKkl'     .'ckNMMMMNXXx.         lXXXNWMMMMMMMMMFD    //
//    MMMMMMMMMXo'.   'o0o.         cKKKXKl.       .dNX00KXXx.       .cXMMMMMMk.         lWMMMMMMMMMMMMMFD    //
//    MMMMMMMMMx.      .xk.         ;KWMMM0,        .d0NMMMMNc         lNMMMMMk.         lWMMMMMMMMMMMMMFD    //
//    MMMMMMMMWx.      .xk.         cNMMMMK;        .lXMMMMMWl         ,0MMMMMk.         lWMMMMMMMMMMMMMFD    //
//    MMMMMMMMN0kc'...:kNO.         lNMMMMK;        'oXMMMMMWl         .OMMMMMk.         lWMMMMMMMMMMMMMFD    //
//    MMMMMMMMXKWWNKKXWMMO.         lNMMMMK;       ..:XMMMMMWl         .OMMMMMk.         lWMMMMMMMMMMMMMFD    //
//    MMMMMMMMXKWMMMMMMMMO.         lNMMMMK;      .. ;XMMMMMWl         .OMMMMMk.         lWMMMMMMMMMMMMMFD    //
//    MMMMMMMMNKNMMMMMMMMO.         lNMMMMK;     ..  ;XMMMMMWl         .OMMMMMk.         lWMMMMMMMMMMMMMFD    //
//    MMMMMMMMWKKWMMMMMMMO.         lNMMMMK;    ..   ;XMMMMMWl         .OMMMMMk.         lWMMMMMMMMMMMMMFD    //
//    MMMMMMMMMWKXWMMMMMMO.         lNMMMMK;  ...    ;XMMMMMWl         .OMMMMMk.         lWMMMMMMMMMMMMMFD    //
//    MMMMMMMMMMWXKNWMMMMO.         lNMMMMXc...      ;XMMMMMWl         .OMMMMMk.         lWMMMMMMMMMMMMMFD    //
//    MMMMMMMMMMMMNXXXNWMO.         lNMMMMXc.        ;XMMMMMWo         .OMMMMMk.         lWMMMMMMMMMMMMMFD    //
//    MMMMMMMMMMMMMMWNXXXx'...  ....oNMMMMK;         ;KMMMMMNl         .OMMWMWk.         oWMMMMMMMMMMMMMFD    //
//    MMMMMMMMMMMMMMMMWXX0kxxxkkxxxxOXNWWNKxlllllllllxKNNWWNXkolllllllld0NXXXXO:        .xWMMMMMMMMMMMMMFD    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNo.      '0MMMMMMMMMMMMMMFD    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWWMMMWd.     lNMMMMMMMMMMMMMMFD    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWKo:;;cxXMXc    ;KMMMMMMMMMMMMMMMFD    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWk'      cXWd   ;0MMMMMMMMMMMMMMMMFD    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNl       .ONl .cKMMMMMMMMMMMMMMMMMFD    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWk'     .oKd,:OWMMMMMMMMMMMMMMMMMMFD    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWKxc::lx0Ok0WMMMMMMMMMMMMMMMMMMMMFD    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWNNNNWWMMMMMMMMMMMMMMMMMMMMMMMFD    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMFDYNAMICS    //
//                                                                                                            //
//                                                                                                            //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract MFD is ERC721Creator {
    constructor() ERC721Creator("Melody Figments", "MFD") {}
}