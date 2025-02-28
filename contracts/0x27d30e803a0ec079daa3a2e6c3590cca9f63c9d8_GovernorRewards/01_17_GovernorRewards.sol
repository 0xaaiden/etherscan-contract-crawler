// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;
pragma abicoder v2;

// OpenZeppelin v4
import { Initializable } from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import { OwnableUpgradeable } from  "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import { Treasury } from "../treasury/Treasury.sol";
import { Staking } from "../governance/Staking.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { SafeERC20 } from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import { Math } from "@openzeppelin/contracts/utils/math/Math.sol";
import { BitMaps } from "@openzeppelin/contracts/utils/structs/BitMaps.sol";

/**
 * @title GovernorRewards
 * @author Railgun Contributors
 * @notice Distributes treasury funds to active governor
 */
contract GovernorRewards is Initializable, OwnableUpgradeable {
  using SafeERC20 for IERC20;
  using BitMaps for BitMaps.BitMap;

  // NOTE: The order of instantiation MUST stay the same across upgrades
  // add new variables to the bottom of the list
  // See https://docs.openzeppelin.com/learn/upgrading-smart-contracts#upgrading

  // Staking contract
  Staking public staking;

  // Treasury contract
  Treasury public treasury;

  // Staking intervals per distribution interval
  uint256 public constant STAKING_DISTRIBUTION_INTERVAL_MULTIPLIER = 14; // 14 days

  // Staking contract constant imported locally for cheaper calculations
  // solhint-disable-next-line var-name-mixedcase
  uint256 public STAKING_DEPLOY_TIME;

  // Distribution interval, calculated at initialization time
  // solhint-disable-next-line var-name-mixedcase
  uint256 public DISTRIBUTION_INTERVAL;

  // Number of basis points that equal 100%
  uint256 public constant BASIS_POINTS = 10000;

  // Basis points to distribute each interval
  uint256 public intervalBP;

  // Fee distribution claimed
  event Claim(IERC20 token, address account, uint256 amount, uint256 startInterval, uint256 endInterval);

  // Bitmap of claimed intervals
  // Internal types not allowed on public variables so custom getter needs to be created
  // Account -> Token -> IntervalClaimed
  mapping(address => mapping(IERC20 => BitMaps.BitMap)) private claimedBitmap;

  // Earmaked tokens for each interval
  // Token -> Interval -> Amount
  mapping(IERC20 => mapping(uint256 => uint256)) public earmarked;

  // Tokens to airdrop
  mapping(IERC20 => bool) public tokens;

  // Next interval to earmark for each token
  mapping(IERC20 => uint256) public nextEarmarkInterval;

  // Next interval to precalculate global snapshot data for
  uint256 public nextSnapshotPreCalcInterval;

  // Precalculated global snapshots
  mapping(uint256 => uint256) public precalculatedGlobalSnapshots;

  /**
   * @notice Sets contracts addresses and initial value
   * @param _owner - initial owner address
   * @param _staking - Staking contract address
   * @param _treasury - Treasury contract address
   * @param _startingInterval - interval to start distribution at
   * @param _tokens - tokens to distribute
   */
  function initializeGovernorRewards(
    address _owner,
    Staking _staking,
    Treasury _treasury,
    uint256 _startingInterval,
    IERC20[] calldata _tokens
  ) external initializer {
    // Call initializers
    OwnableUpgradeable.__Ownable_init();

    // Set owner
    OwnableUpgradeable.transferOwnership(_owner);

    // Set contract addresses
    treasury = _treasury;
    staking = _staking;

    // Get staking contract constants
    STAKING_DEPLOY_TIME = staking.DEPLOY_TIME();
    DISTRIBUTION_INTERVAL = staking.SNAPSHOT_INTERVAL() * STAKING_DISTRIBUTION_INTERVAL_MULTIPLIER;

    // Set starting interval
    nextSnapshotPreCalcInterval = _startingInterval;

    // Set initial tokens to distribute
    for (uint256 i = 0; i < _tokens.length; i += 1) {
      tokens[_tokens[i]] = true;
    }
  }

  /**
   * @notice Gets wheather a interval has been claimed or not
   * @param _account - account to check claim status for
   * @param _token - token to get claim status for
   * @param _interval - interval to check for
   * @return claimed
   */
  function getClaimed(address _account, IERC20 _token, uint256 _interval) external view returns (bool) {
    return claimedBitmap[_account][_token].get(_interval);
  }

  /**
   * @notice Sets new distribution rate
   * @param _newIntervalBP - new distribution rate
   */
  function setIntervalBP(uint256 _newIntervalBP) external onlyOwner {
    intervalBP = _newIntervalBP;
  }

  /**
   * @notice Gets interval at time
   * @param _time - time to get interval of
   * @return interval
   */
  function intervalAtTime(uint256 _time) public view returns (uint256) {
    require(_time >= STAKING_DEPLOY_TIME, "GovernorRewards: Requested time is before contract was deployed");
    return (_time - STAKING_DEPLOY_TIME) / DISTRIBUTION_INTERVAL;
  }

  /**
   * @notice Converts distribution interval to staking interval
   * @param _distributionInterval - distribution interval to get staking interval of
   * @return staking interval
   */
  function distributionIntervalToStakingInterval(uint256 _distributionInterval) public pure returns (uint256) {
    return _distributionInterval * STAKING_DISTRIBUTION_INTERVAL_MULTIPLIER;
  }

  /**
   * @notice Gets current interval
   * @return interval
   */
  function currentInterval() public view returns (uint256) {
    return intervalAtTime(block.timestamp);
  }

  /**
   * @notice Adds new tokens to distribution set
   * @param _tokens - new tokens to distribute
   */
  function addTokens(IERC20[] calldata _tokens) external onlyOwner {
    // Add tokens to distribution set
    for (uint256 i = 0; i < _tokens.length; i += 1) {
      tokens[_tokens[i]] = true;
      nextEarmarkInterval[_tokens[i]] = currentInterval();
    }
  }

  /**
   * @notice Removes tokens from distribution set
   * @param _tokens - tokens to stop distributing
   */
  function removeTokens(IERC20[] calldata _tokens) external onlyOwner {
    // Add tokens to distribution set
    for (uint256 i = 0; i < _tokens.length; i += 1) {
      tokens[_tokens[i]] = false;
    }
  }

  /**
   * @notice Fetch and decompress global voting power snapshots
   * @param _startingInterval - starting interval to fetch from
   * @param _endingInterval - interval to fetch to
   * @param _hints - off-chain computed indexes of intervals
   * @return array of snapshot data
   */
  function fetchGlobalSnapshots(
    uint256 _startingInterval,
    uint256 _endingInterval,
    uint256[] calldata _hints
  ) public view returns (uint256[] memory) {
    uint256 length = _endingInterval - _startingInterval + 1;

    require(_hints.length == length, "GovernorRewards: Incorrect number of hints given");

    // Create snapshots array
    uint256[] memory snapshots = new uint256[](length);

    // Loop through each requested snapshot and retrieve voting power
    for (uint256 i = 0; i < length; i += 1) {
      snapshots[i] = staking.globalsSnapshotAt(
        distributionIntervalToStakingInterval(_startingInterval + i),
        _hints[i]
      ).totalVotingPower;
    }

    // Return voting power
    return snapshots;
  }

  /**
   * @notice Fetch and decompress series of account snapshots
   * @param _startingInterval - starting interval to fetch from
   * @param _endingInterval - interval to fetch to
   * @param _account - account to get snapshot of
   * @param _hints - off-chain computed indexes of intervals
   * @return array of snapshot data
   */
  function fetchAccountSnapshots(
    uint256 _startingInterval,
    uint256 _endingInterval,
    address _account,
    uint256[] calldata _hints
  ) public view returns (uint256[] memory) {
    uint256 length = _endingInterval - _startingInterval + 1;

    require(_hints.length == length, "GovernorRewards: Incorrect number of hints given");

    // Create snapshots array
    uint256[] memory snapshots = new uint256[](length);

    // Loop through each requested snapshot and retrieve voting power
    for (uint256 i = 0; i < length; i += 1) {
      snapshots[i] = staking.accountSnapshotAt(
        _account,
        distributionIntervalToStakingInterval(_startingInterval + i),
        _hints[i]
      ).votingPower;
    }

    // Return voting power
    return snapshots;
  }

  /**
   * @notice Earmarks tokens for past intervals
   * @param _token - token to calculate earmarks for
   */
  function earmark(IERC20 _token) public {
    // Check that token is on distribution list
    require(tokens[_token], "GovernorRewards: Token is not on distribution list");

    // Get intervals
    // Will throw if nextSnapshotPreCalcInterval = 0
    uint256 _calcToInterval = nextSnapshotPreCalcInterval - 1;
    uint256 _calcFromInterval = nextEarmarkInterval[_token];

    // Get token earmarked array
    mapping(uint256 => uint256) storage tokenEarmarked = earmarked[_token];

    // Don't process if we haven't advanced at least one interval
    if (_calcToInterval >= _calcFromInterval) {
      // Get balance from treasury
      uint256 treasuryBalance = _token.balanceOf(address(treasury));

      // Get distribution amount per interval
      uint256 distributionAmountPerInterval = treasuryBalance * intervalBP / BASIS_POINTS
        / (_calcToInterval - _calcFromInterval + 1);

      // Get total distribution amount
      uint256 totalDistributionAmounts = 0;

      // Store earmarked amounts
      for (uint256 i = _calcFromInterval; i <= _calcToInterval; i += 1) {
        // Skip for intervals that have no voting power as those tokens will be unclaimable
        if (precalculatedGlobalSnapshots[i] > 0) {
          tokenEarmarked[i] = distributionAmountPerInterval;
          totalDistributionAmounts += distributionAmountPerInterval;
        }
      }

      // Transfer tokens
      treasury.transferERC20(_token, address(this), totalDistributionAmounts);

      // Store last earmarked interval for token
      nextEarmarkInterval[_token] = _calcToInterval + 1;
    }
  }

  /**
   * @notice Prefetches global snapshot data
   * @param _startingInterval - starting interval to fetch from
   * @param _endingInterval - interval to fetch to
   * @param _hints - off-chain computed indexes of intervals
   */
  function prefetchGlobalSnapshots(
    uint256 _startingInterval,
    uint256 _endingInterval,
    uint256[] calldata _hints,
    IERC20[] calldata _postProcessTokens
  ) external {
    uint256 length = _endingInterval - _startingInterval + 1;

    require(_startingInterval <= nextSnapshotPreCalcInterval, "GovernorRewards: Starting interval too late");
    require(_endingInterval <= currentInterval(), "GovernorRewards: Can't prefetch future intervals");

    // Fetch snapshots
    uint256[] memory snapshots = fetchGlobalSnapshots(
      _startingInterval,
      _endingInterval,
      _hints
    );

    // Store precalculated snapshots
    for (uint256 i = 0; i < length; i+= 1) {
      precalculatedGlobalSnapshots[_startingInterval + i] = snapshots[i];
    }

    // Set next precalc interval
    nextSnapshotPreCalcInterval = _endingInterval + 1;

    for (uint256 i = 0; i < _postProcessTokens.length; i += 1) {
      earmark(_postProcessTokens[i]);
    }
  }

  /**
   * @notice Calculates rewards to payout for each token
   * @param _tokens - tokens to calculate rewards for
   * @param _account - account to calculate rewards for
   * @param _startingInterval - starting interval to calculate from
   * @param _endingInterval - interval to calculate to
   * @param _hints - off-chain computed indexes of intervals
   * @param _ignoreClaimed - whether to include already claimed tokens in calculation
   */
  function calculateRewards(
    IERC20[] calldata _tokens,
    address _account,
    uint256 _startingInterval,
    uint256 _endingInterval,
    uint256[] calldata _hints,
    bool _ignoreClaimed
  ) public view returns (uint256[] memory) {
    // Get account snapshots
    uint256[] memory accountSnapshots = fetchAccountSnapshots(_startingInterval, _endingInterval, _account, _hints);

    // Loop through each token and accumulate reward
    uint256[] memory rewards = new uint256[](_tokens.length);
    for (uint256 token = 0; token < _tokens.length; token += 1) {
      require(_endingInterval < nextEarmarkInterval[_tokens[token]], "GovernorRewards: Tried to claim beyond last earmarked interval");

      // Get claimed bitmap for token
      BitMaps.BitMap storage tokenClaimedMap = claimedBitmap[_account][_tokens[token]];

      // Get earmarked for token
      mapping(uint256 => uint256) storage tokenEarmarked = earmarked[_tokens[token]];

      // Loop through each snapshot and accumulate rewards
      uint256 tokenReward = 0;
      for (uint256 interval = _startingInterval; interval <= _endingInterval; interval += 1) {
        // Skip if already claimed if we're ignoring claimed amounts
        if (!_ignoreClaimed || !tokenClaimedMap.get(interval)) {
          tokenReward += tokenEarmarked[interval]
            * accountSnapshots[interval - _startingInterval]
            / precalculatedGlobalSnapshots[interval - _startingInterval];
        }
      }
      rewards[token] = tokenReward;
    }

    return rewards;
  }

  /**
   * @notice Pays out rewards for block of 
   * @param _tokens - tokens to calculate rewards for
   * @param _account - account to calculate rewards for
   * @param _startingInterval - starting interval to calculate from
   * @param _endingInterval - interval to calculate to
   * @param _hints - off-chain computed indexes of intervals=
   */
  function claim(
    IERC20[] calldata _tokens,
    address _account,
    uint256 _startingInterval,
    uint256 _endingInterval,
    uint256[] calldata _hints
  ) external {
    // Calculate rewards
    uint256[] memory rewards = calculateRewards(
      _tokens,
      _account,
      _startingInterval,
      _endingInterval,
      _hints,
      true
    );

    // Mark all claimed intervals
    for (uint256 token = 0; token < _tokens.length; token += 1) {
      // Get claimed bitmap for token
      BitMaps.BitMap storage tokenClaimedMap = claimedBitmap[_account][_tokens[token]];

      // Set all claimed intervals
      for (uint256 interval = _startingInterval; interval <= _endingInterval; interval += 1) {
        tokenClaimedMap.set(interval);
      }
    }

    // Loop through and transfer tokens (seperate loop to prevent reentrancy)
    for (uint256 token = 0; token < _tokens.length; token += 1) {
      _tokens[token].safeTransfer(_account, rewards[token]);
      emit Claim(_tokens[token], _account, rewards[token], _startingInterval, _endingInterval);
    }
  }
}