// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Samalot Editions
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////////
//                                                                                       //
//                                                                                       //
//                                                                                       //
//             ╔═╗╔═╗╔╦╗╔═╗╦  ╔═╗╔╦╗  ╦ ╦╔═╗╔═╗╦  ╦╔╗╔╔═╗  ╔═╗╦═╗╔╦╗╔═╗                  //
//             ╚═╗╠═╣║║║╠═╣║  ║ ║ ║   ╠═╣║╣ ╠═╣║  ║║║║║ ╦  ╠═╣╠╦╝ ║ ╚═╗                  //
//          o  ╚═╝╩ ╩╩ ╩╩ ╩╩═╝╚═╝ ╩   ╩ ╩╚═╝╩ ╩╩═╝╩╝╚╝╚═╝  ╩ ╩╩╚═ ╩ ╚═╝  o               //
//           ╔╦╗╔═╗╦ ╦  ╔═╗╦  ╦    ╔╗ ╔═╗╦╔╗╔╔═╗╔═╗  ╔╗ ╔═╗  ╦ ╦╔═╗╔═╗╔═╗╦ ╦             //
//           ║║║╠═╣╚╦╝  ╠═╣║  ║    ╠╩╗║╣ ║║║║║ ╦╚═╗  ╠╩╗║╣   ╠═╣╠═╣╠═╝╠═╝╚╦╝             //
//        o  ╩ ╩╩ ╩ ╩   ╩ ╩╩═╝╩═╝  ╚═╝╚═╝╩╝╚╝╚═╝╚═╝  ╚═╝╚═╝  ╩ ╩╩ ╩╩  ╩   ╩   o          //
//       ╔╦╗╔═╗╦ ╦  ╔═╗╦  ╦    ╔╗ ╔═╗╦╔╗╔╔═╗╔═╗  ╔╗ ╔═╗  ╦  ╦╔╗ ╔═╗╦═╗╔═╗╔╦╗╔═╗╔╦╗       //
//       ║║║╠═╣╚╦╝  ╠═╣║  ║    ╠╩╗║╣ ║║║║║ ╦╚═╗  ╠╩╗║╣   ║  ║╠╩╗║╣ ╠╦╝╠═╣ ║ ║╣  ║║       //
//    o  ╩ ╩╩ ╩ ╩   ╩ ╩╩═╝╩═╝  ╚═╝╚═╝╩╝╚╝╚═╝╚═╝  ╚═╝╚═╝  ╩═╝╩╚═╝╚═╝╩╚═╩ ╩ ╩ ╚═╝═╩╝  o    //
//                                                                                       //
//                                                                                       //
//                                                                                       //
///////////////////////////////////////////////////////////////////////////////////////////


contract FEN is ERC1155Creator {
    constructor() ERC1155Creator("Samalot Editions", "FEN") {}
}