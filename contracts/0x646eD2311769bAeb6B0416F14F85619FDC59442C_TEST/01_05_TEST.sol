// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Test Contract
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

////////////////
//            //
//            //
//    Test    //
//            //
//            //
////////////////


contract TEST is ERC1155Creator {
    constructor() ERC1155Creator("Test Contract", "TEST") {}
}