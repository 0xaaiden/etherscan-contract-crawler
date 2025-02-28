// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

interface IConicLPTokenStaker {
    function getUserBalanceForPool(
        address conicPool,
        address account
    ) external view returns (uint256);
}