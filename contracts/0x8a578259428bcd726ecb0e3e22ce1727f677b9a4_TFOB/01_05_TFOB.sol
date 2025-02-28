// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: The Faces of Beauty
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                           //
//                                                                                           //
//                                                                                           //
//                       (                                                                   //
//      *   )   )        )\ )                      (        (                    )           //
//    ` )  /(( /(   (   (()/(   )       (          )\ )   ( )\    (    )   (  ( /((          //
//     ( )(_))\()) ))\   /(_)| /(  (   ))\(     ( (()/(   )((_)  ))\( /(  ))\ )\())\ )       //
//    (_(_()|(_)\ /((_) (_))_)(_)) )\ /((_)\    )\ /(_)) ((_)_  /((_)(_))/((_|_))(()/(       //
//    |_   _| |(_|_))   | |_((_)_ ((_|_))((_)  ((_|_) _|  | _ )(_))((_)_(_))(| |_ )(_))      //
//      | | | ' \/ -_)  | __/ _` / _|/ -_|_-< / _ \|  _|  | _ \/ -_) _` | || |  _| || |      //
//      |_| |_||_\___|  |_| \__,_\__|\___/__/ \___/|_|    |___/\___\__,_|\_,_|\__|\_, |      //
//                                                                                |__/       //
//                                                                                           //
//                                                                                           //
//                                                                                           //
///////////////////////////////////////////////////////////////////////////////////////////////


contract TFOB is ERC721Creator {
    constructor() ERC721Creator("The Faces of Beauty", "TFOB") {}
}