// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.17;

interface IPayments {
    function releaseAllETH() external;

    function releaseAllToken(address tokenAddress) external;
}