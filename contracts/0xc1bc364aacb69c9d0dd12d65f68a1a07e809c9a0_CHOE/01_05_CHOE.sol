// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Chainleft Open Editions
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                //
//                                                                                                //
//    |\   ____\|\  \|\  \|\   __  \|\  \|\   ___  \|\  \     |\  ___ \ |\  _____\\___   ___\     //
//    \ \  \___|\ \  \\\  \ \  \|\  \ \  \ \  \\ \  \ \  \    \ \   __/|\ \  \__/\|___ \  \_|     //
//     \ \  \    \ \   __  \ \   __  \ \  \ \  \\ \  \ \  \    \ \  \_|/_\ \   __\    \ \  \      //
//      \ \  \____\ \  \ \  \ \  \ \  \ \  \ \  \\ \  \ \  \____\ \  \_|\ \ \  \_|     \ \  \     //
//       \ \_______\ \__\ \__\ \__\ \__\ \__\ \__\\ \__\ \_______\ \_______\ \__\       \ \__\    //
//        \|_______|\|__|\|__|\|__|\|__|\|__|\|__| \|__|\|_______|\|_______|\|__|        \|__|    //
//                                                                                                //
//                                                                                                //
//                                                                                                //
////////////////////////////////////////////////////////////////////////////////////////////////////


contract CHOE is ERC1155Creator {
    constructor() ERC1155Creator("Chainleft Open Editions", "CHOE") {}
}