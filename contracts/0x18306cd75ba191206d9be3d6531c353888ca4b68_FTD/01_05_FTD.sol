// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Freedom to Drainage
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                               //
//                                                                                               //
//    (                                            (                                             //
//     )\ )              (                   )      )\ )                                         //
//    (()/( (     (   (  )\ )       )     ( /(     (()/(  (      ) (           ) (  (    (       //
//     /(_)))(   ))\ ))\(()/( (    (      )\())(    /(_)) )(  ( /( )\  (    ( /( )\))(  ))\      //
//    (_))_(()\ /((_)((_)((_)))\   )\  ' (_))/ )\  (_))_ (()\ )(_)|(_) )\ ) )(_)|(_))\ /((_)     //
//    | |_  ((_|_))(_))  _| |((_)_((_))  | |_ ((_)  |   \ ((_|(_)_ (_)_(_/(((_)_ (()(_|_))       //
//    | __|| '_/ -_) -_) _` / _ \ '  \() |  _/ _ \  | |) | '_/ _` || | ' \)) _` / _` |/ -_)      //
//    |_|  |_| \___\___\__,_\___/_|_|_|   \__\___/  |___/|_| \__,_||_|_||_|\__,_\__, |\___|      //
//                                                                              |___/            //
//                                                                                               //
//                                                                                               //
///////////////////////////////////////////////////////////////////////////////////////////////////


contract FTD is ERC1155Creator {
    constructor() ERC1155Creator("Freedom to Drainage", "FTD") {}
}