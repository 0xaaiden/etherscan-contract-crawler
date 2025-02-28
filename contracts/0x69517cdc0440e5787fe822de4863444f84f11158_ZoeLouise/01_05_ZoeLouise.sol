// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Bowie
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

////////////////////////////////////////////////////////////////
//                                                            //
//                                                            //
//    █ ░   █   █░█░█ █ █░░ █░░   █▄▄ █▀▀   █▄▀ █ █▄░█ █▀▀    //
//    █ █   █   ▀▄▀▄▀ █ █▄▄ █▄▄   █▄█ ██▄   █░█ █ █░▀█ █▄█    //
//                                                            //
//                                                            //
////////////////////////////////////////////////////////////////


contract ZoeLouise is ERC721Creator {
    constructor() ERC721Creator("Bowie", "ZoeLouise") {}
}