// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Terrortory
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                            //
//                                                                                            //
//     _   _                         ______       _               _____       _     _ _ _     //
//    | \ | |                        | ___ \     | |             /  __ \     | |   (_) | |    //
//    |  \| | __ _ _ __   ___ _   _  | |_/ / __ _| | _____ _ __  | /  \/ __ _| |__  _| | |    //
//    | . ` |/ _` | '_ \ / __| | | | | ___ \/ _` | |/ / _ \ '__| | |    / _` | '_ \| | | |    //
//    | |\  | (_| | | | | (__| |_| | | |_/ / (_| |   <  __/ |    | \__/\ (_| | | | | | | |    //
//    \_| \_/\__,_|_| |_|\___|\__, | \____/ \__,_|_|\_\___|_|     \____/\__,_|_| |_|_|_|_|    //
//                             __/ |                                                          //
//                            |___/                                                           //
//                                                                                            //
//                                                                                            //
////////////////////////////////////////////////////////////////////////////////////////////////


contract TRRTY is ERC721Creator {
    constructor() ERC721Creator("Terrortory", "TRRTY") {}
}