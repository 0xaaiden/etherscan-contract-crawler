/**
 *Submitted for verification at BscScan.com on 2023-05-08
*/

pragma solidity ^0.8.0;

interface IERC20 {
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address to, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
}

interface IERC20Metadata is IERC20 {
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
}

abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}

contract ERC20 is Context, IERC20, IERC20Metadata {
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;
    uint256 private _totalSupply;
    string private _name;
    string private _symbol;
    uint8 private _decimals;

    uint256 public taxFee;
    address public owner;

    constructor(string memory name_, string memory symbol_, uint8 decimals_, uint256 taxFee_) {
        _name = name_;
        _symbol = symbol_;
        _decimals = decimals_;
        taxFee = taxFee_;
        owner = _msgSender();

        _totalSupply = 7000000000000000 * (10 ** uint256(decimals_));

        // Distribute the initial supply to the contract's owner
        _balances[owner] = _totalSupply;

        // Emit a Transfer event for the initial distribution
        emit Transfer(address(0), owner, _totalSupply);
    }

    function name() public view virtual override returns (string memory) {
        return _name;
    }

    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }

    function decimals() public view virtual override returns (uint8) {
        return _decimals;
    }

    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view virtual override returns (uint256) {
        return _balances[account];
    }

    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        address sender = _msgSender();
        uint256 toAmount = amount;
        uint256 feeAmount = 0;
        if (taxFee > 0 && sender != owner && to != owner) {
            feeAmount = amount * taxFee / 100;
            toAmount = amount - feeAmount;
            _transfer(sender, owner, feeAmount);
        }
        _transfer(sender, to, toAmount);
        return true;
    }

    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        address sender = _msgSender();
        _approve(sender, spender, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public virtual override returns (bool) {
    _spendAllowance(sender, _msgSender(), amount);
    uint256 toAmount = amount;
    uint256 feeAmount = 0;

    if (taxFee > 0 && sender != owner && recipient != owner) {
        feeAmount = amount * taxFee / 100;
        toAmount = amount - feeAmount;
        _transfer(sender, owner, feeAmount);
    }

    _transfer(sender, recipient, toAmount);
    return true;
}


function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
    address sender = _msgSender();
    _approve(sender, spender, _allowances[sender][spender] + addedValue);
    return true;
}

function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
    address sender = _msgSender();
    uint256 currentAllowance = _allowances[sender][spender];
    require(currentAllowance >= subtractedValue, "ERC20: decreased allowance below zero");
    unchecked {
        _approve(sender, spender, currentAllowance - subtractedValue);
    }

    return true;
}

function _transfer(address sender, address recipient, uint256 amount) internal virtual {
    require(sender != address(0), "ERC20: transfer from the zero address");
    require(recipient != address(0), "ERC20: transfer to the zero address");

    _beforeTokenTransfer(sender, recipient, amount);

    uint256 senderBalance = _balances[sender];
    require(senderBalance >= amount, "ERC20: transfer amount exceeds balance");
    unchecked {
        _balances[sender] = senderBalance - amount;
        _balances[recipient] += amount;
    }

    emit Transfer(sender, recipient, amount);

    _afterTokenTransfer(sender, recipient, amount);
}

function _mint(address account, uint256 amount) internal virtual {
    require(account != address(0), "ERC20: mint to the zero address");

    _beforeTokenTransfer(address(0), account, amount);

    _totalSupply += amount;
    _balances[account] += amount;
    emit Transfer(address(0), account, amount);

    _afterTokenTransfer(address(0), account, amount);
}

function _burn(address account, uint256 amount) internal virtual {
    require(account != address(0), "ERC20: burn from the zero address");

    _beforeTokenTransfer(account, address(0), amount);

    uint256 accountBalance = _balances[account];
    require(accountBalance >= amount, "ERC20: burn amount exceeds balance");
    unchecked {
        _balances[account] = accountBalance - amount;
        _totalSupply -= amount;
    }

    emit Transfer(account, address(0), amount);

    _afterTokenTransfer(account, address(0), amount);
}

function _approve(address owner, address spender, uint256 amount) internal virtual {
    require(owner != address(0), "ERC20: approve from the zero address");
    require(spender != address(0), "ERC20: approve to the zero address");

    _allowances[owner][spender] = amount;
    emit Approval(owner, spender, amount);
}

function _spendAllowance(address owner, address spender, uint256 amount) internal virtual {
    uint256 currentAllowance = allowance(owner, spender);
    require(currentAllowance >= amount, "ERC20: transfer amount exceeds allowance");
    unchecked {
        _approve(owner, spender, currentAllowance - amount);
    }
}

function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual { }

function _afterTokenTransfer(address from, address to, uint256 amount) internal virtual { }

}