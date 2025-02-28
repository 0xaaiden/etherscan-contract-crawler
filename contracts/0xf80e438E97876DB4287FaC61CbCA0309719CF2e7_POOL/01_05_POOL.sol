// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Tide Pools by Matt Kane
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                  //
//                                                                                                                  //
//                                                                                                                  //
//      _____ _     _        ____             _       _             __  __       _   _     _  __                    //
//     |_   _(_) __| | ___  |  _ \ ___   ___ | |___  | |__  _   _  |  \/  | __ _| |_| |_  | |/ /__ _ _ __   ___     //
//       | | | |/ _` |/ _ \ | |_) / _ \ / _ \| / __| | '_ \| | | | | |\/| |/ _` | __| __| | ' // _` | '_ \ / _ \    //
//       | | | | (_| |  __/ |  __/ (_) | (_) | \__ \ | |_) | |_| | | |  | | (_| | |_| |_  | . \ (_| | | | |  __/    //
//       |_| |_|\__,_|\___| |_|   \___/ \___/|_|___/ |_.__/ \__, | |_|  |_|\__,_|\__|\__| |_|\_\__,_|_| |_|\___|    //
//                                                          |___/                                                   //
//                                                                                                                  //
//                                                                                                                  //
//                                                                                                                  //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract POOL is ERC1155Creator {
    constructor() ERC1155Creator("Tide Pools by Matt Kane", "POOL") {}
}