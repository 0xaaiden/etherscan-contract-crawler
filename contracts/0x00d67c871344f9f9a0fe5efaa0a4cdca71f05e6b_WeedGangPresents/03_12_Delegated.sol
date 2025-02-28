// SPDX-License-Identifier: BSD-3-Clause

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Delegated is Ownable{
  mapping(address => bool) internal _delegates;

  constructor()
    Ownable(){
    setDelegate( owner(), true );
  }

  modifier onlyDelegates {
    require(_delegates[msg.sender], "Invalid delegate" );
    _;
  }

  //onlyOwner
  function isDelegate( address addr ) external view onlyOwner returns( bool ){
    return _delegates[addr];
  }

  function setDelegate( address addr, bool isDelegate_ ) public onlyOwner{
    _delegates[addr] = isDelegate_;
  }

  function transferOwnership(address newOwner) public virtual override onlyOwner {
    _delegates[newOwner] = true;
    super.transferOwnership( newOwner );
  }
}