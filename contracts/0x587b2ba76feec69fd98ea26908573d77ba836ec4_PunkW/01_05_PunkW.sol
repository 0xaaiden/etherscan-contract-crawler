// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Punk Walk
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                               //
//                                                                                                                               //
//          ___         ___           ___           ___                    ___           ___                         ___         //
//         /  /\       /__/\         /__/\         /__/|                  /__/\         /  /\                       /__/|        //
//        /  /::\      \  \:\        \  \:\       |  |:|                 _\_ \:\       /  /::\                     |  |:|        //
//       /  /:/\:\      \  \:\        \  \:\      |  |:|                /__/\ \:\     /  /:/\:\    ___     ___     |  |:|        //
//      /  /:/~/:/  ___  \  \:\   _____\__\:\   __|  |:|               _\_ \:\ \:\   /  /:/~/::\  /__/\   /  /\  __|  |:|        //
//     /__/:/ /:/  /__/\  \__\:\ /__/::::::::\ /__/\_|:|____          /__/\ \:\ \:\ /__/:/ /:/\:\ \  \:\ /  /:/ /__/\_|:|____    //
//     \  \:\/:/   \  \:\ /  /:/ \  \:\~~\~~\/ \  \:\/:::::/          \  \:\ \:\/:/ \  \:\/:/__\/  \  \:\  /:/  \  \:\/:::::/    //
//      \  \::/     \  \:\  /:/   \  \:\  ~~~   \  \::/~~~~            \  \:\ \::/   \  \::/        \  \:\/:/    \  \::/~~~~     //
//       \  \:\      \  \:\/:/     \  \:\        \  \:\                 \  \:\/:/     \  \:\         \  \::/      \  \:\         //
//        \  \:\      \  \::/       \  \:\        \  \:\                 \  \::/       \  \:\         \__\/        \  \:\        //
//         \__\/       \__\/         \__\/         \__\/                  \__\/         \__\/                       \__\/        //
//                                                                                                                               //
//                                                                                                                               //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract PunkW is ERC721Creator {
    constructor() ERC721Creator("Punk Walk", "PunkW") {}
}