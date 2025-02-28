// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: reminiscence
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                        //
//                                                                                                        //
//    ////////////////////////////////////////////////////////////////////////////////////////////////    //
//    //                                                                                            //    //
//    //                                                                                            //    //
//    //          ::::    :::       ::::::::       :::::::::::       :::::::::       ::::::::::     //    //
//    //         :+:+:   :+:      :+:    :+:          :+:           :+:    :+:      :+:             //    //
//    //        :+:+:+  +:+      +:+    +:+          +:+           +:+    +:+      +:+              //    //
//    //       +#+ +:+ +#+      +#+    +:+          +#+           +#++:++#:       +#++:++#          //    //
//    //      +#+  +#+#+#      +#+    +#+          +#+           +#+    +#+      +#+                //    //
//    //     #+#   #+#+#      #+#    #+#          #+#           #+#    #+#      #+#                 //    //
//    //    ###    ####       ########       ###########       ###    ###      ##########           //    //
//    //                                                                                            //    //
//    //                                                                                            //    //
//    ////////////////////////////////////////////////////////////////////////////////////////////////    //
//                                                                                                        //
//                                                                                                        //
//                                                                                                        //
////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract RMN is ERC721Creator {
    constructor() ERC721Creator("reminiscence", "RMN") {}
}