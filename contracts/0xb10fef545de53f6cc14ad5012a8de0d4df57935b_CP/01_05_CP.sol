// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Caddie Pod
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                                                                            //
//    _________             .___  .___.__         __________          .___    //
//    \_   ___ \_____     __| _/__| _/|__| ____   \______   \____   __| _/    //
//    /    \  \/\__  \   / __ |/ __ | |  |/ __ \   |     ___/  _ \ / __ |     //
//    \     \____/ __ \_/ /_/ / /_/ | |  \  ___/   |    |  (  <_> ) /_/ |     //
//     \______  (____  /\____ \____ | |__|\___  >  |____|   \____/\____ |     //
//            \/     \/      \/    \/         \/                       \/     //
//                                                                            //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////


contract CP is ERC721Creator {
    constructor() ERC721Creator("Caddie Pod", "CP") {}
}