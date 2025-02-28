// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Bloody Mary Nominus
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                          //
//                                                                                          //
//      |~\                           |\  /|                   |                            //
//      |  >                    __/\__| \/ |           __/\__\ |                            //
//      |_/                     \    /| /\ |           \    / \|                            //
//      |~\  |\ /\ /\ |\ /| |~\ /_  _\|/  \| |\ |\ |~\ /_  _\  |\  /\ |\/| |  |  |\  /      //
//      |  > |  \/ \/ | X | |_|   \/  |    | |\ |/ |_|   \/    | \ \/ |/\| | `|  | | --     //
//      |_/  |  /\ /\ |/ \| |||       |    | |  |\ |||         |   /\ |  | |  |` | |  /     //
//                                                                                          //
//                                             ▌                                            //
//                                ▄            █                                            //
//                                ╙            █           ▌                                //
//                                █            ▌           █                                //
//                                █            ▌           █                                //
//                                █            ▌           █                                //
//                                ▐            ▌           █                                //
//                             ╓▄▄█▄▄µ         █           █                                //
//                          ╓██▀▀▀▓▀▀██▄,      ▌      ▄▄████████▄                           //
//                         ]█▀    ▌    ▀██     ▌    ,██▀'  ▐   ╙██▄                         //
//                        Æ█▌  ,█████   ▐█▌ ,╓╥╓,   ██   █████⌐  ██▌                        //
//                   "▀▀▀▀▀█▀▀T▐█████▀▀▀█████▀█▀▀█████▀▀▀█████▌"╜▀██▀▀▀╙"▀"                 //
//                         ██   ▐▀▀▀█  ╓██▀   ▐▌   ▀██▄  ██▀▀▀   ██                         //
//                          ██▄   ▌ ▀█▄██▌  ██████   █████ ▐` ▄▄██                          //
//                           `▀██████▀███  ▐██████▌  ██████████▀`                           //
//                               jU    ███  ▀████▀  ▄██▀   ▐                                //
//                               j▌     ███▄µ ▐▌  ╓███▀    ▐                                //
//                               ,▌     "█████████▀██▀     ▐                                //
//                               ▐▌       ▓█  ]▌¬ ██       █⌐                               //
//                                ▌        ▐█Ç]▌╓██        ▐W                               //
//                                ▌         ╙█▄██▀         ▐C                               //
//                                ▌          ╙██           ▐                                //
//                                D           ╙▌           ▐                                //
//                                ▌            ▌           j⌐                               //
//                                ▌           "▌           ]▌                               //
//                                ▄            ▌           ▐                                //
//                                ╙            ▌           ╙                                //
//                                             ▀                                            //
//                                                                                          //
//                                                                                          //
//////////////////////////////////////////////////////////////////////////////////////////////


contract SCR7PT is ERC1155Creator {
    constructor() ERC1155Creator("Bloody Mary Nominus", "SCR7PT") {}
}