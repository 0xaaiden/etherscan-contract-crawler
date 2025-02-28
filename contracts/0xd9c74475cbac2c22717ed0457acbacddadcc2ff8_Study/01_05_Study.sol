// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Aitudes
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                            //
//                                                                                            //
//                                                                                            //
//                                       ..     - ..  ;.....   .                              //
//                                                                                            //
//                            ,φφφ▒▒▓▓╬╬▒▒╦φ░=!ⁿ==ⁿ≤∩=░ⁿ░░!≥≤░≤=≥░≥≈≥≥░≥=░░=\»ⁿ=¿≤;;..~ --    //
//        >.  ░░ ∩ ░.;»░░≥░░╔╣╬╬╬╬╬╬╬╬╬╬╬╬╬╬╠▒╦                                               //
//        Γ"Γ"Γ""░'       φ╣╬╬╬╬╬╣╣╣╣╣╬╣╬╬╬╬╬╬╬╬▒,,,,,,,,,,,,,,;,,,, ,,  ,,   ,               //
//        ,,,,,,,,,,,..░,╬╣▓▓▓▓╬╣███╣╣╣╬╬╣╬╬╬╬╬╬╬╬╦                          ' '"  ^'"""^"    //
//        ╚╩╚╩╩╩╩╚╚╚╙▒▄▓╬╣▓▓█▓▓███████▓▓▓╣╣╬╬╬╬╬╬╬╬▒░░░░░≥░Σ░≤░≥φΓφ░░░∩░░░                    //
//        ''  '▄▄█████████▓████╬████φ▓╣╬╣╬╬╣╬╣╬╬╬╬╬╬        .    ,,    ,, ,,,,,,,,,,,,,,,,    //
//        """"└╙╙▀▀▀██████▓▓▓╬╣▓╬▓╣▓▓╣╣╬╬╬╬╬╬╣╣╬╬╬╬╬▓▒▒▒▒░░░░░░░░░░░░░≥░╩╩╩╩╩╩╩╩╩╩╩╩╩╩╩╩╩╩    //
//        φφφφφφφφφφφφ-│╠╣╬╣╣╬╣▓╣╣▓╣▓▓╬╬╬╣╬╣╬╬╬╬╣╬▓▓█▓▓▓▓╬▓▓╗,                                //
//         '└ '  '  Γ^^"╙╠╬╬╬╬▓╬╬╬╣▓╬╬▓╣╬╣╣╣▓▓▓██▓▓▓╣╣▓╣╬╬▓▓▓╬╬█▄,                            //
//                   ,,,,,╣╣▓╣╬╬╣╬╬╬╣▓▓█████▓███▓╬╬╬▓▓▓▓╣╬▓▓▓▓╣╬╬╬▓▄      '  '''"""""""""Γ    //
//        φφ▒▒▒╠▒▒▒╬▒╬░░▒╬╬╬╬╬╬╬╬╬╬╣╣▓█████▓▓▓▓████▓███████▓██▓▓▓▓╬╬╬▒                        //
//        ╠╠▒╬╩╩╩╚╩╙╙░░╬╬╬╠╬╬╬╬╬╬╬╣╣███▓███████▓▓▓▓██▓▓▓▓▓▓█▓▓▓▓▓▓▓▓▓╣▓█▄▄▄▄≤φφφ╦φφφφφφφφφ    //
//        ╙╙╙╚░ΓΓ░░░░░╠╬╬╬╬╬╬╬╬╬╬╬╬╣▓██████▓▓█▓█▓█▓▓▓██▓▓█████▓▓▓▓▓▓▓▓▓▓▓▓▓╬╬╬████▒╬╬╬╠╬╬╠    //
//        ░░▒▒▒▒▒▒▒▒╠╠╠╬╬╬╠╬╬╬╬╬╬╬╣╬▓██▓█████████████████████▓█▓▓▓▓▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▀╠╬╬╠╠    //
//        ▒╠╬╩╩╩╩╩░░░╬╬╬╬╬╬╠╬╬╬╬╬╬╣╣▓█▓▓▓█▓█▓╣█▓▓▓█▓█▓▓▓██▓▓▓████▓██▓█▓▓▓▓▓▓▓████▀▀░▒▒░░╠╚    //
//        ░░░╙╙╙│░''│╬╬╣╬╬╬╬╬╬╬╬╬╬╣╣▓▓▓████▓███████████████▓▓▓█████████████████▀▀░░░░"░░░░    //
//        ░░░░Γ▒░Γ╙╙░║╬╬╬╣╬╣╬╬╣╬╬╣╬▓▓▓╣╣▓╣╣█████████████████████████▓▓███▓╬╬╩╬╬╬╬╬╠▒░φ░▒φφ    //
//        ▒▒▒▒▄▄▄▄▄▄▄╬╬╣╬╬╬╬╬╬╣╬╬╣╬╬▓╣▓▓▓██████████████████████████▓╬╠╬╬╬╬╬▒░░░░░░░░░░"Γ╙╙    //
//        ░i▄░░▒▒░╚╝╜╙║▓▓▓╣▓▓▓▓╬╣▓╣▓▓▓▓▓▓▓█╬███████████████▓╬██╬╬╬╬╬╬╣╬╬╣╣╬▒░░░░#φ░░░░''      //
//        ░▒φφφφφφφφφφ║█████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓╬╬╬▓▓▓╣╬╣▓╣▓▓╬╬▓╬╬▓╣╣▓▓▓▓▓▓▓▓▒░░░░░,,░φφ≤≥φ≥φ    //
//        ╬╠╬╬╬╬╬╠╬╬╬▓██████████████████████████▓██▓▓▓▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▄▄▒░╙╙╙╙╙╙╙╚░░    //
//        ╙╙╚╚╩╚╩╩╠╬╠╠█████████████████████████████████████████████████████████▒▒▒▒▒ΓΓ░░░░    //
//        ░░▒▒φφφφφφφ╣▓▓███████████████████████████████████████████████████████████╦╬φ╬╬▒▒    //
//                                                                                            //
//                                                                                            //
//                                                                                            //
//                                                                                            //
//                                                                                            //
////////////////////////////////////////////////////////////////////////////////////////////////


contract Study is ERC721Creator {
    constructor() ERC721Creator("Aitudes", "Study") {}
}