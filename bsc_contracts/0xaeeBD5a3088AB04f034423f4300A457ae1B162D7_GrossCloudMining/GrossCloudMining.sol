/**
 *Submitted for verification at BscScan.com on 2022-09-29
*/

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract GrossCloudMining {
    using SafeMath for uint256;

    address public Dev;
    address public ecosystem = 0xFF878c92EDbc7a3dBcF697E01F8B462fB67Dd899;
    address public marketing = 0x1f3eBE485D1Bf9402Dc7eED9c9DF5865f3800b38;

    uint256 totalDeposits;
    uint256 public totalTx;
    uint256 public totalWithdrawnProfit;
    uint256 public totalMiners;
    uint256 public feePercentage = 100; //10%
    uint256 percentDivider = 1000;
    uint256 powerFactor = 10000000000;
    bool isSpecialCloudTierActive = false;

    uint256[4] public Duration = [365 days, 182 days, 121 days, 30 days];
    uint256[2] Sf = [800, 200];
    uint256[4] public totalDepositPerTier;
    uint256[4] public totalMinersPerTier;
    uint256[4] MinimumPerPlan = [0.05 ether, 0.2 ether, 1 ether, 0.5 ether];
    uint256[3] RefBonusPercentage = [100, 20, 10];
    uint256[4] MinimumHashRatePerTier = [20, 25, 30, 50];

    uint256 REF_COMPENSATION_FACTOR = 3;
    uint256 public LIBERTY_WITHDRAWALS = 100;
    uint256 maximumHashRate = 100; //10%
    uint256 minimumRewardConvertable = 1;
    uint256 HASH_RATE_COMPENSATOR = 1; //0.1%
    uint256 lastWithdrawPenalty = 100;

    struct Mine {
        uint256 tier;
        uint256 endtime;
        uint256 lastwithdrawtime;
        uint256 starttime;
        uint256 wattsamount;
        uint256 profitwithdrawn;
        bool ended;
    }

    struct Miner {
        uint256 totalDepositMiner;
        uint256 totalwithdrawnProfitMiner;
        uint256 lastWithdrawTime;
        uint256 depositCount;
        uint256 txDifference;
        address uplineAddress;
        uint256 downLinesCount;
        bool exists;
    }

    mapping(address => Miner) public Miners;
    mapping(address => mapping(uint256 => Mine)) public minersRecord;
    mapping(address => mapping(uint256 => uint256)) public minerDepositedPerTier;
    mapping(address => uint256) public deposits;

    event DEPOSIT(address Miner, uint256 amount);
    event WITHDRAW(address Miner, uint256 amount);

    modifier OnlyDev() {
        require(Dev == msg.sender, "Only Dev");
        _;
    }

    bool private reentrancySafe = false;

    modifier nonReentrant() {
        require(!reentrancySafe);
        reentrancySafe = true;
        _;
        reentrancySafe = false;
    }

    constructor(address _Dev) {
        Dev = payable(_Dev);
    }

    function deposit(address ref, uint256 tierIndex) public payable nonReentrant {
        require(tierIndex >= 0 && tierIndex <= 3, "Invalid tier index");
        require(msg.value >= MinimumPerPlan[tierIndex], "Amount lower than minimum");

        if(tierIndex == 3){
            require(isSpecialCloudTierActive == true, "Special Cloud tier closed for now. Follow our socials to know when next it will be available");
        }

        uint256 deposit_amount = msg.value;
        uint256 fee = calcFee(deposit_amount);
        uint256 after_tax = msg.value.sub(fee);
        uint256 watt_amount = toWatts(after_tax);

        commit(ecosystem, fee.mul(Sf[0]).div(percentDivider));
        commit(marketing, fee.mul(Sf[1]).div(percentDivider));

        //first time deposit
        if (!Miners[msg.sender].exists) {
            
            if(ref != address(0) && ref != msg.sender && ref != address(this) && !isContract(ref)){

                address ref_l2 = Miners[ref].uplineAddress;
                address ref_l3 = Miners[ref_l2].uplineAddress;

                commit(ref, after_tax.mul(RefBonusPercentage[0]).div(percentDivider));

                if(ref_l2 != address(0)){
                    commit(ref_l2, after_tax.mul(RefBonusPercentage[1]).div(percentDivider));
                }
                if(ref_l3 != address(0)){
                    commit(ref_l3, after_tax.mul(RefBonusPercentage[2]).div(percentDivider));
                }

                Miners[msg.sender].uplineAddress = ref;
                Miners[ref].downLinesCount++;
            }
        
            Miners[msg.sender].exists = true;
            totalMiners++;
            totalMinersPerTier[tierIndex]++;
        }

        uint256 index = Miners[msg.sender].depositCount;
        Miners[msg.sender].totalDepositMiner += deposit_amount;
        deposits[msg.sender] += deposit_amount;
        totalDeposits += deposit_amount;
        totalTx++;
        minersRecord[msg.sender][index].endtime = block.timestamp.add(Duration[tierIndex]);
        minersRecord[msg.sender][index].starttime = block.timestamp;
        minersRecord[msg.sender][index].lastwithdrawtime = block.timestamp;
        minersRecord[msg.sender][index].wattsamount = watt_amount;
        minersRecord[msg.sender][index].tier = tierIndex;
        minersRecord[msg.sender][index].profitwithdrawn = 0;
        Miners[msg.sender].depositCount++;
        Miners[msg.sender].txDifference--;
        minerDepositedPerTier[msg.sender][tierIndex] += deposit_amount;
        totalDepositPerTier[tierIndex] += deposit_amount;

        emit DEPOSIT(msg.sender, deposit_amount);
    }

    function getwithdrawable(address miner, uint256 watts_index) public view returns(uint256) {

        if(minersRecord[miner][watts_index].endtime < block.timestamp){
            minersRecord[miner][watts_index].ended == true;
        }

        require(minersRecord[miner][watts_index].ended == false, "Contract has ended");

        uint256 tier_index = minersRecord[miner][watts_index].tier;
        uint256 hash_rate = getHashRate(miner, tier_index);

        uint256 _daily = minersRecord[miner][watts_index].wattsamount.mul(hash_rate).div(percentDivider);
        uint256 _hourlyreward = _daily.div(24);
        uint256 _sincelastwithdraw = block.timestamp - minersRecord[miner][watts_index].lastwithdrawtime;
        uint256 _withdrawable = _hourlyreward.mul(_sincelastwithdraw) / 3600;

        return _withdrawable;
    }

    function withdrawProfit(uint256 wattsIndex) public {
        require(wattsIndex < Miners[msg.sender].depositCount, "Invalid index");
        require(block.timestamp.sub(minersRecord[msg.sender][wattsIndex].lastwithdrawtime) >= 86400, "Please wait next withdraw time");
        require(getwithdrawable(msg.sender, wattsIndex) > 1, "Not enough watts to withdraw");

        uint256 _withdrawable = getwithdrawable(msg.sender, wattsIndex);
        uint256 fee_on_watts = calcFee(_withdrawable);
        uint256 after_tax = _withdrawable.sub(fee_on_watts);
        uint256 bnb_withdrawable = toBnb(after_tax);
        uint256 bnb_fee = toBnb(fee_on_watts);
         
        commit(ecosystem, bnb_fee.mul(Sf[0]).div(percentDivider));
        commit(marketing, bnb_fee.mul(Sf[1]).div(percentDivider));
        commit(msg.sender, bnb_withdrawable);
        
        minersRecord[msg.sender][wattsIndex].profitwithdrawn += _withdrawable;
        Miners[msg.sender].totalwithdrawnProfitMiner += _withdrawable;
        Miners[msg.sender].lastWithdrawTime = block.timestamp;
        minersRecord[msg.sender][wattsIndex].lastwithdrawtime = block.timestamp;
        totalWithdrawnProfit += _withdrawable;

        if(Miners[msg.sender].txDifference > 0){
            Miners[msg.sender].txDifference++;
        }

        totalTx++;

        emit WITHDRAW(msg.sender, _withdrawable);
    }

    function calcFee(uint256 _input_amount) public view returns(uint256){
        return _input_amount.mul(feePercentage).div(percentDivider);
    }

    function commit(address _address, uint256 _amount) internal {
        (bool success, ) = _address.call{value: _amount}("");
        require(success, "Transfer failed.");
    }

    function getHashRate(address miner, uint256 tier_index) public view returns(uint256) {
        uint256 hash_rate = MinimumHashRatePerTier[tier_index];
        uint256 since_last_withdraw = block.timestamp.sub(Miners[miner].lastWithdrawTime);

        //After days of absense
        uint256 lw_days = since_last_withdraw.div(24 hours);
        if(lw_days >= lastWithdrawPenalty){
            hash_rate -= HASH_RATE_COMPENSATOR.mul(lw_days - 4);
        }

        // Extra upline benefits begins at count 3
        if(Miners[miner].downLinesCount >= 3){
            if(Miners[miner].downLinesCount >= 10){
                // More benefits for users with 10+ downlines
                hash_rate += Miners[miner].downLinesCount.mul(HASH_RATE_COMPENSATOR);
            }else{
                hash_rate += HASH_RATE_COMPENSATOR;
            }
        }

        if(Miners[miner].txDifference > LIBERTY_WITHDRAWALS){
            hash_rate -= HASH_RATE_COMPENSATOR.mul(Miners[miner].txDifference);
        }

        //Rate can not exceed 10%
        if(hash_rate > maximumHashRate){
            hash_rate = maximumHashRate;
        }

        //Can not fall less than 0.5%
        if(hash_rate < 5){
            hash_rate = 5;
        }

        return hash_rate;
    }

    function toWatts(uint256 _bnb_amount) public view returns(uint256){
        return _bnb_amount.mul(powerFactor).div(1 ether);
    }

    function toBnb(uint256 _watts_amount) public view returns(uint256){
        return _watts_amount.mul(1 ether).div(powerFactor);
    }

    function isContract(address addr) public view returns (bool) {
        uint size;
        assembly { size := extcodesize(addr) }
        return size > 0;
    }

    function setMineDuration(
        uint256 t1,
        uint256 t2,
        uint256 t3,
        uint256 cloud
    ) external OnlyDev {
        Duration[0] = t1;
        Duration[1] = t2;
        Duration[2] = t3;
        Duration[3] = cloud;
    }

    //Initializing a new special cloud tier
    function initiateCloud(
        uint256 cloud_duration,
        uint256 cloud_minimum_deposit,
        uint256 cloud_minimum_hash_rate
    ) external OnlyDev {
        Duration[3] = cloud_duration;
        MinimumPerPlan[3] = cloud_minimum_deposit;
        MinimumHashRatePerTier[3] = cloud_minimum_hash_rate;
    }

    function changeDev(address _dev) external OnlyDev {
        Dev = _dev;
    }

    function setPercentDivider(uint256 _div) external OnlyDev {
        percentDivider = _div;
    }

    function setFeePercentage(uint256 _perc) external OnlyDev {
        require(100 >= _perc, "Can not set fee more than 10%");
        feePercentage = _perc;
    }

    function ce(address payable _ecosystem) external OnlyDev {
        ecosystem = _ecosystem;
    }

    function cm(address payable _mkt) external OnlyDev {
        marketing = _mkt;
    }

    function updatePowerFactor(uint256 _pf) external OnlyDev {
        powerFactor = _pf;
    }

    function updateLiberty(uint256 _lbt) external OnlyDev {
        LIBERTY_WITHDRAWALS = _lbt;
    }

    function setSpecialCloudStatus(bool _sct) external OnlyDev {
        isSpecialCloudTierActive = _sct;
    }

    function updateLastWithdrawPenalty(uint256 _lwp) external OnlyDev {
        lastWithdrawPenalty = _lwp;
    }

}

library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-Tiers/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    function mod(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}