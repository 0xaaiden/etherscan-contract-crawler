// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Love From Gaia
/// @author: manifold.xyz

import "./ERC721Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                  //
//                                                                                                  //
//    ██████████████████████████████████████████████████████████████████████████████████████████    //
//    ██████████████████████████████████████████████████████████████████████████████████████████    //
//    ██████████████████████████████████████████████████████████████████████████████████████████    //
//    ██████████████████████████████████████████████████████████████████████████████████████████    //
//    ██████████████████████████████████████████████████████████████████████████████████████████    //
//    ██████████████████████████████████████████████████████████████████████████████████████████    //
//    ███████████████████████████████████████▓▓▒▒░░░░░░▒▓▓██████████████████████████████████████    //
//    █████████████████████████████████████▓░░░░░░░░░░░░░░░▓▓███████████████████████████████████    //
//    ███████████████████████████████████▓░░░░░░░░░░░░░░░░░░░▒██████████████████████████████████    //
//    ██████████████████████████████████▒░░░░░░░░░░░░▒░░░▒▒░░░░▓████████████████████████████████    //
//    █████████████████████████████████▒░░░░░░░▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒████████████████████████████████    //
//    ████████████████████████████████▒░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒███████████████████████████████    //
//    ████████████████████████████████░░░░░▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒███████████████████████████████    //
//    ███████████████████████████████▒░▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒███████████████████████████████    //
//    ███████████████████████████████▓░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒███████████████████████████████    //
//    ███████████████████████████████▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░████████████████████████████████    //
//    ████████████████████████████████▓▒▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░▓████████████████████████████████    //
//    █████████████████████████████████▓▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒█████████████████████████████████    //
//    ██████████████████████████████████▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓█████████████████████████████████    //
//    ███████████████████████████▓▓▓▓▒░░░░░░▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒░▓██████████████████████████████████    //
//    ██████████████████████▓▒░░░░░░░░░░░░░░░░▒▒▓▓▓▓▓▓▓▒▒▒▒░▒███████████████████████████████████    //
//    █████████████████████▒░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▓▓████████████████████████████████    //
//    ████████████████████░░░░░░░░░░░░░▒▒▒▒░░░░░░░░░░░░░▒▒▓▓▒▒░▒▒▒▒█████████████████████████████    //
//    ███████████████████░░░░░░░░░░▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░▒░░▒▓▓▒▒▒███████████████████████████    //
//    ██████████████████░░░░░░░░░▒▒▒▒▒▒▓▒░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒██████████████████████████    //
//    ████████████████▓░░░░░░░░▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓████████████████████████    //
//    ███████████████▓░░░░░░░░▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▓███████████████████    //
//    ███████████████░░░░░░░░░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒█████████████████    //
//    ██████████████▒░░░░░░░░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒░░░░░░░░░░░░░░░░░░░▓███████████████    //
//    ██████████████░░░░░░░░▒▒░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░▒▒▒▒▒▒░▓██████████████    //
//    ██████████████░░░░░░▒▒▒░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░██████████████    //
//    ██████████████▒░░░░▒▒▒▒░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒█████████████    //
//    ██████████████▓░░░▒▒▒▒▒░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒█████████████    //
//    ███████████████▓▒░▒▒▒▒▒░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒░▒█████████████    //
//    ████████████████▒░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒░▒█████████████    //
//    ████████████████▓░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒░░░▒▒▒▒░██████████████    //
//    █████████████████▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒░░░░░░░░░░░░▒▒▒▒▒▒▒░░░░░███████████████    //
//    █████████████████▓░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░▓███████████████    //
//    ████████████████▓░░░░░░░░░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒███████████████    //
//    ████████████████░░░░░░░░░░░▒▒▓▓██████▓▓▒░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░███████████████    //
//    ███████████████▓░░░░░░░░░░░░░░▒▒▒▒▒░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░███████████████    //
//    ███████████████▒░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒███████████████    //
//    ███████████████░░░░░░░▒▒░░░░░░░▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░████████████████    //
//    ███████████████▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░█████████████████    //
//    ███████████████▓░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██████████████████    //
//    ████████████████▒░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓███████████████████    //
//    ████████████████▓▒▒▒▒░░░░░░░░░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓█████████████████████    //
//    █████████████████▓▒▒▒▒░░░░░░░░░░▒▒▒▒▒▒▒▓▓███▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓███████████████████████    //
//    ███████████████████▒▒▒▒░░░░░░░░░▒▒▒▒▒▒▒▒▓▓██████▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒░████████████████████████    //
//    ████████████████████▓▒▒▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓████████████████████████    //
//    ███████████████████████▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒████▓▓▓▒▒▒▒▒▒▒█████████████████████████    //
//    ████████████████████████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░███▓▓▓▒▒▒▒▒▒▒██████████████████████████    //
//    █████████████████████████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒█▓▓▓▓▓▒▒▒▒▒▒███████████████████████████    //
//    ██████████████████████████▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▓████████████████████████████    //
//    ████████████████████████████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▓█████████████████████████████    //
//    █████████████████████████████▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒████▓▒▒▒▒░██████████████████████████████    //
//    ████████████████████████████████▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒░████▓▒▒▒▒▒██████████████████████████████    //
//    ██████████████████████████████████▓▓██▓▒▒▒▒▒▒▒▒▒▒▒███▓▓▒▒▒▓███████████████████████████████    //
//    █████████████████████████████████▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▓██▓▓▓▒▒░████████████████████████████████    //
//    █████████████████████████████████░░░░░░░▒▒▓▓▓▓▒▒▒▓██▓▓▒▒▒▒████████████████████████████████    //
//    ████████████████████████████████▓░░░░░░░░▒▒▒▒▒▒▒▒▓██▓▒▒▒▒▒████████████████████████████████    //
//    ████████████████████████████████▓░░░░░░▒▒▒▒▒▒▒▒▒▒▓██▓▒▒▒▒▓████████████████████████████████    //
//    █████████████████████████████████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██▓▒▒▒▒▓█████████████████████████████████    //
//    █████████████████████████████████▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██▓▒▒▒▒██████████████████████████████████    //
//    ██████████████████████████████████▓▒▒▒▒▒▒▒▒▒▒▒▒▒██▓▓▒▒▒███████████████████████████████████    //
//    ███████████████████████████████████▒▒▒▒▒▒▒▒▒▒▒▒▒██▓▒▒▒▒███████████████████████████████████    //
//    ████████████████████████████████████▒▒▒▒▒▒▒▒▒▒▒▓██▓▒▒▒████████████████████████████████████    //
//    ████████████████████████████████████▒▒▒▒▒▒▒▒▒▒▒██▓▒▒▒▒████████████████████████████████████    //
//    ████████████████████████████████████▓▒▒▒▒▒▒▒▒▒▒██▓▒▒▒▓████████████████████████████████████    //
//    ████████████████████████████████████▒▒▒▒▒▒▒▒▒▒▒██▓▒▒▒█████████████████████████████████████    //
//    ████████████████████████████████████▓▒▒▒▒▒▒▒▒▒▒█▓▒▒▒▒█████████████████████████████████████    //
//    █████████████████████████████████████▓▒▒▒▒▒▒▒▒▒▓▒▒▒▒▓█████████████████████████████████████    //
//    ███████████████████████████████████████▒▒▒▒▒▒▒▒▒▒▒▒▒██████████████████████████████████████    //
//    ████████████████████████████████████████▓▒▒▒▒▒▒▒▒▒▒███████████████████████████████████████    //
//    █████████████████████████████████████████▓▒▒▒▒▒▒▒▒████████████████████████████████████████    //
//    ████████████████████████████████████████████▓▓▓███████████████████████████████████████████    //
//    ██████████████████████████████████████████████████████████████████████████████████████████    //
//    ██████████████████████████████████████████████████████████████████████████████████████████    //
//    ██████████████████████████████████████████████████████████████████████████████████████████    //
//    ██████████████████████████████████████████████████████████████████████████████████████████    //
//                                                                                                  //
//                                                                                                  //
//                                                                                                  //
//////////////////////////////////////////////////////////////////////////////////////////////////////


contract LFG is ERC721Creator {
    constructor() ERC721Creator("Love From Gaia", "LFG") {}
}