// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Cloudy Checks
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                        //
//                                                                                        //
//                                   ___    ,'""""'.                                      //
//                                        ,"""   """"'      `.                            //
//                                       ,'        _.         `._                         //
//                                      ,'       ,'              `"""'.                   //
//                                     ,'    .-""`.    ,-'            `.                  //
//                                    ,'    (        ,'                :                  //
//                                  ,'     ,'           __,            `.                 //
//                            ,""""'     .' ;-.    ,  ,'  \             `"""".            //
//                          ,'           `-(   `._(_,'     )_                `.           //
//                         ,'         ,---. \ @ ;   \ @ _,'                   `.          //
//                    ,-""'         ,'      ,--'-    `;'                       `.         //
//                   ,'            ,'      (      `. ,'                          `.       //
//                   ;            ,'        \    _,','                            `.      //
//                  ,'            ;          `--'  ,'                              `.     //
//                 ,'             ;          __    (                    ,           `.    //
//                 ;              `____...  `78b   `.                  ,'           ,'    //
//                 ;    ...----'''' )  _.-  .d8P    `.                ,'    ,'    ,'      //
//    _....----''' '.        _..--"_.-:.-' .'        `.             ,''.   ,' `--'        //
//                  `" mGk "" _.-'' .-'`-.:..___...--' `-._      ,-"'   `-'               //
//            _.--'       _.-'    .'   .' .'               `"""""                         //
//      __.-''        _.-'     .-'   .'  /                                                //
//     '          _.-' .-'  .-'        .'                                                 //
//            _.-'  .-'  .-' .'  .'   /                                                   //
//        _.-'      .-'   .-'  .'   .'                                                    //
//    _.-'       .-'    .'   .'    /                                                      //
//           _.-'    .-'   .'    .'                                                       //
//        .-'            .'                                                               //
//                                                                                        //
//                                                                                        //
////////////////////////////////////////////////////////////////////////////////////////////


contract CloudyChecks is ERC1155Creator {
    constructor() ERC1155Creator("Cloudy Checks", "CloudyChecks") {}
}