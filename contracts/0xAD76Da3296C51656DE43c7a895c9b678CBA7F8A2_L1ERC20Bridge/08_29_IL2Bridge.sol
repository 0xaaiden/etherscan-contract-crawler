pragma solidity ^0.8.0;

// SPDX-License-Identifier: MIT



/// @author Matter Labs
interface IL2Bridge {
    function initialize(
        address _l1Bridge,
        bytes32 _l2TokenProxyBytecodeHash,
        address _governor
    ) external;

    function finalizeDeposit(
        address _l1Sender,
        address _l2Receiver,
        address _l1Token,
        uint256 _amount,
        bytes calldata _data
    ) external;

    function withdraw(
        address _l1Receiver,
        address _l2Token,
        uint256 _amount
    ) external;

    function l1TokenAddress(address _l2Token) external view returns (address);

    function l2TokenAddress(address _l1Token) external view returns (address);

    function l1Bridge() external view returns (address);
}