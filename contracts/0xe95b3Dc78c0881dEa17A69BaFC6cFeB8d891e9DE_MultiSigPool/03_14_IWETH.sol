// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IWETH {
    function deposit() external payable;
    function approve(address to, uint256 value) external returns (bool);
    function transfer(address to, uint256 value) external returns (bool);
    function withdraw(uint256) external;
}