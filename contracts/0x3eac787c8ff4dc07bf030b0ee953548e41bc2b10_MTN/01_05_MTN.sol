// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: METANODE
/// @author: manifold.xyz

import "./ERC721Creator.sol";

/////////////////////////////////////////////////////////////////////////
//                                                                     //
//                                                                     //
//                                                                     //
//       _____          __           _______             .___          //
//      /     \   _____/  |______    \      \   ____   __| _/____      //
//     /  \ /  \_/ __ \   __\__  \   /   |   \ /  _ \ / __ |/ __ \     //
//    /    Y    \  ___/|  |  / __ \_/    |    (  <_> ) /_/ \  ___/     //
//    \____|__  /\___  >__| (____  /\____|__  /\____/\____ |\___  >    //
//            \/     \/          \/         \/            \/    \/     //
//                                                                     //
//                                                                     //
//                                                                     //
/////////////////////////////////////////////////////////////////////////


contract MTN is ERC721Creator {
    constructor() ERC721Creator("METANODE", "MTN") {}
}