// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.18;

/**
 * @title IAaveFlashLoanReceiver interface
 * @notice Interface for the Aave fee IFlashLoanReceiver.
 * @author Bend
 * @dev implement this interface to develop a flashloan-compatible flashLoanReceiver contract
 **/
interface IAaveFlashLoanReceiver {
    function executeOperation(
        address[] calldata assets,
        uint256[] calldata amounts,
        uint256[] calldata premiums,
        address initiator,
        bytes calldata params
    ) external returns (bool);
}