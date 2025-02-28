/**
 *Submitted for verification at BscScan.com on 2023-03-19
*/

// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

interface IERC20 {
    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);

    function allowance(
        address owner,
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
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    constructor() {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    function owner() public view returns (address) {
        return _owner;
    }

    modifier onlyOwner() {
        require(_owner == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(
            newOwner != address(0),
            "Ownable: new owner is the zero address"
        );
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

contract ERC20 is Context, IERC20, IERC20Metadata {
    mapping(address => uint256) private _balances;

    mapping(address => mapping(address => uint256)) private _allowances;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;

    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    function name() public view virtual override returns (string memory) {
        return _name;
    }

    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }

    function decimals() public view virtual override returns (uint8) {
        return 18;
    }

    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(
        address account
    ) public view virtual override returns (uint256) {
        return _balances[account];
    }

    function transfer(
        address recipient,
        uint256 amount
    ) public virtual override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function allowance(
        address owner,
        address spender
    ) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(
        address spender,
        uint256 amount
    ) public virtual override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public virtual override returns (bool) {
        uint256 currentAllowance = _allowances[sender][_msgSender()];
        if (currentAllowance != type(uint256).max) {
            require(
                currentAllowance >= amount,
                "ERC20: transfer amount exceeds allowance"
            );
            unchecked {
                _approve(sender, _msgSender(), currentAllowance - amount);
            }
        }

        _transfer(sender, recipient, amount);

        return true;
    }

    function increaseAllowance(
        address spender,
        uint256 addedValue
    ) public virtual returns (bool) {
        _approve(
            _msgSender(),
            spender,
            _allowances[_msgSender()][spender] + addedValue
        );
        return true;
    }

    function decreaseAllowance(
        address spender,
        uint256 subtractedValue
    ) public virtual returns (bool) {
        uint256 currentAllowance = _allowances[_msgSender()][spender];
        require(
            currentAllowance >= subtractedValue,
            "ERC20: decreased allowance below zero"
        );
        unchecked {
            _approve(_msgSender(), spender, currentAllowance - subtractedValue);
        }

        return true;
    }

    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) internal virtual {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");

        _beforeTokenTransfer(sender, recipient, amount);

        uint256 senderBalance = _balances[sender];
        require(
            senderBalance >= amount,
            "ERC20: transfer amount exceeds balance"
        );
        unchecked {
            _balances[sender] = senderBalance - amount;
        }
        _balances[recipient] += amount;

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
        }
        _totalSupply -= amount;

        emit Transfer(account, address(0), amount);

        _afterTokenTransfer(account, address(0), amount);
    }

    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {}

    function _afterTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {}
}

interface IUniswapV2Factory {
    event PairCreated(
        address indexed token0,
        address indexed token1,
        address pair,
        uint
    );

    function feeTo() external view returns (address);

    function feeToSetter() external view returns (address);

    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);

    function allPairs(uint) external view returns (address pair);

    function allPairsLength() external view returns (uint);

    function createPair(
        address tokenA,
        address tokenB
    ) external returns (address pair);

    function setFeeTo(address) external;

    function setFeeToSetter(address) external;
}

interface IUniswapV2Pair {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external pure returns (string memory);

    function symbol() external pure returns (string memory);

    function decimals() external pure returns (uint8);

    function totalSupply() external view returns (uint);

    function balanceOf(address owner) external view returns (uint);

    function allowance(
        address owner,
        address spender
    ) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);

    function transfer(address to, uint value) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint value
    ) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);

    function PERMIT_TYPEHASH() external pure returns (bytes32);

    function nonces(address owner) external view returns (uint);

    function permit(
        address owner,
        address spender,
        uint value,
        uint deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    event Mint(address indexed sender, uint amount0, uint amount1);
    event Burn(
        address indexed sender,
        uint amount0,
        uint amount1,
        address indexed to
    );
    event Swap(
        address indexed sender,
        uint amount0In,
        uint amount1In,
        uint amount0Out,
        uint amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint);

    function factory() external view returns (address);

    function token0() external view returns (address);

    function token1() external view returns (address);

    function getReserves()
        external
        view
        returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);

    function price0CumulativeLast() external view returns (uint);

    function price1CumulativeLast() external view returns (uint);

    function kLast() external view returns (uint);

    function mint(address to) external returns (uint liquidity);

    function burn(address to) external returns (uint amount0, uint amount1);

    function swap(
        uint amount0Out,
        uint amount1Out,
        address to,
        bytes calldata data
    ) external;

    function skim(address to) external;

    function sync() external;

    function initialize(address, address) external;
}

