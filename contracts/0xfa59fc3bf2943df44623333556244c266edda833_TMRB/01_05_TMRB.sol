// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Toss by MisterBenjamin
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

////////////////////////////////////////////////////////////////////
//                                                                //
//                                                                //
//                                                                //
//     _____  ____  ____  ____  ____ ___  _ _      ____  ____     //
//    /__ __\/  _ \/ ___\/ ___\/  _ \\  \/// \__/|/  __\/  _ \    //
//      / \  | / \||    \|    \| | // \  / | |\/|||  \/|| | //    //
//      | |  | \_/|\___ |\___ || |_\\ / /  | |  |||    /| |_\\    //
//      \_/  \____/\____/\____/\____//_/   \_/  \|\_/\_\\____/    //
//                                                                //
//                                                                //
//                                                                //
//                                                                //
////////////////////////////////////////////////////////////////////


contract TMRB is ERC721Creator {
    constructor() ERC721Creator("Toss by MisterBenjamin", "TMRB") {}
}