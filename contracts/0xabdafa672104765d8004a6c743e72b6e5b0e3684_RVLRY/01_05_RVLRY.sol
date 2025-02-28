// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Radiant Revelry
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

///////////////////////////////////////////////////////////
//                                                       //
//                                                       //
//                       .___.__               __        //
//    ____________     __| _/|__|____    _____/  |_      //
//    \_  __ \__  \   / __ | |  \__  \  /    \   __\     //
//     |  | \// __ \_/ /_/ | |  |/ __ \|   |  \  |       //
//     |__|  (____  /\____ | |__(____  /___|  /__|       //
//                \/      \/         \/     \/           //
//                               .__                     //
//    _______   _______  __ ____ |  |_______ ___.__.     //
//    \_  __ \_/ __ \  \/ // __ \|  |\_  __ <   |  |     //
//     |  | \/\  ___/\   /\  ___/|  |_|  | \/\___  |     //
//     |__|    \___  >\_/  \___  >____/__|   / ____|     //
//                 \/          \/            \/          //
//                                                       //
//                                                       //
///////////////////////////////////////////////////////////


contract RVLRY is ERC721Creator {
    constructor() ERC721Creator("Radiant Revelry", "RVLRY") {}
}