interface IUniswapV2Router01 {
    function factory() external pure returns (address);

    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);

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

    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);

    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);

    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint amountA, uint amountB);

    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint amountToken, uint amountETH);

    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);

    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);

    function swapExactETHForTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable returns (uint[] memory amounts);

    function swapTokensForExactETH(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);

    function swapExactTokensForETH(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);

    function swapETHForExactTokens(
        uint amountOut,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable returns (uint[] memory amounts);

    function quote(
        uint amountA,
        uint reserveA,
        uint reserveB
    ) external pure returns (uint amountB);

    function getAmountOut(
        uint amountIn,
        uint reserveIn,
        uint reserveOut
    ) external pure returns (uint amountOut);

    function getAmountIn(
        uint amountOut,
        uint reserveIn,
        uint reserveOut
    ) external pure returns (uint amountIn);

    function getAmountsOut(
        uint amountIn,
        address[] calldata path
    ) external view returns (uint[] memory amounts);

    function getAmountsIn(
        uint amountOut,
        address[] calldata path
    ) external view returns (uint[] memory amounts);
}

interface IUniswapV2Router02 is IUniswapV2Router01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountETH);

    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;

    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;

    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}

contract Testing is ERC20, Ownable {
    uint256 public marketingFeeOnBuy = 0;
    uint256 public marketingFeeOnSell = 1;

    address public marketingWallet = 0x13C92077772Ea92c67E45e7d22F63593CF9f8471;

    IUniswapV2Router02 public uniswapV2Router;
    address public uniswapV2Pair;

    address private DEAD = 0x000000000000000000000000000000000000dEaD;

    uint256 public blocktime = 3;
    uint256 public endBlock;

    uint256 public walletLimit = 100;
    uint256 public txLimit = 10;
    uint256 public denominator = 10_000;

    bool private swapping;
    uint256 public swapTokensAtAmount;

    bool public tradingStarted;

    mapping(address => bool) private _isExcludedFromFees;
    mapping(address => bool) private _isBotAddress;
    mapping(address => bool) private _isExcludeFromWalletLimit;
    mapping(address => bool) private _isExcludeFromTxLimit;

    event ExcludeFromFees(address indexed account, bool isExcluded);
    event FeesUpdated(uint256 marketingFeeOnBuy, uint256 marketingFeeOnSell);
    event MarketingWalletChanged(address indexed newWallet);
    event SwapAndSendFee(uint256 tokensSwapped);
    event SwapTokensAtAmountChanged(uint256 newAmount);
    event StartTrading();
    event ChangeBlocktime(uint256 newBlocktime);
    event BotAddressUpdated(address indexed account, bool isBot);
    event UpdateWalletLimit(uint256 amount);
    event UpdateTxLimit(uint256 amount);
    event ExcludeWalletLimit(address indexed account, bool isBot);
    event ExcludeTxLimit(address indexed account, bool isBot);

    constructor() ERC20("Tester", "Tester") {
        IUniswapV2Router02 _uniswapV2Router = IUniswapV2Router02(
            getRouterAddress()
        );
        address _uniswapV2Pair = IUniswapV2Factory(_uniswapV2Router.factory())
            .createPair(address(this), getUSDTAddress());

        uniswapV2Router = _uniswapV2Router;
        uniswapV2Pair = _uniswapV2Pair;

        _approve(address(this), address(uniswapV2Router), type(uint256).max);

        _isExcludedFromFees[owner()] = true;
        _isExcludedFromFees[DEAD] = true;
        _isExcludedFromFees[address(this)] = true;
        _isExcludedFromFees[marketingWallet] = true;

        _isExcludeFromWalletLimit[owner()] = true;
        _isExcludeFromWalletLimit[DEAD] = true;
        _isExcludeFromWalletLimit[address(this)] = true;
        _isExcludeFromWalletLimit[marketingWallet] = true;
        _isExcludeFromWalletLimit[uniswapV2Pair] = true;

        _isExcludeFromTxLimit[owner()] = true;
        _isExcludeFromTxLimit[DEAD] = true;
        _isExcludeFromTxLimit[address(this)] = true;
        _isExcludeFromTxLimit[marketingWallet] = true;

        _mint(owner(), 10_000_000 * (10 ** 18));
        swapTokensAtAmount = totalSupply() / 5000;
    }

    receive() external payable {}

    function getRouterAddress() public view returns (address) {
        uint256 id;
        assembly {
            id := chainid()
        }
        if (id == 97) return 0xD99D1c33F9fC3444f8101754aBC46c52416550D1;
        else if (id == 56) return 0x10ED43C718714eb63d5aA57B78B54704E256024E;
        else return 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
    }

    function getUSDTAddress() public view returns (address) {
        uint256 id;
        assembly {
            id := chainid()
        }
        if (id == 97) return 0x7ef95a0FEE0Dd31b22626fA2e10Ee6A223F8a684;
        else if (id == 56) return 0x55d398326f99059fF775485246999027B3197955;
        else return 0xdAC17F958D2ee523a2206206994597C13D831ec7;
    }

    function claimStuckTokens(address token) external onlyOwner {
        require(token != address(this), "Owner cannot claim native tokens");
        if (token == address(0x0)) {
            payable(msg.sender).transfer(address(this).balance);
            return;
        }
        IERC20 ERC20token = IERC20(token);
        uint256 balance = ERC20token.balanceOf(address(this));
        ERC20token.transfer(msg.sender, balance);
    }

    function isContract(address account) internal view returns (bool) {
        return account.code.length > 0;
    }

    function excludeFromFees(
        address account,
        bool excluded
    ) external onlyOwner {
        require(
            _isExcludedFromFees[account] != excluded,
            "Account is already the value of 'excluded'"
        );
        _isExcludedFromFees[account] = excluded;

        emit ExcludeFromFees(account, excluded);
    }

    function isExcludedFromFees(address account) public view returns (bool) {
        return _isExcludedFromFees[account];
    }

    function setFees(
        uint256 _marketingFeeOnBuy,
        uint256 _marketingFeeOnSell
    ) external onlyOwner {
        require(
            _marketingFeeOnBuy <= 10,
            "Marketing fee on buy cannot be more than 10%"
        );
        require(
            _marketingFeeOnSell <= 10,
            "Marketing fee on sell cannot be more than 10%"
        );
        marketingFeeOnBuy = _marketingFeeOnBuy;
        marketingFeeOnSell = _marketingFeeOnSell;
        emit FeesUpdated(marketingFeeOnBuy, marketingFeeOnSell);
    }

    function changeMarketingWallet(
        address _marketingWallet
    ) external onlyOwner {
        require(
            _marketingWallet != marketingWallet,
            "Marketing wallet is already that address"
        );
        require(
            _marketingWallet != address(0),
            "Marketing wallet cannot be the zero address"
        );
        require(
            !isContract(_marketingWallet),
            "Marketing wallet cannot be a contract"
        );
        marketingWallet = _marketingWallet;
        _isExcludedFromFees[marketingWallet] = true;
        emit MarketingWalletChanged(marketingWallet);
    }

    function setSwapTokensAtAmount(uint256 newAmount) external onlyOwner {
        require(
            newAmount > totalSupply() / 100000,
            "SwapTokensAtAmount must be greater than 0.001% of total supply"
        );
        swapTokensAtAmount = newAmount;
        emit SwapTokensAtAmountChanged(newAmount);
    }

    function startTrading() external onlyOwner {
        require(!tradingStarted, "Trading already started");
        tradingStarted = true;
        endBlock = block.number + blocktime;
        emit StartTrading();
    }

    function setBlocktime(uint256 _blocktime) external onlyOwner {
        require(!tradingStarted, "Cannot set blocktime after start trading");
        require(_blocktime != blocktime, "Blocktime already same");
        blocktime = _blocktime;
        emit ChangeBlocktime(_blocktime);
    }

    function isBotAddress(address account) public view returns (bool) {
        return _isBotAddress[account];
    }

    function removeBotAddress(address account) external onlyOwner {
        require(
            _isBotAddress[account],
            "Account is already not the bot address"
        );
        _isBotAddress[account] = false;

        emit BotAddressUpdated(account, false);
    }

    function setWalletLimit(uint256 _limit) external onlyOwner {
        require(walletLimit != _limit, "Wallet limit already on that amount");
        require(
            _limit >= 100 && _limit <= 10_000,
            "Cannot set limit below than 1% totalSupply (100) or over 100% totalSupply (10000)"
        );
        walletLimit = _limit;
        emit UpdateWalletLimit(_limit);
    }

    function setTxLimit(uint256 _limit) external onlyOwner {
        require(txLimit != _limit, "Tx limit already on that amount");
        require(
            _limit >= 10 && _limit <= 10_000,
            "Cannot set limit below than 0.1% totalSupply (10) or over 100% totalSupply (10000)"
        );
        txLimit = _limit;
        emit UpdateTxLimit(_limit);
    }

    function excludeFromWalletLimit(
        address account,
        bool excluded
    ) external onlyOwner {
        require(
            _isExcludeFromWalletLimit[account] != excluded,
            "Account is already the value of 'excluded'"
        );
        _isExcludeFromWalletLimit[account] = excluded;

        emit ExcludeWalletLimit(account, excluded);
    }

    function isExcludedFromWalletLimit(
        address account
    ) public view returns (bool) {
        return _isExcludeFromWalletLimit[account];
    }

    function excludeFromTxLimit(
        address account,
        bool excluded
    ) external onlyOwner {
        require(
            _isExcludeFromTxLimit[account] != excluded,
            "Account is already the value of 'excluded'"
        );
        _isExcludeFromTxLimit[account] = excluded;

        emit ExcludeTxLimit(account, excluded);
    }

    function isExcludedFromTxLimit(address account) public view returns (bool) {
        return _isExcludeFromTxLimit[account];
    }

    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal override {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");

        require(
            !_isBotAddress[from] && !_isBotAddress[to],
            "Bot address cannot transfer"
        );

        if (!_isExcludedFromFees[from] && !_isExcludedFromFees[to]) {
            require(tradingStarted, "Trading is not started yet");
            if (from == uniswapV2Pair && block.number <= endBlock) {
                _isBotAddress[to] = true;
                emit BotAddressUpdated(to, true);
            }
            if (!_isExcludeFromTxLimit[from] && !_isExcludeFromTxLimit[to]) {
                require(
                    amount <= (txLimit * totalSupply()) / denominator,
                    "amount transaction cannot more than tx limit"
                );
            }
            if (!_isExcludeFromWalletLimit[to]) {
                require(
                    balanceOf(to) + amount <=
                        (walletLimit * totalSupply()) / denominator,
                    "Balance of to user cannot more than wallet limit"
                );
            }
        }

        if (amount == 0) {
            super._transfer(from, to, 0);
            return;
        }

        uint256 contractTokenBalance = balanceOf(address(this));

        bool canSwap = contractTokenBalance >= swapTokensAtAmount;

        if (canSwap && !swapping && to == uniswapV2Pair) {
            swapping = true;

            swapAndSendFee(contractTokenBalance);

            swapping = false;
        }

        bool takeFee = !swapping;

        if (_isExcludedFromFees[from] || _isExcludedFromFees[to]) {
            takeFee = false;
        }

        if (takeFee) {
            uint256 fees;
            if (from == uniswapV2Pair) {
                fees = (amount * marketingFeeOnBuy) / 100;
            } else if (to == uniswapV2Pair) {
                fees = (amount * marketingFeeOnSell) / 100;
            } else {
                fees = 0;
            }
            amount -= fees;
            if (fees > 0) {
                super._transfer(from, address(this), fees);
            }
        }

        super._transfer(from, to, amount);
    }

    function swapAndSendFee(uint256 tokenAmount) private {
        address[] memory path = new address[](2);
        path[0] = address(this);
        path[1] = getUSDTAddress();

        uniswapV2Router.swapExactTokensForTokensSupportingFeeOnTransferTokens(
            tokenAmount,
            0, // accept any amount of ETH
            path,
            address(marketingWallet),
            block.timestamp
        );

        emit SwapAndSendFee(tokenAmount);
    }
}