// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Lady of the lake
/// @author: manifold.xyz

import "./ERC721Creator.sol";

/////////////////////////////////////////////////////////////////////////////////////
//                                                                                 //
//                                                                                 //
//                                                                                 //
//      _              _                __   _   _            _       _            //
//     | |    __ _  __| |_   _    ___  / _| | |_| |__   ___  | | __ _| | _____     //
//     | |   / _` |/ _` | | | |  / _ \| |_  | __| '_ \ / _ \ | |/ _` | |/ / _ \    //
//     | |__| (_| | (_| | |_| | | (_) |  _| | |_| | | |  __/ | | (_| |   <  __/    //
//     |_____\__,_|\__,_|\__, |  \___/|_|    \__|_| |_|\___| |_|\__,_|_|\_\___|    //
//      _                |___/    _          _      _                              //
//     | |__  _   _    __ _| |__ | | ___ __ (_) ___| | _____ _ __                  //
//     | '_ \| | | |  / _` | '_ \| |/ / '_ \| |/ __| |/ / _ \ '__|                 //
//     | |_) | |_| | | (_| | |_) |   <| | | | | (__|   <  __/ |                    //
//     |_.__/ \__, |  \__,_|_.__/|_|\_\_| |_|_|\___|_|\_\___|_|                    //
//            |___/                                                                //
//                                                                                 //
//                                                                                 //
//                                                                                 //
/////////////////////////////////////////////////////////////////////////////////////


contract LADY is ERC721Creator {
    constructor() ERC721Creator("Lady of the lake", "LADY") {}
}