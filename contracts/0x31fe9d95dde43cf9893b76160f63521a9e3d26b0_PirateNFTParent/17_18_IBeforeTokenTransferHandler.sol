// SPDX-License-Identifier: MIT LICENSE

pragma solidity ^0.8.9;

interface IBeforeTokenTransferHandler {
    /**
     * Handles before token transfer events from a ERC721 contract
     */
    function beforeTokenTransfer(
        address tokenContract,
        address operator,
        address from,
        address to,
        uint256 tokenId
    ) external;
}