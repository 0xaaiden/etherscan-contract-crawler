// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: CHECKS 2048
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

/////////////////////////////////////////////////////////////////////////////////////////
//                                                                                     //
//                                                                                     //
//                                                                                     //
//     ________  ___  ___  _______   ________  ___  __    ________                     //
//    |\   ____\|\  \|\  \|\  ___ \ |\   ____\|\  \|\  \ |\   ____\                    //
//    \ \  \___|\ \  \\\  \ \   __/|\ \  \___|\ \  \/  /|\ \  \___|_                   //
//     \ \  \    \ \   __  \ \  \_|/_\ \  \    \ \   ___  \ \_____  \                  //
//      \ \  \____\ \  \ \  \ \  \_|\ \ \  \____\ \  \\ \  \|____|\  \                 //
//       \ \_______\ \__\ \__\ \_______\ \_______\ \__\\ \__\____\_\  \                //
//        \|_______|\|__|\|__|\|_______|\|_______|\|__| \|__|\_________\               //
//                                                          \|_________|               //
//                                                                                     //
//                                                                                     //
//                            _______  ________  ___   ___  ________                   //
//                           /  ___  \|\   __  \|\  \ |\  \|\   __  \                  //
//                          /__/|_/  /\ \  \|\  \ \  \\_\  \ \  \|\  \                 //
//                          |__|//  / /\ \  \\\  \ \______  \ \   __  \                //
//                              /  /_/__\ \  \\\  \|_____|\  \ \  \|\  \               //
//                             |\________\ \_______\     \ \__\ \_______\              //
//                              \|_______|\|_______|      \|__|\|_______|              //
//                                                                                     //
//                                                                                     //
//                                                                                     //
//                                                                                     //
//                                                                                     //
//                                                                                     //
/////////////////////////////////////////////////////////////////////////////////////////


contract C2048 is ERC721Creator {
    constructor() ERC721Creator("CHECKS 2048", "C2048") {}
}