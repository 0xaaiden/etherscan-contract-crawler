// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: The Eighties by Art Anon Collective
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                                                               //
//                                                                                                                                                                               //
//                                                                                                                                                                               //
//      _______ _            ______ _       _     _   _             _                           _                                   _____      _ _           _   _               //
//     |__   __| |          |  ____(_)     | |   | | (_)           | |               /\        | |       /\                        / ____|    | | |         | | (_)              //
//        | |  | |__   ___  | |__   _  __ _| |__ | |_ _  ___  ___  | |__  _   _     /  \   _ __| |_     /  \   _ __   ___  _ __   | |     ___ | | | ___  ___| |_ ___   _____     //
//        | |  | '_ \ / _ \ |  __| | |/ _` | '_ \| __| |/ _ \/ __| | '_ \| | | |   / /\ \ | '__| __|   / /\ \ | '_ \ / _ \| '_ \  | |    / _ \| | |/ _ \/ __| __| \ \ / / _ \    //
//        | |  | | | |  __/ | |____| | (_| | | | | |_| |  __/\__ \ | |_) | |_| |  / ____ \| |  | |_   / ____ \| | | | (_) | | | | | |___| (_) | | |  __/ (__| |_| |\ V /  __/    //
//        |_|  |_| |_|\___| |______|_|\__, |_| |_|\__|_|\___||___/ |_.__/ \__, | /_/    \_\_|   \__| /_/    \_\_| |_|\___/|_| |_|  \_____\___/|_|_|\___|\___|\__|_| \_/ \___|    //
//                                     __/ |                               __/ |                                                                                                 //
//                                    |___/                               |___/                                                                                                  //
//                                                                                                                                                                               //
//                                                                                                                                                                               //
//                                                                                                                                                                               //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract ATEEZ is ERC721Creator {
    constructor() ERC721Creator("The Eighties by Art Anon Collective", "ATEEZ") {}
}