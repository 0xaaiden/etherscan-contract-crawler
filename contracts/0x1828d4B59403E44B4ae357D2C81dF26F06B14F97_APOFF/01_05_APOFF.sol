// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Anton Plotnik-Off
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

////////////////////////////////////////////////////////////////
//                                                            //
//                                                            //
//      / _ \ | ___ | |_ _ __ (_) | __     /___\/ __\/ __\    //
//     / /_)/ |/ _ \| __| '_ \| | |/ /    //  // _\ / _\      //
//    / ___/| | (_) | |_| | | | |   <    / \_// /  / /        //
//    \/    |_|\___/ \__|_| |_|_|_|\_\___\___/\/   \/         //
//                                  |_____|                   //
//                                                            //
//                                                            //
////////////////////////////////////////////////////////////////


contract APOFF is ERC721Creator {
    constructor() ERC721Creator("Anton Plotnik-Off", "APOFF") {}
}