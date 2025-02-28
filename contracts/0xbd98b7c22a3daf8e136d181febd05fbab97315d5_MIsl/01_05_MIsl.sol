// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Arbo x Papa
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                    //
//                                                                                                                                    //
//                                                                                                                                    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██▓░░▀▀██▄░░░░╓▓╢█████▄░▒╬▒▄█▄    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒██▓Ü░░░░░██▌░╟▓Ñ╜▓╟███████▓█▀╢▓    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██▌▓▓╖╓▒╜▒░███░░▒▒░▒░╙▀▓█████▄▄██    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▐█▓▓█`,░░░░,████W░░░░░▓╢╣╢▓▀██████    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒╫▐█▒▒▒▒▒▒╫▒▌▒░╟▒▒▒▒▒▒▒▒▒▒▒▒██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▐█▓▓██▄▒░░░▄███░░░░░░░░░▓▓▓▓╣▒██░╙▀    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▌▒▒▒▒▒╫█▒░╟▓▌▒▒▒▒▒▒▒▒▒▒███▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒█▓▓█████████▀▒░░░░░░░░░╟╢▓▀▓▓▒▒▄███    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒░▓▒▒▒▒▒▓╣▒▒░╫█▌▒▒▒▒▒▒▓▓█▀██▒▒▒▒▒▒▒▒▄▄▄▒▒▒██████▀████░╥▒▄░▒@▒░░▒░░▓▓▓░╟╣▓▓████    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓░░▀▌▒▒▒▐▌╣░░░▒▒▓▓@▒▒▒▓▓▀░▒▀██▒▒▒▒▒▓████▌▒▒█████████████▀██▌╣▒░▒▒▒▒╢███▌╜g▓████    //
//        ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒╫▓░░░█▓▒▒█▒╣░▒░▒▒▒▀█╫▓▓▓▒▒░░░██▌▒▒▄██▒▒]██▒▓██▒▀██████▒░╙▐██▓▓▓╬╬▓████████▌╬░▐██    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒╫▓▓░░░╢▓▓▓█▓▓╢▒░░▒▒▒▒▒╢▒@╖░░╓╖╢█▓▓▓▀▀▒░░]██▒██░▐███████▒▒░███╣╢▒▄██████▀██▀║▓▒███    //
//        ░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒╫▓▓░░▒╜╜╙▒▒▒▒▄▒▓▓▓▓██████████▄▄███▄▄▄▄▄▄▄███▌█▌▀███████▄▄▒██▒▒████████▒▓▓▓╖▓╣▓███    //
//        ░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓████████▀▒▒░▒┼▒╜▀▀▀▀▀▀▀▀▀▀███████▌████████████▐█░░▒▒█████▀▓▀▓▓▓█▀▓████    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓█▓▓▓▄██████▄▄▄█╓g░░░░░░░░▒▒░░@▓▄▄▄@M░Å▓███▓▓██████████▌▒▌░▒░░╢████▓▓╣╢▓▒▒▒█████    //
//        ░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▄▄████▀▀▀▀▀▀▀▀▀▀▀▀▀█▀▀▀███████████████▓▄▄▄█████▌▓▓▓▀░└░▒▒▒███▌▓▓▓░▒▀███▄░╙╜▒▓▒▌██████    //
//        ░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▄██▀▀▒▄▌▒▒▒╜░░░░░░░░]▀▀▀▄▄Z▀░░@▓▓▓▓▓█▒▒▒▒╢@▓██████▌▓▓Ç,╓╓░¢&Ñ▓▓██▓▒░█▌██████▄░░╟▓███████    //
//        ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██▒▒▒▄█▀▒╜░░░░░░░░░░░░░░░░░╫▓▓▓▓███▓▓█████▄██▓▓█████╣▓█▓▒▒g▓╢▓▓███░╢▐█▓███████░▒▐████████    //
//        ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓█▓╣▄██╜░░░░░░░░░░╥▄▄▄▓░░░@▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▌▓▓▓███████▌▒▓▓▒▓▓████▌╢╣███████████▄█████████    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓█▓██╜░░░░▒╓░░░▒██▀▒║╣▓▓▓▓▓▓█▓▓▓▓▓╜▀▀▀▀▓▓█████▓▓███████▒▓▓▓▓▓▓▓▓██▌▒▒█████████████████████    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓███░▒▓▓╫╣▒╨╢▒▒▒░░╙╫╣▄▓▓╫▓▓▓▓▓▓▓░░▓▓░░▓▓██▀███▌▓██████▓▓▓▓▓▓▓▓████▓╣▓██▓▓██▀▓█████████████    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▄███░]▒▒╣▒░▒▒╜▒▒▒░░░g▓╢╣▓g▓▓▓▓▀▒░╜▀░░╣▓▓▓░░░░░░▐▓▓████▌▓▓▓▓▓▓▓▓▓███▒▓██▓▓▓▓▓▓▓▓▓███▓▓▓█████    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒█▓▓██░░╟▒▒▒░▒▒g██▀███▓▓▌▒▒▓█▓▓░░░░░░@▓▓▓▓▌░░░░]░▄█▓▓███▓▓▓▓▓▓▓▓████▌▐██╣▓▓▓▓██▓▓████▓▓██████    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓██░█@▒╣╢▄█████░░╓▓▓▓██▄░▐▓░░░░░╓▄▓▓▓▓╬▓▓░░░▄▓███▓▓███▓▓█▓▓▓▓▓▓███▄██▓╫▓▓▓▓▓█▓▓███╣▓███████    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▐▌▒▌█▒▒▀▒▓████▀░░░░]▓▓▓░▓▌▀█▒M░░░▄╩▓▓▓▓╬╫▓▓████████▌█▓▓███▓█▓▓▓▓▓▓▓▓▀██▓▓▓▓▓▓▓▓▓█████▒████████    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒╢▒▒▌███████▀░░░▒▒░░▐▓▓▄░░░░▐▀░░╙░y░▓▓╣@▓▓▓▓██████▓████▓██████▓▓▓▓▓▓▌▓▓▓▓▓▓▓▓▓▓▓████▌▓█████████    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒╢╫██████▒▒▒▒▒░░▒▒░▀▓▓▓░░░░░║░░░▐░▓Ñg▓▓▓▓▓▓█▀█████████▓▓█████▓▓▓▓▓▓▒██▓▓▓▓▓▓▓▓▓██▓▓▓▓▀████████    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒╢╢╣╫▓█████▌▒▒╢▒░░░▒▓▓▄▄███▄,░#│░░/╓▓▓▓▓▓▓█▓▓▓█▓▓█████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▐███▓▓▓▓▓▓██▓▓▓▓▓▓▒▓█████▓▓    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒╣╢▓▓▓▓█████╢▓▒▒▓╢╣▒████████████▌░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▌█████▓█████▓▒▓▓▓▓▓▓▓▓███▓▓▓    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒╢╢╫▓▓▓█▓██▓▓▓█▓▓█████████████▀█▓@▓▓▓▓▓▓▓▓▓▓▓▓█▓▓▓▓▓w█▌▓▓▓▓▓▓▓▓▓▓▓▓███▐████▓███╫▓█▓▒"╩▓▓▓▓▓████▓▓▓    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒╣╫╣▓▓████╬▒██▓███▓████████▀╟▓╣╣▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓' ╓▄██▓▓▓███▓▓▓▓▓▓▓██▐████████╢╫▒██▒∩╖▓▓█░╫▓╣█▌▒╬    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒╫▒▓████▓███▓▓╢███████████▒╢Ñ╙▓▓▓▓▓▓▓▓▓▓▓▓█▓▓▓▓▄▓██▓▓▓▓╬▒▓▀▀▓▓▓▓▓▓█▓▐▓█████████▓╣╢▒@▄▒▓▓⌡░▓▒▒███    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒╣▓█████████▒╣╣▓██████████▒╢╫░░░▓▓▓╫▓▓▓███▒,░.ⁿ▐█▓██▄╣╢▌╓██▓▓▓▓▓▓▓▓▓╢░█████████▒▄▄▒╣████▓█▄██████    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒╫▓███████▒╟╣╣╢███████████▄████2▓▓▓▓▓▀▓██░ ░░µ▓▓▓▓▓█▌╣▓███▌░ ▓▓▓▓▓▓▓▓Γ▓▓▓█████████▒▓████▄▓███████    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒╣▓██████▌M╫╣╣╢████████████████▀███▓░¢█▓▀▄░░▓████▓▓▓╣╣▓███╜ ▐▓╫▓▓▓▓██H▓▓█████▓████▒███████▄⌠▀████    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒███████▌▐▄╣╢╢████████▀████▀▀▀▀█▌]@█▌░░░▄████▌▓▓███╢Ñ████▄▓▌▐▓▓▓▓██Ü▓▓██╣╢╣╢▄██████▐██████▄░▒▒╣    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▀█████████╣╢╢▀█████████▀░░░░░▒░╓▓████████▓▓▓▓▓▓███████ ███▐██▌▓▓▓M╢╢██▌╣╫███████▌█████████▌▒▄    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▐████████░░╙▓╢╫▀▌░▒║▒▒░░░▒▒▒▒▄████████░▓█▄▓▓▒▄██████▌████▐▀█▓▓▓▓Ñ╣╢██▌╣╣▓██████▐████████████    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▄███████░░░░▓Ñ╬░░░░▒░╗▒╥╣╢██▀╢▓█████▓██▌▓▓▓▓▓▓█████▓███▓▓▓╬▓▓▌▓▓▓▓▓▓╫▌╣██████▌█████████████    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒████████▀░░g╬▒▒▒░░░░░░░╣▓▓▓█▌▒▒▒████████▌▓▓▓▓▓▓▓████████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓╣╢█████▐█████████████    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒███▄░░░@╬▓╣▒▒▒░░░░░░▒▒▓▌▓╬▓██╣╢▓██████████▓▓▓▓▓████V███▌▓▓▓▓▓▓▓███▌╣╣▓▓▓████████████████████    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▐████▄▄▓╢╢Ñ██░░░░░▄▓▀▓██▓▄▓██▌▓╬▓█▓▓██▓▓███▓▓▓▓███▒ä███▌▓▓▓Ñ▓▓████▌▓▓▓▓▓▀███▀▒███▌██████████    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▐████@║╨⌠░╣█░░░░▐█▀░░▒▒▓█████╣▓██▓████████████▀▌▒@▓▓██▓███▓▓████████▌╣▓╢╣▓▒█▒██████████████    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒████▌▓░░███░░░░██▌░░░░╟████░░▀█▓███████████████▓▓▓██▓███▓▓▓▒▀▓╢╢▒▒╢▓▒╢╢╢╢╢▒▒██████████████    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒█████▄▄██▓▓▄░░███▄╣▒▒╢▓███▄ww╫████████████████▓▓█▓▓██▓█▓▓╣╢╣▓╢╢▒╣╢╢╢╢╢╢▓▓▓▒██████████▓▓▓▓    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▐████████▓▓█████▓▀█▓▓▓╣@███▌╙╟█████████████▓▓▓▓▓██▓▓▓█▓▓▓▒╢▓╢╢╣▒▄╣╢╢▒╢╢╣╣▒▒▓█████▓████▓▓▓    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██████████████▓║░V▓▓▓▓▓▓▀░▀██▓██████████▓▓▓▓▓▓▓██▓██▓▓██▓█▄▓▓██████▓█▌╢╢╣╫▒▐██████████▓▓▓    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒█████▀▒░░░⌠██▄░░░░▓▓▓▓░░Ü░,█▀▒▓███████▌▓▓▓████▓▓▓▓▓▓▓▓▓▓████▌███████▓██▓▓▒▓▓▄█████████▓▓▓█    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒╫████▌██▄░░░j██▄░░░▓▓▓░░Æ░▓██g▓███████▌▓▓█▓██▓▓██╢████████████▌██████▓▓▓▓▓▒▓▓███████▌▐▓▓███    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒╫████████▌░╓▄████▌░░░░▄████████▓▓▓▀██▌╫▓▓▓▓╣▓████████████████████████▓╣▓▓▌███████████░▓▓███    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓███████░╓╢█████▄▄█▄██████▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓███████████████████████╣▓▓▓▓▓██▌█████▓▓▓░▓████    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓██████████▄██▓▓█████████▓▓█▓▓▓▓▓▓▓▓███╢▓▓▓▓█████████▀▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██▌█▓█▓█████▓▓▓U▓████    //
//        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒@▄▄▓▓▓▓██████████████╣▓╣▓████▀▄███▓╣▓▓▓▓▓▓▓▓▓███▓▓▓▓▓▓███████▀)▓▓▓▓▓▓█╢▓▓▓▓██████▓▓████████▓▓█▌▓████    //
//        ╣╬╣╣╣╣╢╢╣╢╣╣╣╣╣╣▓▓▓▓▓████████████▓▓██████▌▓▓█╣╢▓██╣▓▓▓▓▓▓▓▓▓▓░╠▓▓█████▓▓▓▓██████▀▄████▓▓██▓▓▓▓████▓█▌▓█▓╬▌███████▓▌▐████    //
//        ▓▓▄▓▓▓█████████████████▀▓▓▓╙╙██████████▀▀▄▓███╢▒██▓▓▓▓▓▓▓▓▓▓▓▓▀▓▓▓▓█████▓██████▓▓▓▓▓▓▓▓██▓▓▓██████▀▄▓▀▓▓▓█████████▓▄████    //
//        ▀▀▀▓▓▀▀▀▀██▀▓▓▓▓█▓▓▓▓▓▓█████████████▓H▒▒ß▓▓▓▓▀██▀▓▓▓Ñ▓▓▓▓▓▓▓▒▒%▓▓██████████████▓▓▓▓▓█▀▓▓▓██▀▀▀▀ÑB▓▓▓Ñ▓█▓▓███▓▓▓█████████    //
//                                                                                                                                    //
//                                                                                                                                    //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract MIsl is ERC1155Creator {
    constructor() ERC1155Creator("Arbo x Papa", "MIsl") {}
}