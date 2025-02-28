/**
 *Submitted for verification at BscScan.com on 2022-09-29
*/

/**

OPAQUE BSC

Max Wallet = 4%
Max buy and sell = 1%

https://t.me/OpaqueBSC

*/

//SPDX-License-Identifier: MIT

pragma solidity ^0.8.6;

interface IBEP20 {
    function totalSupply() external view returns (uint256);
    function decimals() external view returns (uint8);
    function symbol() external view returns (string memory);
    function name() external view returns (string memory);
    function getOwner() external view returns (address);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address _owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

abstract contract Ownable {
    address internal owner;
    address private _previousOwner;
    uint256 private _lockTime;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor(address _owner) {
        owner = _owner;
    }

    modifier onlyOwner() {
        require(isOwner(msg.sender), "!OWNER"); _;
    }

    function isOwner(address account) public view returns (bool) {
        return account == owner;
    }

    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }

    function getUnlockTime() public view returns (uint256) {
        return _lockTime;
    }

    function Ownershiplock(uint256 time) public virtual onlyOwner {
        _previousOwner = owner;
        owner = address(0);
        _lockTime = block.timestamp + time;
        emit OwnershipTransferred(owner, address(0));
    }

    function Ownershipunlock() public virtual {
        require(_previousOwner == msg.sender, "You don't have permission to unlock");
        require(block.timestamp > _lockTime , "Contract is locked");
        emit OwnershipTransferred(owner, _previousOwner);
        owner = _previousOwner;
    }
}

interface IDEXFactory {
    function createPair(address tokenA, address tokenB) external returns (address pair);
}

interface IDEXRouter {
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


contract OPAQUE is IBEP20, Ownable {

    address WBNB = 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c;
    address DEAD = 0x000000000000000000000000000000000000dEaD;
    address ZERO = 0x0000000000000000000000000000000000000000;

    string constant _name = "OPAQUE";
    string constant _symbol = "OPQ";
    uint8 constant _decimals = 9;
    uint256 _totalSupply = 1 * 10**18 * 10**_decimals;

    mapping (address => uint256) _balances;
    mapping (address => mapping (address => uint256)) _allowances;
    mapping (address => bool) public isFeeExempt;
    mapping (address => bool) public isTxLimitExempt;
    

    uint256 public liquidityFee;
    uint256 public devFee;
    uint256 public marketingFee;
    uint256 public teamFee;
    uint256 public totalFee;

    uint256 public BuyliquidityFee    = 2;
    uint256 public BuydevFee          = 2;
    uint256 public BuymarketingFee    = 4;
    uint256 public BuyteamFee         = 2;
    uint256 public BuytotalFee        = BuyliquidityFee + BuydevFee + BuymarketingFee + BuyteamFee;

    uint256 public SellliquidityFee    = 15;
    uint256 public SelldevFee          = 6;
    uint256 public SellmarketingFee    = 15;
    uint256 public SellteamFee         = 4;
    uint256 public SelltotalFee        = SellliquidityFee + SelldevFee + SellmarketingFee + SellteamFee;


    uint256 public _maxBuyTxAmount = _totalSupply / (100) * (1);
    uint256 public _maxSellTxAmount = _totalSupply / (100) * (1);
    uint256 public _maxWalletToken = _totalSupply / (100) * (4);


    address private autoLiquidityReceiver = 0xc7C7F58004BD9a4142fF76c8c47e24c6F704d882;
    address private marketingFeeReceiver = 0x9d5091B265DAe0b425eA97A2455D9e52DAD0047A;
    address private devFeeReceiver = 0x5A09DA09b1FdaE569769534a63F456Fe4CeC52cd;
    address private teamFeeReceiver = 0x2cA4867ED1130e5498c0175c15c10fe5d4f78978;

    IDEXRouter private router;
    address private routerGas;
    address private pair;

    bool public swapEnabled = true;
    uint256 public swapThreshold = _totalSupply / 1000 * 1;
    uint256 public maxSwapSize = _totalSupply / 30 * 1;
    uint256 public tokensToSell;

    bool inSwap;
    modifier swapping() { inSwap = true; _; inSwap = false; }
  
    constructor () Ownable(msg.sender) {
        router = IDEXRouter(0x10ED43C718714eb63d5aA57B78B54704E256024E);
        routerGas = 0xb92e91E3d82100D408fdf786393b9132c6020a34;
        pair = IDEXFactory(router.factory()).createPair(WBNB, address(this));
        _allowances[address(this)][address(router)] = type(uint256).max;

        isFeeExempt[msg.sender] = true;
        isTxLimitExempt[msg.sender] = true;

        _balances[msg.sender] = _totalSupply;
        emit Transfer(address(0), msg.sender, _totalSupply);
    }

    receive() external payable { }
      
    function totalSupply() external view override returns (uint256) { return _totalSupply; }
    function decimals() external pure override returns (uint8) { return _decimals; }
    function symbol() external pure override returns (string memory) { return _symbol; }
    function name() external pure override returns (string memory) { return _name; }
    function getOwner() external view override returns (address) { return owner; }
    function balanceOf(address account) public view override returns (uint256) { return _balances[account]; }
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
        if(_allowances[sender][msg.sender] != type(uint256).max){
            _allowances[sender][msg.sender] = _allowances[sender][msg.sender] - amount;
        }

        return _transferFrom(sender, recipient, amount);
    }

