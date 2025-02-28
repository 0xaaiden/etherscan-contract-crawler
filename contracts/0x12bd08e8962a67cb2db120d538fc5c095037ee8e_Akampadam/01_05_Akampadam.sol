// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Noushad
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                   //
//                                                                                                                   //
//                                                                                                                   //
//      _   _                 _               _            _                                   _                     //
//     | \ | |               | |             | |     /\   | |                                 | |                    //
//     |  \| | ___  _   _ ___| |__   __ _  __| |    /  \  | | ____ _ _ __ ___  _ __   __ _  __| | __ _ _ __ ___      //
//     | . ` |/ _ \| | | / __| '_ \ / _` |/ _` |   / /\ \ | |/ / _` | '_ ` _ \| '_ \ / _` |/ _` |/ _` | '_ ` _ \     //
//     | |\  | (_) | |_| \__ \ | | | (_| | (_| |  / ____ \|   < (_| | | | | | | |_) | (_| | (_| | (_| | | | | | |    //
//     |_| \_|\___/ \__,_|___/_| |_|\__,_|\__,_| /_/    \_\_|\_\__,_|_| |_| |_| .__/ \__,_|\__,_|\__,_|_| |_| |_|    //
//                                                                            | |                                    //
//                                                                            |_|                                    //
//                                                                                                                   //
//                                                                                                                   //
//                                                                                                                   //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract Akampadam is ERC721Creator {
    constructor() ERC721Creator("Noushad", "Akampadam") {}
}