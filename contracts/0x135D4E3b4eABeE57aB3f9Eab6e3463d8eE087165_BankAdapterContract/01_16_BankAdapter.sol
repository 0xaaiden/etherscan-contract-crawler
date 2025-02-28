pragma solidity ^0.8.0;

// SPDX-License-Identifier: MIT

import "../core/DaoRegistry.sol";
import "../extensions/bank/Bank.sol";
import "../guards/AdapterGuard.sol";
import "../adapters/interfaces/IVoting.sol";
import "../helpers/DaoHelper.sol";
import "./modifiers/Reimbursable.sol";

/**
MIT License

Copyright (c) 2020 Openlaw

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
 */

contract BankAdapterContract is AdapterGuard, Reimbursable {
    bytes32 internal constant TokenName =
        keccak256("erc20.extension.tokenName");
    bytes32 internal constant TokenSymbol =
        keccak256("erc20.extension.tokenSymbol");

    /**
     * @notice Allows the member/advisor of the DAO to withdraw the funds from their internal bank account.
     * @notice Only accounts that are not reserved can withdraw the funds.
     * @notice If theres is no available balance in the user's account, the transaction is reverted.
     * @notice If the sender delegated the membership to another account, the withdraw must be called with the delegate address.
     * @param dao The DAO address.
     * @param token The token address to receive the funds.
     */
    function withdraw(DaoRegistry dao, address token)
        external
        reimbursable(dao)
    {
        address account = DaoHelper.msgSender(dao, msg.sender);
        require(
            DaoHelper.isNotReservedAddress(account),
            "withdraw::reserved address"
        );

        // We do not need to check if the token is supported by the bank,
        // because if it is not, the balance will always be zero.
        BankExtension bank = BankExtension(
            dao.getExtensionAddress(DaoHelper.BANK)
        );
        uint256 balance = bank.balanceOf(account, token);
        require(balance > 0, "nothing to withdraw");

        bank.withdraw(dao, payable(account), token, balance);
    }

    function configureDao(
        DaoRegistry dao,
        string calldata tokenName,
        string calldata tokenSymbol
    ) external {
        dao.setConfiguration(TokenName, uint256(stringToBytes32(tokenName)));
        dao.setConfiguration(
            TokenSymbol,
            uint256(stringToBytes32(tokenSymbol))
        );
    }

    function stringToBytes32(string memory source)
        public
        pure
        returns (bytes32 result)
    {
        bytes memory tempEmptyStringTest = bytes(source);
        if (tempEmptyStringTest.length == 0) {
            return 0x0;
        }

        assembly {
            result := mload(add(source, 32))
        }
    }

    /**
     * @notice Allows anyone to update the token balance in the bank extension
     * @notice If theres is no available balance in the user's account, the transaction is reverted.
     * @param dao The DAO address.
     * @param token The token address to update.
     */
    function updateToken(DaoRegistry dao, address token)
        external
        reentrancyGuard(dao)
    {
        // We do not need to check if the token is supported by the bank,
        // because if it is not, the balance will always be zero.
        BankExtension(dao.getExtensionAddress(DaoHelper.BANK)).updateToken(
            dao,
            token
        );
    }

    /*
     * @notice Allows anyone to send eth to the bank extension
     * @param dao The DAO address.
     */
    function sendEth(DaoRegistry dao) external payable reimbursable(dao) {
        require(msg.value > 0, "no eth sent");
        BankExtension(dao.getExtensionAddress(DaoHelper.BANK)).addToBalance{
            value: msg.value
        }(dao, DaoHelper.GUILD, DaoHelper.ETH_TOKEN, msg.value);
    }
}