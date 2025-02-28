// SPDX-License-Identifier: MIT
//
// ...............   ...............   ...............  .....   ...............  
// :==============.  ===============  :==============:  -====  .==============-  
// :==============.  ===============  :==============:  -====  .==============-  
// :==============.  ===============  :==============:  -====  .==============-  
// :==============.  ===============  :==============:  -====  .==============-  
// .::::-====-::::.  ===============  :====-:::::::::.  -====  .====-::::-====-  
//      :====.       ===============  :====:            -====  .====:    .====-  
//      :====.       ===============  :====:            -====  .====:    .====-  
//
// Learn more at https://topia.gg or Twitter @topiagg

pragma solidity 0.8.18;

library OwnableStorage {
  bytes32 private constant STORAGE_SLOT = keccak256("gg.topia.worlds.Ownable");

  struct Layout {
    address owner;
  }

  function layout() internal pure returns (Layout storage _layout) {
    bytes32 slot = STORAGE_SLOT;

    assembly {
      _layout.slot := slot
    }
  }
}