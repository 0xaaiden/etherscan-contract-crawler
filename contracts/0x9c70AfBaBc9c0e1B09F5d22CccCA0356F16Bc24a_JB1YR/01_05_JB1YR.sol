// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Jason Betzner 1 Year in NFT
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                                //
//                                                                                                                                                //
//                                                                                                                                                //
//                      ___           ___           ___                                ___                    ___           ___                   //
//          ___        /  /\         /  /\         /  /\                 ___          /__/\                  /__/\         /  /\        ___       //
//         /__/|      /  /:/_       /  /::\       /  /::\               /  /\         \  \:\                 \  \:\       /  /:/_      /  /\      //
//        |  |:|     /  /:/ /\     /  /:/\:\     /  /:/\:\             /  /:/          \  \:\                 \  \:\     /  /:/ /\    /  /:/      //
//        |  |:|    /  /:/ /:/_   /  /:/~/::\   /  /:/~/:/            /__/::\      _____\__\:\            _____\__\:\   /  /:/ /:/   /  /:/       //
//      __|__|:|   /__/:/ /:/ /\ /__/:/ /:/\:\ /__/:/ /:/___          \__\/\:\__  /__/::::::::\          /__/::::::::\ /__/:/ /:/   /  /::\       //
//     /__/::::\   \  \:\/:/ /:/ \  \:\/:/__\/ \  \:\/:::::/             \  \:\/\ \  \:\~~\~~\/          \  \:\~~\~~\/ \  \:\/:/   /__/:/\:\      //
//        ~\~~\:\   \  \::/ /:/   \  \::/       \  \::/~~~~               \__\::/  \  \:\  ~~~            \  \:\  ~~~   \  \::/    \__\/  \:\     //
//          \  \:\   \  \:\/:/     \  \:\        \  \:\                   /__/:/    \  \:\                 \  \:\        \  \:\         \  \:\    //
//           \__\/    \  \::/       \  \:\        \  \:\                  \__\/      \  \:\                 \  \:\        \  \:\         \__\/    //
//                     \__\/         \__\/         \__\/                              \__\/                  \__\/         \__\/                  //
//                                                                                                                                                //
//                                                                                                                                                //
//                                                                                                                                                //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract JB1YR is ERC721Creator {
    constructor() ERC721Creator("Jason Betzner 1 Year in NFT", "JB1YR") {}
}