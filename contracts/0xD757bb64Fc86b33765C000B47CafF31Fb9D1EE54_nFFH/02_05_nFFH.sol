// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: (Not) Far From Home
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                       //
//                                                                                                       //
//    ::::............:::::::::::::.::::......:::::::::::::----------------------=======----=========    //
//    :::..........:::::::::::...:.:::..  .....::.::::::::::::::::----------------=======---=========    //
//    .............  ....:::.......      ...::..   ..::::::::::::::::::.:::-----------===============    //
//    ............................       ......     .:....      ..::.............:::::----===========    //
//    ...................    ...           .......                ......::.....:::::----=====--------    //
//    :::................... ...         ..                      ....    .... .....:::----=--::---:::    //
//    ::::::...............                                     ..........::..:::::::---------=======    //
//    ::::::...............                                     ..............::::::------===-::::-==    //
//      .:...............                                         .................:::---::.        .    //
//    ...............                                                              ......                //
//                                                                             ........    .....         //
//                                                   .:.                        ... .....:....           //
//                              .                 .:--::::..                  ..............  .....      //
//                          ...-=:..        .    .::::::.:::::.    .       ............    . ........    //
//                       ..::..--:-=:. ...--=:::...-=::......::::-==-:     ...........           ....    //
//                 ..::----::::-:.::==---:---:.....:-...-::---:-==+==+:              ...         ..::    //
//          .:----===--=----:::::-::::------....   .=:.-+-:------==++==..           ............:::::    //
//      ..-=++=--=+=-:-==::=-::::.:::..:::::.-:.....+--:+::--:--:--::=--::---                ........    //
//    **++*+++=---+---==+=-=+-:--=:..::-:--:...  ...+-=.=:::+=-=---:-:----::--:-=+==-=*+=-.      ...:    //
//    **+++++==----+=+*+#++=*=-::+::---=:::--:-...:.=:=.=::-*-:+-=::-==+======++*+-:=######+++=-::...    //
//    ##*++++++*+++#-=+***++#+++++-::==#==-==-=::-::+:=--.:==:-=-+::-+::-++++==++*=-+#**++===++**####    //
//    @@%%%**+***%#%+==++#++#+=+%+==--=*--+===+-+--:*=+#*+=**-=#*#+=-****%%#***%#%@%##%###*+*++**#*#*    //
//    @@@@@@@@@@@@@@%@%%%%%##%##@###+=++*+*+*+*+*+++##+%###%#*#%###+*%#%#%%%#%%%@%%%%%###%%%%%%@@%@@@    //
//    @@@@@@@@@@@@@@%%%@@@@@@@@@@@@@#%%*#****+#**++*%#%%#*%#%#@@%#@%#@%%%%%%%#%%@@@*%@%@@%@%%@@%@@@@@    //
//    @@@@@%%@@@@@@@@@@%@@@%@@@@@@%%#%#+****######*%@@%@#%@%%%@@%@@@%%#####%@%%@@@@@@@##%%##%%@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@%@@@%@%@@@%%%@%###**+**%%#%%#%%@@@#%%%@@@@@%@@@#%%@%%%@@@@@@@%%%%@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@%%@@@@@@@@@@@@@@@@%%##*#%@@#@%@@@@@#*%*##@@@@%%#%%@%@@@@@@@@@@%@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%%@%%@@@@@@@@@@@%%%%%%@%@%%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@[email protected]@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    //
//                                                                                                       //
//                                                                                                       //
//                                                                                                       //
///////////////////////////////////////////////////////////////////////////////////////////////////////////


contract nFFH is ERC721Creator {
    constructor() ERC721Creator("(Not) Far From Home", "nFFH") {}
}