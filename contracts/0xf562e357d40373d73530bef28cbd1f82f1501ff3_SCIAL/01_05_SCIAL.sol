// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Social
/// @author: manifold.xyz

import "./ERC721Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                  //
//                                                                                                                  //
//              _____                   _____                   _____    _____                   _____              //
//             /\    \                 /\    \                 /\    \  /\    \                 /\    \             //
//            /::\    \               /::\    \               /::\____\/::\____\               /::\    \            //
//           /::::\    \              \:::\    \             /:::/    /::::|   |              /::::\    \           //
//          /::::::\    \              \:::\    \           /:::/    /:::::|   |             /::::::\    \          //
//         /:::/\:::\    \              \:::\    \         /:::/    /::::::|   |            /:::/\:::\    \         //
//        /:::/__\:::\    \              \:::\    \       /:::/    /:::/|::|   |           /:::/  \:::\    \        //
//       /::::\   \:::\    \             /::::\    \     /:::/    /:::/ |::|   |          /:::/    \:::\    \       //
//      /::::::\   \:::\    \   ____    /::::::\    \   /:::/    /:::/  |::|   | _____   /:::/    / \:::\    \      //
//     /:::/\:::\   \:::\ ___\ /\   \  /:::/\:::\    \ /:::/    /:::/   |::|   |/\    \ /:::/    /   \:::\ ___\     //
//    /:::/__\:::\   \:::|    /::\   \/:::/  \:::\____/:::/____/:: /    |::|   /::\____/:::/____/     \:::|    |    //
//    \:::\   \:::\  /:::|____\:::\  /:::/    \::/    \:::\    \::/    /|::|  /:::/    \:::\    \     /:::|____|    //
//     \:::\   \:::\/:::/    / \:::\/:::/    / \/____/ \:::\    \/____/ |::| /:::/    / \:::\    \   /:::/    /     //
//      \:::\   \::::::/    /   \::::::/    /           \:::\    \      |::|/:::/    /   \:::\    \ /:::/    /      //
//       \:::\   \::::/    /     \::::/____/             \:::\    \     |::::::/    /     \:::\    /:::/    /       //
//        \:::\  /:::/    /       \:::\    \              \:::\    \    |:::::/    /       \:::\  /:::/    /        //
//         \:::\/:::/    /         \:::\    \              \:::\    \   |::::/    /         \:::\/:::/    /         //
//          \::::::/    /           \:::\    \              \:::\    \  /:::/    /           \::::::/    /          //
//           \::::/    /             \:::\____\              \:::\____\/:::/    /             \::::/    /           //
//            \::/____/               \::/    /               \::/    /\::/    /               \::/____/            //
//             ~~                      \/____/                 \/____/  \/____/                 ~~                  //
//                                                                                                                  //
//                                                                                                                  //
//                                                                                                                  //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract SCIAL is ERC721Creator {
    constructor() ERC721Creator("Social", "SCIAL") {}
}