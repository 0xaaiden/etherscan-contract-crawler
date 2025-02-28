// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: I'm Groot
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                            //
//                                                                                                            //
//                                                                                                            //
//     .----------------.  .----------------.  .----------------.  .----------------.  .----------------.     //
//    | .--------------. || .--------------. || .--------------. || .--------------. || .--------------. |    //
//    | |    ______    | || |  _______     | || |     ____     | || |     ____     | || |  _________   | |    //
//    | |  .' ___  |   | || | |_   __ \    | || |   .'    `.   | || |   .'    `.   | || | |  _   _  |  | |    //
//    | | / .'   \_|   | || |   | |__) |   | || |  /  .--.  \  | || |  /  .--.  \  | || | |_/ | | \_|  | |    //
//    | | | |    ____  | || |   |  __ /    | || |  | |    | |  | || |  | |    | |  | || |     | |      | |    //
//    | | \ `.___]  _| | || |  _| |  \ \_  | || |  \  `--'  /  | || |  \  `--'  /  | || |    _| |_     | |    //
//    | |  `._____.'   | || | |____| |___| | || |   `.____.'   | || |   `.____.'   | || |   |_____|    | |    //
//    | |              | || |              | || |              | || |              | || |              | |    //
//    | '--------------' || '--------------' || '--------------' || '--------------' || '--------------' |    //
//     '----------------'  '----------------'  '----------------'  '----------------'  '----------------'     //
//                                                                                                            //
//                                                                                                            //
//                                                                                                            //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract Groot is ERC721Creator {
    constructor() ERC721Creator("I'm Groot", "Groot") {}
}