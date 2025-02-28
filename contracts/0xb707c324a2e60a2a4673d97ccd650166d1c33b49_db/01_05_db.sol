// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: 800 db
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

//////////////////////////////////////////////////////////
//                                                      //
//                                                      //
//                                                      //
//     █████╗  ██████╗  ██████╗     ██████╗ ██████╗     //
//    ██╔══██╗██╔═████╗██╔═████╗    ██╔══██╗██╔══██╗    //
//    ╚█████╔╝██║██╔██║██║██╔██║    ██║  ██║██████╔╝    //
//    ██╔══██╗████╔╝██║████╔╝██║    ██║  ██║██╔══██╗    //
//    ╚█████╔╝╚██████╔╝╚██████╔╝    ██████╔╝██████╔╝    //
//     ╚════╝  ╚═════╝  ╚═════╝     ╚═════╝ ╚═════╝     //
//                                                      //
//                                                      //
//                                                      //
//                                                      //
//                                                      //
//                                                      //
//                                                      //
//                                                      //
//                                                      //
//                                                      //
//                                                      //
//////////////////////////////////////////////////////////


contract db is ERC1155Creator {
    constructor() ERC1155Creator("800 db", "db") {}
}