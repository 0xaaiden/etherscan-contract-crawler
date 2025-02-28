// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: WORLD OF WONDERS EDITIONS
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                    //
//                                                                                                                                    //
//                                                                                                                                    //
//        ████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████    //
//        ████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████    //
//        ████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████    //
//        ████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████    //
//        ████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████    //
//        ████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████    //
//        ████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████    //
//        ████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████    //
//        ████████████████████████████████████████████████████▓╬╬╬╣╬▓▓▓███████████████████████████████████████████████████████████    //
//        █████████████████████████████████████████████████▓╬╢╣╬╠╠╩╩╩╠╠╫╣╬╬╠╠╬████████████████████████████████████████████████████    //
//        ███████████████████████████████████████████████▓╢╬╬╩▒╟╬╢╠▒░╚╚╠╣▓▒╣▒≥└╨╬█████████████████████████████████████████████████    //
//        █████████████████████████████████████████████▓╬▓╬▒▄╬╬╫╫╬╣╬▓▒╓∩╣▓╔╬▒░░!,╙╫███████████████████████████████████████████████    //
//        ████████████████████████████████████████████▓▓▀▒╟╬╩Ä╠╩╠╝╬╣╣╬▓▓▓▓▓╬╠░└'   ╫██████████████████████████████████████████████    //
//        ███████████████████████████████████████████▓▓▒▒╠╙░░#╙ ,▒╠╠╩╙╙╙╙╙╚╬▓▓▓▄    ║▓████████████████████████████████████████████    //
//        ███████████████████████████████████████████╬╢╬╟░,▒┘' ░└┌''       '"│╬█▓~   ╙████████████████████████████████████████████    //
//        ██████████████████████████████████████████▒╟╬╣▒.╠░ .~'.'           '"╙▓▌    ╚███████████████████████████████████████████    //
//        █████████████████████████████████████████╬╠╬╬▌░╠└ ,.''''             '⌠▓     ╚██████████████████████████████████████████    //
//        ████████████████████████████████████████╬╠╠╬╣▒╔∩[.\¡⌐~'               "╠▒     ╫█████████████████████████████████████████    //
//        ███████████████████████████████████████╬╬╬╬╬╬░▒;⌐!!!⌐'~'               ╠╬     "▓████████████████████████████████████████    //
//        ██████████████████████████████████████▓╣╫╣▓▓╬╠░░:;░;¡¡;┌.' . .,,╓╔╦░∩"-]╫▄     ╚████████████████████████████████████████    //
//        ██████████████████████████████████████▓▓╣▓▓╬╣╩]▒╩╬▓▓▓▓▓▄░░~'.7╚╟▓█▓█▓▄ '⌠█      ▓███████████████████████████████████████    //
//        ██████████████████████████████████████▓▓▓▓▓╬╬░╠▒▓███▀╝╬▓╬░~   "╙≥╩▀╩╙╙¬  ╟⌐     └███████████████████████████████████████    //
//        ███████████████████████████████████████▓▓▓╬╣╬░▒╩▓╬╩╙└┘│╚╠╠∩              j▒      ╟██████████████████████████████████████    //
//        █████████████████████████████████████████╣▓╬▒░░░░∩∩-,¡░░▐╠▒,             j▒      \██████████████████████████████████████    //
//        ████████████████████████████████████████▓▓█╬╬╫▒░░░┐:'¡░#▒▓▒┐             ▐▌⌐  ~   ╙█████████████████████████████████████    //
//        ████████████████████████████████████████▓█▓╬╣█▓╬▒░░(;¡░║╬▓▒┐  . '½░;...'.║░[ ;∩   ╠╫████████████████████████████████████    //
//        ███████████████████████████████████████▓▓▓▓▓▓███╬▒░░░░░╠▓▓▓╣░░└  '└╚░░⌐:¡╩░┌.░∩░   ▒████████████████████████████████████    //
//        ███████████████████████████████████████▓▓╬▓▓▓████╬╠▒▒▒▒╬╠▒▒╥╓╓╔╔╦M∩Γ░⌐"┌¡░░░┌⌐░:   ║╬███████████████████████████████████    //
//        ███████████████████████████████████████▓▓╬╬╣▓████▓▒░╙╠╬▓▓▓╬╠╚┘└∩. . !~^~≤░░∩'~!¡~   ╣███████████████████████████████████    //
//        ████████████████████████████████████▓▓██▓▓▌╙╢╣████▓▒░░╠╬╬╬╩░░░!'''  '.:¡▒▒░:!'»^~   └▌██████████████████████████████████    //
//        ████████████████████████████████████╬╬╣██╩█▓ ╙╬████╬▒▒╠╠▒▒░░░┌.     .;░░╠░⌐ ' ' .'.  ╟╣█████████████████████████████████    //
//        ███████████████████████████████████╬╠╩╣▓█░╫█▓µ ╙█████▓▓▓╬╬▒░░░░┌;,;≡ê╚▒░╚░⌐ ' .   ¡   ▌█████████████████████████████████    //
//        ███████████████████████████████████▒▒░╠▓╣▒^╣██▌,'╙▓████████▓▓▓╬╠╚╙└" !░▒░![   ~    ]] ╟╫████████████████████████████████    //
//        ███████████████████████████████████░∩"╚╫╬╬,└╣▓▓█▓▓▄╬╬▓▓█▓▓▓╬╬╩╚░⌐    '░░▒\│   '    .⌐~ ▌████████████████████████████████    //
//        ███████████████████████████████████▒⌐'"╫╬╚▄┐'╚╬╣╬███▓╬╬╬╬╬╩╙░░'''    '!░▒½[   '  .└,"~ █╬███████████████████████████████    //
//        ███████████████████████████████████▌~ ~╚╣░╚▒░ "░░╠╬╬╣╬▒╙╚╬▒░░¡~       .]░▐b⌐  .  ;;▐░. ∩▀╬██████████████████████████████    //
//        █████████████████████████████▓▓╬▓▓██▒~░;╬▒░╫▓▒▄,,"╙╚▒╚▒░"░░░!┐:..     ;≥░░▒). -  '░░▒⌐], "╝█████████████████████████████    //
//        ██████████████████████████▓╬╬╬╠▒╙╠╬▓▓▒╚░║╬▒░╫▒┘░▒▒▒▒░░╚░ '"""!\░░    '░░░░╠╠,.░   ≥7Γ;░╠╠╣▒▄▓▓██████████████████████████    //
//        █████████████████████████████▓▓╬╟╬╬╬╬▓▓╬▒╫╬▒░░∩░∩▒é╚░░░└     '≤╠░.'"~\░▒░╠╬▒∩/';',░.░░#▒╬╬██████████████████████████████    //
//        ██████████████████████████████▓╬╫╬╬▒▒╩╬╫▓▌╠╩▒░╚░░░░░░░⌐    .;≥╩░░░"''`:│░╚╠∩;≥', ]░;░░╙░╠███████████████████████████████    //
//        ███████████████████████████████╬╣╣╬╠╠╬╠╬╬╬╣▒▒▒▒▒░░░░░░⌐....░¿░░░░⌐ .  !░░░░░░;░░,░▒░░▒░░████████████████████████████████    //
//        ████████████████████████████████▓╬╬╠╬▒╠╬╩░░╟╠╬▒▒▒░░░!¡¡\;;\»"'''^.   .░▒░#╙╙,░≤]░▒▒░░░░▓████████████████████████████████    //
//        █████████████████████████████████▓╬▒╬╬╩╠▒░╢▓▒╚╬╩Ü░│░░∩;»¡░┐:┌.~~    .░░Ö∩░]┌░⌐░▒▒╣╙⌠¡∩▓█████████████████████████████████    //
//        ██████████████████████████████████▓╬╠╬▒╚▒▐▓▓▓▌╚▒]└'''¡¡░¿░░=.'~'  '~!░░▒░░Γ#;:;▒╬╩░;;▓██████████████████████████████████    //
//        ███████████████████████████████████▓▒╣╬░▒▒█▓▓█░░░"''.^!⌡░░░⌐^''     '[]░"/⌠┘│;░╚╬▒░▄████████████████████████████████████    //
//        ████████████████████████████████████▓▒╩▒∩▒██▓▄"¡░⌐ .'!░░░!┌-.      ..[▐░[)≥:░\╠░╚▒▒█████████████████████████████████████    //
//        █████████████████████████████████████▓▄▄▄▄████████▓▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄██▄▄▓▄▄▄▄▄▓█▓██████████████████████████████████████    //
//        ████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████    //
//        ████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████    //
//        ████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████    //
//        ████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████    //
//        ████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████    //
//        ████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████    //
//        ████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████    //
//        ███████████└▀█████████╙╙████████╙╙████████▀╙╙╙╙╙╙╙▀█████╙╙████╙╙╙╙╙╙╙╙╙███└▀██████▀╙███╙╙╙╙╙╙╙╙╙████████████████████████    //
//        ██████████Γ  ╙███████   ███████    ███████  ▐████▓   ███  ╫██▌  █████████⌐  ████   ▓██▌  ███████████████████████████████    //
//        ██████████Γ    ████▀ ,  ██████  ██  ██████  ▐█████▌  ███  ╫██▌  █████████⌐  █▀  ╓█████▌  ██████████████▀╙╙▀▀████████████    //
//        ██████████Γ ▐█  ██▀ ╓█  █████  ████  █████         ,████  ╫██▌        ▐██⌐     ███████▌        ▐█████        ▀██████████    //
//        ██████████Γ ▐██  ` ▄██  ████   ╙╙╙╙   ████  ▐███, └█████  ╫██▌  █████████⌐  █▌  └█████▌  ███████████          ██████████    //
//        ██████████Γ ▐███, ▓███  ███  ▓███████  ███  ╞████▌  ╙███  ╫██▌  █████████⌐  ████,  ▀██▌  ███████████▌        ]██████████    //
//        ██████████▌ ╫█████████ ,██▄ ██████████ ,██, ███████, ███, ████,       ,██▌ ╓██████▄ ▄██,       ,██████▄    ╓▓███████████    //
//        ████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████    //
//        ████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████    //
//        ████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████    //
//        ████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████    //
//        ███████████████████████████████████▀█████████▀██████████████████████████████████████████████████████████████████████████    //
//        ██████████⌐  ▄▄▄▄▄▄▄█▄,,,   ,,,,▄█▌  ███████  ▐█████████████████████████████████████████████████████████████████████████    //
//        ██████████⌐  ████████████▌  ██████▌  ███████  ▐█████████████████████████████████████████████████████████████████████████    //
//        ██████████⌐  ╙╙╙╙╙╙██████▌  ██████▌  ╙╙╙╙╙╙╙  ▐█████████████████████████████████████████████████████████████████████████    //
//        ██████████⌐  ▓▓▓▓▓▓██████▌  ██████▌  ▓▓▓▓▓▓▓  ▐█████████████████████████████████████████████████████████████████████████    //
//        ██████████⌐  ████████████▌  ██████▌  ███████  ▐█████████████████████████████████████████████████████████████████████████    //
//        ██████████µ        └█████▌  ██████▌  ███████  ▐█████████████████████████████████████████████████████████████████████████    //
//        ████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████    //
//        ████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████    //
//        ████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████    //
//        ████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████    //
//        ████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████    //
//        ╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙╙    //
//                                                                                                                                    //
//         www.mariekefeenstra.com                                                                                                    //
//         marieke.art                                                                                                                //
//         marieke.nft                                                                                                                //
//         marieke.eth                                                                                                                //
//         @mariekenft                                                                                                                //
//                                                                                                                                    //
//                                                                                                                                    //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract WOWED is ERC1155Creator {
    constructor() ERC1155Creator("WORLD OF WONDERS EDITIONS", "WOWED") {}
}