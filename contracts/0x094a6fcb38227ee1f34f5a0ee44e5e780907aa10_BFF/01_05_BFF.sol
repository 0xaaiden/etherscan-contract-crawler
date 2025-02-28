// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: BURN FOR FLY
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

/////////////////////////////////////////////////////////
//                                                     //
//                                                     //
//     (                         (           (         //
//     )\ )      (        (      )\ )        )\ )      //
//    (()/( (    )\ )     )\    (()/(    (  (()/(      //
//     /(_)))\  (()/(  ((((_)(   /(_))   )\  /(_))     //
//    (_)) ((_)  /(_))_ )\ _ )\ (_))  _ ((_)(_))       //
//    | _ \| __|(_)) __|(_)_\(_)/ __|| | | |/ __|      //
//    |  _/| _|   | (_ | / _ \  \__ \| |_| |\__ \      //
//    |_|  |___|   \___|/_/ \_\ |___/ \___/ |___/      //
//                                                     //
//                                                     //
//                                                     //
//                                                     //
//                                                     //
/////////////////////////////////////////////////////////


contract BFF is ERC1155Creator {
    constructor() ERC1155Creator("BURN FOR FLY", "BFF") {}
}