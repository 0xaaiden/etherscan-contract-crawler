// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Non-Fungible Artwork
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

////////////////////////////////////////////////////
//                                                //
//                                                //
//                                                //
//                                                //
//          ___          ___          ___         //
//         /\__\        /\  \        /\  \        //
//        /::|  |      /::\  \      /::\  \       //
//       /:|:|  |     /:/\:\  \    /:/\:\  \      //
//      /:/|:|  |__  /::\~\:\  \  /::\~\:\  \     //
//     /:/ |:| /\__\/:/\:\ \:\__\/:/\:\ \:\__\    //
//     \/__|:|/:/  /\/__\:\ \/__/\/__\:\/:/  /    //
//         |:/:/  /      \:\__\       \::/  /     //
//         |::/  /        \/__/       /:/  /      //
//         /:/  /                    /:/  /       //
//         \/__/                     \/__/        //
//                                                //
//                                                //
//                                                //
////////////////////////////////////////////////////


contract NFA is ERC1155Creator {
    constructor() ERC1155Creator("Non-Fungible Artwork", "NFA") {}
}