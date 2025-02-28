// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Fused Visions
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                                       //
//                                                                                                                                                       //
//                                                                                                                                                       //
//          :::::::::: :::    :::  ::::::::  :::::::::: :::::::::       :::     ::: ::::::::::: :::::::: ::::::::::: ::::::::  ::::    :::  ::::::::     //
//         :+:        :+:    :+: :+:    :+: :+:        :+:    :+:      :+:     :+:     :+:    :+:    :+:    :+:    :+:    :+: :+:+:   :+: :+:    :+:     //
//        +:+        +:+    +:+ +:+        +:+        +:+    +:+      +:+     +:+     +:+    +:+           +:+    +:+    +:+ :+:+:+  +:+ +:+             //
//       :#::+::#   +#+    +:+ +#++:++#++ +#++:++#   +#+    +:+      +#+     +:+     +#+    +#++:++#++    +#+    +#+    +:+ +#+ +:+ +#+ +#++:++#++       //
//      +#+        +#+    +#+        +#+ +#+        +#+    +#+       +#+   +#+      +#+           +#+    +#+    +#+    +#+ +#+  +#+#+#        +#+        //
//     #+#        #+#    #+# #+#    #+# #+#        #+#    #+#        #+#+#+#       #+#    #+#    #+#    #+#    #+#    #+# #+#   #+#+# #+#    #+#         //
//    ###         ########   ########  ########## #########           ###     ########### ######## ########### ########  ###    ####  ########           //
//                                                                                                                                                       //
//                                                                                                                                                       //
//    |_) \/                                                                                                                                             //
//    |_) /                                                                                                                                              //
//    ___       __          __           _                                                                                                               //
//     | |_  _ /__ _  _  | /  |_  o  _ _|_                                                                                                               //
//     | | |(/_\_|(/_(/_ |<\__| | | (/_ |                                                                                                                //
//                                                                                                                                                       //
//                                                                                                                                                       //
//                                                                                                                                                       //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract FV is ERC721Creator {
    constructor() ERC721Creator("Fused Visions", "FV") {}
}