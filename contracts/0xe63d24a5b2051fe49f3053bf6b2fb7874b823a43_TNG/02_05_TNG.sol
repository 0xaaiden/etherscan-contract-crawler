// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Tango NFT
/// @author: manifold.xyz

import "./ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                        //
//                                                                                        //
//                                                                                        //
//           &&              #&          %&&&&&&&&&%      &&&&&&&&&&      &&&&&&&&&&      //
//        @&    &&%       @&#   &&@      %@&&   &&@%      @&&   #&@&      @&&    &@&      //
//       &&      &&      &&      &&      %&,     ,&&      &&      &&      &&      &&      //
//       &@      &@      &@      &@      %@,     ,@&      @&      @&      @&      @&      //
//       &&      &&      &&      &&      %&,     ,&&      &&      &&      &&      &&      //
//       &@      &@      &@      &@      %@,     ,@&      @&      @&      @&      @&      //
//       &&      &&      &&      &&      %&,     ,&&      &&      &&      &&      &&      //
//       @@      @@      @@      @@      %@,     ,@&      @@      @@      @@      @@      //
//       &&      &&      &&      &&      %&,     ,&&      &&      &&      &&      &&      //
//       &@      &@      &@      &@      %@,     ,@&      @&      @&      @&      @&      //
//       &&      &&      &&      &&      %&,     ,&&      &&      &&      &&      &&      //
//       &@      &@      &@      &@      %@,     ,@&      @&      @&      @&      @&      //
//       &&      &&      &&      &&      %&,     ,&&      &&      &&      &&      &&      //
//       &@      &@      &@      &@      %@,     ,@&      @&      @&      @&      @&      //
//       &&      &&      &&      &&      %&,     ,&&      &&      &&      &&      &&      //
//       @@      @@      @@      @@      %@,     ,@&      @@      @@      @@      @@      //
//       &&      &&      &&      &&      %&,     ,&&      &&      &&      &&      &&      //
//       &@      &@      &@      &@      %@,     ,@&      @&      @&      @&      @&      //
//       &&      &&      &&      &&      %&,     ,&&      &&      &&      &&      &&      //
//       &@      &@      &@      #@%     &@      ,@&     %@&      @&      @&      @&      //
//       &&       .&&&@&&&         &&&@&&&       ,&&&&@&&&&&      &&&&@&&&&&      &&      //
//                                                                                        //
//                                                                                        //
////////////////////////////////////////////////////////////////////////////////////////////


contract TNG is ERC721Creator {
    constructor() ERC721Creator("Tango NFT", "TNG") {}
}