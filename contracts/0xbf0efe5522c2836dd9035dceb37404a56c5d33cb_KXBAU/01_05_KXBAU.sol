// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Business As Usual
/// @author: manifold.xyz

import "./ERC1155Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                        //
//                                                                                        //
//    ██████████████████████████████████████████████████████████╬╠╬╬╬╠█▓█▓▓╬╬╬╬╠███╬██    //
//    ╬╬[╫╟╫╬╣░╠╙▀╠µ╬░╣p█▐█▐╙█╙▌╫█╙▌╓╬█▀▄]▌╫█j▌╫▌╠╫▌╟░╫▌╫╚╡╙▀╠╬╠▒╬╠╬╬╣╠▒█▒▓╟╬╢╬║╬╠╬▓╬╠    //
//    ╠█^▄▄╚#╚▀╬`≥░ª╝G-▄▄,#╠▀m╓▄▄╔#╨╩^▐"└╝ª▄=╖▄«▀╠▀⌐▄▄,m▀#╬^φ╬╢╣╢╬▒╬▒╫╬╬╬╠╠╬╣╣╬╬╬╬╬╬╬▓    //
//    ▀▄╙██\▄█╠▄█▒▄╬▒╓▒██▀▄██▄██▒≥╬▀░é███▓╬╦╝██┌▄▀╓▐███▓╬▀▄╬╬╬╠╠╠╬╠╫╠╬╬╠╬╬╢╫▒╬╬▒╬╬╬╠╠╢    //
//    ▌▄▌█\██████████▓▒░██████████▓▓▄████▓╣╣█▐▌█▄██████▓▓▌█▒╬╠╬╬╣╬╬╣╬╠╬╬▒╠╠╠╣╬╟╟╬╣▒╠╫╬    //
//    ▌▄▀███████████████▓╬██████████████████▓▒▒≈▄█████████²╬▄▓▒╬▒╬╬╣╟╢╬▒╬╬╟▒╠╬╠╬╬▒╬╬▒╬    //
//    ▀"-▄████████████████╬███████████████████▓█╬╟█████▀▀▀╓▄▓█▓╣▓╣╬╠╣╬╠╬▒╢╬╣╩╬╬╬╣╠╬▓╬╠    //
//    ▌╙▌╟╢███████╫█████████▓██▌██████████████████╬█████╟▄██▓╬╬▓╬╬█╠╢╬╬╬╬╬╬╬╢▒▓╢▓╠╠╬╬╢    //
//    ▄▀▐██║██████▌╠╬███████▀╙╚▀╚╟████████╙█████████▓█▄▀██████╠╟▓▒╠╣▒╠╬╬╠╠╠▓╠╬╠▒╣╠╬╬╬╣    //
//    ╠█└╬▀¬╫██████╬╗╬███▀▀,      ╙╫██████▌ ╙████████▀╖▓╫██████▓Å╜╠╬╙╬╬╠╬╩╬╩╠φ╣╩╬╬╬▒╬╬    //
//    Γ█░█"╝≥╣╚▀████╬╬╣╣╬░         j╠██████╗ ╠█████▀   Γ  ╙╚█╙▀╟╩╫╩╟▒█╜▒█╜█╬╬╟╬╬▒╣╬╠██    //
//    █";▄╩,▓██╙▓█▀╠╢▓╬▓╬;          ╫╬╩█████╠╬╬╬╬▒          █╙╔██⌐╙▄▄"╣▓^╬╣╙╬╬╬╣╠▒▄███    //
//    ≥▄"█▀▀╙╠¬▀█▄▀╠╬███;            ╚Å '╙██╬╣╬╬╬░⌐         ╖▀,╠╙▐▀█▀▄──▄╙╣╬╬╙╙«▀▄#███    //
//    ▓▄^╩«▀Q╟▄▀⌐⌐█╬█▓█└        ┘    ▄¼    ╠╬█▓█▌Γ           ╟▀█▄▀▀▀ ╠#╣╠"▀╙▀▌█╙█└j███    //
//    █╩╠██M└#█'██,4█╣▓███▄         j██▄ , ╚▓▓█▀        ;     ██─`███`██└▓██~»█≥▐█████    //
//    ▓▀,╫╧▄╠█▀▄⌐¬▄╙█╠╟█▓███░φε.} .░`╫████╖φ;╟███▄           █╣█▀▄▄▄.╠█é▒.╫`▄╙█▀╗jj███    //
//    µ╙;█▄▌,▀ ▄▀▀▄`▀╟███▓╠╝▒╠▒  ▌""╟█╬▌▀╣▒╬ε ╟█████▒,, )  ░²╠▀╙,▀▄╫▄▀,▒▀▄█▄╚^╙'▄▀▀███    //
//    █░▀▀\,███ ▀█,╫█████╬╬░░ ╬░ █  ███▓▒╠ ╠▒ ▄▄╢╫╟╬▒╠φ  ▄⌠╩½,╙██⌐/▀▀╓██⌂▀▀Q^███ƒ█▀███    //
//    ▄█▄█╚╫▄╗.▄▀██╬██████╬╬▒▒▒░ ╫▒▐████▓▒╬╟▒████╬▒∩╚`╠░ ╟  ╫╠▄╔⌐▄▄╟░▓.⌐█╩█╟æ▄m)▄█▀███    //
//    ╙▓«▄▄╚██W╙▄███╬║██████▓██▒▓█▓╟██████▓███████╬▓▒▒╬≥ ╟▌ ▌╙«▀╗▄╓╬µ▓╩▀▄╓▄▄;█▀w╙j ███    //
//    ╝í╙╫█\▄████████▒╠████████▓███╫█ ██████╬██████▓╠██▒φ▓▓╟█W▐▀▌▄██▀▄╙▀▄▀██,,╠█∞▀▀███    //
//    ▀╓▄█████████████▓╬╠╩██████████⌐ ███████▒╠████████▒███╣█ ▌█]█▌▓▐▄╟╩▄⌐█╒█∩█]█▐/███    //
//    ██████████████████▒▒╠╚╚▀████████████████▒╠╬▀██████████▌ ╔▄█]#╜▀╬,▄╠╜▀#░▄▄▄▀╠╙███    //
//    ███████████████████▓╬░░▄██████████████████▒╠░╚╠███████  ║█████▄φ▀▀¬╬█▄▄▀█▀▄╙▀███    //
//    ███████████████████▒╫M╚████████████████████▒╬▒░╠╫█╬╬╬╬█ ╟████████▌█M█▐█▌█▐█╙\███    //
//    ████████████████████▒▒.████████████████████╬╬▒#╬╟█▓╬▒╠╬╬▓█████████▀╓██7▀█▌w▄▄███    //
//    █████████████████████╬██████████████████████░▒ .╙╚▓╣▒▒░░╟█████████#╙▀▀²≥▄æ"╙╙███    //
//    █████████████████████████████████████████████╠ ⌡  ╢█░╠▒╠███████████,█▐█\█▐▀▄▄███    //
//    █████████████████████████████████████████████▌≥ .]▓╬░░╣║██████████▀▄▄╙.██▌╙█████    //
//    ██████████████████████████████████████████████▒░]▓╬╬░φ╠╫██████████▌ª█▀▀╙▀`▀▄▄███    //
//    ███████████████████████████████████████████████▒█╬╬░╠╠╬████████████"▀╙▀▌█└█╙:███    //
//    ████████████████████████████████████████████████╬╬▒╬╬╠╫███████████████⌐«█æ"█████    //
//    █████████████████████████████████████████████████╬╬▒╠╟█████████████▌▄└▄▀█▀▄j ███    //
//    ██████╟███████████████████████████████████████████╬╬╢████████████████▄▀^▀^▄█████    //
//    █████¬████████████████████████████████████████████▓╠█████████████████⌐j███▀█████    //
//    █████▄███████████████████████████████████████████████████████████████╠▄.▄,╙█▀███    //
//                                                                                        //
//                                                                                        //
////////////////////////////////////////////////////////////////////////////////////////////


contract KXBAU is ERC1155Creator {
    constructor() ERC1155Creator() {}
}