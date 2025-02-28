// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Rhymezlikedimez Official ERC1155
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                       //
//                                                                                                                                       //
//                                                                                                                                       //
//    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    //
//    //                                                                                                                           //    //
//    //                                                                                                                           //    //
//    //                                                                                                                           //    //
//    //                                                                                =+-..:=+                                   //    //
//    //                                                                               #:       #.                                 //    //
//    //                                                        -==========-           %   .....+-                                 //    //
//    //                                                     -=-.          .==-        :+:....:=+                                  //    //
//    //                                                   :*.                .*:        %.+===.                                   //    //
//    //                                                  =+                    +-      :**:                                       //    //
//    //                                      :====---===++                      +===---: :+-.                                     //    //
//    //                                   .+=:                                              -+-                                   //    //
//    //                                  +=                          ... .....                .*:                                 //    //
//    //                                .#.                     ...................... .         =+                                //    //
//    //                                #.                   ...............................      +-                               //    //
//    //                               -+                 ..................::.::::............    #                               //    //
//    //                               +-             .:::..........:..::::::::-----:::::.......   %                               //    //
//    //                               ==         -+++*++****++:...::::::::=*+*++++**#*+-::........%                               //    //
//    //                               .%       =*+=+**********##-::---::+*+=+**********##-:::....==                               //    //
//    //                           .:-=+=     .#=+***************%#====*%++***************%*:::...-++--:                           //    //
//    //                       -*%@@#-        #=*************++***%%++*@+*************+****#+::::..  :[email protected]@@*=.                      //    //
//    //                     [email protected]@@@%:         =****+:.:*****+:  =**[email protected]+#+**-::+****+-  :**=:%-::::...  .*@@@@*.                    //    //
//    //                   .%@@@@*           *#**:    =**+:     .  %-:+#*=    :***-     :.  #=::::::...  [email protected]@@@@=                   //    //
//    //                   %@@@@#          ..=#-      =+:        [email protected]:=%:     .*=         =.%-:::::::::.. [email protected]@@@@:                  //    //
//    //                   @@@@@.        .....#:                +:#+-::#-                -=+*-::::::::::.. #@@@@=                  //    //
//    //                   @@@@#       .......:#-             -=:*+-::::#=             .=-**--:::::::::::[email protected]@@@+                  //    //
//    //                   @%@@*      .........:+*--==-:.::===-+#=-::::::+#=:==-:..:-===+#+--:::::::-:-:::[email protected]@@@+                  //    //
//    //                  [email protected]+*@%.    .........:.::=**++++++++**=--::::::::-=**+=++++++**==--:::::--------::[email protected]@%@+                  //    //
//    //                  [email protected]**+*#*=:......:::::::::::--====----::::::::::::::---====--------------------+*%%%%%@=                  //    //
//    //                   @*******##*+-:::::::::::::::::-:---:-----:-----:------------------------=*#%%%%%%@@@@=                  //    //
//    //                   %*****###****##*+-::-:----------------------------------------==-===+*#%@%%%%%@@@@@@@:                  //    //
//    //                   =%**##########***###*+=------------------------------=-========+*#%@%%%%%@@@@@@@@@@@%                   //    //
//    //                    %#**#####%%%%%%%%#**####*+==-==-=========================+*#%@@%%%@@@@@@@@@@@@@@@@@:                   //    //
//    //                    .%#######%%%%%%@@@@@%%%##%%%#*+=====================+*#%%@%%%%@@@@@@@@@@@@@@@@@@@@=                    //    //
//    //                      #######%%%%%@@@@@@@@@@@@@@@@@@%%#+===========+*#%@%%%%@@@@@@@@@@@@@@@@@@@@@@@@@-                     //    //
//    //                       =%####%%%%%@@@@@@@@@@@@@@@@@@@@@@@%%#*+*##%@%%%%@@@@@@@@@@@@@@@@@@@@@@@@@@@@#.                      //    //
//    //                        .*%%%%%%%%@@@@@@@@@@@@@@@@@@@@@@@%%%%%%%%%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#:                        //    //
//    //                          .+%@@@@%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*:                          //    //
//    //                                                                                                                           //    //
//    //                                                                                                                           //    //
//    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    //
//                                                                                                                                       //
//                                                                                                                                       //
//                                                                                                                                       //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract RHYMEZ1155 is ERC1155Creator {
    constructor() ERC1155Creator("Rhymezlikedimez Official ERC1155", "RHYMEZ1155") {}
}