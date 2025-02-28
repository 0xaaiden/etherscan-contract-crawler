// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Just The Two of Us
/// @author: manifold.xyz

import "./ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                                                                            //
//                                ### ###  ### ###  #### ##                   //
//                                 ##  ##   ##  ##  # ## ##                   //
//                                 ##  ##   ##        ##                      //
//                                 ##  ##   ## ##     ##                      //
//                                 ### ##   ##        ##                      //
//                                  ###     ##        ##                      //
//                                   ##    ####      ####                     //
//                                                                            //
//                                                                            //
//                                                                            //
//                   ## ##   ### ###  ### ##     ####   ### ###   ## ##       //
//                  ##   ##   ##  ##   ##  ##     ##     ##  ##  ##   ##      //
//                  ####      ##       ##  ##     ##     ##      ####         //
//                   #####    ## ##    ## ##      ##     ## ##    #####       //
//                      ###   ##       ## ##      ##     ##          ###      //
//                  ##   ##   ##  ##   ##  ##     ##     ##  ##  ##   ##      //
//                   ## ##   ### ###  #### ##    ####   ### ###   ## ##       //
//                                                                            //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////


contract VFTS is ERC721Creator {
    constructor() ERC721Creator("Just The Two of Us", "VFTS") {}
}