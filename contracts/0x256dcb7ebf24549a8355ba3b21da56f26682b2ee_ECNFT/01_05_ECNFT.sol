// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Emmet Cohen
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                     //
//                                                                                                     //
//                                                                                                     //
//     ____                                    __        ____            __                            //
//    /\  _`\                                 /\ \__    /\  _`\         /\ \                           //
//    \ \ \L\_\    ___ ___     ___ ___      __\ \ ,_\   \ \ \/\_\    ___\ \ \___      __    ___        //
//     \ \  _\L  /' __` __`\ /' __` __`\  /'__`\ \ \/    \ \ \/_/_  / __`\ \  _ `\  /'__`\/' _ `\      //
//      \ \ \L\ \/\ \/\ \/\ \/\ \/\ \/\ \/\  __/\ \ \_    \ \ \L\ \/\ \L\ \ \ \ \ \/\  __//\ \/\ \     //
//       \ \____/\ \_\ \_\ \_\ \_\ \_\ \_\ \____\\ \__\    \ \____/\ \____/\ \_\ \_\ \____\ \_\ \_\    //
//        \/___/  \/_/\/_/\/_/\/_/\/_/\/_/\/____/ \/__/     \/___/  \/___/  \/_/\/_/\/____/\/_/\/_/    //
//                                                                                                     //
//                                                                                                     //
//                                                                                                     //
//                                                                                                     //
//                                                                                                     //
/////////////////////////////////////////////////////////////////////////////////////////////////////////


contract ECNFT is ERC721Creator {
    constructor() ERC721Creator("Emmet Cohen", "ECNFT") {}
}