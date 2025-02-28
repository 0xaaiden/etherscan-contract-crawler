// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Scratched ClayPunks
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                        //
//                                                                                        //
//      ██████  ▄████▄   ██▀███   ▄▄▄     ▄▄▄█████▓ ▄████▄   ██░ ██ ▓█████ ▓█████▄        //
//    ▒██    ▒ ▒██▀ ▀█  ▓██ ▒ ██▒▒████▄   ▓  ██▒ ▓▒▒██▀ ▀█  ▓██░ ██▒▓█   ▀ ▒██▀ ██▌       //
//    ░ ▓██▄   ▒▓█    ▄ ▓██ ░▄█ ▒▒██  ▀█▄ ▒ ▓██░ ▒░▒▓█    ▄ ▒██▀▀██░▒███   ░██   █▌       //
//      ▒   ██▒▒▓▓▄ ▄██▒▒██▀▀█▄  ░██▄▄▄▄██░ ▓██▓ ░ ▒▓▓▄ ▄██▒░▓█ ░██ ▒▓█  ▄ ░▓█▄   ▌       //
//    ▒██████▒▒▒ ▓███▀ ░░██▓ ▒██▒ ▓█   ▓██▒ ▒██▒ ░ ▒ ▓███▀ ░░▓█▒░██▓░▒████▒░▒████▓        //
//    ▒ ▒▓▒ ▒ ░░ ░▒ ▒  ░░ ▒▓ ░▒▓░ ▒▒   ▓▒█░ ▒ ░░   ░ ░▒ ▒  ░ ▒ ░░▒░▒░░ ▒░ ░ ▒▒▓  ▒        //
//    ░ ░▒  ░ ░  ░  ▒     ░▒ ░ ▒░  ▒   ▒▒ ░   ░      ░  ▒    ▒ ░▒░ ░ ░ ░  ░ ░ ▒  ▒        //
//    ░  ░  ░  ░          ░░   ░   ░   ▒    ░      ░         ░  ░░ ░   ░    ░ ░  ░        //
//          ░  ░ ░         ░           ░  ░        ░ ░       ░  ░  ░   ░  ░   ░           //
//     ▄████▄  ░██▓    ▄▄▄     ▓██   ██▓ ██▓███   █░   ██  ███▄    █  ██ ▄█▀░ ██████      //
//    ▒██▀ ▀█  ▓██▒   ▒████▄    ▒██  ██▒▓██░  ██▒ ██  ▓██▒ ██ ▀█   █  ██▄█▒ ▒██    ▒      //
//    ▒▓█    ▄ ▒██░   ▒██  ▀█▄   ▒██ ██░▓██░ ██▓▒▓██  ▒██░▓██  ▀█ ██▒▓███▄░ ░ ▓██▄        //
//    ▒▓▓▄ ▄██▒▒██░   ░██▄▄▄▄██  ░ ▐██▓░▒██▄█▓▒ ▒▓▓█  ░██░▓██▒  ▐▌██▒▓██ █▄   ▒   ██▒     //
//    ▒ ▓███▀ ░░██████▒▓█   ▓██▒ ░ ██▒▓░▒██▒ ░  ░▒▒█████▓ ▒██░   ▓██░▒██▒ █▄▒██████▒▒     //
//    ░ ░▒ ▒  ░░ ▒░▓  ░▒▒   ▓▒█░  ██▒▒▒ ▒▓▒░ ░  ░░▒▓▒ ▒ ▒ ░ ▒░   ▒ ▒ ▒ ▒▒ ▓▒▒ ▒▓▒ ▒ ░     //
//      ░  ▒   ░ ░ ▒  ░ ▒   ▒▒ ░▓██ ░▒░ ░▒ ░     ░░▒░ ░ ░ ░ ░░   ░ ▒░░ ░▒ ▒░░ ░▒  ░ ░     //
//    ░          ░ ░    ░   ▒   ▒ ▒ ░░  ░░        ░░░ ░ ░    ░   ░ ░ ░ ░░ ░ ░  ░  ░       //
//    ░ ░          ░  ░     ░  ░░ ░                 ░              ░ ░  ░         ░       //
//    ░                         ░ ░                                                       //
//                                                                                        //
//                                                                                        //
////////////////////////////////////////////////////////////////////////////////////////////


contract SCP is ERC721Creator {
    constructor() ERC721Creator("Scratched ClayPunks", "SCP") {}
}