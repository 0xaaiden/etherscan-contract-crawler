// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: CREEPTURES
/// @author: manifold.xyz

import "./ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                    //
//                                                                                                                                    //
//    #   ▄▄▄▄▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄▄▄▄▄ ▄         ▄ ▄▄▄▄▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄▄▄▄▄     //
//    #  ▐░░░░░░░░░░░▐░░░░░░░░░░░▐░░░░░░░░░░░▐░░░░░░░░░░░▐░░░░░░░░░░░▐░░░░░░░░░░░▐░▌       ▐░▐░░░░░░░░░░░▐░░░░░░░░░░░▐░░░░░░░░░░░▌    //
//    #  ▐░█▀▀▀▀▀▀▀▀▀▐░█▀▀▀▀▀▀▀█░▐░█▀▀▀▀▀▀▀▀▀▐░█▀▀▀▀▀▀▀▀▀▐░█▀▀▀▀▀▀▀█░▌▀▀▀▀█░█▀▀▀▀▐░▌       ▐░▐░█▀▀▀▀▀▀▀█░▐░█▀▀▀▀▀▀▀▀▀▐░█▀▀▀▀▀▀▀▀▀     //
//    #  ▐░▌         ▐░▌       ▐░▐░▌         ▐░▌         ▐░▌       ▐░▌    ▐░▌    ▐░▌       ▐░▐░▌       ▐░▐░▌         ▐░▌              //
//    #  ▐░▌         ▐░█▄▄▄▄▄▄▄█░▐░█▄▄▄▄▄▄▄▄▄▐░█▄▄▄▄▄▄▄▄▄▐░█▄▄▄▄▄▄▄█░▌    ▐░▌    ▐░▌       ▐░▐░█▄▄▄▄▄▄▄█░▐░█▄▄▄▄▄▄▄▄▄▐░█▄▄▄▄▄▄▄▄▄     //
//    #  ▐░▌         ▐░░░░░░░░░░░▐░░░░░░░░░░░▐░░░░░░░░░░░▐░░░░░░░░░░░▌    ▐░▌    ▐░▌       ▐░▐░░░░░░░░░░░▐░░░░░░░░░░░▐░░░░░░░░░░░▌    //
//    #  ▐░▌         ▐░█▀▀▀▀█░█▀▀▐░█▀▀▀▀▀▀▀▀▀▐░█▀▀▀▀▀▀▀▀▀▐░█▀▀▀▀▀▀▀▀▀     ▐░▌    ▐░▌       ▐░▐░█▀▀▀▀█░█▀▀▐░█▀▀▀▀▀▀▀▀▀ ▀▀▀▀▀▀▀▀▀█░▌    //
//    #  ▐░▌         ▐░▌     ▐░▌ ▐░▌         ▐░▌         ▐░▌              ▐░▌    ▐░▌       ▐░▐░▌     ▐░▌ ▐░▌                   ▐░▌    //
//    #  ▐░█▄▄▄▄▄▄▄▄▄▐░▌      ▐░▌▐░█▄▄▄▄▄▄▄▄▄▐░█▄▄▄▄▄▄▄▄▄▐░▌              ▐░▌    ▐░█▄▄▄▄▄▄▄█░▐░▌      ▐░▌▐░█▄▄▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄▄▄█░▌    //
//    #  ▐░░░░░░░░░░░▐░▌       ▐░▐░░░░░░░░░░░▐░░░░░░░░░░░▐░▌              ▐░▌    ▐░░░░░░░░░░░▐░▌       ▐░▐░░░░░░░░░░░▐░░░░░░░░░░░▌    //
//    #   ▀▀▀▀▀▀▀▀▀▀▀ ▀         ▀ ▀▀▀▀▀▀▀▀▀▀▀ ▀▀▀▀▀▀▀▀▀▀▀ ▀                ▀      ▀▀▀▀▀▀▀▀▀▀▀ ▀         ▀ ▀▀▀▀▀▀▀▀▀▀▀ ▀▀▀▀▀▀▀▀▀▀▀     //
//    #                                                                                                                               //
//    #                                                                                                                               //
//    #                       ____  __ __      ___ ___  ____ ____     __  ___       ___ ___  ___  ____  ____                          //
//    #                      |    \|  |  |    |   |   |/    |    \   /  ]/   \     |   |   |/   \|    \|    |                         //
//    #                      |  o  |  |  |    | _   _ |  o  |  D  ) /  /|     |    | _   _ |     |  D  )|  |                          //
//    #                      |     |  ~  |    |  \_/  |     |    / /  / |  O  |    |  \_/  |  O  |    / |  |                          //
//    #                      |  O  |___, |    |   |   |  _  |    \/   \_|     |    |   |   |     |    \ |  |                          //
//    #                      |     |     |    |   |   |  |  |  .  \     |     |    |   |   |     |  .  \|  |                          //
//    #                      |_____|____/     |___|___|__|__|__|\_|\____|\___/     |___|___|\___/|__|\_|____|                         //
//    #                                                                                                                               //
//    #                                                                                                                               //
//    #                                     ▐██████████▌                            ▐██████████▌                                      //
//    #                                     ▐██▌````████▄▄▄▄▄▄▄▄▄▄        ▄▄▄▄▄▄▄▄▄▄▄███````▐██▌                                      //
//    #                                     ▐██▌    ██████████████▌       ██████████████    ▐██▌                                      //
//    #                                  ███████▄▄▄▄███████    ███▌       ███    ▐█████████████████                                   //
//    #                                  ███▀▀▀▀▀▀▀▀███████    ███▌,,,,,,▐███    ▐███████▀▀▀▀▀▀▀███                                   //
//    #                                  ███        ███████    ██████████████    ▐██████        ███                                   //
//    #                           ▄▄▄▄▄▄▄███     ▄▄▄███▀▀▀▀    `▀▀▀▀▀▀▀▀▀▀▀▀▀     ▀▀▀███▄▄▄▄    ███▄▄▄▄▄▄▄▄                           //
//    #                          ▐██████████    ▐██████▌                             ███████    ██████████▌                           //
//    #                          ▐███    ██████████▌                                    ▐██████████    ███▌                           //
//    #                          ▐███    ████████▀▀▌                                    ▐▀▀▀███████    ███▌                           //
//    #                          ▐███    ███████                                            ▐██████    ███▌                           //
//    #                          ▐███    ███████        ▄▄▄▄▄▄▄               ▄▄▄▄▄▄        ███████    ▐██▌                           //
//    #                          ▐███    ▐██████        ██████▌              ▐██████▌       ███████    ▐██▌                           //
//    #                          ▐███    ▐██████        ██████▌              ▐██████▌       ███████    ▐██▌                           //
//    #                          ▐███    ▀▀▀▀▀▀▀        ██████▌              ▐██████▌       ▀▀▀▀▀▀▀    ███▌                           //
//    #                          ▐██████▌               ██████▌              ▐██████▌              ▐██████▌                           //
//    #                           ▀▀▀████▄▄▄▄▄▄▄        ▀▀▀▀▀▀`               ▀▀▀▀▀▀`       ▄▄▄▄▄▄▄▄███▀▀▀                            //
//    #                              ███████████                                            ▐██████████                               //
//    #                                  ███████                                            ▐██████▌                                  //
//    #                                 ███████                                            ███████                                    //
//    #                                 ██████████████▌       ██████████████        ██████████████                                    //
//    #                                  ▀▀▀▀▀▀▀▀▀▀███▌       ████▀▀▀▀▀▀▀███        ███▀▀▀▀▀▀▀▀▀▀▀                                    //
//    #                                            ███▌       ███▌      ▐███        ███                                               //
//    #                                    ▐█████████████████████▌      ▐█████████████████████▌                                       //
//    #                                    ▐█████████████████████▌      ▐█████████████████████▌                                       //
//    #                                    ▐███    ███▌                            ▐███    ▐██▌                                       //
//    #                                    ▐███    ███▌                            ▐███    ▐██▌                                       //
//    #                                    ▐██████████▌                            ▐██████████▌                                       //
//                                                                                                                                    //
//                                                                                                                                    //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract CRP is ERC721Creator {
    constructor() ERC721Creator("CREEPTURES", "CRP") {}
}