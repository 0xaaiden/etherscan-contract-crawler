// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: 0xNovus Editions
/// @author: manifold.xyz

import "./ERC1155Creator.sol";

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                         //
//                                                                                                                                         //
//                                                                                                                                         //
//     ▒█████  ▒██   ██▒ ███▄    █  ▒█████   ██▒   █▓ █    ██   ██████    ▓█████ ▓█████▄  ██▓▄▄▄█████▓ ██▓ ▒█████   ███▄    █   ██████     //
//    ▒██▒  ██▒▒▒ █ █ ▒░ ██ ▀█   █ ▒██▒  ██▒▓██░   █▒ ██  ▓██▒▒██    ▒    ▓█   ▀ ▒██▀ ██▌▓██▒▓  ██▒ ▓▒▓██▒▒██▒  ██▒ ██ ▀█   █ ▒██    ▒     //
//    ▒██░  ██▒░░  █   ░▓██  ▀█ ██▒▒██░  ██▒ ▓██  █▒░▓██  ▒██░░ ▓██▄      ▒███   ░██   █▌▒██▒▒ ▓██░ ▒░▒██▒▒██░  ██▒▓██  ▀█ ██▒░ ▓██▄       //
//    ▒██   ██░ ░ █ █ ▒ ▓██▒  ▐▌██▒▒██   ██░  ▒██ █░░▓▓█  ░██░  ▒   ██▒   ▒▓█  ▄ ░▓█▄   ▌░██░░ ▓██▓ ░ ░██░▒██   ██░▓██▒  ▐▌██▒  ▒   ██▒    //
//    ░ ████▓▒░▒██▒ ▒██▒▒██░   ▓██░░ ████▓▒░   ▒▀█░  ▒▒█████▓ ▒██████▒▒   ░▒████▒░▒████▓ ░██░  ▒██▒ ░ ░██░░ ████▓▒░▒██░   ▓██░▒██████▒▒    //
//    ░ ▒░▒░▒░ ▒▒ ░ ░▓ ░░ ▒░   ▒ ▒ ░ ▒░▒░▒░    ░ ▐░  ░▒▓▒ ▒ ▒ ▒ ▒▓▒ ▒ ░   ░░ ▒░ ░ ▒▒▓  ▒ ░▓    ▒ ░░   ░▓  ░ ▒░▒░▒░ ░ ▒░   ▒ ▒ ▒ ▒▓▒ ▒ ░    //
//      ░ ▒ ▒░ ░░   ░▒ ░░ ░░   ░ ▒░  ░ ▒ ▒░    ░ ░░  ░░▒░ ░ ░ ░ ░▒  ░ ░    ░ ░  ░ ░ ▒  ▒  ▒ ░    ░     ▒ ░  ░ ▒ ▒░ ░ ░░   ░ ▒░░ ░▒  ░ ░    //
//    ░ ░ ░ ▒   ░    ░     ░   ░ ░ ░ ░ ░ ▒       ░░   ░░░ ░ ░ ░  ░  ░        ░    ░ ░  ░  ▒ ░  ░       ▒ ░░ ░ ░ ▒     ░   ░ ░ ░  ░  ░      //
//        ░ ░   ░    ░           ░     ░ ░        ░     ░           ░        ░  ░   ░     ░            ░      ░ ░           ░       ░      //
//                                               ░                                ░                                                        //
//                                                                                                                                         //
//                                                                                                                                         //
//                                                                                                                                         //
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract NVSED is ERC1155Creator {
    constructor() ERC1155Creator() {}
}