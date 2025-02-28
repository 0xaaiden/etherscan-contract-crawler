// SPDX-License-Identifier: GPL-3.0-only
pragma solidity 0.8.9;

import { Initializable } from "@openzeppelin/contracts/proxy/utils/Initializable.sol";
import { ReentrancyGuard } from "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { SafeERC20 } from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

import { LevelXToken } from "./LevelXToken.sol";

interface MasterChef
{
	function bankroll() external view returns (address _bankroll);
	function poolInfo(uint256 _pid) external view returns (address _token, uint256 _allocPoint, uint256 _lastRewardTime, uint256 _accRewardPerShare, uint256 _amount, uint256 _depositFee, uint256 _withdrawalFee, uint256 _epochAccRewardPerShare);
	function userInfo(uint256 _pid, address _account) external view returns (uint256 _amount, uint256 _rewardDebt, uint256 _unclaimedReward);

	function depositOnBehalfOf(uint256 _pid, uint256 _amount, address _account, address _referral) external;
}

contract LevelXWrapperToken is Initializable, ReentrancyGuard, ERC20
{
	using SafeERC20 for IERC20;

	struct RewardInfo {
		uint256 totalReward;
		uint256 accRewardPerShare;
	}

	struct AccountInfo {
		bool exists;
		uint256 shares;
		mapping(address => AccountRewardInfo) rewardInfo;
	}

	struct AccountRewardInfo {
		uint256 rewardDebt;
		uint256 unclaimedReward;
	}

	address payable public token;
	address public wrapperTokenBridge;
	address public masterChef;
	uint256 public pid;

	address[] public accountIndex;
	mapping(address => AccountInfo) public accountInfo;

	mapping(address => RewardInfo) public rewardInfo;
	mapping(address => uint256) public rewardPid;

	function accountIndexLength() external view returns (uint256 _length)
	{
		return accountIndex.length;
	}

	function accountRewardInfo(address _account, address _rewardToken) external view returns (AccountRewardInfo memory _accountRewardInfo)
	{
		return accountInfo[_account].rewardInfo[_rewardToken];
	}

	constructor(address payable _token, address _wrapperTokenBridge, address _masterChef, uint256 _pid, uint256[] memory _rewardPid)
		ERC20("", "")
	{
		initialize(_token, _wrapperTokenBridge, _masterChef, _pid, _rewardPid);
	}

	function name() public pure override returns (string memory _name)
	{
		return "LevelX Wrapper Token";
	}

	function symbol() public pure override returns (string memory _symbol)
	{
		return "LVLXWT";
	}

	function initialize(address payable _token, address _wrapperTokenBridge, address _masterChef, uint256 _pid, uint256[] memory _rewardPid) public initializer
	{
		token = _token;
		wrapperTokenBridge = _wrapperTokenBridge;
		masterChef = _masterChef;
		pid = _pid;
		for (uint256 _i = 0; _i < _rewardPid.length; _i++) {
			address _rewardToken = LevelXToken(_token).rewardIndex(_i + 1);
			rewardPid[_rewardToken] = _rewardPid[_i];
		}
	}

	function migrate() external
	{
		{
			address XGRO = 0x4AdAE3Ad22c4e8fb56D4Ae5C7Eb3abC0dd2d3379;
			require(rewardPid[XGRO] == 0, "invalid state");
			rewardPid[XGRO] = 56;
		}
		{
			address EMP = 0x3b248CEfA87F836a4e6f6d6c9b42991b88Dc1d58;
			require(rewardPid[EMP] == 0, "invalid state");
			rewardPid[EMP] = 60;
		}
	}

	function totalReserve() public returns (uint256 _totalReserve)
	{
		return LevelXToken(token).computeBalanceOf(address(this));
	}

	function deposit(uint256 _amount, address _account) external nonReentrant returns (uint256 _shares)
	{
		require(msg.sender == wrapperTokenBridge, "access denied");
		_claimRewards();
		{
			uint256 _totalSupply = totalSupply();
			uint256 _totalReserve = totalReserve();
			IERC20(token).safeTransferFrom(msg.sender, address(this), _amount);
			uint256 _newTotalReserve = totalReserve();
			_amount = _newTotalReserve - _totalReserve;
			_shares = _calcSharesFromAmount(_totalReserve, _totalSupply, _amount);
			_mint(msg.sender, _shares);
		}
		_updateAccount(_account, int256(_shares));
		emit Deposit(_account, _shares);
		return _shares;
	}

	function withdraw(uint256 _shares) external returns (uint256 _amount)
	{
		return withdraw(_shares, msg.sender);
	}

	function withdraw(uint256 _shares, address _account) public nonReentrant returns (uint256 _amount)
	{
		require(msg.sender == _account || msg.sender == wrapperTokenBridge, "access denied");
		_claimRewards();
		{
			uint256 _totalSupply = totalSupply();
			uint256 _totalReserve = totalReserve();
			_amount = _calcAmountFromShares(_totalReserve, _totalSupply, _shares);
			_burn(msg.sender, _shares);
			IERC20(token).safeTransfer(msg.sender, _amount);
		}
		_updateAccount(_account, -int256(_shares));
		_sync(_account);
		emit Withdraw(_account, _shares);
		return _amount;
	}

	function bumpLevel() external nonReentrant
	{
		uint256 _level = LevelXToken(token).computeLevelOf(address(this));
		uint256 _totalShares = LevelXToken(token).computeTotalShares();
		uint256 _totalActiveSupply = LevelXToken(token).computeTotalActiveSupply();
		uint256 _averageLevel = _totalShares * 1e18 / _totalActiveSupply;
		require(_level < _averageLevel, "not available");
		uint256 _amount = LevelXToken(token).burnAmountToBumpLevel();
		IERC20(token).safeTransferFrom(msg.sender, address(this), _amount);
		LevelXToken(token).bumpLevel();
		uint256 _newLevel = LevelXToken(token).computeLevelOf(address(this));
		emit BumpLevel(msg.sender, _amount, _newLevel - _level);
	}

	function claim(address _account) external
	{
		// ignored no need to auto claim by the bridge
	}

	function claimAll() external nonReentrant returns (uint256[] memory _rewardAmounts)
	{
		_claimRewards();
		_updateAccount(msg.sender, 0);
		{
			uint256 _length = LevelXToken(token).rewardIndexLength();
			_rewardAmounts = new uint256[](_length - 1);
			for (uint256 _i = 1; _i < _length; _i++) {
				_rewardAmounts[_i - 1] = _claim(msg.sender, _i);
			}
		}
		return _rewardAmounts;
	}

	function compoundAll() external nonReentrant returns (uint256[] memory _rewardAmounts)
	{
		_claimRewards();
		_updateAccount(msg.sender, 0);
		{
			uint256 _length = LevelXToken(token).rewardIndexLength();
			_rewardAmounts = new uint256[](_length - 1);
			for (uint256 _i = 1; _i < _length; _i++) {
				_rewardAmounts[_i - 1] = _compound(msg.sender, _i);
			}
		}
		return _rewardAmounts;
	}

	function claim(uint256 _i) external nonReentrant returns (uint256 _rewardAmount)
	{
		require(_i + 1 < LevelXToken(token).rewardIndexLength(), "invalid index");
		_claimRewards();
		_updateAccount(msg.sender, 0);
		return _claim(msg.sender, _i + 1);
	}

	function compound(uint256 _i) external nonReentrant returns (uint256 _rewardAmount)
	{
		require(_i + 1 < LevelXToken(token).rewardIndexLength(), "invalid index");
		_claimRewards();
		_updateAccount(msg.sender, 0);
		return _compound(msg.sender, _i + 1);
	}

	function _claim(address _account, uint256 _i) internal returns (uint256 _rewardAmount)
	{
		address _rewardToken = LevelXToken(token).rewardIndex(_i);
		AccountRewardInfo storage _accountRewardInfo = accountInfo[_account].rewardInfo[_rewardToken];
		_rewardAmount = _accountRewardInfo.unclaimedReward;
		if (_rewardAmount > 0) {
			_accountRewardInfo.unclaimedReward = 0;
			rewardInfo[_rewardToken].totalReward -= _rewardAmount;
			IERC20(_rewardToken).safeTransfer(_account, _rewardAmount);
		}
		emit Claim(_account, _rewardToken, _rewardAmount);
		return _rewardAmount;
	}

	function _compound(address _account, uint256 _i) internal returns (uint256 _rewardAmount)
	{
		address _rewardToken = LevelXToken(token).rewardIndex(_i);
		AccountRewardInfo storage _accountRewardInfo = accountInfo[_account].rewardInfo[_rewardToken];
		_rewardAmount = _accountRewardInfo.unclaimedReward;
		if (_rewardAmount > 0) {
			_accountRewardInfo.unclaimedReward = 0;
			rewardInfo[_rewardToken].totalReward -= _rewardAmount;
			IERC20(_rewardToken).approve(masterChef, _rewardAmount);
			MasterChef(masterChef).depositOnBehalfOf(rewardPid[_rewardToken], _rewardAmount, _account, address(0));
		}
		emit Compound(_account, _rewardToken, _rewardAmount);
		return _rewardAmount;
	}

	function _beforeTokenTransfer(address _from, address _to, uint256 _shares) internal override
	{
		if (_from == address(0) || _to == address(0)) return;
		if (msg.sender == masterChef && (_from == masterChef || _to == masterChef || _from == wrapperTokenBridge || _to == wrapperTokenBridge)) return;
		_claimRewards();
		_updateAccount(_from, -int256(_shares));
		_updateAccount(_to, int256(_shares));
	}

	function syncAll() external nonReentrant
	{
		_claimRewards();
		for (uint256 _i = 0; _i < accountIndex.length; _i++) {
			_sync(accountIndex[_i]);
		}
	}

	function _sync(address _account) internal
	{
		address _bankroll = MasterChef(masterChef).bankroll();
		if (_account == _bankroll) return;
		(address _token,,,,,,,) = MasterChef(masterChef).poolInfo(pid);
		require(_token == address(this), "invalid pid");
		uint256 _balance = balanceOf(_account);
		(uint256 _stake,,) = MasterChef(masterChef).userInfo(pid, _account);
		uint256 _shares = _balance + _stake;
		if (accountInfo[_account].shares <= _shares) return;
		uint256 _excess = accountInfo[_account].shares - _shares;
		_updateAccount(_account, -int256(_excess));
		_updateAccount(_bankroll, int256(_excess));
	}

	function _updateAccount(address _account, int256 _shares) internal
	{
		AccountInfo storage _accountInfo = accountInfo[_account];
		if (!_accountInfo.exists) {
			_accountInfo.exists = true;
			accountIndex.push(_account);
		}
		if (_accountInfo.shares > 0) {
			uint256 _length = LevelXToken(token).rewardIndexLength();
			for (uint256 _i = 1; _i < _length; _i++) {
				address _rewardToken = LevelXToken(token).rewardIndex(_i);
				RewardInfo storage _rewardInfo = rewardInfo[_rewardToken];
				AccountRewardInfo storage _accountRewardInfo = _accountInfo.rewardInfo[_rewardToken];
				_accountRewardInfo.unclaimedReward += _accountInfo.shares * _rewardInfo.accRewardPerShare / 1e36 - _accountRewardInfo.rewardDebt;
			}
		}
		if (_shares > 0) {
			_accountInfo.shares += uint256(_shares);
		}
		else
		if (_shares < 0) {
			_accountInfo.shares -= uint256(-_shares);
		}
		{
			uint256 _length = LevelXToken(token).rewardIndexLength();
			for (uint256 _i = 1; _i < _length; _i++) {
				address _rewardToken = LevelXToken(token).rewardIndex(_i);
				RewardInfo storage _rewardInfo = rewardInfo[_rewardToken];
				AccountRewardInfo storage _accountRewardInfo = _accountInfo.rewardInfo[_rewardToken];
				_accountRewardInfo.rewardDebt = _accountInfo.shares * _rewardInfo.accRewardPerShare / 1e36;
			}
		}
	}

	function _calcSharesFromAmount(uint256 _totalReserve, uint256 _totalSupply, uint256 _amount) internal pure virtual returns (uint256 _shares)
	{
		if (_totalReserve == 0) return _amount;
		return _amount * _totalSupply / _totalReserve;
	}

	function _calcAmountFromShares(uint256 _totalReserve, uint256 _totalSupply, uint256 _shares) internal pure virtual returns (uint256 _amount)
	{
		if (_totalSupply == 0) return _totalReserve;
		return _shares * _totalReserve / _totalSupply;
	}

	function _claimRewards() internal
	{
		uint256 _totalSupply = totalSupply();
		if (_totalSupply > 0) {
			uint256 _length = LevelXToken(token).rewardIndexLength();
			for (uint256 _i = 1; _i < _length; _i++) {
				LevelXToken(token).claim(_i);
				address _rewardToken = LevelXToken(token).rewardIndex(_i);
				RewardInfo storage _rewardInfo = rewardInfo[_rewardToken];
				uint256 _rewardBalance = IERC20(_rewardToken).balanceOf(address(this));
				uint256 _rewardAmount = _rewardBalance - _rewardInfo.totalReward;
				if (_rewardAmount > 0) {
					_rewardInfo.totalReward = _rewardBalance;
					_rewardInfo.accRewardPerShare += _rewardAmount * 1e36 / _totalSupply;
				}
			}
		}
	}

	event Deposit(address indexed _account, uint256 _shares);
	event Withdraw(address indexed _account, uint256 _shares);
	event BumpLevel(address indexed _account, uint256 _amount, uint256 _levelBump);
	event Claim(address indexed _account, address indexed _rewardToken, uint256 _rewardAmount);
	event Compound(address indexed _account, address indexed _rewardToken, uint256 _rewardAmount);
}