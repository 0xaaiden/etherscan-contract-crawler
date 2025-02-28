// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Digitickets
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                            //
//                                                                                                            //
//                                                                                                            //
//                                                                                                            //
//                                                                                                            //
//                                                                                                            //
//                           @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                           //
//                           @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                           //
//                      @@@@@                                                      @@@@@                      //
//                      @@@@@                                                      @@@@@                      //
//                  @@@@         @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#        /@@@@                  //
//                  @@@@         @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#        /@@@@                  //
//                  @@@@     @@@@                                             #@@@@    /@@@@                  //
//                  @@@@     @@@@         /////,,,,         /////,,,,         #@@@@    /@@@@                  //
//                  @@@@     @@@@         @@@@@             @@@@@             #@@@@    /@@@@                  //
//                  @@@@     @@@@         @@@@@@@@@         @@@@@@@@@*        #@@@@    /@@@@                  //
//                  @@@@     @@@@         @@@@@@@@@         @@@@@@@@@*        #@@@@    /@@@@                  //
//                  @@@@     @@@@                                             #@@@@    /@@@@                  //
//                  @@@@     @@@@                                             #@@@@    /@@@@                  //
//                  @@@@     @@@@     @@@@                           &@@@@    #@@@@    /@@@@                  //
//                  @@@@     @@@@     @@@@                           &@@@@    #@@@@    /@@@@                  //
//                  @@@@     @@@@     @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    #@@@@    /@@@@                  //
//                  @@@@     @@@@     @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    #@@@@    /@@@@                  //
//                  @@@@     @@@@                                             #@@@@    /@@@@                  //
//                  @@@@         @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#        /@@@@                  //
//                  @@@@         @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#        /@@@@                  //
//                      @@@@@                                                      @@@@@                      //
//                      @@@@@                                                      @@@@@                      //
//                           @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                           //
//                           @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                           //
//                                                                                                            //
//                                                                                                            //
//                                                                                                            //
//                                                                                                            //
//                                                                                                            //
//                                                                                                            //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract DGTKTS is ERC1155Creator {
    constructor() ERC1155Creator("Digitickets", "DGTKTS") {}
}