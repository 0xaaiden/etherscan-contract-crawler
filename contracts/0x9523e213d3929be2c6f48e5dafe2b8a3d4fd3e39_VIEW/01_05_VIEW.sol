// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: View to nothingness
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                          //
//                                                                                                                          //
//     __ __ __  ____ __    __    ______   ___      __  __   ___   ______ __  __ __ __  __   ___  __  __  ____  __   __     //
//     || || || ||    ||    ||    | || |  // \\     ||\ ||  // \\  | || | ||  || || ||\ ||  // \\ ||\ || ||    (( \ (( \    //
//     \\ // || ||==  \\ /\ //      ||   ((   ))    ||\\|| ((   ))   ||   ||==|| || ||\\|| (( ___ ||\\|| ||==   \\   \\     //
//      \V/  || ||___  \V/\V/       ||    \\_//     || \||  \\_//    ||   ||  || || || \||  \\_|| || \|| ||___ \_)) \_))    //
//                                                                                                                          //
//    View to Nothingness is a series of 36 chemical paintings created by Pedro Victor Brandão between 2008 and 2012.       //
//    Minted in 2023.                                                                                                       //
//                                                                                                                          //
//                                                                                                                          //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract VIEW is ERC721Creator {
    constructor() ERC721Creator("View to nothingness", "VIEW") {}
}