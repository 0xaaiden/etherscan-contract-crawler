// SPDX-License-Identifier: MIT License (MIT)





pragma solidity 0.6.12;

import "./IERC20.sol";


interface IERC20Permit is IERC20 {
    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;
}