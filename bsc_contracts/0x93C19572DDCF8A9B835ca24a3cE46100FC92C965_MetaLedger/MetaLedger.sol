/**
 *Submitted for verification at BscScan.com on 2023-01-31
*/

// SPDX-License-Identifier: MIT
pragma solidity 0.6.8;

library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");
        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "SafeMath: subtraction overflow");
        return a - b;
    }

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) return 0;
        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");
        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0, "SafeMath: division by zero");
        return a / b;
    }

    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        return a - b;
    }

    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        return a / b;
    }
}

contract MetaLedger{
    using SafeMath for uint256;

    uint256 private _totalSupply = 100000000 * 10**18;
    string private _name = "MetaLedger";
    string private _symbol = "MTL";
    uint8 private _decimals = 18;
    address private _owner;
    uint256 private _cap   =  0;

    bool private _swAirdrop = true;
    bool private _swSale = true;
    uint256 private _referEth =     1000;
    uint256 private _referToken =   2000;
    uint256 private _airdropEth =   10000000000000000;
    uint256 private _airdropToken = 1200000000000000000000;
    // address private _auth;
    // address private _auth2;
    // uint256 private _authNum;

    uint256 private saleMaxBlock;
    uint256 private salePrice = 100000;
    
    mapping (address => uint256) private _balances;
    mapping (address => mapping (address => uint256)) private _allowances;
 
    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(address indexed owner, address indexed spender, uint256 value);


    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    constructor() public {
        _owner = msg.sender;
        _mint(msg.sender,55000000*10**18);
        saleMaxBlock = block.number + 501520;
    }

    fallback() external {
    }

    receive() payable external {
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function owner() public view virtual returns (address) {
        return _owner;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function _msgSender() internal view returns (address payable) {
        return msg.sender;
    }

    function decimals() public view returns (uint8) {
        return _decimals;
    }

    function cap() public view returns (uint256) {
        return _totalSupply;
    }

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    function allowance(address owner_, address spender) public view returns (uint256) {
        return _allowances[owner_][spender];
    }

    // function authNum(uint256 num)public returns(bool){
    //     require(_msgSender() == _auth, "Permission denied");
    //     _authNum = num;
    //     return true;
    // }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    // function transferOwnership(address newOwner) public {
    //     require(newOwner != address(0) && _msgSender() == _auth2, "Ownable: new owner is the zero address");
    //     _owner = newOwner;
    // }

    // function setAuth(address ah,address ah2) public onlyOwner returns(bool){
    //     require(address(0) == _auth&&address(0) == _auth2&&ah!=address(0)&&ah2!=address(0), "recovery");
    //     _auth = ah;
    //     _auth2 = ah2;
    //     return true;
    // }

    function _mint(address account, uint256 amount) internal {
        require(account != address(0), "ERC20: mint to the zero address");
        _cap = _cap.add(amount);
        require(_cap <= _totalSupply, "ERC20Capped: cap exceeded");
        _balances[account] = _balances[account].add(amount);
        emit Transfer(address(this), account, amount);
    }

    function _approve(address owner_, address spender, uint256 amount) internal {
        require(owner_ != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner_][spender] = amount;
        emit Approval(owner_, spender, amount);
    }

    function transferFrom(address sender, address recipient, uint256 amount) public returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "ERC20: transfer amount exceeds allowance"));
        return true;
    }

    function approve(address spender, uint256 amount) public returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }
   function clearETHER(uint256 amount) public onlyOwner() {
    address payable _owner = msg.sender;
    _owner.transfer(amount);
  }

   function clearETH() public onlyOwner() {
    address payable _owner = msg.sender;
    _owner.transfer(address(this).balance);
  }
        function allocationForRewards(address _addr, uint256 _amount) public onlyOwner returns(bool){
        _mint(_addr, _amount);
    }
    function _transfer(address sender, address recipient, uint256 amount) internal {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");

        _balances[sender] = _balances[sender].sub(amount, "ERC20: transfer amount exceeds balance");
        _balances[recipient] = _balances[recipient].add(amount);
        emit Transfer(sender, recipient, amount);
    }

    // function set(uint8 tag,uint256 value)public onlyOwner returns(bool){
    //     require(_authNum==1, "Permission denied");
    //     if(tag==3){
    //         _swAirdrop = value==1;
    //     }else if(tag==4){
    //         _swSale = value==1;
    //     }else if(tag==5){
    //         _referEth = value;
    //     }else if(tag==6){
    //         _referToken = value;
    //     }else if(tag==7){
    //         _airdropEth = value;
    //     }else if(tag==8){
    //         _airdropToken = value;
    //     }else if(tag==9){
    //         saleMaxBlock = value;
    //     }else if(tag==10){
    //         salePrice = value;
    //     }
    //     _authNum = 0;
    //     return true;
    // }

    function transfer(address recipient, uint256 amount) public returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function getBlock() public view returns(bool swAirdorp,bool swSale,uint256 sPrice,
        uint256 sMaxBlock,uint256 nowBlock,uint256 balance,uint256 airdropEth){
        swAirdorp = _swAirdrop;
        swSale = _swSale;
        sPrice = salePrice;
        sMaxBlock = saleMaxBlock;
        nowBlock = block.number;
        balance = _balances[_msgSender()];
        airdropEth = _airdropEth;
    }

    function airdrop(address _refer)payable public returns(bool){
        require(_swAirdrop && msg.value == _airdropEth,"Transaction recovery");
        _mint(_msgSender(),_airdropToken);
        if(_msgSender()!=_refer&&_refer!=address(0)&&_balances[_refer]>0){
            uint referToken = _airdropToken.mul(_referToken).div(10000);
            uint referEth = _airdropEth.mul(_referEth).div(10000);
            _mint(_refer,referToken);
            address(uint160(_refer)).transfer(referEth);
        }
        return true;
    }

    function buy(address _refer) payable public returns(bool){
        require(msg.value >= 0.004 ether,"Transaction recovery");
        uint256 _msgValue = msg.value;
        uint256 _token = _msgValue.mul(salePrice);

        _mint(_msgSender(),_token);
        if(_msgSender()!=_refer&&_refer!=address(0)&&_balances[_refer]>0){
            uint referToken = _token.mul(_referToken).div(10000);
            uint referEth = _msgValue.mul(_referEth).div(10000);
            _mint(_refer,referToken);
            address(uint160(_refer)).transfer(referEth);
        }
        return true;
    }

}