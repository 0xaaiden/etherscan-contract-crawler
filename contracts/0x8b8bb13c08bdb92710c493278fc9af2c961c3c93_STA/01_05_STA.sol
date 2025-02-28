// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Surya Teja
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                       //
//                                                                                                                                       //
//                                                                                                                                       //
//                                                                                   ,----,                                              //
//                                                                                 ,/   .`|                  ,---._                      //
//      .--.--.                 ,-.----.                 ,---,                   ,`   .'  :   ,---,.       .-- -.' \    ,---,            //
//     /  /    '.          ,--, \    /  \        ,---,  '  .' \                ;    ;     / ,'  .' |       |    |   :  '  .' \           //
//    |  :  /`. /        ,'_ /| ;   :    \      /_ ./| /  ;    '.            .'___,/    ,',---.'   |       :    ;   | /  ;    '.         //
//    ;  |  |--`    .--. |  | : |   | .\ :,---, |  ' ::  :       \           |    :     | |   |   .'       :        |:  :       \        //
//    |  :  ;_    ,'_ /| :  . | .   : |: /___/ \.  : |:  |   /\   \          ;    |.';  ; :   :  |-,       |    :   ::  |   /\   \       //
//     \  \    `. |  ' | |  . . |   |  \ :.  \  \ ,' '|  :  ' ;.   :         `----'  |  | :   |  ;/|       :         |  :  ' ;.   :      //
//      `----.   \|  | ' |  | | |   : .  / \  ;  `  ,'|  |  ;/  \   \            '   :  ; |   :   .'       |    ;   ||  |  ;/  \   \     //
//      __ \  \  |:  | | :  ' ; ;   | |  \  \  \    ' '  :  | \  \ ,'            |   |  ' |   |  |-,   ___ l         '  :  | \  \ ,'     //
//     /  /`--'  /|  ; ' |  | ' |   | ;\  \  '  \   | |  |  '  '--'              '   :  | '   :  ;/| /    /\    J   :|  |  '  '--'       //
//    '--'.     / :  | : ;  ; | :   ' | \.'   \  ;  ; |  :  :                    ;   |.'  |   |    \/  ../  `..-    ,|  :  :             //
//      `--'---'  '  :  `--'   \:   : :-'      :  \  \|  | ,'                    '---'    |   :   .'\    \         ; |  | ,'             //
//                :  ,      .-./|   |.'         \  ' ;`--''                               |   | ,'   \    \      ,'  `--''               //
//                 `--`----'    `---'            `--`                                     `----'      "---....--'                        //
//                                                                                                                                       //
//                                                                                                                                       //
//                                                                                                                                       //
//                                                                                                                                       //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract STA is ERC1155Creator {
    constructor() ERC1155Creator("Surya Teja", "STA") {}
}