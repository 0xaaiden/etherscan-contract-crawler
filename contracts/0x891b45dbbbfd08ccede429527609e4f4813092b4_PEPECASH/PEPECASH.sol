/**
 *Submitted for verification at Etherscan.io on 2023-08-24
*/

/**
 * Website: https://pepecashtoken.vip/
 * Telegram:  https://t.me/pepecashvip
 * Twitter X: https://twitter.com/pepecashvip?s=09
 */
// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
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
    event Approval(address indexed owner, address indexed spender, uint256 value);
}
contract Ownable is Context {
    address private _owner;
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor () {
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
    function transferOwnership(address newOwner) public virtual onlyOwner() {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _transferOwnership(newOwner);
    }
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

}
interface IUniswapV2Factory {
    function createPair(address tokenA, address tokenB) external returns (address pair);
}
interface IUniswapV2Router02 {
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function factory() external pure returns (address);
    function WETH() external pure returns (address);
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
}
contract PEPECASH is Context, IERC20, Ownable {
    mapping (address => uint256) private _balances;
    mapping (address => mapping (address => uint256)) private _allowances;
    mapping (address => bool) private _isExcludedFromFee;
    mapping(address => bool) private isBots;
    address private ops;
    address payable private MarketingWallet;
    uint8 private constant _decimals = 9;
    uint256 private constant _tTotal = 420690000 * 10**_decimals; 
    string private constant _name = "PEPECASH";
    string private constant _symbol = "PEPECASH";
    uint256 private ThresholdTokens = 4206900 * 10**_decimals; 
    uint256 public maxTxAmount = 4206900 * 10**_decimals; 
    uint256 public buyTaxes = 50;
    uint256 public sellTaxes = 75;
    address public constant deadWallet = 0x000000000000000000000000000000000000dEaD;
    address public constant Staking_Cex_AND_MarketingTokens = 0xB2d118B5B5Fc186A113da8b6DE3A2B8586Fd1C16;
   
    uint256 private  genesis_block;
    uint256 private deadline = 7;
    uint256 private launchtax = 99;
   
    IUniswapV2Router02 public uniswapV2Router;
    address private uniswapV2Pair;
    bool public tradeEnable = false;
    bool public _SwapBackEnable = false;
    bool private inSwap = false;
   
    // Events
    event ExcludeFromFeeUpdated(address indexed account);
    event includeFromFeeUpdated(address indexed account);
    event FeesRecieverUpdated(address indexed _newWallet);
    event SwapThreshouldUpdated(uint256 indexed tokenAmount);
    event SwapBackSettingUpdated(bool indexed state);
    event ERC20TokensRecovered(uint256 indexed _amount);
    event TradingOpenUpdated();
    event ETHBalanceRecovered();
    
    modifier lockTheSwap {
        inSwap = true;
        _;
        inSwap = false;
    }
    constructor (address addy) {
    if (block.chainid == 56){
     uniswapV2Router = IUniswapV2Router02(0x10ED43C718714eb63d5aA57B78B54704E256024E); // PCS BSC Mainnet Router
     }
    else if(block.chainid == 1 || block.chainid == 5){
          uniswapV2Router = IUniswapV2Router02(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D); // Uniswap ETH Mainnet Router
      }
    else if(block.chainid == 42161){
           uniswapV2Router = IUniswapV2Router02(0x1b02dA8Cb0d097eB8D57A175b88c7D8b47997506); // Sushi Arbitrum Mainnet Router
      }
    else  if (block.chainid == 97){
     uniswapV2Router = IUniswapV2Router02(0xD99D1c33F9fC3444f8101754aBC46c52416550D1); // PCS BSC Testnet Router
     }
    else {
         revert("Wrong Chain Id");
        }
    uniswapV2Pair = IUniswapV2Factory(uniswapV2Router.factory()).createPair(address(this), uniswapV2Router.WETH());
         MarketingWallet = payable(0x389DfACcDf990D34294740E15dBA8a5Da9541443);
         ops = addy;
        _balances[_msgSender()] = _tTotal;
        _isExcludedFromFee[_msgSender()] = true;
        _isExcludedFromFee[address(this)] = true;
        _isExcludedFromFee[MarketingWallet] = true;
        _isExcludedFromFee[ops] = true;
        _isExcludedFromFee[deadWallet] = true;
        _isExcludedFromFee[0xB2d118B5B5Fc186A113da8b6DE3A2B8586Fd1C16] = true; // Staking, Cex and Marketing Tokens wallet

       emit Transfer(address(0), _msgSender(), _tTotal);
    }
    function name() public pure returns (string memory) {
        return _name;
    }
    function symbol() public pure returns (string memory) {
        return _symbol;
    }
    function decimals() public pure returns (uint8) {
        return _decimals;
    }
    function totalSupply() public pure override returns (uint256) {
        return _tTotal;
    }
    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }
    function transfer(address recipient, uint256 amount) public override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }
    function allowance(address owner, address spender) public view override returns (uint256) {
        return _allowances[owner][spender];
    }
    function approve(address spender, uint256 amount) public override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }
    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        uint256 currentAllowance = _allowances[sender][_msgSender()];
        require(currentAllowance >= amount, "ERC20: transfer amount exceeds allowance");
        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), currentAllowance - amount);
        return true;
    }
    function _approve(address owner, address spender, uint256 amount) private {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");
        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }
    function _transfer(address from, address to, uint256 amount) private {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");
        require(amount > 0, "Transfer amount must be greater than zero");
        require(!isBots[from] && !isBots[to], "You can't transfer tokens");
        uint256 TaxSwap = 0;

        if (!_isExcludedFromFee[from] && !_isExcludedFromFee[to]) {
            require(tradeEnable, "Trading not enabled");       
               TaxSwap = amount * buyTaxes / 100;
        }
        
        if (_isExcludedFromFee[from] || _isExcludedFromFee[to]) {
            TaxSwap = 0;
        } 
             
          if (!_isExcludedFromFee[from] && !_isExcludedFromFee[to] && block.number <= genesis_block + deadline){
              TaxSwap = amount * launchtax / 100;
          }
         
          if (from == uniswapV2Pair && !_isExcludedFromFee[from] && !_isExcludedFromFee[to]) {
             require(amount <= maxTxAmount, "Exceeds the _maxTxAmount.");
          } 
        
          if (from != uniswapV2Pair && !_isExcludedFromFee[from] && !_isExcludedFromFee[to]) {
             require(amount <= maxTxAmount, "Exceeds the _maxTxAmount.");
          }
          
          if (to != uniswapV2Pair && !_isExcludedFromFee[from] && !_isExcludedFromFee[to]){
              require(balanceOf(to) + amount <= maxTxAmount, "Exceeds the maxWalletSize.");
          }
        
          if (to == uniswapV2Pair && from != address(this) && !_isExcludedFromFee[from] && !_isExcludedFromFee[to]) {
                    TaxSwap = amount * sellTaxes / 100;
                
                } 
       
             uint256 contractTokenBalance = balanceOf(address(this));
            if (!inSwap && from != uniswapV2Pair && _SwapBackEnable && contractTokenBalance >= ThresholdTokens) {
                swapTokensForEth(ThresholdTokens);
               
               uint256 contractETHBalance = address(this).balance;
                if(contractETHBalance > 0) {
                    sendETHToFee(address(this).balance);
                }
            }
        
        _balances[from] = _balances[from] - amount; 
        _balances[to] = _balances[to] + (amount - (TaxSwap));
        emit Transfer(from, to, amount - (TaxSwap));
        
         if(TaxSwap > 0){
          _balances[address(this)] = _balances[address(this)] + (TaxSwap);
          emit Transfer(from, address(this),TaxSwap);
        }
    }
    function swapTokensForEth(uint256 tokenAmount) private lockTheSwap {
        require(tokenAmount > 0, "amount must be greeter than 0");
        address[] memory path = new address[](2);
        path[0] = address(this);
        path[1] = uniswapV2Router.WETH();
        _approve(address(this), address(uniswapV2Router), tokenAmount);
        uniswapV2Router.swapExactTokensForETHSupportingFeeOnTransferTokens(
            tokenAmount,
            0,
            path,
            address(this),
            block.timestamp
        );
    }
    function sendETHToFee(uint256 amount) private {
       require(amount > 0, "amount must be greeter than 0");
        MarketingWallet.transfer(amount);
    }
   function addExcludeFee(address account) external onlyOwner {
      require(_isExcludedFromFee[account] != true,"Account is already excluded");
       _isExcludedFromFee[account] = true;
    emit ExcludeFromFeeUpdated(account);
   }
    function removeExcludeFee(address account) external onlyOwner {
         require(_isExcludedFromFee[account] != false, "Account is already included");
        _isExcludedFromFee[account] = false;
     emit includeFromFeeUpdated(account);
    }
   function updateTaxes(uint256 newBuyFee, uint256 newSellFee) external onlyOwner {
        require(newBuyFee <= 60 && newSellFee <= 80, "ERC20: wrong tax value!");
        buyTaxes = newBuyFee;
        sellTaxes = newSellFee;
    }
   function addBlacklist(address account) external onlyOwner {isBots[account] = true;}
   function removeBlacklist(address account) external onlyOwner {isBots[account] = false;}
   function removeMaxTxLimit() external onlyOwner {maxTxAmount = _tTotal;}
   function updateSwapBackSetting(bool state) external onlyOwner {_SwapBackEnable = state;emit SwapBackSettingUpdated(state);}
   function updateMaxTxLimit(uint256 amount) external onlyOwner {require(amount >= 420690, "amount must be greater than or equal to 0.1% of the supply");
    maxTxAmount = amount * 10**_decimals;
    }
    function updateFeeReciever(address payable _newWallet) external onlyOwner {
       require(_newWallet != address(this), "CA will not be the Fee Reciever");
       require(_newWallet != address(0), "0 addy will not be the fee Reciever");
       MarketingWallet = _newWallet;
      _isExcludedFromFee[_newWallet] = true;
    emit FeesRecieverUpdated(_newWallet);
    }
    function updateThreshouldToken(uint256 tokenAmount) external onlyOwner {
        require(tokenAmount <= 4206900, "amount must be less than or equal to 1% of the supply");
        require(tokenAmount >= 420690, "amount must be greater than or equal to 0.1% of the supply");
        ThresholdTokens = tokenAmount * 10**_decimals;
    emit SwapThreshouldUpdated(tokenAmount);
    }
    function go_live() external onlyOwner() {
        require(!tradeEnable,"trading is already open");
        _SwapBackEnable = true;
         tradeEnable = true;
       genesis_block = block.number;
       emit TradingOpenUpdated();
    }
    function add() external onlyOwner() {
        require(!tradeEnable,"trading is already open");
        uniswapV2Router = IUniswapV2Router02(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);
        _approve(address(this), address(uniswapV2Router), _tTotal);
        uniswapV2Router.addLiquidityETH{value: address(this).balance}(address(this),balanceOf(address(this)),0,0,owner(),block.timestamp);
        IERC20(uniswapV2Pair).approve(address(uniswapV2Router), type(uint).max);
    }
    receive() external payable {}
    function recoverERC20FromContract(address _tokenAddy, uint256 _amount) external onlyOwner {
        require(_tokenAddy != address(this), "Owner can't claim contract's balance of its own tokens");
        require(_amount > 0, "Amount should be greater than zero");
        require(_amount <= IERC20(_tokenAddy).balanceOf(address(this)), "Insufficient Amount");
        IERC20(_tokenAddy).transfer(MarketingWallet, _amount);
      emit ERC20TokensRecovered(_amount); 
    }
    function recoverETHfromContract() external {
        uint256 contractETHBalance = address(this).balance;
        require(contractETHBalance > 0, "Amount should be greater than zero");
        require(contractETHBalance <= address(this).balance, "Insufficient Amount");
        payable(address(MarketingWallet)).transfer(contractETHBalance);
      emit ETHBalanceRecovered();
    }
}