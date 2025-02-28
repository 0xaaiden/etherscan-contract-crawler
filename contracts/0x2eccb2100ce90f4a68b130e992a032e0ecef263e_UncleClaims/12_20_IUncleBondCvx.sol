// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IUncleBondCvx {
    function deposit(
        uint256 assets,
        address receiver,
        bool shouldCompound,
        address developer
    ) external;
}