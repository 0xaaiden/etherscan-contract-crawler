// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: 3D Magazine - Editions
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                                                         //
//                                                                                                                                                                         //
//     .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .----------------.   .----------------.  .----------------.     //
//    | .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. | | .--------------. || .--------------. |    //
//    | |     ______   | || |     ____     | || |   _____      | || |  ________    | || |     _____    | || |  _________   | | | |    ______    | || |  ________    | |    //
//    | |   .' ___  |  | || |   .'    `.   | || |  |_   _|     | || | |_   ___ `.  | || |    |_   _|   | || | |_   ___  |  | | | |   / ____ `.  | || | |_   ___ `.  | |    //
//    | |  / .'   \_|  | || |  /  .--.  \  | || |    | |       | || |   | |   `. \ | || |      | |     | || |   | |_  \_|  | | | |   `'  __) |  | || |   | |   `. \ | |    //
//    | |  | |         | || |  | |    | |  | || |    | |   _   | || |   | |    | | | || |      | |     | || |   |  _|  _   | | | |   _  |__ '.  | || |   | |    | | | |    //
//    | |  \ `.___.'\  | || |  \  `--'  /  | || |   _| |__/ |  | || |  _| |___.' / | || |     _| |_    | || |  _| |___/ |  | | | |  | \____) |  | || |  _| |___.' / | |    //
//    | |   `._____.'  | || |   `.____.'   | || |  |________|  | || | |________.'  | || |    |_____|   | || | |_________|  | | | |   \______.'  | || | |________.'  | |    //
//    | |              | || |              | || |              | || |              | || |              | || |              | | | |              | || |              | |    //
//    | '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' | | '--------------' || '--------------' |    //
//     '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'   '----------------'  '----------------'     //
//                                                                                                                                                                         //
//                                                                                                                                                                         //
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract Mag3DEd is ERC1155Creator {
    constructor() ERC1155Creator("3D Magazine - Editions", "Mag3DEd") {}
}