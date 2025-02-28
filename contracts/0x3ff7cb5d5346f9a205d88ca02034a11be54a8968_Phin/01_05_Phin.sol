// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Portraits of Daniel
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////////
//                                                                                       //
//                                                                                       //
//     _________.__            __    __________         __________.__    .__             //
//     /   _____/|  |__   _____/  |_  \______   \___.__. \______   \  |__ |__| ____      //
//     \_____  \ |  |  \ /  _ \   __\  |    |  _<   |  |  |     ___/  |  \|  |/    \     //
//     /        \|   Y  (  <_> )  |    |    |   \\___  |  |    |   |   Y  \  |   |  \    //
//    /_______  /|___|  /\____/|__|    |______  // ____|  |____|   |___|  /__|___|  /    //
//            \/      \/                      \/ \/                     \/        \/     //
//                                                                                       //
//                                                                                       //
///////////////////////////////////////////////////////////////////////////////////////////


contract Phin is ERC721Creator {
    constructor() ERC721Creator("Portraits of Daniel", "Phin") {}
}