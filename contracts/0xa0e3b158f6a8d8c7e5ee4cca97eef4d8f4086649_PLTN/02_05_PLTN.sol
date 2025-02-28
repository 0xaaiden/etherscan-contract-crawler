// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Palatine (Playschool)
/// @author: manifold.xyz

import "./ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                                                                                                //
//                                                                                                                                                                                                                //
//     .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .----------------.     //
//    | .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. |    //
//    | |   ______     | || |   _____      | || |      __      | || |  ____  ____  | || |    _______   | || |     ______   | || |  ____  ____  | || |     ____     | || |     ____     | || |   _____      | |    //
//    | |  |_   __ \   | || |  |_   _|     | || |     /  \     | || | |_  _||_  _| | || |   /  ___  |  | || |   .' ___  |  | || | |_   ||   _| | || |   .'    `.   | || |   .'    `.   | || |  |_   _|     | |    //
//    | |    | |__) |  | || |    | |       | || |    / /\ \    | || |   \ \  / /   | || |  |  (__ \_|  | || |  / .'   \_|  | || |   | |__| |   | || |  /  .--.  \  | || |  /  .--.  \  | || |    | |       | |    //
//    | |    |  ___/   | || |    | |   _   | || |   / ____ \   | || |    \ \/ /    | || |   '.___`-.   | || |  | |         | || |   |  __  |   | || |  | |    | |  | || |  | |    | |  | || |    | |   _   | |    //
//    | |   _| |_      | || |   _| |__/ |  | || | _/ /    \ \_ | || |    _|  |_    | || |  |`\____) |  | || |  \ `.___.'\  | || |  _| |  | |_  | || |  \  `--'  /  | || |  \  `--'  /  | || |   _| |__/ |  | |    //
//    | |  |_____|     | || |  |________|  | || ||____|  |____|| || |   |______|   | || |  |_______.'  | || |   `._____.'  | || | |____||____| | || |   `.____.'   | || |   `.____.'   | || |  |________|  | |    //
//    | |              | || |              | || |              | || |              | || |              | || |              | || |              | || |              | || |              | || |              | |    //
//    | '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' |    //
//     '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'     //
//                                                                                                                                                                                                                //
//                                                                                                                                                                                                                //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract PLTN is ERC721Creator {
    constructor() ERC721Creator("Palatine (Playschool)", "PLTN") {}
}