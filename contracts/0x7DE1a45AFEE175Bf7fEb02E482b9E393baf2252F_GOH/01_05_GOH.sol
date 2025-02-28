// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Glimmer Of Hope
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

///////////////////////////////////////////////////////////////////////////
//                                                                       //
//                                                                       //
//                                                                       //
//       ___ _ _                        ___   __   _  _                  //
//      / __| (_)_ __  _ __  ___ _ _   / _ \ / _| | || |___ _ __ ___     //
//     | (_ | | | '  \| '  \/ -_| '_| | (_) |  _| | __ / _ | '_ / -_)    //
//      \___|_|_|_|_|_|_|_|_\___|_|    \___/|_|   |_||_\___| .__\___|    //
//                                                         |_|           //
//                                                                       //
//                                                                       //
//                                                                       //
///////////////////////////////////////////////////////////////////////////


contract GOH is ERC721Creator {
    constructor() ERC721Creator("Glimmer Of Hope", "GOH") {}
}