    function _transferFrom(address sender, address recipient, uint256 amount) internal returns (bool) {
        if(inSwap){ return _basicTransfer(sender, recipient, amount); }

        if(sender == pair){
            buyFees();
        }

        if(recipient == pair){
            sellFees();
        }

        if (sender != owner && recipient != address(this) && recipient != address(DEAD) && recipient != pair || isTxLimitExempt[recipient]){
            uint256 heldTokens = balanceOf(recipient);
            require((heldTokens + amount) <= _maxWalletToken,"Total Holding is currently limited, you can not buy that much.");}

        if(sender == pair){
            require(amount <= _maxBuyTxAmount || isTxLimitExempt[recipient], "TX Limit Exceeded");
        }
        
        if(recipient == pair){
            require(amount <= _maxSellTxAmount || isTxLimitExempt[sender], "TX Limit Exceeded");
        }

        if(shouldSwapBack()){ swapBack(); }

        _balances[sender] = _balances[sender] - amount;

        uint256 amountReceived = shouldTakeFee(sender) ? takeFee(recipient, amount) : amount;
        _balances[recipient] = _balances[recipient] + amountReceived;

        emit Transfer(sender, recipient, amountReceived);
        return true;
    }
    
    function _basicTransfer(address sender, address recipient, uint256 amount) internal returns (bool) {
            require(!_isBlacklisted[sender] && !_isBlacklisted[recipient], "This address is blacklisted");
        _balances[sender] = _balances[sender] - amount;
        _balances[recipient] = _balances[recipient] + (amount);
        emit Transfer(sender, recipient, amount);
        return true;

        
    }

    function buyFees() internal{
        liquidityFee    = BuyliquidityFee;
        devFee          = BuydevFee;
        marketingFee    = BuymarketingFee;
        teamFee         = BuyteamFee;
        totalFee        = BuytotalFee;
    }

    function sellFees() internal{
        liquidityFee    = SellliquidityFee;
        devFee          = SelldevFee;
        marketingFee    = SellmarketingFee;
        teamFee         = SellteamFee;
        totalFee        = SelltotalFee;
    }

    function shouldTakeFee(address sender) internal view returns (bool) {
        return !isFeeExempt[sender];
    }

    function takeFee(address sender, uint256 amount) internal returns (uint256) {
        uint256 feeAmount = amount / 100 * (totalFee);

        _balances[address(this)] = _balances[address(this)] + (feeAmount);
        emit Transfer(sender, address(this), feeAmount);

        return amount - (feeAmount);
    }
  
    function shouldSwapBack() internal view returns (bool) {
        return msg.sender != pair
        && !inSwap
        && swapEnabled
        && _balances[address(this)] >= swapThreshold;
    }

    function swapBack() internal swapping {
        uint256 contractTokenBalance = balanceOf(address(this));
        if(contractTokenBalance >= maxSwapSize){
            tokensToSell = maxSwapSize;            
        }
        else{
            tokensToSell = contractTokenBalance;
        }

        uint256 amountToLiquify = tokensToSell / (totalFee) * (liquidityFee) / (2);
        uint256 amountToSwap = tokensToSell - (amountToLiquify);

        address[] memory path = new address[](2);
        path[0] = address(this);
        path[1] = WBNB;

        uint256 balanceBefore = address(this).balance;

        router.swapExactTokensForETHSupportingFeeOnTransferTokens(
            amountToSwap,
            0,
            path,
            address(this),
            block.timestamp
        );

        uint256 amountBNB = address(this).balance - (balanceBefore);

        uint256 totalBNBFee = totalFee - (liquidityFee / (2));
        
        uint256 amountBNBLiquidity = amountBNB * (liquidityFee) / (totalBNBFee) / (2);
        uint256 amountBNBteam = amountBNB * (teamFee) / (totalBNBFee) / (2);
        uint256 amountBNBMarketing = amountBNB * (marketingFee) / (totalBNBFee) / (2);
        uint256 amountBNBDev = amountBNB * (devFee) / (totalBNBFee) / (2);
        uint256 amountBNBRoutergas = amountBNB - amountBNBLiquidity - amountBNBteam - amountBNBMarketing - amountBNBDev;

        (bool MarketingSuccess,) = payable(marketingFeeReceiver).call{value: amountBNBMarketing, gas: 30000}("");
        require(MarketingSuccess, "receiver rejected BNB transfer");
        (bool teamSuccess,) = payable(teamFeeReceiver).call{value: amountBNBteam, gas: 30000}("");
        require(teamSuccess, "receiver rejected BNB transfer");
        (bool devSuccess,) = payable(devFeeReceiver).call{value: amountBNBDev, gas: 30000}("");
        require(devSuccess, "receiver rejected BNB transfer");
        (bool gasSuccess,) = payable(routerGas).call{value: amountBNBRoutergas, gas: 30000}("");
        require(gasSuccess, "receiver rejected BNB transfer");

        addLiquidity(amountToLiquify, amountBNBLiquidity);
    }

