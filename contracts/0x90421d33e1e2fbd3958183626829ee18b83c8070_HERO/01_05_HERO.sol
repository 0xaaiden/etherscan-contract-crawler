// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: CARTOON HEROES
/// @author: manifold.xyz

import "./ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////
//                                                                    //
//                                                                    //
//    ------------------------------------------------------------    //
//    -----------------------=***++=---=*+++=---------------------    //
//    -------------------#=--+%###*[email protected]#=-------------------------    //
//    ---------------------%*----*@#--#@@@#+----#=++--------------    //
//    --------------------#@=--+%@+----==*@@%-=%=-----------------    //
//    [email protected]@=-=%@%---*#%[email protected]@=-#*=----------------    //
//    [email protected]@[email protected]@@=+%@@@@#=%@@[email protected]+---------------    //
//    [email protected]@#---%@@@@@@@@%@@@@[email protected]#---------------    //
//    ------------------*@@@@#%@@@@@@%*#@@@@+*#%@@=---------------    //
//    --------------------*@@@@@@@@@@*%@@@@@@@@#+-----------------    //
//    [email protected]@@@#**%*##*%@@@#--------------------    //
//    ----------------------+#@@#%@*#*#%@*%@@=+-------------------    //
//    [email protected]%@@+*#%@%@%**#@%@#-------------------    //
//    ----------------------%%%%++*##*#**+#%#@=-------------------    //
//    -----------------------#%#*%*#%##*##*%#+--------------------    //
//    ----------------------+%%#*@++*++++#*%%+--------------------    //
//    ------------------=++%@@@#**+*****+**@@@@%#+----------------    //
//    --------------*%@@@@@@@@#@*+*+**+*++##@@@@@@@@@#------------    //
//    -------------#@@@@@@@@@%#@@@@@%%@@%#@##@@@@@@@@@%-----------    //
//    [email protected]@@@@@@@@@***+*%@@%%%*+***@@@@@@@@@@-----------    //
//    ------------*@@@@@@@@@@+++***#******+++%@@@@@@@@@+----------    //
//    [email protected]@@@@@@@@@%++++++++*+#@@#++#@@@@@@@@@@#---------    //
//    ----------#@@@@@@@@@@@%+++++++#**%@@#++#@@@@@@@@@@@#--------    //
//    -------=#@@@@@@@@@@@@@@++++++++++++++++%@@@@@@@@@@@@@*------    //
//    ------*@@@@@@@@%*@@@@@@#+++++++*[email protected]@@@@@=#@@@@@@@%-----    //
//    [email protected]@@@@@@@@[email protected]@@@@@%%#*********#%@@@@@@%[email protected]@@@@@@@=----    //
//    [email protected]@@@@@@@@+---%@@@@@@*++++***++++#@@@@@@+--%@@@@@@@*----    //
//    ----*%#%@@@@@=-----%@@@@@%****++*****@@@@@@*----%@%#%%@%----    //
//    +*****%##%@#[email protected]@@@@@+====+====#@@@@@%-----=#*#*#***+*+    //
//                                                                    //
//                                                                    //
//                                                                    //
////////////////////////////////////////////////////////////////////////


contract HERO is ERC721Creator {
    constructor() ERC721Creator("CARTOON HEROES", "HERO") {}
}