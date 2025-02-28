// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: cypher•abstrakts
/// @author: manifold.xyz

import "./ERC721Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                   //
//                                                                                                                   //
//                                                                                                                   //
//      ______ ____    ____ .______    __    __   _______ .______                                                    //
//     /      |\   \  /   / |   _  \  |  |  |  | |   ____||   _  \                                                   //
//    |  ,----' \   \/   /  |  |_)  | |  |__|  | |  |__   |  |_)  |                                                  //
//    |  |       \_    _/   |   ___/  |   __   | |   __|  |      /                                                   //
//    |  `----.    |  |     |  |      |  |  |  | |  |____ |  |\  \----.                                              //
//     \______|    |.______ | _|   _______.___________.______| `._____|___       ______ .___________.    _______.    //
//        /   \     |   _  \      /       |           |   _  \        /   \     /      ||           |   /       |    //
//       /  ^  \    |  |_)  |    |   (----`---|  |----|  |_)  |      /  ^  \   |  ,----'`---|  |----`  |   (----`    //
//      /  /_\  \   |   _  <      \   \       |  |    |      /      /  /_\  \  |  |         |  |        \   \        //
//     /  _____  \  |  |_)  | .----)   |      |  |    |  |\  \----./  _____  \ |  `----.    |  |    .----)   |       //
//    /__/     \__\ |______/  |_______/       |__|    | _| `._____/__/     \__\ \______|    |__|    |_______/        //
//                                                                                                                   //
//                                                                                                                   //
//                                                                                                                   //
//                                                                                                                   //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract CYABS is ERC721Creator {
    constructor() ERC721Creator(unicode"cypher•abstrakts", "CYABS") {}
}