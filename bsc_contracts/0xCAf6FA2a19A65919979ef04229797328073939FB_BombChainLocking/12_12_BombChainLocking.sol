import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

import "@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol";

// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract BombChainLocking is ContextUpgradeable {
    using SafeMathUpgradeable for uint256;
    using AddressUpgradeable for address;
    using SafeERC20Upgradeable for IERC20;

    // Info of each pool.
    struct TierInfo {
        uint256 tier1multiplier; // Divide by 100 to get multiplier.  I.E. use 300 for 3x, 250 for 2.5x, etc
        uint256 tier1maxAmount; // Max amount that can be in contract for this tier
        uint256 tier1currentAmount; // Current amount of this tier used
        uint256 tier2multiplier; // Divide by 100 to get multiplier.  I.E. use 300 for 3x, 250 for 2.5x, etc
        uint256 tier2maxAmount; // Max amount that can be in contract for this tier
        uint256 tier2currentAmount; // Current amount of this tier used
        uint256 tier3multiplier; // Divide by 100 to get multiplier.  I.E. use 300 for 3x, 250 for 2.5x, etc
        uint256 tier3maxAmount; // Max amount that can be in contract for this tier
        uint256 tier3currentAmount; // Current amount of this tier used
        uint256 tier4multiplier; // Divide by 100 to get multiplier.  I.E. use 300 for 3x, 250 for 2.5x, etc
        uint256 tier4maxAmount; // Max amount that can be in contract for this tier
        uint256 tier4currentAmount; // Current amount of this tier used
    }

    // Info of each user
    struct UserInfo {
        uint256 tier1amountDeposited;
        uint256 tier1amountWithReward;
        uint256 tier2amountDeposited;
        uint256 tier2amountWithReward;
        uint256 tier3amountDeposited;
        uint256 tier3amountWithReward;
        uint256 tier4amountDeposited;
        uint256 tier4amountWithReward;
        uint256 totalDeposited;
        uint256 totalWithReward;
        uint256 lastDepositedTimestamp;
        bool claimedReward;
    }

    IERC20 public bomb;

    address public dev;

    address private _operator;

    TierInfo public tierInfo;

    mapping(address => UserInfo) public userInfo;

    // The time when deposits open.
    uint256 public startTime;

    // The time when deposits ends.
    uint256 public endTime;

    uint256 public currentTier;

    event OperatorTransferred(
        address indexed previousOperator,
        address indexed newOperator
    );
    event Deposit(address indexed user, uint256 tier, uint256 amount);

    /* ========== FUNCTIONS ========== */

    // Info of each token.
    constructor(address _dev) {}

    // function __BombChainLocking_init(address _dev) internal initializer {
    //     __Context_init_unchained();
    //     __BombChainLocking_init_unchained(_dev);
    // }

    function initialize(address _dev) public initializer {
        dev = _dev;
        _operator = _dev;
        bomb = IERC20(address(0x522348779DCb2911539e76A1042aA922F9C47Ee3));
        startTime = 1668618000;
        endTime = 1670432400;
        tierInfo = TierInfo({
            tier1multiplier: 300,
            tier1maxAmount: 250000 ether,
            tier1currentAmount: 0,
            tier2multiplier: 250,
            tier2maxAmount: 500000 ether,
            tier2currentAmount: 0,
            tier3multiplier: 200,
            tier3maxAmount: 750000 ether,
            tier3currentAmount: 0,
            tier4multiplier: 150,
            tier4maxAmount: 1000000 ether,
            tier4currentAmount: 0
        });
        currentTier = 1;
        emit OperatorTransferred(address(0), _operator);
    }

    // Deposit Tokens
    function deposit(uint256 _tier, uint256 _amount) public {
        address _sender = msg.sender;
        require(_tier > 0 && _tier <= 4, "Tier must be between 1 and 4");
        uint256 multiplier;
        uint256 currentAmount;
        uint256 maxAmount;
        if (_tier == 1) {
            multiplier = tierInfo.tier1multiplier;
            currentAmount = tierInfo.tier1currentAmount;
            maxAmount = tierInfo.tier1maxAmount;
        } else if (_tier == 2) {
            multiplier = tierInfo.tier2multiplier;
            currentAmount = tierInfo.tier2currentAmount;
            maxAmount = tierInfo.tier2maxAmount;
        } else if (_tier == 3) {
            multiplier = tierInfo.tier3multiplier;
            currentAmount = tierInfo.tier3currentAmount;
            maxAmount = tierInfo.tier3maxAmount;
        } else if (_tier == 4) {
            multiplier = tierInfo.tier4multiplier;
            currentAmount = tierInfo.tier4currentAmount;
            maxAmount = tierInfo.tier4maxAmount;
        }

        require(
            _amount <= maxAmount - currentAmount,
            "Not enough available in this tier"
        );

        UserInfo storage user = userInfo[_sender];

        if (_amount > 0) {
            bomb.transferFrom(_sender, address(this), _amount);
            if (_tier == 1) {
                user.tier1amountDeposited = user.tier1amountDeposited.add(
                    _amount
                );
                user.tier1amountWithReward = user.tier1amountWithReward.add(
                    _amount.mul(multiplier).div(100)
                );
                user.totalDeposited = user.totalDeposited.add(_amount);
                user.totalWithReward = user.totalWithReward.add(
                    _amount.mul(multiplier).div(100)
                );
            } else if (_tier == 2) {
                user.tier2amountDeposited = user.tier2amountDeposited.add(
                    _amount
                );
                user.tier2amountWithReward = user.tier2amountWithReward.add(
                    _amount.mul(multiplier).div(100)
                );
                user.totalDeposited = user.totalDeposited.add(_amount);
                user.totalWithReward = user.totalWithReward.add(
                    _amount.mul(multiplier).div(100)
                );
            } else if (_tier == 3) {
                user.tier3amountDeposited = user.tier3amountDeposited.add(
                    _amount
                );
                user.tier3amountWithReward = user.tier3amountWithReward.add(
                    _amount.mul(multiplier).div(100)
                );
                user.totalDeposited = user.totalDeposited.add(_amount);
                user.totalWithReward = user.totalWithReward.add(
                    _amount.mul(multiplier).div(100)
                );
            } else if (_tier == 4) {
                user.tier4amountDeposited = user.tier4amountDeposited.add(
                    _amount
                );
                user.tier4amountWithReward = user.tier4amountWithReward.add(
                    _amount.mul(multiplier).div(100)
                );
                user.totalDeposited = user.totalDeposited.add(_amount);
                user.totalWithReward = user.totalWithReward.add(
                    _amount.mul(multiplier).div(100)
                );
            }
            user.lastDepositedTimestamp = block.timestamp;
        }

        emit Deposit(_sender, _tier, _amount);
    }

    /** wallet addresses setters **/
    function transferDev(address value) public onlyOwner {
        dev = value;
    }

    function operator() public view returns (address) {
        return _operator;
    }

    modifier onlyOperator() {
        require(
            _operator == _msgSender(),
            "operator: caller is not the operator"
        );
        _;
    }

    modifier onlyOwner() {
        require(dev == _msgSender(), "operator: caller is not the operator");
        _;
    }

    modifier ownerOrOperator() {
        require(
            dev == _msgSender() || _operator == _msgSender(),
            "operator: caller is not the operator"
        );
        _;
    }

    function isOperator() public view returns (bool) {
        return _msgSender() == _operator;
    }

    function transferOperator(address newOperator_) public onlyOwner {
        _transferOperator(newOperator_);
    }

    function _transferOperator(address newOperator_) internal {
        require(
            newOperator_ != address(0),
            "operator: zero address given for new operator"
        );
        emit OperatorTransferred(address(0), newOperator_);
        _operator = newOperator_;
    }

    /* ========== EMERGENCY ========== */

    function governanceRecoverUnsupported(IERC20 _token) external onlyOwner {
        _token.transfer(dev, _token.balanceOf(address(this)));
    }
}