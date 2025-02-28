// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Noah Addis Archive - Cuba
/// @author: manifold.xyz

import "./ERC721Creator.sol";

//////////////////////////////////////////////////////////////////////////////////
//                                                                              //
//                                                                              //
//                                                                              //
//    ███╗░░██╗░█████╗░░█████╗░██╗░░██╗  ░█████╗░██████╗░██████╗░██╗░██████╗    //
//    ████╗░██║██╔══██╗██╔══██╗██║░░██║  ██╔══██╗██╔══██╗██╔══██╗██║██╔════╝    //
//    ██╔██╗██║██║░░██║███████║███████║  ███████║██║░░██║██║░░██║██║╚█████╗░    //
//    ██║╚████║██║░░██║██╔══██║██╔══██║  ██╔══██║██║░░██║██║░░██║██║░╚═══██╗    //
//    ██║░╚███║╚█████╔╝██║░░██║██║░░██║  ██║░░██║██████╔╝██████╔╝██║██████╔╝    //
//    ╚═╝░░╚══╝░╚════╝░╚═╝░░╚═╝╚═╝░░╚═╝  ╚═╝░░╚═╝╚═════╝░╚═════╝░╚═╝╚═════╝░    //
//                                                                              //
//    ░█████╗░██████╗░░█████╗░██╗░░██╗██╗██╗░░░██╗███████╗                      //
//    ██╔══██╗██╔══██╗██╔══██╗██║░░██║██║██║░░░██║██╔════╝                      //
//    ███████║██████╔╝██║░░╚═╝███████║██║╚██╗░██╔╝█████╗░░                      //
//    ██╔══██║██╔══██╗██║░░██╗██╔══██║██║░╚████╔╝░██╔══╝░░                      //
//    ██║░░██║██║░░██║╚█████╔╝██║░░██║██║░░╚██╔╝░░███████╗                      //
//    ╚═╝░░╚═╝╚═╝░░╚═╝░╚════╝░╚═╝░░╚═╝╚═╝░░░╚═╝░░░╚══════╝                      //
//                                                                              //
//    ░█████╗░██╗░░░██╗██████╗░░█████╗░                                         //
//    ██╔══██╗██║░░░██║██╔══██╗██╔══██╗                                         //
//    ██║░░╚═╝██║░░░██║██████╦╝███████║                                         //
//    ██║░░██╗██║░░░██║██╔══██╗██╔══██║                                         //
//    ╚█████╔╝╚██████╔╝██████╦╝██║░░██║                                         //
//    ░╚════╝░░╚═════╝░╚═════╝░╚═╝░░╚═╝                                         //
//                                                                              //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////


contract NAAC is ERC721Creator {
    constructor() ERC721Creator("Noah Addis Archive - Cuba", "NAAC") {}
}