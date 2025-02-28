// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Game of Life
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                 //
//                                                                                                                 //
//       ______       _       ____    ____  ________     ___   ________   _____     _____  ________  ________      //
//     .' ___  |     / \     |_   \  /   _||_   __  |  .'   `.|_   __  | |_   _|   |_   _||_   __  ||_   __  |     //
//    / .'   \_|    / _ \      |   \/   |    | |_ \_| /  .-.  \ | |_ \_|   | |       | |    | |_ \_|  | |_ \_|     //
//    | |   ____   / ___ \     | |\  /| |    |  _| _  | |   | | |  _|      | |   _   | |    |  _|     |  _| _      //
//    \ `.___]  |_/ /   \ \_  _| |_\/_| |_  _| |__/ | \  `-'  /_| |_      _| |__/ | _| |_  _| |_     _| |__/ |     //
//     `._____.'|____| |____||_____||_____||________|  `.___.'|_____|    |________||_____||_____|   |________|     //
//                                                                                                                 //
//                                                                                                                 //
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract LIFE is ERC721Creator {
    constructor() ERC721Creator("Game of Life", "LIFE") {}
}