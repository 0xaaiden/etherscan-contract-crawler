// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: BAJDT
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                               //
//                                                                                                               //
//                                                                                                               //
//    ██████╗░░█████╗░██████╗░███╗░░██╗░█████╗░██████╗░██╗░░░██╗  ░█████╗░████████╗██╗░░░░░░█████╗░░██████╗      //
//    ██╔══██╗██╔══██╗██╔══██╗████╗░██║██╔══██╗██╔══██╗╚██╗░██╔╝  ██╔══██╗╚══██╔══╝██║░░░░░██╔══██╗██╔════╝      //
//    ██████╦╝███████║██████╔╝██╔██╗██║███████║██████╦╝░╚████╔╝░  ███████║░░░██║░░░██║░░░░░███████║╚█████╗░      //
//    ██╔══██╗██╔══██║██╔══██╗██║╚████║██╔══██║██╔══██╗░░╚██╔╝░░  ██╔══██║░░░██║░░░██║░░░░░██╔══██║░╚═══██╗      //
//    ██████╦╝██║░░██║██║░░██║██║░╚███║██║░░██║██████╦╝░░░██║░░░  ██║░░██║░░░██║░░░███████╗██║░░██║██████╔╝      //
//    ╚═════╝░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░╚══╝╚═╝░░╚═╝╚═════╝░░░░╚═╝░░░  ╚═╝░░╚═╝░░░╚═╝░░░╚══════╝╚═╝░░╚═╝╚═════╝░      //
//                                                                                                               //
//    ░░░░░██╗░█████╗░███╗░░░███╗███████╗░██████╗░░░  ██████╗░░█████╗░██████╗░███╗░░██╗  ░█████╗░███╗░░██╗       //
//    ░░░░░██║██╔══██╗████╗░████║██╔════╝██╔════╝░░░  ██╔══██╗██╔══██╗██╔══██╗████╗░██║  ██╔══██╗████╗░██║       //
//    ░░░░░██║███████║██╔████╔██║█████╗░░╚█████╗░░░░  ██████╦╝██║░░██║██████╔╝██╔██╗██║  ██║░░██║██╔██╗██║       //
//    ██╗░░██║██╔══██║██║╚██╔╝██║██╔══╝░░░╚═══██╗██╗  ██╔══██╗██║░░██║██╔══██╗██║╚████║  ██║░░██║██║╚████║       //
//    ╚█████╔╝██║░░██║██║░╚═╝░██║███████╗██████╔╝╚█║  ██████╦╝╚█████╔╝██║░░██║██║░╚███║  ╚█████╔╝██║░╚███║       //
//    ░╚════╝░╚═╝░░╚═╝╚═╝░░░░░╚═╝╚══════╝╚═════╝░░╚╝  ╚═════╝░░╚════╝░╚═╝░░╚═╝╚═╝░░╚══╝  ░╚════╝░╚═╝░░╚══╝       //
//                                                                                                               //
//    ████████╗██╗░░██╗███████╗  ██████╗░██╗░░░░░░█████╗░░█████╗░██╗░░██╗░█████╗░██╗░░██╗░█████╗░██╗███╗░░██╗    //
//    ╚══██╔══╝██║░░██║██╔════╝  ██╔══██╗██║░░░░░██╔══██╗██╔══██╗██║░██╔╝██╔══██╗██║░░██║██╔══██╗██║████╗░██║    //
//    ░░░██║░░░███████║█████╗░░  ██████╦╝██║░░░░░██║░░██║██║░░╚═╝█████═╝░██║░░╚═╝███████║███████║██║██╔██╗██║    //
//    ░░░██║░░░██╔══██║██╔══╝░░  ██╔══██╗██║░░░░░██║░░██║██║░░██╗██╔═██╗░██║░░██╗██╔══██║██╔══██║██║██║╚████║    //
//    ░░░██║░░░██║░░██║███████╗  ██████╦╝███████╗╚█████╔╝╚█████╔╝██║░╚██╗╚█████╔╝██║░░██║██║░░██║██║██║░╚███║    //
//    ░░░╚═╝░░░╚═╝░░╚═╝╚══════╝  ╚═════╝░╚══════╝░╚════╝░░╚════╝░╚═╝░░╚═╝░╚════╝░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝╚═╝░░╚══╝    //
//                                                                                                               //
//                                                                                                               //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract BAJDT is ERC721Creator {
    constructor() ERC721Creator("BAJDT", "BAJDT") {}
}