// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: WAGMI Music Blue Edition
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

///////////////////////////////////////////////////////////////////////
//                                                                   //
//                                                                   //
//     ___       __   ________  ________  _____ ______   ___         //
//    |\  \     |\  \|\   __  \|\   ____\|\   _ \  _   \|\  \        //
//    \ \  \    \ \  \ \  \|\  \ \  \___|\ \  \\\__\ \  \ \  \       //
//     \ \  \  __\ \  \ \   __  \ \  \  __\ \  \\|__| \  \ \  \      //
//      \ \  \|\__\_\  \ \  \ \  \ \  \|\  \ \  \    \ \  \ \  \     //
//       \ \____________\ \__\ \__\ \_______\ \__\    \ \__\ \__\    //
//        \|____________|\|__|\|__|\|_______|\|__|     \|__|\|__|    //
//                                                                   //
//                                                                   //
//                                                                   //
//                                                                   //
//                                                                   //
///////////////////////////////////////////////////////////////////////


contract WAGMI is ERC721Creator {
    constructor() ERC721Creator("WAGMI Music Blue Edition", "WAGMI") {}
}