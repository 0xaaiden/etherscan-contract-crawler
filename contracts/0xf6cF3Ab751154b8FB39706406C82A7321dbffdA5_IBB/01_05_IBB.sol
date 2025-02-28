// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Isekai Battle Box
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                //
//                                                                                                                //
//                                                                                                                //
//    .___               __           .__  __________         __    __  .__           __________                  //
//    |   | ______ ____ |  | _______  |__| \______   \_____ _/  |__/  |_|  |   ____   \______   \ _______  ___    //
//    |   |/  ___// __ \|  |/ /\__  \ |  |  |    |  _/\__  \\   __\   __\  | _/ __ \   |    |  _//  _ \  \/  /    //
//    |   |\___ \\  ___/|    <  / __ \|  |  |    |   \ / __ \|  |  |  | |  |_\  ___/   |    |   (  <_> >    <     //
//    |___/____  >\___  >__|_ \(____  /__|  |______  /(____  /__|  |__| |____/\___  >  |______  /\____/__/\_ \    //
//             \/     \/     \/     \/             \/      \/                     \/          \/            \/    //
//                                                                                                                //
//                                                                                                                //
//                                                                                                                //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract IBB is ERC1155Creator {
    constructor() ERC1155Creator("Isekai Battle Box", "IBB") {}
}