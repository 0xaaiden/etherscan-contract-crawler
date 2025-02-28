// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: pages
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

//////////////////////////////////////////////////////////////////////
//                                                                  //
//                                                                  //
//                                                                  //
//    .-------.    ____      .-_'''-.       .-''-.     .-'''-.      //
//    \  _(`)_ \ .'  __ `.  '_( )_   \    .'_ _   \   / _     \     //
//    | (_ o._)|/   '  \  \|(_ o _)|  '  / ( ` )   ' (`' )/`--'     //
//    |  (_,_) /|___|  /  |. (_,_)/___| . (_ o _)  |(_ o _).        //
//    |   '-.-'    _.-`   ||  |  .-----.|  (_,_)___| (_,_). '.      //
//    |   |     .'   _    |'  \  '-   .''  \   .---..---.  \  :     //
//    |   |     |  _( )_  | \  `-'`   |  \  `-'    /\    `-'  |     //
//    /   )     \ (_ o _) /  \        /   \       /  \       /      //
//    `---'      '.(_,_).'    `'-...-'     `'-..-'    `-...-'       //
//                                                                  //
//                                                                  //
//                                                                  //
//                                                                  //
//////////////////////////////////////////////////////////////////////


contract pgs is ERC721Creator {
    constructor() ERC721Creator("pages", "pgs") {}
}