// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: FlowBlox
/// @author: manifold.xyz

import "./ERC721Creator.sol";

///////////////////////////////////////////////////////////////////////
//                                                                   //
//                                                                   //
//    ___________.__                __________.__                    //
//    \_   _____/|  |   ______  _  _\______   \  |   _______  ___    //
//     |    __)  |  |  /  _ \ \/ \/ /|    |  _/  |  /  _ \  \/  /    //
//     |     \   |  |_(  <_> )     / |    |   \  |_(  <_> >    <     //
//     \___  /   |____/\____/ \/\_/  |______  /____/\____/__/\_ \    //
//         \/                               \/                 \/    //
//                                                                   //
//                                                                   //
///////////////////////////////////////////////////////////////////////


contract FBX is ERC721Creator {
    constructor() ERC721Creator("FlowBlox", "FBX") {}
}