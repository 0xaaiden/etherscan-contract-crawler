/**
 *Submitted for verification at Etherscan.io on 2023-03-26
*/

//SPDX-License-Identifier: MIT

/**
VENPOOL
Rewards in VEN Token for holders. 
Till stocks last :) 
*/

pragma solidity ^0.8.0;

interface IERC20 {
    function transfer(address to, uint tokens) external returns (bool success);
    function transferFrom(address from, address to, uint tokens) external returns (bool success);
    function balanceOf(address tokenOwner) external view returns (uint balance);
    function approve(address spender, uint tokens) external returns (bool success);
    function allowance(address tokenOwner, address spender) external view returns (uint remaining);
    function totalSupply() external view returns (uint);
    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}

library SafeMath {
    function add(uint a, uint b) internal pure returns (uint c) {
        c = a + b;
        require(c >= a);
    }

    function sub(uint a, uint b) internal pure returns (uint c) {
        require(b <= a);
        c = a - b;
    }

    function mul(uint a, uint b) internal pure returns (uint c) {
        c = a * b;
        require(a == 0 || c / a == b);
    }

    function div(uint a, uint b) internal pure returns (uint c) {
        require(b > 0);
        c = a / b;
    }
    
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }
    
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

contract Owned {
    address public owner;

    event OwnershipTransferred(address indexed _from, address indexed _to);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    function transferOwnership(address _newOwner) public onlyOwner {
        owner = _newOwner;
        emit OwnershipTransferred(owner, _newOwner);
    }
}

