// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Xmas Gift
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

//////////////////////////////////////////////////////////////////////////
//                                                                      //
//                                                                      //
//                                                                      //
//                              ____                                    //
//     ,--,     ,--,          ,'  , `.    ,---,          .--.--.        //
//     |'. \   / .`|       ,-+-,.' _ |   '  .' \        /  /    '.      //
//     ; \ `\ /' / ;    ,-+-. ;   , ||  /  ;    '.     |  :  /`. /      //
//     `. \  /  / .'   ,--.'|'   |  ;| :  :       \    ;  |  |--`       //
//      \  \/  / ./   |   |  ,', |  ': :  |   /\   \   |  :  ;_         //
//       \  \.'  /    |   | /  | |  || |  :  ' ;.   :   \  \    `.      //
//        \  ;  ;     '   | :  | :  |, |  |  ;/  \   \   `----.   \     //
//       / \  \  \    ;   . |  ; |--'  '  :  | \  \ ,'   __ \  \  |     //
//      ;  /\  \  \   |   : |  | ,     |  |  '  '--'    /  /`--'  /     //
//    ./__;  \  ;  \  |   : '  |/      |  :  :         '--'.     /      //
//    |   : / \  \  ; ;   | |`-'       |  | ,'           `--'---'       //
//    ;   |/   \  ' | |   ;/           `--''                            //
//    `---'     `--`  '---'                                             //
//                                                                      //
//                                                                      //
//                                                                      //
//                                                                      //
//////////////////////////////////////////////////////////////////////////


contract XG is ERC1155Creator {
    constructor() ERC1155Creator("Xmas Gift", "XG") {}
}