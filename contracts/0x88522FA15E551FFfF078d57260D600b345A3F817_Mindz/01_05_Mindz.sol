// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Art by Mindzeye
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                    //
//                                                                                                    //
//     ___ __ __   ________ ___   __   ______    ______ ______  __  __  ______                        //
//    /__//_//_/\ /_______//__/\ /__/\/_____/\  /_____//_____/\/_/\/_/\/_____/\                       //
//    \::\| \| \ \\__.::._\\::\_\\  \ \:::_ \ \ \:::__\\::::_\/\ \ \ \ \::::_\/_                      //
//     \:.      \ \  \::\ \ \:. `-\  \ \:\ \ \ \   /: / \:\/___/\:\_\ \ \:\/___/\                     //
//      \:.\-/\  \ \ _\::\ \_\:. _    \ \:\ \ \ \ /::/___\::___\/\::::_\/\::___\/_                    //
//       \. \  \  \ /__\::\__/\. \`-\  \ \:\/.:| /_:/____/\:\____/\\::\ \ \:\____/\                   //
//        \__\/ \__\\________\/\__\/ \__\/\____/_\_______\/\_____\/ \__\/  \_____\/                   //
//                                                                                                    //
//    *Michael Sidofsky*                                                                              //
//                                                                                                    //
//                                                                                                    //
////////////////////////////////////////////////////////////////////////////////////////////////////////


contract Mindz is ERC721Creator {
    constructor() ERC721Creator("Art by Mindzeye", "Mindz") {}
}