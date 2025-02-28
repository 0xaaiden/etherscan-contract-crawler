// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Xander Blue
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                              //
//                                                                                                              //
//                                                                                                              //
//    ____  ___                  .___          __________.__                 _______  ______________________    //
//    \   \/  /____    ____    __| _/__________\______   \  |  __ __   ____  \      \ \_   _____/\__    ___/    //
//     \     /\__  \  /    \  / __ |/ __ \_  __ \    |  _/  | |  |  \_/ __ \ /   |   \ |    __)    |    |       //
//     /     \ / __ \|   |  \/ /_/ \  ___/|  | \/    |   \  |_|  |  /\  ___//    |    \|     \     |    |       //
//    /___/\  (____  /___|  /\____ |\___  >__|  |______  /____/____/  \___  >____|__  /\___  /     |____|       //
//          \_/    \/     \/      \/    \/             \/                 \/        \/     \/                   //
//        .___.__       .__  __         .__      _____          __ ____  _____________.____     ____ ___        //
//      __| _/|__| ____ |__|/  |______  |  |    /  _  \________/  |\   \/  /\______   \    |   |    |   \       //
//     / __ | |  |/ ___\|  \   __\__  \ |  |   /  /_\  \_  __ \   __\     /  |    |  _/    |   |    |   /       //
//    / /_/ | |  / /_/  >  ||  |  / __ \|  |__/    |    \  | \/|  | /     \  |    |   \    |___|    |  /        //
//    \____ | |__\___  /|__||__| (____  /____/\____|__  /__|   |__|/___/\  \ |______  /_______ \______/         //
//         \/   /_____/               \/              \/                 \_/        \/        \/                //
//                                                                                                              //
//                                                                                                              //
//                                                                                                              //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract XBLU is ERC1155Creator {
    constructor() ERC1155Creator("Xander Blue", "XBLU") {}
}