// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Identity Crisis Editions
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                          //
//                                                                                                          //
//                                                                                                          //
//    ██╗██████╗░███████╗███╗░░██╗████████╗██╗████████╗██╗░░░██╗  ░█████╗░██████╗░██╗░██████╗██╗░██████╗    //
//    ██║██╔══██╗██╔════╝████╗░██║╚══██╔══╝██║╚══██╔══╝╚██╗░██╔╝  ██╔══██╗██╔══██╗██║██╔════╝██║██╔════╝    //
//    ██║██║░░██║█████╗░░██╔██╗██║░░░██║░░░██║░░░██║░░░░╚████╔╝░  ██║░░╚═╝██████╔╝██║╚█████╗░██║╚█████╗░    //
//    ██║██║░░██║██╔══╝░░██║╚████║░░░██║░░░██║░░░██║░░░░░╚██╔╝░░  ██║░░██╗██╔══██╗██║░╚═══██╗██║░╚═══██╗    //
//    ██║██████╔╝███████╗██║░╚███║░░░██║░░░██║░░░██║░░░░░░██║░░░  ╚█████╔╝██║░░██║██║██████╔╝██║██████╔╝    //
//    ╚═╝╚═════╝░╚══════╝╚═╝░░╚══╝░░░╚═╝░░░╚═╝░░░╚═╝░░░░░░╚═╝░░░  ░╚════╝░╚═╝░░╚═╝╚═╝╚═════╝░╚═╝╚═════╝░    //
//                                                                                                          //
//    ███████╗██████╗░██╗████████╗██╗░█████╗░███╗░░██╗░██████╗                                              //
//    ██╔════╝██╔══██╗██║╚══██╔══╝██║██╔══██╗████╗░██║██╔════╝                                              //
//    █████╗░░██║░░██║██║░░░██║░░░██║██║░░██║██╔██╗██║╚█████╗░                                              //
//    ██╔══╝░░██║░░██║██║░░░██║░░░██║██║░░██║██║╚████║░╚═══██╗                                              //
//    ███████╗██████╔╝██║░░░██║░░░██║╚█████╔╝██║░╚███║██████╔╝                                              //
//    ╚══════╝╚═════╝░╚═╝░░░╚═╝░░░╚═╝░╚════╝░╚═╝░░╚══╝╚═════╝░                                              //
//                                                                                                          //
//    ██████╗░██╗░░░██╗                                                                                     //
//    ██╔══██╗╚██╗░██╔╝                                                                                     //
//    ██████╦╝░╚████╔╝░                                                                                     //
//    ██╔══██╗░░╚██╔╝░░                                                                                     //
//    ██████╦╝░░░██║░░░                                                                                     //
//    ╚═════╝░░░░╚═╝░░░                                                                                     //
//                                                                                                          //
//    ░░░░░██╗░█████╗░░█████╗░░█████╗░██████╗░████████╗██╗░░██╗███████╗░█████╗░██████╗░███████╗             //
//    ░░░░░██║██╔══██╗██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝██║░░██║██╔════╝██╔══██╗██╔══██╗██╔════╝             //
//    ░░░░░██║███████║██║░░╚═╝██║░░██║██████╦╝░░░██║░░░███████║█████╗░░███████║██████╔╝█████╗░░             //
//    ██╗░░██║██╔══██║██║░░██╗██║░░██║██╔══██╗░░░██║░░░██╔══██║██╔══╝░░██╔══██║██╔═══╝░██╔══╝░░             //
//    ╚█████╔╝██║░░██║╚█████╔╝╚█████╔╝██████╦╝░░░██║░░░██║░░██║███████╗██║░░██║██║░░░░░███████╗             //
//    ░╚════╝░╚═╝░░╚═╝░╚════╝░░╚════╝░╚═════╝░░░░╚═╝░░░╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝╚═╝░░░░░╚══════╝             //
//                                                                                                          //
//                                                                                                          //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract ICeds is ERC1155Creator {
    constructor() ERC1155Creator("Identity Crisis Editions", "ICeds") {}
}