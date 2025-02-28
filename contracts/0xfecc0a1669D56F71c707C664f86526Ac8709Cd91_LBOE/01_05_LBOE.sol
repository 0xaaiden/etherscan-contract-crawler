// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Open Editions: BRAAVI
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

////////////////////////////////////////////////////////////////////////
//                                                                    //
//                                                                    //
//                                                                    //
//                                 .-'''-.                            //
//    .---.                       '   _    \                          //
//    |   |/|                   /   /` '.   \      __.....__          //
//    |   |||                  .   |     \  '  .-''         '.        //
//    |   |||                  |   '      |  '/     .-''"'-.  `.      //
//    |   |||  __              \    \     / //     /________\   \     //
//    |   |||/'__ '.            `.   ` ..' / |                  |     //
//    |   ||:/`  '. '              '-...-'`  \    .-------------'     //
//    |   |||     | |                         \    '-.____...---.     //
//    |   |||\    / '                          `.             .'      //
//    '---'|/\'..' /                             `''-...... -'        //
//         '  `'-'`                                                   //
//                                                                    //
//                                                                    //
//                                                                    //
//                                                                    //
////////////////////////////////////////////////////////////////////////


contract LBOE is ERC1155Creator {
    constructor() ERC1155Creator("Open Editions: BRAAVI", "LBOE") {}
}