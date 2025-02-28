// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Feathered
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////////
//                                                                                //
//                                                                                //
//    .------..------..------..------..------..------..------..------..------.    //
//    |F.--. ||E.--. ||A.--. ||T.--. ||H.--. ||E.--. ||R.--. ||E.--. ||D.--. |    //
//    | :(): || (\/) || (\/) || :/\: || :/\: || (\/) || :(): || (\/) || :/\: |    //
//    | ()() || :\/: || :\/: || (__) || (__) || :\/: || ()() || :\/: || (__) |    //
//    | '--'F|| '--'E|| '--'A|| '--'T|| '--'H|| '--'E|| '--'R|| '--'E|| '--'D|    //
//    `------'`------'`------'`------'`------'`------'`------'`------'`------'    //
//                                                                                //
//                                                                                //
////////////////////////////////////////////////////////////////////////////////////


contract JO is ERC721Creator {
    constructor() ERC721Creator("Feathered", "JO") {}
}