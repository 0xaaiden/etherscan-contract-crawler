// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Open Editions by Byron Grobler
/// @author: manifold.xyz

import "./ERC721Creator.sol";

////////////////////////////////////////////////////////////////
//                                                            //
//                                                            //
//                                                            //
//     ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄        ▄     //
//    ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░▌      ▐░▌    //
//    ▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀▀▀ ▐░▌░▌     ▐░▌    //
//    ▐░▌       ▐░▌▐░▌       ▐░▌▐░▌          ▐░▌▐░▌    ▐░▌    //
//    ▐░▌       ▐░▌▐░█▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄▄▄ ▐░▌ ▐░▌   ▐░▌    //
//    ▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░▌  ▐░▌  ▐░▌    //
//    ▐░▌       ▐░▌▐░█▀▀▀▀▀▀▀▀▀ ▐░█▀▀▀▀▀▀▀▀▀ ▐░▌   ▐░▌ ▐░▌    //
//    ▐░▌       ▐░▌▐░▌          ▐░▌          ▐░▌    ▐░▌▐░▌    //
//    ▐░█▄▄▄▄▄▄▄█░▌▐░▌          ▐░█▄▄▄▄▄▄▄▄▄ ▐░▌     ▐░▐░▌    //
//    ▐░░░░░░░░░░░▌▐░▌          ▐░░░░░░░░░░░▌▐░▌      ▐░░▌    //
//     ▀▀▀▀▀▀▀▀▀▀▀  ▀            ▀▀▀▀▀▀▀▀▀▀▀  ▀        ▀▀     //
//                                                            //
//     ▄         ▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄            ▄▄▄▄▄▄▄▄▄▄      //
//    ▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░▌          ▐░░░░░░░░░░▌     //
//    ▐░▌       ▐░▌ ▀▀▀▀█░█▀▀▀▀ ▐░▌          ▐░█▀▀▀▀▀▀▀█░▌    //
//    ▐░▌       ▐░▌     ▐░▌     ▐░▌          ▐░▌       ▐░▌    //
//    ▐░▌   ▄   ▐░▌     ▐░▌     ▐░▌          ▐░▌       ▐░▌    //
//    ▐░▌  ▐░▌  ▐░▌     ▐░▌     ▐░▌          ▐░▌       ▐░▌    //
//    ▐░▌ ▐░▌░▌ ▐░▌     ▐░▌     ▐░▌          ▐░▌       ▐░▌    //
//    ▐░▌▐░▌ ▐░▌▐░▌     ▐░▌     ▐░▌          ▐░▌       ▐░▌    //
//    ▐░▌░▌   ▐░▐░▌ ▄▄▄▄█░█▄▄▄▄ ▐░█▄▄▄▄▄▄▄▄▄ ▐░█▄▄▄▄▄▄▄█░▌    //
//    ▐░░▌     ▐░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░▌     //
//     ▀▀       ▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀      //
//                                                            //
//                                                            //
//                                                            //
////////////////////////////////////////////////////////////////


contract OWILD is ERC721Creator {
    constructor() ERC721Creator("Open Editions by Byron Grobler", "OWILD") {}
}