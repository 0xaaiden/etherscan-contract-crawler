// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.7.6;
pragma abicoder v2;

import "./IAlgebraVirtualPoolBase.sol";

interface IAlgebraEternalVirtualPool is IAlgebraVirtualPoolBase {
    function rewardRate0() external view returns (uint256);

    function rewardRate1() external view returns (uint256);

    function rewardReserve0() external view returns (uint256);

    function rewardReserve1() external view returns (uint256);

    function totalRewardGrowth0() external view returns (uint256);

    function totalRewardGrowth1() external view returns (uint256);

    /// @notice Change reward rates
    /// @param rate0 The new rate of main token distribution per sec
    /// @param rate1 The new rate of bonus token distribution per sec
    function setRates(uint128 rate0, uint128 rate1) external;

    function addRewards(uint256 token0Amount, uint256 token1Amount) external;

    function getInnerRewardsGrowth(int24 bottomTick, int24 topTick)
        external
        view
        returns (uint256 rewardGrowthInside0, uint256 rewardGrowthInside1);
}