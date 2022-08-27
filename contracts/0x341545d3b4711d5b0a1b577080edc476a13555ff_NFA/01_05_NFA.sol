// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: NonFungibleAlpha
/// @author: manifold.xyz

import "./ERC721Creator.sol";

/////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                             //
//                                                                                             //
//                                                                                             //
//       ___  ____  __  ______  __  _____    ____ _      ___  __  ___   __   ___  __ _____     //
//      / _ )/ __/  \ \/ / __ \/ / / / _ \  / __ \ | /| / / |/ / / _ | / /  / _ \/ // / _ |    //
//     / _  / _/     \  / /_/ / /_/ / , _/ / /_/ / |/ |/ /    / / __ |/ /__/ ___/ _  / __ |    //
//    /____/___/     /_/\____/\____/_/|_|  \____/|__/|__/_/|_/ /_/ |_/____/_/  /_//_/_/ |_|    //
//                                                                                             //
//                                                                                             //
//                                                                                             //
//                                                                                             //
/////////////////////////////////////////////////////////////////////////////////////////////////


contract NFA is ERC721Creator {
    constructor() ERC721Creator("NonFungibleAlpha", "NFA") {}
}