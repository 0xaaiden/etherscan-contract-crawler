// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Convergence
/// @author: manifold.xyz

import "./ERC721Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                                               //
//                                                                                                                                                               //
//                                                                                                                                                               //
//                                                                                                                                                               //
//                              ██████╗ ██████╗ ███╗   ██╗██╗   ██╗███████╗██████╗  ██████╗ ███████╗███╗   ██╗ ██████╗███████╗                                   //
//                             ██╔════╝██╔═══██╗████╗  ██║██║   ██║██╔════╝██╔══██╗██╔════╝ ██╔════╝████╗  ██║██╔════╝██╔════╝                                   //
//                             ██║     ██║   ██║██╔██╗ ██║██║   ██║█████╗  ██████╔╝██║  ███╗█████╗  ██╔██╗ ██║██║     █████╗                                     //
//                             ██║     ██║   ██║██║╚██╗██║╚██╗ ██╔╝██╔══╝  ██╔══██╗██║   ██║██╔══╝  ██║╚██╗██║██║     ██╔══╝                                     //
//                             ╚██████╗╚██████╔╝██║ ╚████║ ╚████╔╝ ███████╗██║  ██║╚██████╔╝███████╗██║ ╚████║╚██████╗███████╗                                   //
//                              ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝  ╚═══╝  ╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═══╝ ╚═════╝╚══════╝                                   //
//                                                                                                                                                               //
//                                                         ╔═╗┬─┐┌┬┐  ┌┐ ┬ ┬  ╔═╗┬ ┬┬─┐┌─┐┌┐┌┬┌─┐┌┬┐                                                             //
//                                                         ╠═╣├┬┘ │   ├┴┐└┬┘  ╠═╣│ │├┬┘├─┤││││└─┐│││                                                             //
//                                                         ╩ ╩┴└─ ┴   └─┘ ┴   ╩ ╩└─┘┴└─┴ ┴┘└┘┴└─┘┴ ┴                                                             //
//                                                                                                                                                               //
//         .  ........       ..               ......    .. .......     ...              ......      .......      .                       ...   ....... .    .    //
//            .... ..       ..               .......   .. .......     ...   .         .......     .......      .                       ...        ...            //
//         .  ....   .       ...              ......   .  ...  ..     ...   ..        ......     ........     ..                     ...          .              //
//          .  ....  ..       ..              .......     .......     ...            .......   .........     ..                    ...           ..  .           //
//              ..... ..      ....            .......  ..  ......     ...           ........   ........      .                    ...           .. ..            //
//                ....  .       ...            ..........  ......     ....          .......   .........     ..                  ....           ....              //
//                .....  .      ...            ...................    ....         ........  .........     ..                  ....          ....                //
//             ..  .....  ..     ...            ..........  ......    ....         ........ .. ......     ...                ....  ...    ......                 //
//              ..  ...... .     ....           ........... ......   .....         .......... ... ...    ...                ....  ....  ......                   //
//               ..   .....      .....          ................ .  ......         .........  ... ..    ....            .......       .......                    //
//                ..   .....      .....          ................  .......        .......... .......   ....  ...       .......      .......        .             //
//                  .........      .....         ................  .......       ........... ......    ...           .......      ........       ..              //
//                  ..........      .....        .........................      ...................   ....         ........     ........       ..                //
//                   ..........      .....        ........................      ..................   .....       .........    ........        ..                 //
//                    ..........  .........        ...........'...........     ..............'...   .....       ........    .........      ..                    //
//                      ...................     . ..... ..................   ...............'..  .......       .........  .........      ..                      //
//                       ...................    ........ .................   ..................  ......       .........  .........     ..                        //
//                        ...................    .........................   .........................       ...................     ...                         //
//                         ............ ......   ..   ....................  ..............'..........       .......... .......     ...                           //
//    .                     ............ ......   ..  ....................  .........................     ...................    ....                     ..     //
//    ...                     ..................   ..  ...... ............  ........................     ..................     ....                   .....     //
//    .....                    .   ..............  ... ...................  .......................   ....................   .......    .           ......       //
//    .......      .                ..............  ......................  .......................  ....................  ...........          .......    .     //
//    .........      .               .............   .. ..................  ...................... ...............'....   .....  .....     ..............        //
//    .    ......      ..             .............. ...................... ..................... ...............'.... .......          ..........  .....  .     //
//    .      ......     ..            ..................................... .....     ..........  ............''...........        ............     ........     //
//    ......  .......     ..           ........................................       ..         ............''..........        ...........     ...........     //
//    .......  ........     ..      ..  .............. ...............   .....  ......               ..................       ............    ............       //
//     .....  ...........    ...    ...  .............. .............  ............              .....................      ..........................           //
//       ...................  ....   .....................................                ............     ..........    ...........................             //
//         ....... ...........  .......... ............... .......   .                 .................       ..................................       ....     //
//           ......... ........   ........................ .....                  ...............  .........      ..........................     .  ...          //
//            ........  .........   ................................         .. .......''.....  .........................................     .....              //
//              .................... ...............................   ................'.....   ...............................''.....    ......                 //
//                ...........................  ....................................................................  ......''......  ..........                  //
//                  ............................................................................................ .............................. ...              //
//             ..... ................''...................'...  .............',,,,'..........................  ................................                  //
//    ....      .....  ...............'''...............','.. ...............';;:c,.'..'''''''........  ............................ ....          .........     //
//      .............. .................''.............''...............''..'''.,;,'...........................................     ........................     //
//    .      .............. .........................','.  ..............'....................................     .........................................     //
//    ....       .........      ......... ..........,,..  ...........................,,,,,'..................        .......................................     //
//    .........     .........     .................,,..  ...'..............   ...',;::;'........................      ...     ..............................     //
//    ...............  ...........................',.    ..',..  ..............,::::;'...........................      ...    ..............................     //
//    ..........................................''...   ..,,'. ..............';;;;;'...................'............      ..   .............................     //
//    ...................................',,,..';'.    ..,,,.. .............';;,'..........................'''......         .  ....................             //
//    ...................'...... ......',';;;:::,.   ...;;;,'. ............,;,,,',,,'''....''''''''........;;'.......      ..         ......  ...........  .     //
//    ......................''.. ........';;,.''..  . .';;;:'.......'.....,;,,;;;;;,,,;,,,;;;;;,,,,;;;,'....'...........          ..     ..........              //
//    .........................   .........''....  ....';:::'.......'....';;,;,''',;;;;,,;:;;,,,''....',;'...............          ....   ....                   //
//        ....................    ..'.......''..  .....',;::,............,;,,;;,;::;'.',;;;;;,;;;'.......''...............          ... ...........              //
//                ...........   .  .........',..   ....',:::;...........,;,',:c:;,'....''....',;:;,............'...........         ....   ...                   //
//                    .......  ........''''.....     ..',::;,'....'''.',;;,'';:;..............';::;;'.....................           ....  ..........            //
//    ........           ...   ..................     ..';:,''...';;..,;:;'..;:,........'',,'..';;;;,,................  .....           .  .................     //
//    ......................    .................     ...';;'','.'::,.';:,'..';,........',;;,.';:;,'',,...............   ....       ..    ..................     //
//    ..  ..................    .... ............   ......,:,',,',;;,..::,...............';;;;;;:,...,;.................            ...    .................     //
//        ...   ............    .................   .......;;,,,,,;;'..;c;'...........'''''',',;,....,;..................   .        ...   .................     //
//    ......................    .......   ........  ........;;',,',,..';::,..................','.....'...,'......  .......             ..   ................     //
//    ...............'.......    ......  .......... .........;;,,,',;,,::::'................''..........';'................         .   ..  .. .............     //
//    .......................    .....    ..... ..............;:,;;,',:cc:::,...............''................. ...........        ...   .........       ...     //
//    .........................   .....   ..... ... ...........,;;;;,'',;:;;c;.'''............................   ..........         ..     ............          //
//    .......................  .    ...     .... ...............',;,,''.'''':;';;,'..........................    .. ......          ..     .................     //
//    .......................      ....      ...  ................';;,,'.....'',,,'.....   ...............      ... ......           ..   ..................     //
//    ........................       ..       ... ......',.........',;;,'''......... .....................    ..... ...               .   ..................     //
//    ........    .........           ..      ......................,,,;;,''............... ...........     ...........        .        ....................     //
//                      ........                ..  ................',,,;;;,'....'.....................  ..............       ..        ....................     //
//               ................                    ............''....',;;:;;,''''..............,,'..... .  ..... ...      ..         .....................     //
//          .......................                   .........'',,'......',:cc::::;,,'''''......';:;,''... ...... .     ......       ......................     //
//    .............................  .....             ..........',;::,,'.....',:c:;;;;::;;;;;::,.':;'.','.......       ....         .......................     //
//    .............................      .....           ..........,::;,,,''....,;;;;;;::;;;,,;:::'','..''......... ........   .   ..   ....................     //
//        ...........................     .....           ...........',;;;,,.....''',;::::;;,,,..','',....................        ......  ..................     //
//      ..   ........'............................         ............',,;;,''',;;'';cc;,;:::;'...'''...'''..... .......      ...........   ............        //
//    ..............................................             .....',,'',;;:::cc:;;;;'';;,;c,.''............. ......       ..............    ............     //
//    ......................................                  ..    ...'''..''''''''.........':;,:;'........... .....      ..................      .........     //
//    ................................ ........   .   ....    ... ............................,,,,,'.....'...  .....      ....................        ......     //
//    ............................   ...............   ........   ............................''.',........           .........................         ....     //
//    .........................    .................  ...      ...........................................            ...........'...............          .     //
//    ......................     ........................   .......... .................. ..............       ......  ...........................               //
//    ..............   .      ...................  ........................ ..........................  ..............  ............'...............             //
//    ..........            ................... ....  ....  ..............  .........'...................''...........    ......  ....................           //
//    .....              ....................         ...  ............... .........''.........   ........'...........     ......  .....................         //
//    .                ..................            ...  ..........................''.........   .........'...........      ..... ......... .............       //
//                 ......................           ..  ....................... ....'.........     ........'...........      .....   ........  ............      //
//                ........................        ...  ................ ....... ...............    .... ....'...........       ....    ....... ..  .........     //
//            ...........................        ..   ........................  ................   ....  ................       .....    .........   .......     //
//         ...........................          ..   ...............  ........  ..................  .... .................       .....    ..........   .....     //
//       .......        .............          ..   ...............   ... ...   ...............   ......   ...... ........         ....     .........    ...     //
//     ......          ............           .     ..............   ..   ...   ...............   ......   ................     ........     .........     .     //
//    .....       ..............                  ...............         ...  ........ .......   .......   ....... ........    ....  ...     ........           //
//    ..        ...............                  ..............           ..   .......  ......  .........   ........ .......    ...    ...      ........         //
//            .  ......  ....                   ..............            .   ........  ......   ...  ...    .......  .......            ...     ........        //
//         ..........  ...                     .....  .......             .   .......   .....     .    ...   .......   ......             ...     ........       //
//       ... ......   ..                      .....  .......             ..   ......... .....     .     ..    ......    ......              ..      ........     //
//     ...  .....   ..                       ...............                                                                                                     //
//                                                                                                                                                               //
//                                                                                                                                                               //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract CVN is ERC721Creator {
    constructor() ERC721Creator("Convergence", "CVN") {}
}