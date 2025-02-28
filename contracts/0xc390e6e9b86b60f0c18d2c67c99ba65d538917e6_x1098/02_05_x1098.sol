// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: (re)memes by 1098
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

///////////////////////////////////////////////////////////////////////////////////
//                                                                               //
//                                                                               //
//                                                                               //
//       /$$    /$$$$$$   /$$$$$$   /$$$$$$                 /$$     /$$          //
//     /$$$$   /$$$_  $$ /$$__  $$ /$$__  $$               | $$    | $$          //
//    |_  $$  | $$$$\ $$| $$  \ $$| $$  \ $$     /$$$$$$  /$$$$$$  | $$$$$$$     //
//      | $$  | $$ $$ $$|  $$$$$$$|  $$$$$$/    /$$__  $$|_  $$_/  | $$__  $$    //
//      | $$  | $$\ $$$$ \____  $$ >$$__  $$   | $$$$$$$$  | $$    | $$  \ $$    //
//      | $$  | $$ \ $$$ /$$  \ $$| $$  \ $$   | $$_____/  | $$ /$$| $$  | $$    //
//     /$$$$$$|  $$$$$$/|  $$$$$$/|  $$$$$$//$$|  $$$$$$$  |  $$$$/| $$  | $$    //
//    |______/ \______/  \______/  \______/|__/ \_______/   \___/  |__/  |__/    //
//                                                                               //
//                                                                               //
//                                                                               //
//                                                                               //
//                                                                               //
//                                                                               //
///////////////////////////////////////////////////////////////////////////////////


contract x1098 is ERC1155Creator {
    constructor() ERC1155Creator("(re)memes by 1098", "x1098") {}
}