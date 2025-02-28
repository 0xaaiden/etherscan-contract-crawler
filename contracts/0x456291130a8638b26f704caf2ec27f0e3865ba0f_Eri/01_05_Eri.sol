// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Eri Vlc
/// @author: manifold.xyz

import "./ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                //
//                                                                                                                                //
//    *+++***####*+==================------------------------+**+====----------------========+++++***###########%%##*=-:=**--*    //
//    **+***##*##*++================-----------------------=#@%####%#*+---------------======++++++***###########%%###=::=**=-*    //
//    #**#********+===============-=----------------------+%@@%%%##%@@%#=-------------======++++++****##########%%###+=:-*+***    //
//    *****++++*++================-----------------------=%@@@@@%%%#%@@%#+------------======++++++****##########%%###*+-:+=+*#    //
//    *+++++++++=================-----------------------=%@@@@@@@@@%#%@%##=------------======+++++*****#########%%####+-:=-+**    //
//    **+*++++*+================------------------------#@@@@@@@@%*==-+%%%#------------=======++++******########%%####*=:=:-*#    //
//    *********[email protected]@@@@@@@%*=--:.:*%%+-----------=======++++******########%%####*=:---**    //
//    *********+============---------------------------*@@@@@@@%#*+=-:..:#%#------------=======+++******########%%#**#*=:---+*    //
//    *+***+++++==========----------------------------=%@@@@@@@%#*+=-:[email protected]#+------------======+++******#########%#****+-:=-**    //
//    *+++================----------------------------*@@@@@@@@#**+=-:...:%%*-------------=====++++******########%#****+=:=-+=    //
//    *++++==============-----------------------------#@@@@@@@@#**+=-::..:#@*=-------------=====+++******########%#*****=:--+=    //
//    +++**[email protected]@@@@@@@@%%###+-::[email protected]#=-::-----------====+++******########%#**#**+---++    //
//    =+*#*+============---------------------------:[email protected]@@@@@@@@%#***#[email protected]%=::::::---------===+++*******#######%#**#**+--==#    //
//    =***+=============------------------------:::--#@@@@@@@@%#%%*=*#-=#**@%+-:::::---------====++*******#########+****+::==#    //
//    ++++============--------------------------::::[email protected]@@@@@@@@%%@@#+*%+=#+*@%*-:::::::-------====++*******#########+***+=::--#    //
//    ++==============-----------------------:-:::::[email protected]@@@@@@@%%%%#*=*%#[email protected]@*-::::::::------====++*******#########+***+=::--#    //
//    ++============---------------------------:::::*@@@@@@@@%%#*+==*%#=..:%@#-::::::::-------====++*******########++**+=::--*    //
//    +============------------------------::-:::::-#@@@@@@@@%%#*+==*%#=...#@#-:::::::::------====++*******########++**+=::-=*    //
//    ++=========---------------------------:::::::-%@@@@@@@@%%##*++*%#*:..#@#-::::::::::------===++*******########++***=-:==#    //
//    ==========-------------------------::-:::::::[email protected]@@@@@@@%%%##*++#%#=...%@#=:::::::::::------===+*******########*+***+-:=+#    //
//    ===========------------------------::::::::::[email protected]@@@@@%%%%###****#+-:.:@@#+::::::::::::-----===+********#######*+***+-:=+#    //
//    ===========-----------------------::::::::::-*@@@@@@%%%%###***##*[email protected]@#+::::::::::::-----===+********#######*+***+-:=+#    //
//    ==========-----------------------:::::::::::-*@@@@@@@@@%###***##*[email protected]@#*-::::::::::::-----==++*******########*##*+-.=+#    //
//    =========------------------------:::::::::::-#@@@@@@@@@%%###****[email protected]@%#-::::::::::::-----==++*******########*###+-.-+*    //
//    ========-------------------------:::::::::::-#@@@@@@%@@%%##****+=:..#@@%#+:::::::::::::----===+********#######**#*+-.:+*    //
//    ======-=------------------------::::::::::::-*@@@@@@@@@%%##*****+-:[email protected]@@%%+:::::::::::::-----==+********#######*##*+-::+#    //
//    ======--------------------------:-::::::::::-*@@@@@@@@@%###*******#%@@@@#*-:::::::::::::----==++*******#######*##*+-::=#    //
//    ======--------------------------:-::::::::::[email protected]@@@%@@@@%###***#%@@@@@@@%#*-:::::::::::::----==++********######****+=::=#    //
//    =======-------------------------::::::::::::-+%%#*+=+%%#####***%@@@@@@%%#*-:::::::::::::----==++********######****+=:.=*    //
//    =======-----------------------::::::::::::::-+#*++=-:-*####***#@@@@@@@%%#*=::::::::::::::----==+*********#####*****+-:+=    //
//    ======------------------------::::::::::::::=###*+=-:.:+###***%@@@@@@@%%#*=::::::::::::::----==++********#####*****+=:==    //
//    ======------------------------:::::::::::::=#%%#*+=-::.:+##***%@@@@@@@%%#*+::::::::::::::----==++********#####*****+=::-    //
//    ====------------------------:-::::::::::::-*%%%#*+=-:::-=****#@@@@@@@@%###+:::.:::::::::::---==+++*******#####*****++-.:    //
//    ====------------------------::::::::::::::+#%%%##*+=-:-#=+#*#%@@@@@@@@%###*:::.:::::::::::----=+++********####*****++=::    //
//    ====-----------------------::::::::::::::-*#%%%###*+-::#*:*#%@@@@@@@@@%###*::.....::::::::----=++++*******####*+****==-.    //
//    ===-----------------------:::::::::::::::=######**##+====::*%@@@@#%@@@%###*-:....:::::::::----==++++******####*+****+=-:    //
//    ==------------------------:::::::::::::::*#####*#%%#**++=:.:+%@@@##@@@%%##*-:......::::::::---==++++*******####*++***+=:    //
//    ==-----------------------:::::::::::::::-######%%%#**+**=:[email protected]@@#*%@@@#%#*-:......::::::::---==+++++*******###*++****=:    //
//    =-----------------------::::::::::::::::+######%%#######+::...-%%%*%@@@%#%*-:.......:::::::----=+++++*******###*++***+=:    //
//    =------------------------::::::::::::::-######*###%##***=:::...+%%%#@@@%#%#-:.......:::::::----=+++++*******###*++*+++=:    //
//    ------------------------:::::::::::::::+#%######%%#**+**=::::[email protected]@#@@@%##*-:.......::::::::---==+++++*******##*++**++=:    //
//    --------------------::::::::::::::::::=########%%####%##+-::::...-##@@@%##*-:.......::::::::---==+++++********##+++**+=:    //
//    --------------------::::::::::::::::::+########*##%%%#**=--::::....-+*%%##*-::.......:::::::---==++++++******#*#+++***=-    //
//    --------------------:::::::::::::::::-#######%%*%%%#*++*+==--::....:-:-+#**-::.......:::::::---==++++++********#*++***=-    //
//    ------------------:::::::::::::::::::+######%%%%*#****#**++++-::.......:=**---........::::::----=+++++++*******##+++++=-    //
//    ------------------::::::::::::::::::=######%%%%%###%#***##++++==:........+*=+=........:::::::---=+++++++********#***++=-    //
//    ------------------:::::::::::::::::-*#%%%#%%%%%@%###*+=--=****++=........:++*=........:::::::---==+++++++*******##**++=-    //
//    ------------------:::::::::::::::::+####%%%%%%%%%####+=--:--+*#*+:.......:=**+........:::::::---==+++++++*******##**++=-    //
//    ------------------::::::::::::::::-*#####%%%%%%%%####*+=-::::-+*+:..:.....-**+:........::::::---==+++++++*******#%#*++=-    //
//    ------------------::::::::::::::::=#####%%%%%%%%%%###**+=-:::::=+:.::....::**+:.........::::::---=++++++++******#%#*+++-    //
//    ------------------:::::::::::::::-*####%%%%%%%%%%%####*+=-::....-:.::....::+*+:.........::::::---==+++++++******#%##*++=    //
//    -----------------::::::::::::::::=####%%%%%%%%%%%%%####*+=-::...::.--......+*+:.........::::::---==++++++++******###*+==    //
//    ----------------:::::::::::::::::*###%%%%%%%%%%%%%%####**+=-:....:.=-......+#*:..........:::::---===+++++++******##*#*==    //
//    -----------------::::::::::::::::###%%%%%@@%%%%%%%%%####**+-::....:=-......=#+:..........::::::---==+++++++*********#*+=    //
//    -----------------:::::::::::::::=##%%%@%%@%%%%%%%%%%%###**+=-:....:+-:.....=#+:..........::::::---==++++++++********#*+=    //
//    ------------------::::::::::::::*###%@@@@%%%###%%%%%%#*****+=-:...-+-:....:*#+:..........::::::---===++++++++*******#**=    //
//    ------------------:::::::::::::-##%%%@@@%########%%%%%#****+=-:...:=-:....:*#+-...........::::::---==++++++++********#*+    //
//    ------------------:::::::::::::=%#%%%%%###******#####%#*****+=::...--.....:*#*-...........::::::---===+++++++********#**    //
//    ------------------:::::::::::::+%%%@%###****++++**####%#*****=-:....:.....:*#*-...........::::::---===++++++++*******##*    //
//    -------------------:::::::::::=*%%%%##***++++++++**####%#****+=:..........:*##=:...........:::::----==++++++++******#*++    //
//    --------------------:::::::::=#%%%##***+++++===+++*####%#*#***+-:.........:###+:...........::::::---===+++++++******#*++    //
//    ----------------------::::::=#%%#*****++++=======++*######****+=-.........:###+:...........::::::---===+++++++******#*++    //
//    -----------------------::::=*##*****++++==========++*#####*****+-:........:#%**-............::::::--====++++++*****##*++    //
//    -----------------------:::=*#****++++++============+**#####****+=:.:......-*##*-............::::::---===+++++++****##**=    //
//    ------------------------:-******++++++=====------===+**#*###***+=-::......-###*-............::::::---===+++++++*****#**+    //
//    =------------------------+**#**+++++=======--------=+****####**+==:.......-#%##-.............::::::---===++++++*****#**+    //
//    ==---------------------=+*##***++++=======----------=+***%%#%***+=-:.:.....+#**=..............:::::---===++++++****#%**+    //
//    =====-----------------=+*###***+++=======-----------=+***%%%%#***=-:::......**=*:.............::::::---==++++++****#%**+    //
//    =====----------------=*+####**+++======---------::--=+***%%%%%***=---::.....:+-=-..............:::::---===+++++****#%**+    //
//    =======-------------=***###***+++=====--------::::--=+**+#%%%%#**+===-::.....:-:+:.............:::::----==+++++****##**+    //
//    =======------------=***####***+++=====-------:::::--=+**=+%%###**++++=-::.....::=-..............:::::---==+++++****##**+    //
//    =======------------+##+###****+++=====------::::::--=+*+:.==-:#***+++==-:::.....:=..............:::::---==+++++****##**+    //
//    ==========--------=*#+*###****+++=====-------:::::--=+*=......#***+++===-:::...::=...............:::::--==+++++****##**+    //
//    ==========--------*##+###****++++=====------::::::--=+*-......*****+++==---::...:-:..............:::::---=+++++****##**+    //
//    =========--------+###*###****+++=====-------::::::--=++.......******++==----:....-...............:::::---=++++++***##**+    //
//    ==========------=*###*###****+++=====-------:::::---=+=.......+*****++===--:-:...................:::::---==++++****##**+    //
//    ==========------=**#*####***+++++====--------:::----=+:.......+******++==---:::...................::::---==++++****#*#*+    //
//    ============----+**#*####***++++=====--------:::---==++:......=**++**+++==--::::..................:::::--==++++******#*+    //
//    ============---=+****####***++++=====--------------==*%#+:....=**++++++++==--::::.................:::::--==++++******#*+    //
//    ============---=*****###***++++======--------------==#%%%%*=:.=**+=======.:-=-::::................:::::--==++++********+    //
//    ==============-=*****###***++++======--------------=+*##%%%%#***++===----...:---::::..............:::::--==++++********+    //
//    ================*****###***++++=====---------------=+**##%%%%%#*+===--:::.....:--::-:.............:::::--=+++++********+    //
//    ================*****##****+++======--------------=+++**##%%%@%*+===-:::=++=::..--:-=:............:::::--=++++*********+    //
//    ===============+*****##****+++=====--------------=***+++**##%%%*++==-:::+**##*+-++--=:............::::---=++++*********+    //
//    ===============+*****#****++++=====-------------=+*********##%%*++==-:..+#########*=-:............::::---=++++******#**+    //
//    +==============+**********++++=====-------------**=:+*******###*++==-:..+**+++**#%%*=:...........:::::--==++++**********    //
//    ===========----+**+*******++++=====-----------=##+-..=*******##*++==-:..-=+===-=+*##*=:..........:::::--==++++********++    //
//    ++++++=========+*++******+++++=====----------=#%#*=---+#*****##*+++=-:..:--------=+##*=:.........:::::--==+++*****#**#+=    //
//    ++++++++++++===+++++++***++++======---------=*%%%#####%%##***##*+++=-:..:::::::::--=*#%*-........:::::--==++*****##*##*=    //
//    ++++++++++++===+++++++**+++++======--------=*###*####%%@%###*##*+++-:::.:::::...:::::-=++-:......:::::--=++******##****=    //
//    ++++++++++++====+++++++*+++++=======-----==***++++***##%%%%####*+++-:::.:-::::....::::::..:::.:::::::--==+****#####****+    //
//    +++++++++++=====+++++++++++++==========-==++++=====++**#%%%%###*+*+-:::.:-----::...:::.....::.::::::---==++***#####****+    //
//    ++++++++++=======+++++==+++++============++==========++*#%%%%##***=::::.:==-----::.::::......:::::::---=++****###%#*#*++    //
//    +++===============++=====+++++=========+++===-------===+*#%%@%#***=::::.:++==-==--:::::::::...::::::---=++***####%#*#*==    //
//    ++++==============++==================++===-----------==+*#%%%#***=:::::.-========----::::::..:::::---==++***####%%##*--    //
//    ++++++====================-==========+++==-------------==+#####***=::.:-.::-=========--::::::::::::---=++**##########+=-    //
//    ++++++++==================-----===+======---------------=+*###****=::.:-:...::--=======-::::::::::---==+**######%%%%#+=-    //
//    +++++++++++===============-----=+++======---------------==*###****=::.:-:.::..::--=====----::::::::::---=++**######%%*=-    //
//    ++++++++++++====================++=======-----==-------==+*#%%****=::..--::-:::::---===-----:.....:::::---==++***####%#*    //
//    ++++++++++++++=========+========++========--======----===+*#%#****=-:.::-:::--:::::---------:.........:::::--==+***###%%    //
//    +++++++++++++++++======++++++==++=++=+===================+*#%#****=-::::--:.:---::::::::---:...............::::--=+****#    //
//    ++++++++++++++++++=====+*++++=+++==+====================++##%*****+=-::::-::..::----::::::.......................:::----    //
//    ++++++++++++++++++++++==+++++=+++======================++*###***+++==--::::::...:-=--:::................................    //
//    +++++++++++++++++++++++++*++++++==+==+================++**#%#++++==-==-:::::::....:-:::.................................    //
//    ++++++++++++++++++++++++++**++++=====+==============+++**##%#+++===--==-:::::::.....:...        ........................    //
//    +++++++++++++++++++++++++++***+++====+++++=====+++++++**#%%%#++==---------::::::.........         ......................    //
//    ========================++*#%%##**++=++++++++++++++***#%%%%%#*+=--::---==-:::::::...........          ..................    //
//    =========--------------------==+++********+++********##%%%%#**+=--::---===----:::::.......::..          ................    //
//    --------------:::::::::::::::::::::::::::::::::::::----=+*###*+==-----======------:.....::::::.          .......  ....      //
//    --:::::::::::::::::::::::::::::::::::::::........::::::::-=+*#**+====++**++======--:::::---::-.            ...........      //
//    :::::::::::::::::::::::::::::::.............................:::---==++*#######*+===-==-::::::-:             ..........      //
//    :::::::::::::::::::::::::..............................................:::-=+*###*++**+:.-:.::.              .. ....        //
//    :::::::::::::::::.....:.......................................................:.:::--==-::...                .......        //
//    ::::::::::.::::...........................................................................                   ..             //
//                                                                                                                                //
//                                                                                                                                //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract Eri is ERC721Creator {
    constructor() ERC721Creator("Eri Vlc", "Eri") {}
}