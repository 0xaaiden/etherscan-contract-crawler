// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Cliftonites
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                           //
//                                                                                           //
//                                                                                           //
//     ██████╗██╗     ██╗███████╗████████╗ ██████╗ ███╗   ██╗██╗████████╗███████╗███████╗    //
//    ██╔════╝██║     ██║██╔════╝╚══██╔══╝██╔═══██╗████╗  ██║██║╚══██╔══╝██╔════╝██╔════╝    //
//    ██║     ██║     ██║█████╗     ██║   ██║   ██║██╔██╗ ██║██║   ██║   █████╗  ███████╗    //
//    ██║     ██║     ██║██╔══╝     ██║   ██║   ██║██║╚██╗██║██║   ██║   ██╔══╝  ╚════██║    //
//    ╚██████╗███████╗██║██║        ██║   ╚██████╔╝██║ ╚████║██║   ██║   ███████╗███████║    //
//     ╚═════╝╚══════╝╚═╝╚═╝        ╚═╝    ╚═════╝ ╚═╝  ╚═══╝╚═╝   ╚═╝   ╚══════╝╚══════╝    //
//                                                                                           //
//                                                                                           //
//                                                                                           //
//                                                                                           //
///////////////////////////////////////////////////////////////////////////////////////////////


contract clif is ERC1155Creator {
    constructor() ERC1155Creator("Cliftonites", "clif") {}
}