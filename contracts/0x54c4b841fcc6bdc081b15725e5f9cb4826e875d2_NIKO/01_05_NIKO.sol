// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Nikolina Petolas
/// @author: manifold.xyz

import "./ERC721Creator.sol";

/////////////////////////////////
//                             //
//                             //
//        ┌──┐                 //
//      ┌┬┴┼┼┼─┐               //
//     ┌┼│o└─┼┼┼┐              //
//     └┴┘   │┼┼┘              //
//      ▼    │┼│               //
//           │┼┘               //
//          ┌┼┘                //
//         ┌┼┘                 //
//        ┌┼┘                  //
//       ┌┼┘                   //
//      ┌┼┘                    //
//     ┌┼│   ┌──────┐          //
//     │┼┼───┼┼┼┼─┼┼┼──┐       //
//     │┼┼┼┼┼┼─┼│ └─┼┼┼│       //
//     │┼┼┼┼┼│ │┼┐  │┼┼┼─┐     //
//     └┼┼┼┼┼┼─┼┼┼──┼┼┼┼─┼┐    //
//      └─┼┼┼┼┼┼┼┼┼┼┼┼─┘ └┘    //
//        └───┼┼┼┼┼──┘         //
//            │┼┼─┘            //
//            └┼│              //
//             └┤              //
//              │              //
//              │              //
//              │              //
//              │              //
//              │              //
//              │              //
//              │              //
//              │              //
//              │              //
//              │              //
//        ╔╦╗ ──┘╔╗            //
//     ╔═╦╬╣╠╦═╦╗╠╬═╦╦═╗       //
//     ║║║║║═╣╬║╚╣║║║║╬╚╗      //
//     ╚╩═╩╩╩╩═╩═╩╩╩═╩══╝      //
//                             //
//                             //
//                             //
/////////////////////////////////


contract NIKO is ERC721Creator {
    constructor() ERC721Creator("Nikolina Petolas", "NIKO") {}
}