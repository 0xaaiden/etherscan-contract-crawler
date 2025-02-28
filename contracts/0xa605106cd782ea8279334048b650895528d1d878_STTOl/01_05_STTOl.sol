// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Super Turtle Toschie
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                  //
//                                                                                                                                  //
//                                                                                                                                  //
//                                                                                                                                  //
//      ____                          _____           _   _        _____              _     _   _              ___  _        __     //
//     / ___| _   _ _ __   ___ _ __  |_   _|   _ _ __| |_| | ___  |_   _|__  ___  ___| |__ (_) | |__  _   _   / _ \| | __ _ / _|    //
//     \___ \| | | | '_ \ / _ \ '__|   | || | | | '__| __| |/ _ \   | |/ _ \/ __|/ __| '_ \| | | '_ \| | | | | | | | |/ _` | |_     //
//      ___) | |_| | |_) |  __/ |      | || |_| | |  | |_| |  __/   | | (_) \__ \ (__| | | | | | |_) | |_| | | |_| | | (_| |  _|    //
//     |____/ \__,_| .__/ \___|_|      |_| \__,_|_|   \__|_|\___|   |_|\___/|___/\___|_| |_|_| |_.__/ \__, |  \___/|_|\__,_|_|      //
//                 |_|                                                                                |___/                         //
//                                                                                                                                  //
//                                                                                                                                  //
//                                                                                                                                  //
//                                                                                                                                  //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract STTOl is ERC1155Creator {
    constructor() ERC1155Creator("Super Turtle Toschie", "STTOl") {}
}