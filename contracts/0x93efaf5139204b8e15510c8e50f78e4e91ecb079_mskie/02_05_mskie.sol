// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: meowski12 editions
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

//////////////////////////////////////////////////////////////////////////////////
//                                                                              //
//                                                                              //
//    ░░░░░░░░░░▓▓▓▓░░░░░░░░░░░░░░░░░░▒▓▓▓▓░░░░░░░░░░░░░░░░░░▒▓▓▓▓░░░░░░░░░░    //
//    ░░░░░░░░░░▒▓▓▓▒░░░░░░░░░░░░▒▒░░░░▓▓▓▒░░░░░▒░░░░░░░░░░░░▒▓▓▓▒░░░░░░░░░░    //
//    ░░░░░░░░░▒▒▓▓▓▒░░░░░▒▒▒▒▒▒▒▒▒░░░▒▒▓▓▒▒▒░░▒▒▒▒▒▒▒▒▒░░░░░▒▓▓▓▒▒░░░░░░░░░    //
//    ░░░▒▒▒░░░░▒▒▓▓▓▒░░░░░▒▒▒▒▒▒▒▒░░░░▒▓▓▒░░░░▒▒▒▒▒▒▒▒░░░░░▒▓▓▓▒▒▒░░░▒▒▒▒░░    //
//    ░░▒▒▒▒░░░░░░▒▓▓▓▒░▒▒▒▒▒▒▒▒░░░░░░░▒▓▓░░░░░░░▒▒▒▒▒▒▒░▒░▒▓▓▓▒▒░░░░░░▒▒▒░░    //
//    ░▒▒▒▒▒▒░░░░░░▒▒▒▒▒▒░░░░░░▒▒░░░░░░▒▓▓▒░░░░░░▒▒▒░░░▒░▒▒▒▒▒▒░░░░░░▒▒▒▒▒▒░    //
//    ▓▓▓▒▒▒▒░░░░░░░▒▒▒▓░░░▒▒▒░░░▒▒░░░░▒▒▒▒░░░░▒▒░░░▒▒░▒░░▓▒▒▒░░░░░░░▒▒▒▒▒▓▓    //
//    ▓▓▓▓▓▓▓▓▒▒▒▒░░░░░▒░░▒░░░▒▒░░░▒░░░▒▒▒▒░░▒▒░░░▒░░░░▒░░▓░░░░░▒▒▒▒▒▓▓▓▓▓▓▒    //
//    ░░▒▒▒▓▓▓▓▓▓▓▒░░░░▒░░▒░░░░░░░░░▒░░░░░░░░▒░░░░░░░░░▒░░▒░░░░▒▓▓▓▓▓▓▓▓▒▒░░    //
//    ░▒▒▒▒▒▒▒▒▓▓▓▓▓▒░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓░░▒▓▓▓▓▒▒▒▒▒▒▒▒▒░    //
//    ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░    //
//    ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒    //
//    ▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▓▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▓▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓    //
//    ▓▓▓▒▒▒▒▒▒▒▒▒░░▒░░░░▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒░░░▒░░▒▒▒▒▒▒▒▒▒▓▓▓    //
//    ▒▓▓▓▒▒▒▒▒▒▒▒░░▒░░░░▒▓▒▒▒░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓░░░░▒░░▒▒▒▒▒▒▒▒▓▓▒░    //
//    ░▒▓▓▓▒▒▒▒░░░▒░▒░░░░▓░░░░░░░▒▒░▒░░░░░░░░▒▒▒░░░▒░░░░▒░░░░▒░▒░░░▒▒▒▒▓▓▒▒░    //
//    ▒▒▒▒▓▓▒▒▒▒▒▒▒░▒░░░░▒░░░▒▒▒▒▒░░░░░░░░░░░░░▒▒▒▒▒░░░░▓░░░░▒░▒▒▒▒▒▒▒▓▓▒▒▒▒    //
//    ▒▒▒▒▒▓▓▒░▒▒▒▒░▒░░░░▒▒░░░▒▒▒▒▒░░░░░░░░░░░▒▒▒▒▒▒░░░░▒░░░░▒░▒▒▒▒░▒▓▓▒▒▒▒▒    //
//    ░▒▒▒▒▒▓▓▓▒▒▒░░▒░░░░▒▒░░▒▒▒░░▒▒░░▒▒▒▒▒░░░▒░░░▒░▒░░░▒░░░░▒░░▒▒▒▓▓▓▒▒▒▒▒░    //
//    ░░▒▒▒▒▒▓▓▓▒▒▒░▒░░░░░▒░░░░░░░░░▒▒▒▒▒▒▒▒▒░░░░░░░░░░▓░░░░▒░░▒▒▓▓▓▒▒▒▒▒▒░░    //
//    ▓▒▒▒▒▒▒▒▒▓▓▓▒▒░▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒░▒▒▓▓▒▒▒▒▒▒▒▒▒▓    //
//    ▓▓▒▒▒▒▒▒▒▒▒▓▓▒░▒▒▒▒▒▒▒▒▒▒▒▒░▒░░░░░▒▒░░░░░░▒▒▒▒▒▒▓▒▒▒▒▒░░▒▓▒▒▒▒▒▒▒▒▒▒▓▓    //
//    ▓▓▓▒▒░▒▒▒▒▒▒▒▓▓▒░▒▒▒░▒▒▒▒▒▒░▒░░░▒▒▒░▒▒░░░░░▒▒▒▒▒▒▒▒▒░░▒▓▓▒▒▒▒▒▒▒░▒▒▓▓▓    //
//    ▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒    //
//    ░░░▒▒▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▒░░░░▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▒▒░░░    //
//    ░░░░▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒░▒▒░░░▒▒▒▒░░▒▒▒░▒▒▒▒▒▒▒▓▓▒▓▓▓▒▒▒▒▒▒▒▒▒▒░░░░    //
//    ░░░░▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒░▒▒▒▒░░░▒▒░░▒▒▒░▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒░░▒▒▒▒░░░░    //
//    ░░░░▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▓▓▒▓▒▒▒▒░░░▒░▒▒▒▒░░▒▒▒▒▒▓▒▓▓▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒░░░░    //
//    ░░░░░▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒░░░░░    //
//    ░░▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒░░    //
//    ▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒░░░▒▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▒▒░░▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒    //
//    ▓▓▓▓▒░▒▒▒░░░▒░░░░▒▒░░░▒▒▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▒░░░░▒▒░░░░▒░░░▒▒▒░▒▓▓▓▓    //
//    ░▒▒▓▓▒░▒▒░░░▒▒▒▓▓▓▓▓▓▓▓▓▓▒▓▒▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▒▒▒░░░▒▒▒▓▓▓▒▒░    //
//    ░░░▒▓▓▒░▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒░░▒▓▓▒░░░    //
//    ░░░░▓▓▒▒▓▓▓▒▒▒░▒▒▒░░░▒▒▒░▒▒▒▓▓▓▓▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒░▒░▒▒▒▒▒▒▒▒▓▓▓▒▓▓▓░░░░    //
//                                                                              //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////


contract mskie is ERC1155Creator {
    constructor() ERC1155Creator("meowski12 editions", "mskie") {}
}