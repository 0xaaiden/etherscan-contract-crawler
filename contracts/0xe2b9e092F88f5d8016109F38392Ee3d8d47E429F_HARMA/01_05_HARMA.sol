// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Harma
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                                                                                     //
//                                                                                                                                                                                                     //
//                                                                                                                                                                                                     //
//       ,:'/?/`:,       .Ј/?/`:,'                ,.-:~:-.                .:'/*/'`:,Ј:~ЈЦ:.,                          _             _                        ,.-:~:-.                                  //
//      /:/_/::::/';    /:/_/::::';             /':::::::::'`,             /::/:/:::/:::;::::::/`':.,'              ,Ј?/:::::'`:,   ,:?/::::'`:,'                 /':::::::::'`,                       //
//     /:'     '`:/::;  /Ј?    `Ј,::';          /;:-Ј~Ј-:;':::',          /Ј*'`Ј??'`^Ј-~Ј:Ц-'::;:::'`;           '/  /:::::::::'`Ј/::/::::::::/'\              /;:-Ј~Ј-:;':::',                        //
//     ;         ';:';  ;         ';:;        ,'?          '`:;::`,        '\                       '`;::'iС         /,Ј'? ??'`Ј;:::/:;Ј? ? '`Ј;/:::i          ,'?          '`:;::`,                   //
//     |         'i::i  i         'i:';∞      /                `;::\         '`;        ,Ц .,        'i:'/        /            '`;':/            \:::';        /                `;::\                  //
//     ';        ;'::/?/;        ';:;С'    ,'                   '`,::;         i       i':/:::';       ;/'       ,'               `'               ';:::i∞    ,'                   '`,::;              //
//     'i        i':/_/:';        ;:';∞   i'       ,';?'`;         '\:::', С     i       i/:Ј'?       ,:''        ,'                                  ;::iС'   i'       ,';?'`;         '\:::', С      //
//      ;       iЈ?   '`Ј;       ;:/∞  ,'        ;' /?:`';         ';:::'iС     '; '    ,:,     ~;'?:::'`:,     ;'       ,^,         ,:^,          'i::;∞ ,'        ;' /?:`';         ';:::'iС         //
//      ';      ;Ј,  '  ,Ј;      ;/'    ;        ;/:;::;:';         ',:::;     'i      i:/\       `;::::/:'`;' 'i        ;:::\       ;/   ',         'i:;'  ;        ;/:;::;:';         ',:::;         //
//       ';    ';/ '`'*'?  ';    ';/' 'С  'i        '?        `'         'i::'/      ;     ;/   \       '`:/::::/' 'i       'i::/  \     /      ;        ;/   'i        '?        `'         'i::'/    //
//        \   /          '\   '/'      ¶       '/`' *^~-Ј'?\         ';'/'В      ';   ,'       \         '`;/'   ;      'i:/     `*'?       'i       ;/ ∞  ¶       '/`' *^~-Ј'?\         ';'/'В        //
//         '`'?             `''?   '    '`., .Ј?              `Ј.,_,.Ј?  В       `'*?          '`~Ј-Ј^'?      '`.    ,'                   '.     /      '`., .Ј?              `Ј.,_,.Ј?  В             //
//                          '                                                                                  `*?                      `'*'?                                                          //
//                                                                                                                                                                                                     //
//                                                                                                                                                                                                     //
//                                                                                                                                                                                                     //
//                                                                                                                                                                                                     //
//                                                                                                                                                                                                     //
//                                                                                                                                                                                                     //
//                                                                                                                                                                                                     //
//                                           ..                ..                                                                                                                                      //
//                                           ;d:.            .;xd.                                                                                                                                     //
//                                           ;lol.          .lkOd.                                                                                                                                     //
//                                          .:ccdo.        'oOkxd,                                                                                                                                     //
//                                          .c::oOk:,,,''':k0OOxdc.                                                                                                                                    //
//                                          ,:,,lkOkO000OOOKOxkddl.                                                                                                                                    //
//                                          ';;cokOO0KKKKKXK0Okooc.                                                                                                                                    //
//                                          ,ol:;cdOKK0kxdxxOKK0O:.                                                                                                                                    //
//                                          'oo:;;;o0Kxc::cokKXKx,.                                                                                                                                    //
//                                          ,oddxxxk0KKK0000K000o...                                                                                                                                   //
//                                          .':cloxxxOK000OOkxxo,...                                                                                                                                   //
//                                             .':looxkxdolooo:.                                                                                                                                       //
//                                              .;ccloooooddxd;.                                                                                                                                       //
//                                              .;looodxxxkOOd:.                                                                                                                                       //
//                                             .':clllodddxxdool'.                                                                                                                                     //
//                                            .:dol::;::cclok0KKk,..                                                                                                                                   //
//                                           .lxkOkxoc:cldk0KXXXKk:.                                                                                                                                   //
//                                           ;kOO0000xdkO00KKXXXXKOc.                                                                                                                                  //
//                                          .ckO00K0000000KKKXXXKK0Ol.                                                                                                                                 //
//                                          .:xkO0OO00K0000KKKKKK000O:.                                                                                                                                //
//                                           ;dxkkxO00K0kxk00OkkO0K00x;..                                                                                                                              //
//                                         ..;cdkxok000xl:lk000kxkOKKOl,..   ..'..                                                                                                                     //
//                                 .      .;,.,okxoxO0O:..ckkOKK0OkOKKOkk:..,;,.''.                                                                                                                    //
//                               ..  .. .;l:'..cxkolk0k,..:dxk0KKKK00KK0K0occ;,'.''.  ...                                                                                                              //
//                              ... ....:dl;'..ckkd:ckd'..:ooxO0KKKK00KKKK0d:;;'..,'...''                                                                                                              //
//                              .......'cdl;'..lOOko;c:..'ldook0KKKKK00KKKOd:;,'.',,'..',.                                                                                                             //
//                       ..    .'......':oc;'..lOOOxc,,'';okkxk0KKKKK00KK0xl:,'.';;,,'.',.                                                                                                             //
//                      .c,   .,'.......;cc;'..cOOOxc,,'':ddxkk0KKKKK00KKOo:;,',;:;;,''::.                                                                                                             //
//                     .;c;.  .,'....'''';;,...:kOkd:'''':dolxOKK00KK00KKkl;,,;;;::;,;ldd,                                                                                                             //
//                     .,::,. .,,'.'cllllodo:'.,dkkd;'.'':dolxKKKKKK00KK0dc;;;:::::;;ldddc...                                                                                                          //
//                     .':c:'..,,;cxOkkkxxxxxo,'ckko,....;odx0KKKKKKKKKKkl::::::::;;ldoodc';,                                                                                                          //
//                      .cll:'.';okkOOOOOkkkxl:,ckOo,..,;lk0KKKKKKKKKK0xl::::cccllclollol;;:'                                                                                                          //
//                  .   .::cl:'.:dkxxkOOOOOOOOkkk00kddxO0000000000KK0Okdl;;::cldxxdl::cc;,;,.                                                                                                          //
//                  ',. .,:;;::'.,:codddxkOOOOOOOOOOOOOOOOO0000000OOOkxdlc::coooooo:;,,,'',,.                                                                                                          //
//                   .....;;,'','..,cllccclodxkOOOOOOOOOOOOOOOkkxxddxxdlcccllcccll:,'..',;:c.                                                                                                          //
//                    .....''....,,;cc:,''''';:lddkOkkxdol::::::cclool:;;::;;;::c;'...,;;,,.                                                                                                           //
//                        .......',;;;;;,'..',;;::odoollcc;,,'',;:cool::,'..',;;,...''.....                                                                                                            //
//                               ..''...'',''...',:cc:;,'',,;;;,,,,;::;;,'..........   ..                                                                                                              //
//                                 ......  ........''..............',,...                                                                                                                              //
//                                  ...                         ......                                                                                                                                 //
//                                                                                                                                                                                                     //
//                                                                                                                                                                                                     //
//                                                                                                                                                                                                     //
//                                                                                                                                                                                                     //
//                                                                                                                                                                                                     //
//                                                                                                                                                                                                     //
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract HARMA is ERC721Creator {
    constructor() ERC721Creator("Harma", "HARMA") {}
}