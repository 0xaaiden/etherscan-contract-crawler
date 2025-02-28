// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: X-peri-MENTAL
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                            //
//                                                                                            //
//                                                                                            //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒    //
//        ▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▄▒▒▒╣╢╢▓█▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓╣▓▓▓▄▄▄▄▄▒▓▓▓████▓▓▓▄▄▓▄▄▒▄▒▒▒▒╣▒╢╢╢▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒╫████▓▓▓████████████████████████▓▒▒▒╣▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▄▓██████▓▓▓▓███████████████████████████▓▒╣▒╬▒╣▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒╫▓▓███████▓▓▓████████████████████████████╢▓╢▓▀▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒    //
//        ▒▒▒▒▒▒╢▒▒▒▒▒▒▓█████████████████████████████████████████████▌▒╫▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒    //
//        ▒▒▒▒▒▒▒▒▒▒╢╣╢╫█████████████████████████████████████████████▓▒▒╢▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒    //
//        ▒▒▒▒▒▒▒▒▒╣╣╣╫╣███████████████████████▓█████████████████████▌▒╫▓▓╣▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒    //
//        ▒▒▒▒▒▒▒▒▒▒▓▓▓▓█████████████████████████████████████████████████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒    //
//        ▒▒▒▒▒▒▒▒▒▒▓▓▓██████████████████████████████████████████████████╣▒▒▒▒▒▒▒▒▒▒╢╢▒▒▒▒    //
//        ▒▒▒▒▒▒▒▒▒▒▓█████████████████▓▓█████████████████████████████████▒▒▒▒▒▒▒▒▒▒▒▒▒▒╢▒▒    //
//        ▒▒╢▒▒▒▒▒▒▒▒▓▓▓███████████████████████████████▓▓▓▓▓▓▓▓▓▓▓███████▒▒▒▒▒▒▒▒▒▒▒▒▒▒║▒╢    //
//        ▒▒▒▒▒▒▒▒▒▒▒╣▒▓███████████████████████████████▓▓▓╣╣╢╣▓▓▓▓██████▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒╠███████████████████████████████▓╢▒╢╢╢╢╢▓╢▓▓█▓╣▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒╫███████████▓▓▓▓▓▓███████████▓▓▓▒╢╢╣╢╢╣╢╣▓▓███▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒╫██████████▓▓╣▓▓▓▓███████████╣╣╣╫╣╢╣╣╢╣╣▓▓▓██████▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒    //
//        ▒▒▒▒▒▒▒▒▒▒▒╣▒╬███████▓▓▓███████▓▓▓█████▓▓▓▓▓▓▓▓▓▓▓▓▓███████████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒    //
//        ▒▒▒▒▒▒▒▒▒▒▒╫▒╫▓▀▀████▓╫▓▓█████████████▓▓▓▓▓▓▓▓▓▓▓▓▓█████████▀▀▀▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓██▓╣╣▓█████████████▌▓▓╣╢╫▓▓▓▓▓▓▓▓▓╣╢▓███▓╢▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓██████████████▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▓▓▓▓▓████▒▒▒▒▒▒▒▒▒╣▒▒▒▒▒▒▒    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒╢▓███████████████▓▓▓▓▓▓▓▓▓▓▓▓███▓▓▓▓████▓▒▒▒▒▒▒▒▒╢▒▒▒▒▒▒▒    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒╫╢╫▓████████████▓█▓▓▓▓▓██████▓█▓▓▓▓████▓▒╢╢╢▒▒▒▒▒▒▒▒▒▒▒▒    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓████████████████████████▓▓▓▓▓▓▓████▒╣▒╣╢▒▒▒▒▒▒▒▒▒▒▒▒    //
//        ▒▒▒▒▒▒▒▒▒▒╫▒▒▒▒▒▒▒▒▒▒▒▒▒▓█▓▓████████████████████████▓▓▓▓▓▓▓████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒╢████████████████▓▓╣╣▓╢▓▓███████▌▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒    //
//        ▒▒▒▒▒▒▒╣▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒╫██████████████▓▓▓▓▓▓▓▓╣▓▓▓█████▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒╫████▓█████████▓█▓▓▓▓█▓╫▓▓▓▓████▌▒╢╬╢▒╢╣╢▒▒╣╢▒▒▒▒▒▒▒▒    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒╢██████▓╫▒▓████████▓▓▓▓▓████▓╬╢╣▒╢╣╢▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒╢▓███▓▓▓▒▒╫▓███████▓▓█▓▓█████╬╣╣╢╫╣▒▒▒▒╣╢╣▒▒▒▒▒▒▒▒▒▒▒    //
//        ▒▒▒▒▒▒▒▒╣╣╢▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒╫███████████▓▓█▒╣▒╢▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▀▓▓▓▓▓▓▓▓▀▒▒▒▒╫╢▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒╣▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒    //
//                                                                                            //
//    ---                                                                                     //
//    by viggggiu                                                                             //
//                                                                                            //
//                                                                                            //
//                                                                                            //
////////////////////////////////////////////////////////////////////////////////////////////////


contract xmntl is ERC721Creator {
    constructor() ERC721Creator("X-peri-MENTAL", "xmntl") {}
}