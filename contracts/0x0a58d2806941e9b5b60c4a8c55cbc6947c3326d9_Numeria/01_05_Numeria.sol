// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Numeria
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                  //
//                                                                                                  //
//    --------------------------------------------------------------------------------=#####*#%%    //
//    --------------------------------------------------------------------------------=##****#%%    //
//    ---==-=---------==+=-============-=================----------------------------==#####*#%%    //
//    ----------------=================================================================#####*#%%    //
//    ----------------========--==-----================+==============================+##***##%%    //
//    ---------------------------------================*===============================****###%%    //
//    --===========------------------------------------#+------------============+====+##**###%%    //
//    ++++++++++++++++++++++++++======================*%#+====================-=-++--==****###%%    //
//    ++++++++++++++++++++++++++=====================-*#%*=======================%#====##**##%%%    //
//    =======================-----===================-*#@%======================#@@#+=+##**###%%    //
//    ===========================++++++++++++---++++--*#@@====================+*#%%%#+=**++###%%    //
//    +++++++++++++++++++++++++++++++++++++==--=+++=--##@@#+++++++++++++++++++***#%%%*++***#%%%%    //
//    @@#++++===***++++++++++++++++++++=------=++==---##@@%+++++++++++++++++++***#%%%#+*#***##%%    //
//    @@#++++=#=###+============-------------=++==---=##@@@*++++++++++++++++++**##%%%#+**++*+#%%    //
//    @@#++++=#=###==--------------------===+++++++--***%%@#++++++++++++++++*###%@@%@%+****#+#%%    //
//    @@%*+++=#=###++++++++++++++++++++++++++++++++--=++*%@#++++========++*#%%%%%@@@@%***+*++#%%    //
//    @@@%++==#+*##**++++++++++++++++++++++++++++++--=++*%@*-------------=#%%%%%%@@@@%+****#+%@@    //
//    %%%%%%##%******+++++*##++++++++++++++++++++++--+++*%@#==============######%@@@@%**#**#*#%%    //
//    %%%%@%%@%******+++===#%#+++++++++++++++++++=--++++*%@%+++++++++++++=######%%#**+*%%%%%%%%%    //
//    %%%#%%%%#*****+++====+%%*++++++++++++++++++=--++++*%%@*++++***+++++=####*+++++**+%%@@%%%@@    //
//    %%%%%%%%%*+++++++====+%%#+++*****+++++++++++--+****#%%*+***####*++++*###****#**#+%%%%%%%%%    //
//    %%%%@@%@%*+++++++====+%%#*+=######++++++++++-+*****#%%#+*#####**++++*###*#*+*++++%%%%%%%%%    //
//    ##########*++++++====+%%#*=-####*##*++++++++-+*****#%%#+*#####++++++*****+++***#+%%@@%%%@@    //
//    %%%%%%%%%%%#*++++====*%%%*=-#***####*+++++++-+*****#%%#+*#####+++++=***%*#**#***+%%%%%%%%%    //
//    %%@%@@%@%%%%%**++===**%%%*=-****####*+++++*+-+*****#%%#+*#######*+++*#%%*++++++*+%%@%%%%@@    //
//    #########%%%%%#*++==%*%%%*=-***%%%%#****+=++++*****#%%%+***********###%%****#**#+%%%%%%%%%    //
//    %%%%%%%%%%%%%%%%##**######**#####################**####**********###%%%@#*++*++++%%%%%%%%%    //
//    %%%%%%%%%%%%%%%%%#+*******++++++*###********++++*********##***####**%%%%*******#+%%@@%%%@@    //
//    %%%%#####%%%%%%%%%##*#*#**======+###++++++++==--=**+**#++****#######%%%%*#**#**#+%%%%%%%%%    //
//    %%%%%%%%%%%%%%@@%%%%#**#*+======+***++++++++==--=**+**#+****#####%%%%%%%*++++++++%%%%%%%%%    //
//    %%%%%%%%%%%@@@@@@%%%%##%*+======+***++++++++=---=**+**#+*######%%%@@%##**#**#**#+%%@@%%%@@    //
//    %%%%%%%%%%@@@@@@@@@@%%%%%#======****++++++++=---=**+**######%%%%@@@%##%%***+*++*+%%%%%%%%%    //
//    %%%%%%%%%#***#%@@@@@@@@%%%#*===+****+++++++***+++****#####%%@%@@@%##%%%%#+++++++*%%@@@%%@@    //
//    %%%%%%%%%##*+*#%%%%%%%%%%%+=====+++++===*%#------+++######%%%%%%%%%%%%%%#*****%%*%%%%%##%%    //
//    %%%%%%%%%%@%%***[email protected]@@@@***===================++****++*%%%%#%%%%%##%%    //
//    %%%%@@%@%%@@@##***===================+********+--=====================++**##@@@@%@@%@@##@@    //
//    %%%%%%%%%@@@@@@#**##**=-----------------------=+++++++=============+******%@@@@@%%%%######    //
//    @@@@@@@@@@@@@@@@@%%%@###+----------------------------------------+**#%#*@@@@@@@@@@%%@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@%%####+----------------------------------=#**#%%@%%@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@%%%#*+================================+**%%%@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@%*****+++++++++++++++++++++*+++++++***++++++*****%@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@%#********************************************#%@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@@%#########################################@@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@%######%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%####%@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%@@@@@@@@@@@@@@@@@@@@    //
//                                                                                                  //
//                                                                                                  //
//                                                                                                  //
//////////////////////////////////////////////////////////////////////////////////////////////////////


contract Numeria is ERC721Creator {
    constructor() ERC721Creator("Numeria", "Numeria") {}
}