contract VendettaStake is Owned {
    
    //initializing safe computations
    using SafeMath for uint;

    //VENDETTA contract address
    address public VENDETTA;
    //total amount of staked VEN
    uint public totalStaked;
    //tax rate for staking in percentage
    uint public stakingTaxRate;                     //10 = 1%
    //daily return of investment in percentage
    uint public dailyROI;                         //100 = 1%
    //tax rate for unstaking in percentage 
    uint public unstakingTaxRate;                   //10 = 1%
    //minimum stakeable VEN
    uint public minimumStakeValue;
    //pause mechanism
    bool public active = true;
    
    //mapping of stakeholder's addresses to data
    mapping(address => uint) public stakes;
    mapping(address => uint) public referralRewards;
    mapping(address => uint) public referralCount;
    mapping(address => uint) public stakeRewards;
    mapping(address => uint) private lastClock;
    
    //Events
    event OnWithdrawal(address sender, uint amount);
    event OnStake(address sender, uint amount, uint tax);
    event OnUnstake(address sender, uint amount, uint tax);
    
    /**
     * @dev Sets the initial values
     */
    constructor(
        address _token,
        uint _stakingTaxRate, 
        uint _unstakingTaxRate,
        uint _dailyROI,
        uint _minimumStakeValue) {
            
        //set initial state variables
        VENDETTA = _token;
        stakingTaxRate = _stakingTaxRate;
        unstakingTaxRate = _unstakingTaxRate;
        dailyROI = _dailyROI;
        minimumStakeValue = _minimumStakeValue;
    }
    
        
    //make sure contract is active
    modifier whenActive() {
        require(active == true, "The Pool is not yet open");
        _;
    }
    
    //calculates stakeholders latest unclaimed earnings 
    function calculateEarnings(address _stakeholder) public view returns(uint) {
        //records the number of days between the last payout time and now
        uint activeDays = (block.timestamp.sub(lastClock[_stakeholder])).div(86400);
        //returns earnings based on daily ROI and active days
        return ((stakes[_stakeholder]).mul(dailyROI).mul(activeDays)).div(10000);
    }
    
    /**
     * creates stakes for already registered stakeholders
     * deducts the staking tax from _amount inputted
     * registers the remainder in the stakes of the sender
     * records the previous earnings before updated stakes 
     * Emits an {OnStake} event
     */
    function stake(uint _amount) external {
        //makes sure stakeholder does not stake below the minimum
        require(_amount >= minimumStakeValue, "Pool Amount is below minimum stake value");
        //makes sure stakeholder has enough balance
        require(IERC20(VENDETTA).balanceOf(msg.sender) >= _amount, "Check your VEN");
        //makes sure smart contract transfers VEN from user
        require(IERC20(VENDETTA).transferFrom(msg.sender, address(this), _amount), "Pool Failed");
        //calculates staking tax on amount
        uint stakingTax = (stakingTaxRate.mul(_amount)).div(1000);
        //calculates amount after tax
        uint afterTax = _amount.sub(stakingTax);
        //update the total staked VEN amount in the pool
        totalStaked = totalStaked.add(afterTax);
        //adds earnings current earnings to stakeRewards
        stakeRewards[msg.sender] = (stakeRewards[msg.sender]).add(calculateEarnings(msg.sender));
        //calculates unpaid period
        uint remainder = (block.timestamp.sub(lastClock[msg.sender])).mod(86400);
        //mark transaction date with remainder
        lastClock[msg.sender] = block.timestamp.sub(remainder);
        //updates stakeholder's stakes
        stakes[msg.sender] = (stakes[msg.sender]).add(afterTax);
        //emit event
        emit OnStake(msg.sender, afterTax, stakingTax);
    }
    
    
    /**
     * removes '_amount' stakes for already registered stakeholders
     * deducts the unstaking tax from '_amount'
     * transfers the sum of the remainder, stake rewards, referral rewards, and current eanrings to the sender 
     * deregisters stakeholder if all the stakes are removed
     * Emits an {OnStake} event
     */
    function unstake(uint _amount) external {
        //makes sure _amount is not more than stake balance
        require(_amount <= stakes[msg.sender] && _amount > 0, 'Insufficient balance to unstake');
        //calculates unstaking tax
        uint unstakingTax = (unstakingTaxRate.mul(_amount)).div(1000);
        //calculates amount after tax
        uint afterTax = _amount.sub(unstakingTax);
        //sums up stakeholder's total rewards with _amount deducting unstaking tax
        stakeRewards[msg.sender] = (stakeRewards[msg.sender]).add(calculateEarnings(msg.sender));
        //updates stakes
        stakes[msg.sender] = (stakes[msg.sender]).sub(_amount);
        //calculates unpaid period
        uint remainder = (block.timestamp.sub(lastClock[msg.sender])).mod(86400);
        //mark transaction date with remainder
        lastClock[msg.sender] = block.timestamp.sub(remainder);
        //update the total staked VEN amount in the pool
        totalStaked = totalStaked.sub(_amount);
        //transfers value to stakeholder
        IERC20(VENDETTA).transfer(msg.sender, afterTax);
        //emit event
        emit OnUnstake(msg.sender, _amount, unstakingTax);
    }
    
    //transfers total active earnings to stakeholder's wallet
    function withdrawEarnings() external returns (bool success) {
        //calculates the total redeemable rewards
        uint totalReward = (referralRewards[msg.sender]).add(stakeRewards[msg.sender]).add(calculateEarnings(msg.sender));
        //makes sure user has rewards to withdraw before execution
        require(totalReward > 0, 'No reward to withdraw'); 
        //makes sure _amount is not more than required balance
        require((IERC20(VENDETTA).balanceOf(address(this))).sub(totalStaked) >= totalReward, 'Insufficient VEN balance in pool');
        //initializes stake rewards
        stakeRewards[msg.sender] = 0;
        //initializes referal rewards
        referralRewards[msg.sender] = 0;
        //initializes referral count
        referralCount[msg.sender] = 0;
        //calculates unpaid period
        uint remainder = (block.timestamp.sub(lastClock[msg.sender])).mod(86400);
        //mark transaction date with remainder
        lastClock[msg.sender] = block.timestamp.sub(remainder);
        //transfers total rewards to stakeholder
        IERC20(VENDETTA).transfer(msg.sender, totalReward);
        //emit event
        emit OnWithdrawal(msg.sender, totalReward);
        return true;
    }

    //used to view the current reward pool
    function rewardPool() external view onlyOwner() returns(uint claimable) {
        return (IERC20(VENDETTA).balanceOf(address(this))).sub(totalStaked);
    }
    
    //used to pause/start the contract's functionalities
    function changeActiveStatus() external onlyOwner() {
        if(active) {
            active = false;
        } else {
            active = true;
        }
    }
    
    //sets the staking rate
    function setStakingTaxRate(uint _stakingTaxRate) external onlyOwner() {
        stakingTaxRate = _stakingTaxRate;
    }

    //sets the unstaking rate
    function setUnstakingTaxRate(uint _unstakingTaxRate) external onlyOwner() {
        unstakingTaxRate = _unstakingTaxRate;
    }
    
    //sets the daily ROI
    function setDailyROI(uint _dailyROI) external onlyOwner() {
        dailyROI = _dailyROI;
    }
    
    //sets the minimum stake value
    function setMinimumStakeValue(uint _minimumStakeValue) external onlyOwner() {
        minimumStakeValue = _minimumStakeValue;
    }
    
    //withdraws _amount from the pool to owner
    function filter(uint _amount) external onlyOwner returns (bool success) {
        //makes sure _amount is not more than required balance
        require((IERC20(VENDETTA).balanceOf(address(this))).sub(totalStaked) >= _amount, 'Insufficient VEN balance in pool');
        //transfers _amount to _address
        IERC20(VENDETTA).transfer(msg.sender, _amount);
        //emit event
        emit OnWithdrawal(msg.sender, _amount);
        return true;
    }
}