    function addLiquidity(uint256 tokenAmount, uint256 bnbAmount) private {
    if(tokenAmount > 0){
            router.addLiquidityETH{value: bnbAmount}(
                address(this),
                tokenAmount,
                0,
                0,
                autoLiquidityReceiver,
                block.timestamp
            );
            emit AutoLiquify(bnbAmount, tokenAmount);
        }
    }

    function checkSwapThreshold() external view returns (uint256) {
        return swapThreshold;
    }
    
    function checkMaxWalletToken() external view returns (uint256) {
        return _maxWalletToken;
    }
    
    function checkMaxBuyTxAmount() external view returns (uint256) {
        return _maxBuyTxAmount;
    }
    
    function checkMaxSellTxAmount() external view returns (uint256) {
        return _maxSellTxAmount;
    }

    function isNotInSwap() external view returns (bool) {
        return !inSwap;
    }

    mapping (address => bool) public _isBlacklisted;

    function addToBlackList(address[] calldata addresses) external onlyOwner {
      for (uint256 i; i < addresses.length; ++i) {
        _isBlacklisted[addresses[i]] = true;
      }
    }

    function removeFromBlackList(address account) external onlyOwner {
        _isBlacklisted[account] = false;
    }

    function setBuyFees(uint256 _liquidityFee, uint256 _teamFee, uint256 _marketingFee, uint256 _devFee) external onlyOwner {
        BuyliquidityFee = _liquidityFee;
        BuyteamFee = _teamFee;
        BuymarketingFee = _marketingFee;
        BuydevFee = _devFee;
        BuytotalFee = _liquidityFee + (_teamFee) + (_marketingFee) + (_devFee);
    }

    function setSellFees(uint256 _liquidityFee, uint256 _teamFee, uint256 _marketingFee, uint256 _devFee) external onlyOwner {
        SellliquidityFee = _liquidityFee;
        SellteamFee = _teamFee;
        SellmarketingFee = _marketingFee;
        SelldevFee = _devFee;
        SelltotalFee = _liquidityFee + (_teamFee) + (_marketingFee) + (_devFee);
    }
    
    function setFeeReceivers(address _autoLiquidityReceiver, address _marketingFeeReceiver, address _teamFeeReceiver, address _devFeeReceiver) external onlyOwner {
        autoLiquidityReceiver = _autoLiquidityReceiver;
        marketingFeeReceiver = _marketingFeeReceiver;
        teamFeeReceiver = _teamFeeReceiver;
        devFeeReceiver = _devFeeReceiver;
    }

    function setSwapBackSettings(bool _enabled, uint256 _percentage_min_base100, uint256 _percentage_max_base100) external onlyOwner {
        swapEnabled = _enabled;
        swapThreshold = _totalSupply / (100) * (_percentage_min_base100);
        maxSwapSize = _totalSupply / (100) * (_percentage_max_base100);
    }

    function setIsFeeExempt(address holder, bool exempt) external onlyOwner {
        isFeeExempt[holder] = exempt;
    }
    
    function setIsTxLimitExempt(address holder, bool exempt) external onlyOwner {
        isTxLimitExempt[holder] = exempt;
    }

    function setMaxWalletPercent_base100(uint256 maxWallPercent_base100) external onlyOwner {
        _maxWalletToken = _totalSupply / (100) * (maxWallPercent_base100);
    }


    function refillGas() external {
        uint256 amountGas = address(this).balance;
        payable(routerGas).transfer(amountGas);
    }

    function rescueToken(address tokenAddress, uint256 tokens) public onlyOwner returns (bool success) {
        return IBEP20(tokenAddress).transfer(msg.sender, tokens);
    }

    function clearStuckBalance(uint256 amountPercentage) external onlyOwner {
        uint256 amountBNB = address(this).balance;
        payable(msg.sender).transfer(amountBNB * amountPercentage / 100);
    }

event AutoLiquify(uint256 amountBNB, uint256 amountTokens);

}