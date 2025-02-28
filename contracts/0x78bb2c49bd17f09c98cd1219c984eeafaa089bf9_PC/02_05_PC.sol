// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Perry Cooper / Like Ratio
/// @author: manifold.xyz

import "./ERC721Creator.sol";

///////////////////////////////////////////////////////////////////
//                                                               //
//                                                               //
//                                                               //
//                  @@@@@  @@@@@@@@@@@@@@@@@@@@@                 //
//              @@@@@  @@@@@@@@@@@@  &@@@@@@@@@@@@@              //
//           @@@@# @@@@@@@@@@@  @@@@@@@@@@@@@@@@@@@@@@@          //
//         @@@@ @@@@@@@@@@  @@@@@@@@@@@@@@@@@@@@@@@@@@@@         //
//       (@@  @@@@@@@@@  @@@@@@@@@@@@@@@@        (@@@   &@       //
//       @  @@@@@@@@  @@@@@@@@@@@@@@    @@@@@@@@@@@@@@@@@@       //
//      @ @@@@@@@@ *@@@@@@@@@@@@@   @@@@@@@@@@@@@@@@@@@@@@@      //
//       (@@@@@@  @@@@@@@@@@@@   @@@@@@@@@@@@@@@@@@@@@@@@@@@     //
//       @@@@@@ @@@@@@@@@@@@  (@@@@@@@@@@@@@@@@@@@@@@@@@@@@@     //
//     @ @@@@  @@@@@@@@@@@  &@@@@@@@@@@@@@@@@@@@@        @@@@    //
//     @ @@@ @@@@@@@@@@@   @@@@@@@@@@@@@@@@@@       @@@@   @@    //
//      @@@ @@@@@@@@@@@  @@@@@@@@@@@@@@@@@     %@@@@@@@@@@  @    //
//      @@@ @@@@@@@@@  @@@@@@@@@@@@@@@@@    @@@@@@@@@@@@@   @    //
//       @@ /@@@@@@( @@@@@@@@@@@@@@@@#   @@@@@@@@@@@@@@@@@@      //
//        %@ @@@@@  @@@@@@@@@@@@@@@   [email protected]@@@@@@@@@@@@@@@@@@       //
//          @@@@@   @@@@@@@@@@@@@@   @@@@@   @@@@@@@@@@@ @       //
//         @@@             #@@@@@                     @@@@       //
//        @@@                @@@                      @@  *      //
//       @@@@@               @@  @@@@@               @@@@@@@     //
//       @@@@@             @@@ @@   @@@             @@@@@@@      //
//        @@@@@@ @@@@@@@@@@@ &@     @@@@@@@@@     @@@@@@@@       //
//          @@@@ @@@@@@@@@@@ @       @@@@@@@@@@@@@@@@@@@         //
//                @@@@@@@@@.          @@@@@@@@@@@@@@@            //
//              @@@@  @@@@@ .    @    @@@@@@@@     @@            //
//              @@@@@@ @@@  @@@@@@@@@@@@@@@@@@@    @@            //
//              @@@@@@ @@ @@@@@@@@@@@@@@@@@@@ @@@@@@@            //
//              %@  @@@  *@@@@@@@@@@@@@@@@@  @@@@@@@@            //
//                @@@@@@@ &@@@@@@@@@@@@@@  @@@@@@@@              //
//                 @@@@@@@ @       [email protected]@@@@@@@@@@@@@               //
//                   @@@@ @@@@@@@@@@@@@@@@@@@@@@@                //
//                    @  @@@@@@@@@@@@@@@@@@@@@@                  //
//                      @@@@@@@@@@@@@@@@@@@@@                    //
//                         @@@@@@@@@@@@@@@                       //
//                                                               //
//                                                               //
//                                                               //
///////////////////////////////////////////////////////////////////


contract PC is ERC721Creator {
    constructor() ERC721Creator("Perry Cooper / Like Ratio", "PC") {}
}