// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Paperless
/// @author: manifold.xyz

import "./ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                            //
//                                                                                                            //
//    ***,,,,,,.,,,,,,,..............,..,.......  .                                            .  ,.**&&%.    //
//    ****,*,,,,,,,,,,,,,,,,................................                                           ...    //
//    ***,**,,,,,,,,,,,,,,,,,.,,..............................                                      ...,,,    //
//    ****,*,,,,,,,,,,,,,,,,,,.................................                                   ..,,,,,,    //
//    **,*,,*,,,,,,,,,,,,,.,,,,........,......................                                  .,,,,,,,,,    //
//    *,*,,,,,,,,,,,,,,,,,,,,.,,................................                              .,,,.    ..,    //
//    ,,,,,,,,,,,,,,,,,,,,,,,...................................... .                        ..        /((    //
//    ,,,,,,,,,,,,,,,,,.,,,,..,.........................................                 ....,/..(/(/((###    //
//    (///((/////((///*////,,,,,,,,,.................................................,,,,,.,,,/....(##&(((    //
//    #(/(#(/(((((//((/#((#((######%/*********//***,*****(%%%%%%%%%%%%%%#,#%(*#%%%%%%%%%%,,,,,*,..,(%%%/((    //
//    /#(####(##////(/*********************/%%*******,,***%%%%%%%%%%%%%,#%(/#%/**(&%%%%%%,,,,**,,,,,%%%%#/    //
//    #(%###(/((/((*/***///*//#//****************/**/***,,,*/%%%%%%%%%%///((////#/(/%%#%%,,.,*/,,,,*%%%#//    //
//    #(/##/(//(/(/(//////**(**/*****/**/******%%%%%%(*(##%###%%%%%%%%%/(&,.(/((,,%%,**&%,,,,***,,,,&%&#(/    //
//    %(//((/(#///*(*(//*//*(&##%&%%%%&&%%%%%%%&%%%%%%%%%%%%%%%%%%%&%##*/#//*///,,*%(///%,,,,*/,*,*,%%%%**    //
//    #((/((///((///*///*/*%%&&%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%/*/(#%%##((////,%#,,,,,/*,,,,/#///*    //
//    (#(//(##//(////**/**(%&%%%%&%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%&%%%%%%%#,%%%#%%%%%%%%%/,,,,***,,,,%%####    //
//    /((%#/*(//*(////****/%%&&%##(,/#//(/((#((/(//(#(((%%&%%%%&%%%%%%%%%%%#%%%%%%%%%%%%/,,,,*/*,***(%(#((    //
//    ##((#(/*//(#///****/%%&%&%(/((((/(/(*/**//(((/(#%#(%&##%%%%%&%%%%%%%%#(%%%%%%%%%%%/,,,,*/*****(#/(((    //
//    %((((#%((/((//****/%&%%%/&(//(//#(*(/****(((*/(##%/%***,,,,*,*%%&%&%%((%%%%%%%%&%%/,,,********((((((    //
//    ((#(###%##(#%%((//(%%%%%%%((//****/#((////(*//*/#/(*#(,/(/((*,,%////#((%%*(%%%%%%#*,,,,*/*****#///(/    //
//    (#*%%%(##(%((%%%*((&%%%%%%((*/(#(//*/(/*/(//***##(/**,,,,*******/*&%(//%&(*%%%&&%%*,,,,******/%(////    //
//    #(/*(#((((#(###/(*%&%%%(%%*(/#/(/*/*///**/%/*##/#(*(%%#(********#%(%((,%%%#%%#%%&%*,,,,*****/(&%#%#%    //
//    (((##/#(/((#(#(%/*/(&%%%%%/#*/*(#/*///(///#*((/(#**../(/**/*//**((#%#(*%&%%%%#((%%,,,,,******(%###%%    //
//    %((*%(#((((#%##%/**/%#%%%%*(/*/*%(/(**(###.........,,,%(###/**,,,.((((*%%%%%&%#(#%,,,,,******##/*/**    //
//    (*((#(##(#((//(****(%%#%&%/#**,//*(/((/.......,..,...,,(///***,/.....#%%&&%%%%%%%%,,,,,*****/##%####    //
//    ((#((##(/*(*/(/(/***#%%%&&(#//(((%#%,.....,.............,,*,,*...........(##(/%&%%,,,,******/######(    //
//    ###////#&&&%//*/***/#%*&%&*(/(#((#(,.....................,,,...............&(((&&%,,,,*/****/##(((/(    //
//    (/#%(/////%*/*//////((*#&%*(/##%&............. ..........,...........,......*((#&%,,,,*/****/%(#(((/    //
//    ###/#((#*/**/*///*(/%#/#&%//(#%..........**,,,  .,.,.*..............,........(/#%%,,*,,/****(*(((((/    //
//    //(///(*/(***(#%%%&%%**#&&***,,,,,.......%,,,.  *.,*,,*. (..,,...,,/.,..,.....(/%%,,,,*/****/#((/(((    //
//    #(((//(##&&&&&%%(*/****&&#**,,,,,,,*,/(%(,,,,,.*../,##, *(,*,., ...,*,,.......#/%%,*,,*/****/#(#%%%#    //
//    (#(#(//(/%%//*//******(%/**,*,,,,%&%%%((%,,,.*,..,*,/(,.///**.,.,(.**,,.,......#%%,**,*/**///##%%%%%    //
//    ........,*(*////(/****#//**,***%%%%%%%,(,,*.../...(,#,*((*/,(,/(/,//,,,,........&%,**,*(/*//%####%##    //
//    (////***,,,.................,,%#%%%(%%***,(*.////.(,//,**(//(*((,*#%*,,,,.......#%,****(////((((((##    //
//    %#%#((///**************,,,......  .    .,,.*//*#...*,*(//*,/,.,//,%/(#,,,*#(#%####*****(*//(/((##(#%    //
//    &###((//////////**///*/*************/....,.,*.*./ #*******,,.,./,,%((//**/(///********/////%(###%%%&    //
//    &&%(((///*************************///....,,,,,,,**#*(#( *,.....(*//**/***//*,****,*****////(#%#%%%(/    //
//    &&#((((//********************,*,***//*...,,,,*,....,.,,...,///**/**/**//((,,,,***,,***/(//#/#%&%%%#(    //
//    (&&/(/(///***************,**,,,,,***//,...%(/#*,*,,*,,*,*,,*****/*(/(#%,,,,*,*********/(//&(#(((((/(    //
//    ((%&&(////******,*********,********,//*...#%%#,,,***#,*/**//((#%*,,,,,,,,,,,*,********/(//%/%%%%%%%%    //
//    #(((%%((///**********,,,,,,,,*,******//,...(((#(%#/,**/%%%###(((,,,,,,,,**,,*********//(//(/%%%%%%%%    //
//    %#((/#%/&/////******,,*,,,,,,,,,,*,**//*...(((((((#######((##/(((*,,,,,*************/*//(//(%%%%%&&&    //
//    %%#((/#&/&/((///*********,,,,,,,,,****(/,..,((#%(%##(####////*((/*****,*,*************((////#(#(##%&    //
//    #%%#((/#%/%///(///*********,*,,,,,****((*...%%%##%####(((/////(##*************%%*****/((((((%#(##%%%    //
//    ##%%#((/(%%&///////**********,*,,,*****((,..*%%%#%#####((##(//(//************////*****/(/(((%%(%&%&%    //
//    (%((((#(/(%%%#//////************,,*****/(*,..%%%###%#/(((///(/*//&///****,**////*/////((/((%%%%%%%%%    //
//    %&%%%%%%(((%#&%*///(/*****,*,,,*,,,****//(,..(%%##(((#(((////(///#*/(//(////(/((/(((((#((((%(###%%%%    //
//    %*/*****/%%%%%&&%#(//*,,,,,,**/***,,****((/,,,%%%#,###(#(/((((/((((,,(/(/(((#######(((##(###%%&%%%%&    //
//    %////*/***/*%%%&%%%%%&*/(////**,,,,,,,*/((#*..(*%%#/###(((/((#/(#(((/(%((#(####%%%#%%###%##%%%%%%%%%    //
//    %#%%%%%%%%%%%&%%&%%%%////*/*****,,/**//**((*,,,//%##%#/#(#/((#((##(((((%%%%#%%#*///#%((###%%%&%%%%%&    //
//    %%%%%%%%%&%%%%%%#%%%%%%//*****#%#/%#((#(*,.,*,%%%%%%%%###(###(#(%%%####%%%####(#%########%##%%%%%%((    //
//    %%%%%%(%%%%%%%&%%%%%%%//******%%#####((##(##%%%%%%%%%##,((,##((((#%%%%%%%%#%#####*/(((((#(#%%%#%%/%%    //
//    %&%%#%%%%&%%%%%%&%%%%%//*/****##%#(#(#(#(/#%(//#/#%%%##(#/(###((%%%%%#%#%%%%%%(%%%(/%%%##%%%#/%#//%&    //
//    &%%%%%%%%%%%%%%%%%%%%%%//(///(%%#%##(#(####%%%%%%%%%%%%##((##%#&%%%%%%%%((#(/,*#%%%%#%%/%%%#%%%%#/%&    //
//    %%%%%%&#%##%%%%%%%((/%%%#(/(((%%#*#%#####(#%%&%%%%%%%%%####(##%%%%%%%%%%%%%%%(,,,,,,/#(%*%%%&/*,%%%%    //
//                                                                                                            //
//                                                                                                            //
//                                                                                                            //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract paper is ERC721Creator {
    constructor() ERC721Creator("Paperless", "paper") {}
}