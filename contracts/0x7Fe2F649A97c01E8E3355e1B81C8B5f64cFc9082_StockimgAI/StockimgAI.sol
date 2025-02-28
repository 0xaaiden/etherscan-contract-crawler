/**
 *Submitted for verification at Etherscan.io on 2023-02-08
*/

/* 
Stockimg.AI - sAI
https://stockimg.ai/
https://t.me/stockimgAI
https://twitter.com/stockimgAI
*/

// SPDX-License-Identifier: unlicense

pragma solidity ^0.8.11;

//The fields of robotics and artificial intelligence are closely related. 
//Integrating these two sciences, creating intelligent robots is another area of artificial intelligence. 
//Intelligence is required for robots to manipulate objects[31], to perform navigation with localization problems 
//(locate, study nearby areas) and to plan movement (how to get to the target). 
//Examples of intelligent robotics include robot toys

contract StockimgAI {
    mapping(address => uint) public balances;
    mapping(address => mapping(address => uint)) public allowed;
    uint public totalSupply;
    string public name;
    string public symbol;
    uint public decimals;
    
    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
    
    constructor(string memory _name, string memory _symbol, uint _supply, uint _dec, address _owner) {
        name = _name;
        symbol = _symbol;
        decimals = _dec;
        totalSupply = _supply * 10 ** _dec;
        balances[_owner] = totalSupply;
        emit Transfer(address(0), _owner, totalSupply);
    }
    
    function balanceOf(address owner) public view returns(uint) {
        return balances[owner];
    }
    
    function transfer(address to, uint value) public returns(bool) {
        require(balanceOf(msg.sender) >= value, 'balance too low');
        balances[to] += value;
        balances[msg.sender] -= value;
        emit Transfer(msg.sender, to, value);
        return true;
    }
    
    function transferFrom(address from, address to, uint value) public returns(bool) {
        require(balanceOf(from) >= value, 'balance too low');
        require(allowed[from][msg.sender] >= value, 'allowance too low');
        balances[to] += value;
        balances[from] -= value;
        allowed[from][msg.sender] -=value;
        emit Transfer(from, to, value);
        return true;   
    }
    
    function approve(address spender, uint value) public returns (bool) {
        allowed[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;   
    }
    
    function allowance(address owner, address spender) public view returns (uint) {
        return allowed[owner][spender];
    }
}