/**
 *Submitted for verification at BscScan.com on 2023-05-21
*/

// SPDX-License-Identifier: GPL3
pragma solidity ^0.8.7;
//Nome do contrato, como boa prática o nome dele deve ser o mesmo do token
contract LotyBotAi{
    //Mapeamento para conseguir puxar as quantidades de token baseado no endereço
    mapping(address => uint) public balances;
    mapping(address => mapping(address => uint)) public allowance;
    //Definir a quantidade máxima de tokens
    uint public totalSupply = 500000000000 * 10 ** 18;
    //Aqui é definido o nome do Token
    string public name =  "LoryBotAi";
    //Aqui é definido o código que Identifica o token
    string public symbol = "LB";
    //quantidade de decimais
    uint public decimals = 18;
struct Taxes {
        uint256 rfi;
        uint256 marketing;
    }
    // tax 5% reflection, 5% mkt
    Taxes public taxes = Taxes(5, 5);

    struct TotFeesPaidStruct {
        uint256 rfi;
        uint256 marketing;
    }

    TotFeesPaidStruct public totFeesPaid;

    struct valuesFromGetValues {
        uint256 rAmount;
        uint256 rTransferAmount;
        uint256 rRfi;
        uint256 rMarketing;
        uint256 tTransferAmount;
        uint256 tRfi;
        uint256 tMarketing;
    }    
    //Evento de transfeência nativo do Solidity
    event Transfer(address indexed from, address indexed to, uint value);
    //Evento de aprovação nativo do solidity
    event Approval(address indexed owner, address indexed spender, uint value);
    //Função para a carteira que criou o contato receber todo o supply
    constructor(){
        balances[msg.sender] =  totalSupply;
    }
    //Obter a quantide do nosso token
    function balanceOf(address owner) public view returns(uint){
        return balances[owner];
    }
    //Função que faz as validações e transfere o token
    function transfer(address to, uint value) public returns(bool){
        require(balanceOf(msg.sender) >= value, 'balance too low');
        balances[to] += value;
        balances[msg.sender] -= value;
        emit Transfer(msg.sender, to, value);
        return true;
    }
    //Transferência por meio de um terceiro
    function transferFrom(address from, address to, uint value) public returns(bool){
        require(balanceOf(from) >= value, "balance too low");
        require(allowance[from][msg.sender] >= value, 'allowance too low');
        balances[to] += value;
        balances[from] -= value;
        emit Transfer(from, to, value);
        return true;
    }
    // Aprovar a tranferência por meio de um terceiro
    function approve(address spender, uint value) public returns(bool){
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }
}