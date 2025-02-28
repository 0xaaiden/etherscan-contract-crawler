// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: DEFΞCTZ
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

//////////////////////////////////////////////////////////////////
//                                                              //
//                                                              //
//     ▄▄▄       ██▓    ▄▄▄       ███▄    █      ▄████          //
//    ▒████▄    ▓██▒   ▒████▄     ██ ▀█   █     ██▒ ▀█▒         //
//    ▒██  ▀█▄  ▒██░   ▒██  ▀█▄  ▓██  ▀█ ██▒   ▒██░▄▄▄░         //
//    ░██▄▄▄▄██ ▒██░   ░██▄▄▄▄██ ▓██▒  ▐▌██▒   ░▓█  ██▓         //
//     ▓█   ▓██▒░██████▒▓█   ▓██▒▒██░   ▓██░   ░▒▓███▀▒ ██▓     //
//     ▒▒   ▓▒█░░ ▒░▓  ░▒▒   ▓▒█░░ ▒░   ▒ ▒     ░▒   ▒  ▒▓▒     //
//      ▒   ▒▒ ░░ ░ ▒  ░ ▒   ▒▒ ░░ ░░   ░ ▒░     ░   ░  ░▒      //
//      ░   ▒     ░ ░    ░   ▒      ░   ░ ░    ░ ░   ░  ░       //
//          ░  ░    ░  ░     ░  ░         ░          ░   ░      //
//                                                       ░      //
//                                                              //
//                                                              //
//////////////////////////////////////////////////////////////////


contract DFCTZ is ERC721Creator {
    constructor() ERC721Creator(unicode"DEFΞCTZ", "DFCTZ") {}
}