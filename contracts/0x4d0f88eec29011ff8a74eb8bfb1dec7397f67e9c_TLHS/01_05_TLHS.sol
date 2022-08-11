// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: The Lost Hyenas
/// @author: manifold.xyz

import "./ERC721Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                                              //
//                                                                                                                                                              //
//                                ███╗   ██╗ ██████╗ ███╗   ██╗██╗   ██╗██╗  ██╗███████╗███████╗                                                                //
//                                ████╗  ██║██╔═══██╗████╗  ██║██║   ██║██║ ██╔╝██╔════╝██╔════╝                                                                //
//                                ██╔██╗ ██║██║   ██║██╔██╗ ██║██║   ██║█████╔╝ █████╗  ███████╗                                                                //
//                                ██║╚██╗██║██║   ██║██║╚██╗██║██║   ██║██╔═██╗ ██╔══╝  ╚════██║                                                                //
//                                ██║ ╚████║╚██████╔╝██║ ╚████║╚██████╔╝██║  ██╗███████╗███████║                                                                //
//                                ╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝                                                                //
//                                                                                                                                                              //
//    ████████╗██╗  ██╗███████╗    ██╗      ██████╗ ███████╗████████╗    ██╗  ██╗██╗   ██╗███████╗███╗   ██╗ █████╗ ███████╗                                    //
//    ╚══██╔══╝██║  ██║██╔════╝    ██║     ██╔═══██╗██╔════╝╚══██╔══╝    ██║  ██║╚██╗ ██╔╝██╔════╝████╗  ██║██╔══██╗██╔════╝                                    //
//       ██║   ███████║█████╗      ██║     ██║   ██║███████╗   ██║       ███████║ ╚████╔╝ █████╗  ██╔██╗ ██║███████║███████╗                                    //
//       ██║   ██╔══██║██╔══╝      ██║     ██║   ██║╚════██║   ██║       ██╔══██║  ╚██╔╝  ██╔══╝  ██║╚██╗██║██╔══██║╚════██║                                    //
//       ██║   ██║  ██║███████╗    ███████╗╚██████╔╝███████║   ██║       ██║  ██║   ██║   ███████╗██║ ╚████║██║  ██║███████║                                    //
//       ╚═╝   ╚═╝  ╚═╝╚══════╝    ╚══════╝ ╚═════╝ ╚══════╝   ╚═╝       ╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝                                    //
//                                                                                                                                                              //
//                                                                                                                                                              //
//                                                                                                                                                              //
//     ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,    //
//    (%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%################((((((((((((((((((((((((((((((((((((((((((((((#(################%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    //
//    (%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%################(((((((((((((((((((((((((((((((((((((((((((((((((((((((###############%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    //
//    (%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#############(((((((((((((((((((((((////////////////////((((((((((((((((((((###############%%%%%%%%%%%%%%%%%%%%%%%%%%%%    //
//    (%%%%%%%%%%%%%%%%%%%%%%%%%%%%############((((((((((((((((((///////////////////////////////////(((((((((((((((((#############%%%%%%%%%%%%%%%%%%%%%%%%%%    //
//    (%%%%%%%%%%%%%%%%%%%%%%%%%#############(((((((((((((((////////////////////////////////////////////(((((((((((((((#############%%%%%%%%%%%%%%%%%%%%%%%%    //
//    (%%%%%%%%%%%%%%%%%%%%%%%%###########((((((((((((((/////////////////////////////////////////////////////(((((((((((((############%%%%%%%%%%%%%%%%%%%%%%    //
//    (%%%%%%%%%%%%%%%%%%%%%%###########((((((((((((//////////////////*************************/////////////////(((((((((((((##########%%%%%%%%%%%%%%%%%%%%%    //
//    (%%%%%%%%%%%%%%%%%%%%###########(((((((((((///////////////************************************///////////////((((((((((((##########%%%%%%%%%%%%%%%%%%%    //
//    (%%%%%%%%%%%%%%%%%%%##########(((((((((((////////////**********************************************////////////((((((((((((##########%%%%%%%%%%%%%%%%%    //
//    (%%%%%%%%%%%%%%%%%##########((((((((((////////////****************************************************////////////(((((((((((#########%%%%%%%%%%%%%%%%    //
//    (%%%%%%%%%%%%%%%%#########((((((((((///////////******************,,,,,,,,,,,,,,,,,,,,,,*******************//////////((((((((((##########%%%%%%%%%%%%%%    //
//    (%%%%%%%%%%%%%%#########((((((((((//////////***************,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,***************//////////((((((((((#########%%%%%%%%%%%%%    //
//    (%%%%%%%%%%%%%#########(((((((((//////////*************,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,***********#*#/////////(((((((((#########%%%%%%%%%%%%    //
//    (%%%%%%%%%%%%########((((((((((////////*************,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,****&@@(****/////////((((((((##########%%%%%%%%%%    //
//    (%%%%%%%%%%#########(((((((((////////************,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,@@@@@@@*****/////////(((((((((#########%%%%%%%%%    //
//    (%%%%%%%%%#########(((((((((////////**********,,,,,,,,,,,,,,,,,,.......................,.,,,,,,,,,,,@@@@@@@@@#*******////////((((((((#########%%%%%%%%    //
//    (%%%%%%%%#########((((((((////////**********,,,,,,,,,,,,,,,[email protected]@@@@@@@@@@@@@@@@@@@@@********/////////((((((((########%%%%%%%    //
//    (%%%%%%%########(((((((((///////**********,,,,,,,,,,,,,,[email protected]@@@@@@@@@@@@@@@@@@@@@@@@@@,**********////////((((((((########%%%%%%    //
//    (%%%%%%########((((((((////////*********,,,,,,,,,,,,,[email protected]@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@,*******////////(((((((#########%%%%%    //
//    (%%%%%########((((((((///////**********,,,,,,,,,,,[email protected]@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  #******////////((((((((########%%%%    //
//    (%%%%%#######((((((((////////********,,,,,,,,,,,..........................*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@**********///////(((((((#########%%%    //
//    (%%%%########(((((((///////********,,,,,,,,,,,.................. ...     (@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#****//(@@@(((((((((#######%%%    //
//    (%%%########(((((((///////********,,,,,,,,,,...................        @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@(((((((########%%    //
//    (%%########(((((((///////*******,,,,,,,,,,,................          @@@@@@@@@@@@@@@@@@@@@@#*@ @ @/&@@@%%@@@@@@%%@@@@@@@@@@@@@&@@@@@@@(((((((########%    //
//    (%%#######((((((((//////********,,,,,,,,,...............            @@@@@@@@@@@@@@@@@@@%@@@@@&% @@@@@@ @@@@@@@@.# @ %#@@@@@@@@@@@@@@@#/(((((((########    //
//    (%########(((((((//////********,,,,,,,,,..............            @@@@@@@@@@@@@@@@@@@@@@%@/ ,*& (    .& #*[email protected]@ ,* %@@@@@   %    @@@@/////(((((((#######    //
//    (########(((((((//////********,,,,,,,,,.............            @@@@@@@@@@@@@@@@@@@@@@@@@##         .........#[email protected]@.*#,. @ @ (( (//////(((((((#######    //
//    (#######(((((((//////********,,,,,,,,,.............            @@@@@@@@@@@@@@@@@@@%###&@@@@ (   /     ..............,,,,,,@,(** ***//////(((((((######    //
//    (######(((((((///////*******,,,,,,,,,............             @@@@@@@@@@@@@@@@@##%########%@ %* /,*  # ............,,,,,,,,,*******///////(((((((#####    //
//    (######(((((((//////*******,,,,,,,,,............              @@@@@@@@@@@@@@@%######@@@@@@@ %  &@@*@( @. @ ..........,,,,,,,,*******//////(((((((#####    //
//    (#####(((((((//////*******,,,,,,,,,...........               @@@@@@@@@@@@@@@%#####@@@@@@@@@@@@@@@@((@@@@@ #.(.. ,..%.,,,,,,,,********//////(((((((####    //
//    (#####((((((///////*******,,,,,,,,...........              #@@@@@@@@@@@@@@@@%#####@@@@@  ,@@@@@@@@@@@@@@@@&@&@* .#, *..,%,./,,*******///////((((((####    //
//    (####(((((((//////*******,,,,,,,,...........             @@@@@@@@@@@@@@@@@@@%@###&@@@@@#           .%@@@@@@@@@@@@@@@%[email protected]  @ @,,,*******//////(((((((###    //
//    (####((((((///////*******,,,,,,,...........           @@@@@@@@@@@@@@@@@@@@@#####@@@@@@@@@@              &@@@@@@@@@@@@@@@@@@,,,,,*******/////(((((((###    //
//    (####((((((//////*******,,,,,,,,...........      @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@,               ..........,,,,,,,,,******//////((((((###    //
//    /###(((((((//////*******,,,,,,,,..........   %@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@(         ...........,,,,,,,,******//////(((((((##    //
//    /###(((((((/////*******,,,,,,,,[email protected]@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@.     ...........,,,,,,,,*******/////(((((((##    //
//    /###(((((((/////*******,,,,,,,,[email protected]@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    ...........,,,,,,,*******//////((((((##    //
//    /###((((((//////*******,,,,,,,[email protected]@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ ...........,,,,,,,,******//////((((((##    //
//    /###((((((//////******,,,,,,,,[email protected]@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ .........,,,,,,,,******//////(((((((#    //
//    /###((((((//////******,,,,,,,,[email protected]@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@........,,,,,,,,******///////(((((##    //
//    /##(((((((/////*******,,,,,,,.*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@........,,,,,,,*******//////((((((#    //
//    /##(((((((/////*******,,,,,,,*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@(,&#*,,,,/@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#......,,,,,,,*******/////(((((((#    //
//    /##(((((((/////*******,,,,,,,@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@,,#,,,,,,,,,,,,,#@@/,@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ .....,,,,,,,*******//////((((((#    //
//    /##(((((((/////*******,,,,,,,@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@,/#,#,,,,,,&,,,,(*,,,,@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&.....,,,,,,,*******//////((((((#    //
//    /##(((((((/////*******,,,,,,*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@(*(,(,,,,,,(,#&(/,,,,,,@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ ....,,,,,,,*******//////((((((#    //
//    /##(((((((/////*******,,,,,,@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@,(@,*,,,,,,,,,,&#,/,,#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@....,,,,,,,*******/////(((((((#    //
//    /##(((((((/////*******,,,,,@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@/,(,,,,,,,,,,,.,(,,,,,,@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@....,,,,,,,*******//////((((((#    //
//    /###((((((/////*******,,,,,@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@,,@,,,,,,,@@@@@@,,/,,#&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@,..,,,,,,,,*******//////(((((##    //
//    /###((((((/////*******,,,,,@@@@@@@@@@@@@@@@@@ @@@@@@@@@@@@@@@@(,(#,,,,,,/,/.,/*,,/,,,@@@@@@@@@@@@@@@@# @@@@@@@@@@@@@@@@,..,,,,,,,,******//////(((((((#    //
//    /###((((((//////*******,,,,@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@,(&,,,,,,,,,,,,@,,/,,//@@@@@@@@@@@@@@@@ &[email protected]@@@@@@@@@@@@@(..,,,,,,,,******//////((((((##    //
//    /###(((((((/////*******,,,,@@@@@@@@@@@@@@@@@ @@@@@@@@@@@@@@@@@@@((@,,,,,,,,.#%/,,,,,,,@@@@@@@@@@@@@@@*   @@@@@@@@@@@@@@@..,,,,,,,*******//////((((((##    //
//    /###((((((//////*******,,,,,,,[email protected]@@@@@@@@*   @@@@@@@@@@@@@@@@@@@#(#(,,,#@@@@@@&,#@(,,,,@@@@@@@@@@@@@@    @@@@@@@@@@@@@@@.,,,,,,,,*******/////(((((((##    //
//    /###(((((((//////*******,,,,,,,...........   [email protected]@@@@@@@@@@@@@@@@@@((@,,(@@(  (#   /*@,,,@@@@@@@@@@@@@@    @@@@@@@@@@@@@@@%,,,,,,,,*******//////((((((##    //
//    (####(((((((/////*******,,,,,,,,...........  @@@@@@@@@@@@@@@@@@@@@((%,(@,(    &  (@@,,,@@@@@@@@@@@@@.   #@@@@@@@@@@@@@@%@,,,,,,,,******//////((((((###    //
//    /####(((((((//////******,,,,,,,,...........  %@@@@@@@@@@@@@@@@@@@@@@&,,(@@@%.,#%@@@,,,*@@@@@@@@@@@@@.    %@@@@@@@@@@@@@.,,,,,,,,*******/////(((((((###    //
//    (####(((((((//////*******,,,,,,,,...........  @@@@@@@@@@@@@@@@@@@@@@@&,,,,(&@&&&@@@@@@@@@@@@@@@@@@@@     @@@@@@@@@@@@@%,,,,,,,,*******//////(((((((###    //
//    (#####((((((///////*******,,,,,,,,[email protected]@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@.   @@@@@@@@@@@@@@,,,,,,,,*******///////((((((####    //
//    (#####(((((((///////******,,,,,,,,,......... @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@/  *@@@@@@@@@@@@@.,,,,,,,,*******//////(((((((####    //
//                                                                                                                                                              //
//                                                                                                                                                              //
//                                                                                                                                                              //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract TLHS is ERC721Creator {
    constructor() ERC721Creator("The Lost Hyenas", "TLHS") {}
}