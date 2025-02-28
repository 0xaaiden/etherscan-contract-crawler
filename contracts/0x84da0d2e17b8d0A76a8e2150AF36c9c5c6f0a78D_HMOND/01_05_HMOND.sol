// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: HouseMond
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                            //
//                                                                                                            //
//                                                                                                            //
//              _____                    _____                    _____                    _____              //
//             /\    \                  /\    \                  /\    \                  /\    \             //
//            /::\____\                /::\    \                /::\    \                /::\    \            //
//           /::::|   |               /::::\    \               \:::\    \              /::::\    \           //
//          /:::::|   |              /::::::\    \               \:::\    \            /::::::\    \          //
//         /::::::|   |             /:::/\:::\    \               \:::\    \          /:::/\:::\    \         //
//        /:::/|::|   |            /:::/__\:::\    \               \:::\    \        /:::/__\:::\    \        //
//       /:::/ |::|   |           /::::\   \:::\    \              /::::\    \      /::::\   \:::\    \       //
//      /:::/  |::|___|______    /::::::\   \:::\    \    _____   /::::::\    \    /::::::\   \:::\    \      //
//     /:::/   |::::::::\    \  /:::/\:::\   \:::\    \  /\    \ /:::/\:::\    \  /:::/\:::\   \:::\    \     //
//    /:::/    |:::::::::\____\/:::/  \:::\   \:::\____\/::\    /:::/  \:::\____\/:::/__\:::\   \:::\____\    //
//    \::/    / ~~~~~/:::/    /\::/    \:::\  /:::/    /\:::\  /:::/    \::/    /\:::\   \:::\   \::/    /    //
//     \/____/      /:::/    /  \/____/ \:::\/:::/    /  \:::\/:::/    / \/____/  \:::\   \:::\   \/____/     //
//                 /:::/    /            \::::::/    /    \::::::/    /            \:::\   \:::\    \         //
//                /:::/    /              \::::/    /      \::::/    /              \:::\   \:::\____\        //
//               /:::/    /               /:::/    /        \::/    /                \:::\   \::/    /        //
//              /:::/    /               /:::/    /          \/____/                  \:::\   \/____/         //
//             /:::/    /               /:::/    /                                     \:::\    \             //
//            /:::/    /               /:::/    /                                       \:::\____\            //
//            \::/    /                \::/    /                                         \::/    /            //
//             \/____/                  \/____/                                           \/____/             //
//                                                                                                            //
//                                                                                                            //
//                                                                                                            //
//                                                                                                            //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract HMOND is ERC1155Creator {
    constructor() ERC1155Creator("HouseMond", "HMOND") {}
}