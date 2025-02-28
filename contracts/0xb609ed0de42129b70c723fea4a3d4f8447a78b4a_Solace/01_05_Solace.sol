// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Dougs Collections
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                //
//                                                                                                                                //
//    ....',:::;;::;;;;;,,''......           ..                .....:dl::::::::::::::::;;;;;;;;;;,,,,,,,,,''''''..............    //
//    ...',,,,,''',,'''..........        ............              .xOl;::::::::::;;;;;;;;;;;;;;;,,,,,,,,'''''''''............    //
//    .',,,,'...                                ...........  ..    ;0k:;;;;;;;;;;;;;;;;;;;;;;;;;,,,,,,,,,''''''''',;;'........    //
//      ..'..                                          ...         .do;;;;;;;;;;;;;;;;;;;;;;;,,,,,,,,,,,'''''''..',:;'........    //
//                                                                ..;;;;;;;;;;;;;;;;;;,,,,,,,,,,,,,''''''''''.................    //
//             ..                     .,,'..                  ....'',,,,,,,,,,,,,,,,,,,,,,,,,,,''''''''''''...'...............    //
//             ......                ..,::;,,,,'..             ..,,;;;;,,,,,,,,,,,,,,,,,,,,,,,,''''''''''''',,'...............    //
//                ....                 ..'.....,,,,,'.       ..',;;;;;;,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,''''',;;'''.............    //
//                   ..''.                 ........',,...... .,;;;;;;;;,,,;;;;;,,,,,,,,,,,,,,,,,,,,'''''''''''''..............    //
//                     .....             ..'......''.... ..;cclc;;;;;;;;;;;,;;,,,,,,,,,,;;,,,,,,,,''''''''''''................    //
//                         .            ..''''............ .';clooool:;;;;;;;,,,,,,,,,,,;;,,,,,,,''''''''''''''''....'........    //
//                                    ..'',,,,,,,,,,,.  ....   ..';:cclc:;;;;;;;,,,,,,,,,,,,,,,''''''''''''''''''...''........    //
//                                   .',,,,,,,;;;;;;,.  .... .........'',,;;;;;;;;;,,,,,,,,,,,,,''''''''''''''''..............    //
//                                  .,;;;;;;;;;;;;;,..  .... ....''''.....';;;;;;;;,,,,,,,,,,,,,'''''''''''''.................    //
//                                .',;;;;;;;;;:::;,.   ....  .';::;;,.  ..,::;;;;;;;;,,,,,,,,,,'''''''''''''''................    //
//                               .';;;;;:::::::::,.   .''.  .;cc:::;.  ..,:::;;;;;;;,,,,,,,,,,,''''''''''''...................    //
//                              .,;;:::::::cccc;'.  .',..  .;cccc;,.  ..,::::;;;;;;,,,,,,,,,,,,'''''''''''....................    //
//                             .,;;::::::ccccc,.  ..,,.   .,llcc:'.  ..;ccc::::;;;;;;;,,,,,,,,''''''''''......................    //
//                            .,;;::::::ccc:;'.  .,;'.    'llll:'. ..';ccccc::::;;;;;;;,,,,,,,,''''''''''''...................    //
//    .                      .,;;;::::c:;,''.  .';,.     .coll:'....':llccccc:::;;;;;;;,,,,,,,,''''''''''''...................    //
//    .                     .,;;;;::;,...... ..,;'.     .cool:....',cllllcccc::::;;;;;;,,,,,,,,''''''''''.....................    //
//    ..                   .',,;;;,.. ...  ..,;'.      .:ool;...';:clllllccccc::::;;;;;;,,,,,,,,'''''''''.....................    //
//                        .',,,,,.  ...  ..,,'.        .:l:'...':loolllllccccc:::::;;;;;;,,,,,,,,'''''''''....................    //
//                        .......      ..,,..           ......,coooollllllccccc:::::;;;;;;,,,,,,,,''''''''''..................    //
//                                   ..''.             ..'',;cloooolllllllcccccc::::;;;;;;;,,,,,,,,'''''''''..................    //
//                       ............'..               .;:clloooollllllllccccccc:::::;;;;;;,,,,,,,,''''''''...................    //
//                         ..........                  .looololllllllllllccccccc:::::;;;;;;;,,,,,,,,,'''''''..................    //
//                                                     .cllllllllllllllccccccccc::::;;;;;;;;,,,,,;::c:;,'''''.................    //
//                                                     'clllllllllllcccccccccc::::::;;;;;;;,,,,,,:cclc:,'''''.................    //
//                                                    .;cccccccccccccccccccc:::::::;;;;;;;,,,,,,,;:c:;,,''''..................    //
//                                                    .;cccccccccccccccccc:::::::;;;;;;;;,,,,,,,,,,,,,''''''..................    //
//                                                    .;c:cccccccccccc:::::::::;;;;;;;;;,,,,,,,,,,,,''''''....................    //
//                                      .'.           .;:::::::::::::::::::::;;;;;;;;;,,,,,,,,,,,'''''''''....................    //
//                                                    .;;;;::::::::::::::;;;;;;;;;;;;,,,,,,,,,,''''''''''.....................    //
//                                                    ';;;;;;;;;;;;;;;;;;;;;;;;;;;;,,,,,,,,,,,''''''''''......................    //
//                                                   .;;;;;;;;;;;;;;;;;;;;;;;;;;;,,,,,,,,,,,,''''''''''.......................    //
//                                                  .,;;;;;;;;;;;;;;;;;;;;;;;;;;,,,,,,,,,,,,'''''''''.........................    //
//                                                ..,,,;;;;;;;;;;;;;;;;;;;;;;;,,,,,,,,,,,,''''''''''..........................    //
//                              .               ..',,,,,;;;;;;;;;;;;;;;;;;;;;,,,,,,,,,,,,,''''''''''..........................    //
//                             .......      ....,,,,,,,,;;;;;;;;;;;;;;;;;;;;,,,,,,,,,,,,,,'''''''''...........................    //
//    ..                      ....''''''''''',,,,,,,,,,,;;;;;;;;;;;;;;;;;;;;,,,,,,,,,,,,,,,'''''''............................    //
//    ....                  .......''''''''',,,,,,,,,,,,,;;;;;;;;;;;;;;;;;;;;;,,,,,,,,,,,,,''''''''...........................    //
//    .......            ...........'''''''',,,,,,,,,,,,;;;;;;;;;;;;;;;;;;;;;;;;,,,,,,,,,,,''''''''...........................    //
//    ..............................'''''''',,,,,,,,,,;;;;;;;;;;;;;;;;;;;;;;;;;;;;,,,,,,,,,,''''''''..........................    //
//    ...............................'''''''',,,,,,,,,;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,,,,,,,,''''''''..........................    //
//    .................................'''''',,,,,,,,,;;;;;;;;;;;;;;::::;;;;;;;;;;;;;;,,,,,,,''''''''.........................    //
//    ..................................''''''',,,,,,,,;;;;;;;;;;;:::::::::;;;;;;;;;;;;,,,,,,,''''''''........................    //
//        ................................''''''',,,,,,,;;;;;;;;;::::::::::::;;;;;;;;;;;;,,,,,,,'''''''.......................    //
//         ................................''''''',,,,,,,;;;;;;;;;;:::::::::::::;;;;;;;;;,,,,,,,'''''''.......................    //
//                                                                                                                                //
//                                                                                                                                //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract Solace is ERC1155Creator {
    constructor() ERC1155Creator("Dougs Collections", "Solace") {}
}