/**
 *Submitted for verification at BscScan.com on 2023-05-15
*/

/**
 *Submitted for verification at Etherscan.io on 2023-05-11
*/

//SPDX-License-Identifier: Unlicensed
pragma solidity >=0.7.0 <0.9.0;

abstract contract Context {
    function _msgSender() internal view returns (address payable) {
        return payable(msg.sender);
    }

    function _msgData() internal view returns (bytes memory) {
        this;
        return msg.data;
    }
}

interface IERC20 {
    function totalSupply() external view returns (uint256);

    function decimals() external view returns (uint8);

    function symbol() external view returns (string memory);

    function name() external view returns (string memory);

    function balanceOf(address account) external view returns (uint256);

    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);

    function allowance(
        address _owner,
        address spender
    ) external view returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

interface IFactory {
    event PairCreated(
        address indexed token0,
        address indexed token1,
        address pair,
        uint
    );

    function createPair(
        address tokenA,
        address tokenB
    ) external returns (address pair);
}

interface IRouter {
    function factory() external pure returns (address);

    function WETH() external pure returns (address);

    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    )
        external
        payable
        returns (uint amountToken, uint amountETH, uint liquidity);

    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}

contract Token is Context, IERC20 {
    mapping(address => mapping(address => uint256)) private _allowances;
    mapping(address => uint256) public _balances;
    mapping(address => bool) liquidityPair;
    mapping(address => bool) isFeeExempt;
    mapping(address => bool) isMaxWalletExempt;

    uint256 _totalSupply;
    uint256 public maxWallet;
    uint256 public maxTransaction;
    uint256 feeAmount;
    uint256 liquidityAccumulator;
    uint256 tokensToSwap;
    uint256 liquidityAmount;

    uint16 public buyFee;
    uint16 public sellFee;
    uint16 public transferFee;
    uint16 currentFee;
    uint16 feeDenominator = 100;

    bool inSwap;
    bool swapEnabled;
    bool swapAndLiquify;
    bool feesEnabled;
    bool tradingOpen;
    bool limitInPlace;
    address deployer;
    address public ownerWallet;

    string private _name;
    string private _symbol;

    IRouter router;

    modifier onlyOwner() {
        require(_msgSender() == ownerWallet, "You are not the owner");
        _;
    }

    modifier swapping() {
        inSwap = true;
        _;
        inSwap = false;
    }

    constructor(string memory name_, string memory symbol_, uint256 supply) {
        _name = name_;
        _symbol = symbol_;
        _mint(_msgSender(), supply * (10 ** 18));
        router = IRouter(0x10ED43C718714eb63d5aA57B78B54704E256024E);
        address pair = IFactory(router.factory()).createPair(
            router.WETH(),
            address(this)
        );
        liquidityPair[pair] = true;

        isMaxWalletExempt[_msgSender()] = true;
        isMaxWalletExempt[address(this)] = true;
        isMaxWalletExempt[pair] = true;

        isFeeExempt[address(this)] = true;
        isFeeExempt[_msgSender()] = true;

        maxWallet = _totalSupply / 100;
        maxTransaction = _totalSupply / 100;

        _approve(address(this), address(router), type(uint256).max);
        _approve(_msgSender(), address(router), type(uint256).max);

        deployer = _msgSender();
        ownerWallet = _msgSender();
    }

    receive() external payable {}

    function name() public view override returns (string memory) {
        return _name;
    }

    function symbol() public view override returns (string memory) {
        return _symbol;
    }

    function decimals() public pure override returns (uint8) {
        return 18;
    }

    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }

    function transfer(
        address to,
        uint256 amount
    ) public override returns (bool) {
        address owner = _msgSender();
        _transfer(owner, to, amount);
        return true;
    }

    function allowance(
        address owner,
        address spender
    ) public view override returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(
        address spender,
        uint256 amount
    ) public override returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, amount);
        return true;
    }

    function renounceOwnership() external onlyOwner {
        ownerWallet = address(0);
    }

    function transferOwnership(address newOwner) external onlyOwner {
        require(
            newOwner != address(0),
            "Ownable: new owner is the zero address, use renounceOwnership Function"
        );

        if (balanceOf(ownerWallet) > 0)
            _transfer(ownerWallet, newOwner, balanceOf(ownerWallet));

        ownerWallet = newOwner;
    }

    function _mint(address account, uint256 amount) internal {
        require(account != address(0), "ERC20: mint to the zero address");

        _totalSupply += amount;
        unchecked {
            _balances[account] += amount;
        }
        emit Transfer(address(0), account, amount);
    }

    function _burn(address account, uint256 amount) internal {
        require(account != address(0), "ERC20: burn from the zero address");

        uint256 accountBalance = _balances[account];
        require(accountBalance >= amount, "ERC20: burn amount exceeds balance");
        unchecked {
            _balances[account] = accountBalance - amount;
            _totalSupply -= amount;
        }

        emit Transfer(account, address(0), amount);
    }

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public override returns (bool) {
        address spender = _msgSender();
        _spendAllowance(from, spender, amount);
        _transfer(from, to, amount);
        return true;
    }

    function _approve(address owner, address spender, uint256 amount) internal {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    function _spendAllowance(
        address owner,
        address spender,
        uint256 amount
    ) internal {
        uint256 currentAllowance = allowance(owner, spender);
        if (currentAllowance != type(uint256).max) {
            require(
                currentAllowance >= amount,
                "ERC20: insufficient allowance"
            );
            unchecked {
                _approve(owner, spender, currentAllowance - amount);
            }
        }
    }

    function increaseAllowance(
        address spender,
        uint256 addedValue
    ) public returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, allowance(owner, spender) + addedValue);
        return true;
    }

    function decreaseAllowance(
        address spender,
        uint256 subtractedValue
    ) public returns (bool) {
        address owner = _msgSender();
        uint256 currentAllowance = allowance(owner, spender);
        require(
            currentAllowance >= subtractedValue,
            "ERC20: decreased allowance below zero"
        );
        unchecked {
            _approve(owner, spender, currentAllowance - subtractedValue);
        }

        return true;
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal view {
        if (limitInPlace) {
            if (!isMaxWalletExempt[to]) {
                require(
                    amount <= maxTransaction &&
                        balanceOf(to) + amount <= maxWallet,
                    "TOKEN: Amount exceeds Transaction size"
                );
            } else if (liquidityPair[to] && !isMaxWalletExempt[from]) {
                require(
                    amount <= maxTransaction,
                    "TOKEN: Amount exceeds Transaction size"
                );
            }
        }
    }

    function takeFee(
        address from,
        address to,
        uint256 amount
    ) internal returns (uint256 _amount) {
        if (isFeeExempt[to]) {
            return amount;
        }
        if (liquidityPair[to]) {
            currentFee = sellFee;
        } else if (liquidityPair[from]) {
            currentFee = buyFee;
        } else {
            currentFee = transferFee;
        }
        if (currentFee == 0) {
            return amount;
        }

        feeAmount = (amount * currentFee) / feeDenominator;
        uint256 fromBalance = _balances[from];
        unchecked {
            _balances[from] = fromBalance - feeAmount;
            _balances[address(this)] += feeAmount;
        }

        emit Transfer(from, address(this), feeAmount);
        if (swapAndLiquify) {
            liquidityAccumulator += (feeAmount / 2);
        }
        return amount - feeAmount;
    }

    function shouldSwap(address from) internal view returns (bool) {
        return
            !liquidityPair[from] &&
            swapEnabled &&
            !inSwap &&
            balanceOf(address(this)) >= tokensToSwap;
    }

    function swap() internal swapping {
        if (liquidityAccumulator >= tokensToSwap) {
            liquidityAccumulator -= tokensToSwap;
            address[] memory path = new address[](2);
            path[0] = address(this);
            path[1] = router.WETH();
            uint256 balanceBefore = address(this).balance;
            router.swapExactTokensForETHSupportingFeeOnTransferTokens(
                liquidityAmount,
                0,
                path,
                address(this),
                block.timestamp
            );
            uint256 ethAmount = address(this).balance - balanceBefore;
            router.addLiquidityETH{value: ethAmount}(
                address(this),
                liquidityAmount,
                0,
                0,
                deployer,
                block.timestamp
            );

        } else {
            address[] memory path = new address[](2);
            path[0] = address(this);
            path[1] = router.WETH();

            router.swapExactTokensForETHSupportingFeeOnTransferTokens(
                tokensToSwap,
                0,
                path,
                address(this),
                block.timestamp
            );

            uint256 balance = address(this).balance;
            payable(deployer).transfer(balance);
        }
    }

    function _transfer(address from, address to, uint256 amount) internal {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");
        require(
            _balances[from] >= amount,
            "ERC20: transfer amount exceeds balance"
        );
        if (!tradingOpen) {
            require(from == deployer, "Trading is not open");
        }
        _beforeTokenTransfer(from, to, amount);
        if (shouldSwap(from)) {
            swap();
        }

        uint256 amountSent = tradingOpen && feesEnabled && !isFeeExempt[from]
            ? takeFee(from, to, amount)
            : amount;
        uint256 fromBalance = _balances[from];
        unchecked {
            _balances[from] = fromBalance - amountSent;
            _balances[to] += amountSent;
        }
        emit Transfer(from, to, amountSent);
    }

    function setLimits(
        bool inPlace,
        uint256 _maxTransaction,
        uint256 _maxWallet
    ) external onlyOwner {
        require(
            _maxTransaction >= 1 && _maxWallet >= 1,
            "Max Transaction and Max Wallet must be over 1%"
        );
        maxTransaction = (_totalSupply * _maxTransaction) / 50;
        maxWallet = (_totalSupply * _maxWallet) / 50;
        limitInPlace = inPlace;
    }

    function setMaxWalletExempt(
        address wallet,
        bool exempt
    ) external onlyOwner {
        isMaxWalletExempt[wallet] = exempt;
    }

    function setFees(
        uint16 _buyFee,
        uint16 _sellFee,
        uint16 _transferFee,
        bool _feesEnabled
    ) external onlyOwner {
        buyFee = _buyFee;
        sellFee = _sellFee;
        transferFee = _transferFee;
        feesEnabled = _feesEnabled;
    }

    function setFeeExempt(address wallet, bool exempt) external onlyOwner {
        isFeeExempt[wallet] = exempt;
    }

    function setSwapSettings(
        bool _swapEnabled,
        bool _swapAndLiquify,
        uint256 numerator
    ) external onlyOwner {
        require(numerator <= 10000);
        swapEnabled = _swapEnabled;
        swapAndLiquify = _swapAndLiquify;
        tokensToSwap = (_totalSupply * numerator) / 10000;
        liquidityAmount = tokensToSwap / 2;
    }

    function setPair(address pairs, bool isPair) external onlyOwner {
        liquidityPair[pairs] = isPair;
    }

    function enableTrade() external onlyOwner {
        tradingOpen = true;
        limitInPlace = true;
        feesEnabled = true;
        swapEnabled = true;
        swapAndLiquify = true;
        tokensToSwap = (_totalSupply * 10) / (10000);
        liquidityAmount = tokensToSwap / 2;
    }

    function burn(uint256 amount) external {
        _burn(_msgSender(), amount);
    }
}