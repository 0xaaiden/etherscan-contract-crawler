// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Elena Verve - Editions
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////////
//                                                                                       //
//                                                                                       //
//    ,------.,--.                           ,--.   ,--.                                 //
//    |  .---'|  | ,---. ,--,--,  ,--,--.     \  `.'  /,---. ,--.--.,--.  ,--.,---.      //
//    |  `--, |  || .-. :|      \' ,-.  |      \     /| .-. :|  .--' \  `'  /| .-. :     //
//    |  `---.|  |\   --.|  ||  |\ '-'  |       \   / \   --.|  |     \    / \   --.     //
//    `------'`--' `----'`--''--' `--`--'        `-'   `----'`--'      `--'   `----'     //
//                                                                                       //
//                                                                                       //
///////////////////////////////////////////////////////////////////////////////////////////


contract EVE is ERC1155Creator {
    constructor() ERC1155Creator("Elena Verve - Editions", "EVE") {}
}