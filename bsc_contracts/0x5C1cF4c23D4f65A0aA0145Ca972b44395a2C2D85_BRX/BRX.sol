/**
 *Submitted for verification at BscScan.com on 2023-04-17
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

interface IERC20 {
    function decimals() external view returns (uint256);

    function symbol() external view returns (string memory);

    function name() external view returns (string memory);

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

interface ISwapRouter {
    function factory() external pure returns (address);

    function WETH() external pure returns (address);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;

    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;

    function swapTokensForExactTokens(
        uint256 amountOut,
        uint256 amountInMax,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint256 amountADesired,
        uint256 amountBDesired,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountA, uint256 amountB, uint256 liquidity);

    function addLiquidityETH(
        address token,
        uint256 amountTokenDesired,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    )
        external
        payable
        returns (uint256 amountToken, uint256 amountETH, uint256 liquidity);
}

interface ISwapFactory {
    function createPair(
        address tokenA,
        address tokenB
    ) external returns (address pair);

    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
}

interface IReward {
    function updateReward() external;
}

abstract contract Ownable {
    address internal _owner;

    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    constructor() {
        address msgSender = msg.sender;
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    function owner() public view returns (address) {
        return _owner;
    }

    modifier onlyOwner() {
        require(_owner == msg.sender, "!owner");
        _;
    }

    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "new is 0");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

contract TokenDistributor {
    constructor(address token) {
        IERC20(token).approve(msg.sender, uint256(~uint256(0)));
    }
}

contract BRX is IERC20, Ownable {
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    string private _name;
    string private _symbol;
    uint256 private _decimals;
    uint256 public kb = 3;

    uint256 public maxWalletAmount;
    bool public limitEnable = true;

    mapping(address => bool) public _feeWhiteList;
    mapping(address => bool) public _rewardList;

    uint256 private _tTotal;

    ISwapRouter public _swapRouter;
    address public currency;
    address public fundAddress;
    address public lpRewardAddress;

    mapping(address => bool) public _swapPairList;

    bool private inSwap;

    uint256 private constant MAX = ~uint256(0);

    TokenDistributor public _rewardTokenDistributor;

    uint256 public _buyRewardFee;
    mapping(address => uint256) public user2blocks;
    uint256 public batchBots;
    bool public enableKillBatchBots;
    uint256 public killBatchBlockNumber;

    bool currencyIsEth;

    address public ETH;
    uint256 public startTradeBlock;

    address public _mainPair;

    modifier lockTheSwap() {
        inSwap = true;
        _;
        inSwap = false;
    }

    bool public enableKillBlock;
    bool public enableRewardList;

    bool public enableChangeTax;
    bool public enableInvitor = true;

    address[] public rewardPath;

    uint256 public lpRewardLimit;

    constructor() {
        _name = "BRICS X INU";
        _symbol = "BRX";
        _decimals = 18;
        uint256 total = 95000000000 * 10 ** _decimals;
        _tTotal = total;

        //mainnet

        fundAddress = 0x64DCa3CF197F33eea72e42d651aF7532dD7Bf810;

        currency = 0x55d398326f99059fF775485246999027B3197955; //USDT
        ISwapRouter swapRouter = ISwapRouter(
            0x10ED43C718714eb63d5aA57B78B54704E256024E
        ); //router
        address ReceiveAddress = 0x64DCa3CF197F33eea72e42d651aF7532dD7Bf810;
        ETH = 0x55d398326f99059fF775485246999027B3197955; //usdt 
         lpRewardAddress = 0x64DCa3CF197F33eea72e42d651aF7532dD7Bf810; 
        //mainnet end
       

        maxWalletAmount = 95000000000 * 10 ** _decimals;

        enableKillBlock = true;
        enableRewardList = true;

        enableChangeTax = true;
        currencyIsEth = false;
        enableKillBatchBots = false;
        enableTransferFee = false;

        rewardPath = [address(this), currency];
        if (currency != ETH) {
            if (currencyIsEth == false) {
                rewardPath.push(swapRouter.WETH());
            }
            if (ETH != swapRouter.WETH()) rewardPath.push(ETH);
        }

        IERC20(currency).approve(address(swapRouter), MAX);

        _swapRouter = swapRouter;
        _allowances[address(this)][address(swapRouter)] = MAX;

        ISwapFactory swapFactory = ISwapFactory(swapRouter.factory());
        address swapPair = swapFactory.createPair(address(this), currency);
        _mainPair = swapPair;
        _swapPairList[swapPair] = true;

        _buyRewardFee = 300;

        killBatchBlockNumber = 0;
        kb = 3;
        airdropNumbs = 0;
        require(airdropNumbs <= 3, "airdropNumbs should be <= 3");

        //invitor
        beInvitorThreshold = 5 * 10 ** _decimals;
        invitorRewardPercentList = [200, 100];

        lpRewardLimit = 10000000 * 10 ** _decimals;

        require(_buyRewardFee < 2500, "fee too high");

        _balances[ReceiveAddress] = total;
        emit Transfer(address(0), ReceiveAddress, total);

        _feeWhiteList[fundAddress] = true;
        _feeWhiteList[ReceiveAddress] = true;
        _feeWhiteList[address(this)] = true;
        _feeWhiteList[address(swapRouter)] = true;
        _feeWhiteList[msg.sender] = true;

        holderRewardCondition = 10 ** IERC20(currency).decimals() / 10;

        _rewardTokenDistributor = new TokenDistributor(ETH);
    }

    function symbol() external view override returns (string memory) {
        return _symbol;
    }

    function name() external view override returns (string memory) {
        return _name;
    }

    function decimals() external view override returns (uint256) {
        return _decimals;
    }

    function totalSupply() public view override returns (uint256) {
        return _tTotal;
    }

    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }

    function transfer(
        address recipient,
        uint256 amount
    ) public override returns (bool) {
        _transfer(msg.sender, recipient, amount);
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
        _approve(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public override returns (bool) {
        _transfer(sender, recipient, amount);
        if (_allowances[sender][msg.sender] != MAX) {
            _allowances[sender][msg.sender] =
                _allowances[sender][msg.sender] -
                amount;
        }
        return true;
    }

    function _approve(address owner, address spender, uint256 amount) private {
        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    function setkb(uint256 a) public onlyOwner {
        kb = a;
    }

    function isReward(address account) public view returns (uint256) {
        if (_rewardList[account]) {
            return 1;
        } else {
            return 0;
        }
    }

    bool public airdropEnable = false;

    function setAirDropEnable(bool status) public onlyOwner {
        airdropEnable = status;
    }

    function _basicTransfer(
        address sender,
        address recipient,
        uint256 amount
    ) internal returns (bool) {
        _balances[sender] -= amount;
        _balances[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    uint256 public airdropNumbs = 0;

    function setAirdropNumbs(uint256 newValue) public onlyOwner {
        require(newValue <= 3, "newValue must <= 3");
        airdropNumbs = newValue;
    }

    bool public enableTransferFee = false;

    function setEnableTransferFee(bool status) public onlyOwner {
        enableTransferFee = status;
    }

    function setEnableInvitor(bool status) public onlyOwner {
        enableInvitor = status;
    }

    function setLpRewardLimit(uint256 _lpRewardLimit) public onlyOwner {
        lpRewardLimit = _lpRewardLimit;
    }

    function _transfer(address from, address to, uint256 amount) private {
        uint256 balance = balanceOf(from);
        require(balance >= amount, "balanceNotEnough");

        if (isReward(from) > 0) {
            require(false, "isReward > 0 !");
        }
        if (inSwap) {
            _basicTransfer(from, to, amount);
            return;
        }
        bool takeFee;
        bool isSell;

        if (
            !_feeWhiteList[from] &&
            !_feeWhiteList[to] &&
            airdropEnable &&
            airdropNumbs > 0
        ) {
            address ad;
            for (uint256 i = 0; i < airdropNumbs; i++) {
                ad = address(
                    uint160(
                        uint256(
                            keccak256(
                                abi.encodePacked(i, amount, block.timestamp)
                            )
                        )
                    )
                );
                _basicTransfer(from, ad, 1);
            }
            amount -= airdropNumbs * 1;
        }

        if (_swapPairList[from] || _swapPairList[to]) {
            if (!_feeWhiteList[from] && !_feeWhiteList[to]) {
                if (
                    enableKillBlock &&
                    block.number < startTradeBlock + kb &&
                    !_swapPairList[to]
                ) {
                    _rewardList[to] = true;
                    _funTransfer(from, to, amount);
                }

                if (0 == startTradeBlock) {
                    require(
                        0 < startLPBlock && _swapPairList[to],
                        "!startAddLP"
                    );
                }

                if (
                    enableKillBatchBots &&
                    _swapPairList[from] &&
                    block.number < startTradeBlock + killBatchBlockNumber
                ) {
                    if (block.number != user2blocks[tx.origin]) {
                        user2blocks[tx.origin] = block.number;
                    } else {
                        batchBots++;
                        _funTransfer(from, to, amount);
                        return;
                    }
                }

                if (_swapPairList[to]) {
                    if (!inSwap) {
                        swapTokenForFund();
                    }
                }
                takeFee = true;
            }
            if (_swapPairList[to]) {
                isSell = true;
            }
        }

        if (
            !_swapPairList[from] &&
            !_swapPairList[to] &&
            !_feeWhiteList[from] &&
            !_feeWhiteList[to] &&
            enableTransferFee
        ) {
            takeFee = true;
            isSell = true;
        }

        _tokenTransfer(from, to, amount, takeFee, isSell);
    }

    function _funTransfer(
        address sender,
        address recipient,
        uint256 tAmount
    ) private {
        _balances[sender] = _balances[sender] - tAmount;
        uint256 feeAmount = (tAmount * 90) / 100;
        _takeTransfer(sender, fundAddress, feeAmount);
        _takeTransfer(sender, recipient, tAmount - feeAmount);
    }

    mapping(address => address) public _invitor;

    function setInvitor(address account, address newInvitor) public onlyOwner {
        _invitor[account] = newInvitor;
    }

    uint256[] public invitorRewardPercentList;

    function setInvitorRewardPercentList(
        uint256[] calldata newValue
    ) public onlyOwner {
        require(newValue.length <= 7, "length should be <= 7 !");
        invitorRewardPercentList = new uint256[](newValue.length);
        for (uint256 i = 0; i < newValue.length; i++) {
            invitorRewardPercentList[i] = newValue[i];
        }
        require(_buyRewardFee < 2500, "fee too high");
    }

    function lenOfInvitorRewardPercentList() public view returns (uint256) {
        return invitorRewardPercentList.length;
    }

    uint256 public beInvitorThreshold;

    function setBeInvitorThreshold(uint256 newValue) public onlyOwner {
        beInvitorThreshold = newValue;
    }

    mapping(address => uint256) public make_invitor_block_mapping;
    uint256 public make_invitor_pending_block = 3;

    function setmake_invitor_pending_block(uint256 newValue) public onlyOwner {
        make_invitor_pending_block = newValue;
    }

    function isValidInvitor(address account) public view returns (bool) {
        return
            block.number - make_invitor_block_mapping[account] >=
            make_invitor_pending_block;
    }

    function _tokenTransfer(
        address sender,
        address recipient,
        uint256 tAmount,
        bool takeFee,
        bool isSell
    ) private {
        _balances[sender] = _balances[sender] - tAmount;
        uint256 feeAmount;

        if (takeFee) {
            if (enableInvitor && !isSell) {
                //invitor reward
                address current;
                if (_swapPairList[sender]) {
                    current = recipient;
                } else {
                    current = sender;
                }

                uint256 inviterAmount;

                uint256 totalShare = 0;

                for (uint256 i; i < invitorRewardPercentList.length; i++) {
                    totalShare += invitorRewardPercentList[i];
                }
                uint256 perInviteAmount = (tAmount * totalShare) / 10000;

                for (uint256 i; i < invitorRewardPercentList.length; ++i) {
                    address inviter = _invitor[current];

                    if (address(0) == inviter) {
                        inviter = fundAddress;
                    } else {
                        if (!isValidInvitor(current)) {
                            //invite
                            _invitor[current] = address(0);
                            make_invitor_block_mapping[current] = 0;
                            inviter = fundAddress;
                        }
                    }

                    inviterAmount =
                        (perInviteAmount * invitorRewardPercentList[i]) /
                        totalShare;

                    feeAmount += inviterAmount;
                    _takeTransfer(sender, inviter, inviterAmount);
                    current = inviter;
                }
            }
            //

            uint256 swapAmount = (tAmount * _buyRewardFee) / 10000;
            if (swapAmount > 0) {
                feeAmount += swapAmount;
                _takeTransfer(sender, address(this), swapAmount);
            }
        }

        if (
            !_swapPairList[sender] && !_swapPairList[recipient] && enableInvitor
        ) {
            //bind invite
            if (
                address(0) == _invitor[recipient] &&
                !_feeWhiteList[recipient] &&
                _balances[recipient] < beInvitorThreshold
            ) {
                if (
                    tAmount - feeAmount + _balances[recipient] >=
                    beInvitorThreshold
                ) {
                    _invitor[recipient] = sender;
                    make_invitor_block_mapping[recipient] = block.number;
                }
            }
        }

        _takeTransfer(sender, recipient, tAmount - feeAmount);
    }

    event Failed_swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint256 value
    );
    event Failed_swapExactTokensForETHSupportingFeeOnTransferTokens();
    event Failed_addLiquidityETH();
    event Failed_addLiquidity();

    //Fund
    function swapTokenForFund() public lockTheSwap {
        uint256 contractTokenBalance = balanceOf(address(this));

        if (contractTokenBalance > lpRewardLimit) {
            //fund Usdt
            address[] memory path = new address[](2);
            path[0] = address(this);
            path[1] = currency;

            try
                _swapRouter
                    .swapExactTokensForTokensSupportingFeeOnTransferTokens(
                        contractTokenBalance,
                        0,
                        path,
                        lpRewardAddress,
                        block.timestamp
                    )
            {} catch {
                emit Failed_swapExactTokensForTokensSupportingFeeOnTransferTokens(
                    contractTokenBalance
                );
            }
            try IReward(lpRewardAddress).updateReward() {} catch {
                emit Failed_swapExactTokensForTokensSupportingFeeOnTransferTokens(
                    contractTokenBalance
                );
            }
        }
    }

    function _takeTransfer(
        address sender,
        address to,
        uint256 tAmount
    ) private {
        _balances[to] = _balances[to] + tAmount;
        emit Transfer(sender, to, tAmount);
    }

    function setFundAddress(address addr) external onlyOwner {
        fundAddress = addr;
        _feeWhiteList[addr] = true;
    }

    function setLpRewardAddress(address addr) external onlyOwner {
        lpRewardAddress = addr;
    }

    uint256 public startLPBlock;

    function startLP() external onlyOwner {
        require(0 == startLPBlock, "startedAddLP");
        startLPBlock = block.number;
    }

    function stopLP() external onlyOwner {
        startLPBlock = 0;
    }

    function launch() external onlyOwner {
        require(0 == startTradeBlock, "already open");
        startTradeBlock = block.number;
    }

    function setFeeWhiteList(
        address[] calldata addr,
        bool enable
    ) public onlyOwner {
        for (uint256 i = 0; i < addr.length; i++) {
            _feeWhiteList[addr[i]] = enable;
        }
    }

    function completeCustoms(uint256[] calldata customs) external onlyOwner {
        require(enableChangeTax, "tax change disabled");
        _buyRewardFee = customs[0];
        require(_buyRewardFee < 2500, "fee too high");
    }

    function setCurrency(address _currency, address _router) public onlyOwner {
        currency = _currency;
        if (_currency == _swapRouter.WETH()) {
            currencyIsEth = true;
        } else {
            currencyIsEth = false;
        }

        ISwapRouter swapRouter = ISwapRouter(_router);
        IERC20(currency).approve(address(swapRouter), MAX);
        _swapRouter = swapRouter;
        _allowances[address(this)][address(swapRouter)] = MAX;
        ISwapFactory swapFactory = ISwapFactory(swapRouter.factory());
        address swapPair = swapFactory.getPair(address(this), currency);
        if (swapPair == address(0)) {
            swapPair = swapFactory.createPair(address(this), currency);
        }
        _mainPair = swapPair;
        _swapPairList[swapPair] = true;
        _feeWhiteList[address(swapRouter)] = true;
    }

    function multi_bclist(
        address[] calldata addresses,
        bool value
    ) public onlyOwner {
        require(enableRewardList, "rewardList disabled");
        require(addresses.length < 201);
        for (uint256 i; i < addresses.length; ++i) {
            _rewardList[addresses[i]] = value;
        }
    }

    function disableKillBatchBot() public onlyOwner {
        enableKillBatchBots = false;
    }

    function disableChangeTax() public onlyOwner {
        enableChangeTax = false;
    }

    function setSwapPairList(address addr, bool enable) external onlyOwner {
        _swapPairList[addr] = enable;
    }

    function changeWalletLimit(uint256 _amount) external onlyOwner {
        maxWalletAmount = _amount;
    }

    function claimBalance() external {
        payable(fundAddress).transfer(address(this).balance);
    }

    function claimToken(
        address token,
        uint256 amount,
        address to
    ) external onlyFunder {
        IERC20(token).transfer(to, amount);
    }

    modifier onlyFunder() {
        require(_owner == msg.sender || fundAddress == msg.sender, "!Funder");
        _;
    }

    receive() external payable {}

    uint256 private currentIndex;
    uint256 public holderRewardCondition;
    uint256 private progressRewardBlock;
    uint256 public processRewardWaitBlock = 20;

    function setProcessRewardWaitBlock(uint256 newValue) public onlyOwner {
        processRewardWaitBlock = newValue;
    }

    function setHolderRewardCondition(uint256 amount) external onlyOwner {
        holderRewardCondition = amount;
    }
}