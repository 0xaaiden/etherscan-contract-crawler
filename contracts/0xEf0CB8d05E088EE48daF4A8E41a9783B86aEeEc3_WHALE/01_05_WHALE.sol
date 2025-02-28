// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Whale
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

//////////////////////////////////////////////////////
//                                                  //
//                                                  //
//                                                  //
//     ___      ___   _______  _______  __   __     //
//    |   |    |   | |  _    ||  _    ||  | |  |    //
//    |   |    |   | | |_|   || |_|   ||  |_|  |    //
//    |   |    |   | |       ||       ||       |    //
//    |   |___ |   | |  _   | |  _   | |_     _|    //
//    |       ||   | | |_|   || |_|   |  |   |      //
//    |_______||___| |_______||_______|  |___|      //
//                                                  //
//                                                  //
//                                                  //
//////////////////////////////////////////////////////


contract WHALE is ERC721Creator {
    constructor() ERC721Creator("Whale", "WHALE") {}
}