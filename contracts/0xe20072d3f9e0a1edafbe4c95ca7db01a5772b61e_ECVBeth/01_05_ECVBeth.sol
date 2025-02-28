// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Espacio Cripto
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                                                                                                                 //
//                                                                                                                                                                                                                                 //
//    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    //
//    //                                                                                                                                                                                                                     //    //
//    //                                                                                                                                                                                                                     //    //
//    //    ___________                           .__         _________        .__        __                        __________                                        ____   ____                                            //    //
//    //    \_   _____/ _________________    ____ |__| ____   \_   ___ \_______|__|______/  |_  ____       .__      \______   \__ _________   ____   ______   ______  \   \ /   /___ ___.__._____     ____   ___________     //    //
//    //     |    __)_ /  ___/\____ \__  \ _/ ___\|  |/  _ \  /    \  \/\_  __ \  \____ \   __\/  _ \    __|  |___   |    |  _/  |  \_  __ \_/ __ \ /  ___/  /_____/   \   Y   /  _ <   |  |\__  \   / ___\_/ __ \_  __ \    //    //
//    //     |        \\___ \ |  |_> > __ \\  \___|  (  <_> ) \     \____|  | \/  |  |_> >  | (  <_> )  /__    __/   |    |   \  |  /|  | \/\  ___/ \___ \   /_____/    \     (  <_> )___  | / __ \_/ /_/  >  ___/|  | \/    //    //
//    //    /_______  /____  >|   __(____  /\___  >__|\____/   \______  /|__|  |__|   __/|__|  \____/      |__|      |______  /____/ |__|    \___  >____  >              \___/ \____// ____|(____  /\___  / \___  >__|       //    //
//    //            \/     \/ |__|       \/     \/                    \/          |__|                                      \/                   \/     \/                           \/          \//_____/      \/           //    //
//    //                                                                                                                                                                                                                     //    //
//    //                                                                                                                                                                                                                     //    //
//    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    //
//                                                                                                                                                                                                                                 //
//                                                                                                                                                                                                                                 //
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract ECVBeth is ERC1155Creator {
    constructor() ERC1155Creator("Espacio Cripto", "ECVBeth") {}
}