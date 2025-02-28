// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "../libraries/ERC20Base.sol";
import "../libraries/ERC20Capped.sol";
import "../libraries/ERC20Mintable.sol";
import "../libraries/ERC20Pausable.sol";
import "../libraries/Recoverable.sol";
import "../services/FeeProcessor.sol";

/**
 * @dev ERC20Token implementation with Mint, Cap, Pause, Recover capabilities
 */
contract ERC20Token is ERC20Base, ERC20Mintable, ERC20Pausable, ERC20Capped, Ownable, Recoverable, FeeProcessor {
    constructor(
        string memory name_,
        string memory symbol_,
        uint8 decimals_,
        uint256 initialSupply_,
        uint256 maxSupply_,
        address payable feeReceiver_
    )
        payable
        ERC20Base(name_, symbol_, decimals_)
        ERC20Capped(maxSupply_)
        FeeProcessor(feeReceiver_, 0x564ac55fdb85802837237d0d9e012d3c0fbf13f1ab785fb476b047ecedd3d5e9)
    {
        if (initialSupply_ > 0) _mint(_msgSender(), initialSupply_);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual override(ERC20, ERC20Pausable) {
        super._beforeTokenTransfer(from, to, amount);
    }

    /**
     * @dev Mint new tokens
     * only callable by `owner()`
     */
    function mint(address account, uint256 amount) external override onlyOwner {
        _mint(account, amount);
    }

    /**
     * @dev Mint new tokens
     */
    function _mint(address account, uint256 amount) internal virtual override(ERC20, ERC20Capped, ERC20Mintable) {
        super._mint(account, amount);
    }

    /**
     * @dev Pause the contract
     * only callable by `owner()`
     */
    function pause() external override onlyOwner {
        _pause();
    }

    /**
     * @dev Resume the contract
     * only callable by `owner()`
     */
    function resume() external override onlyOwner {
        _unpause();
    }

    /**
     * @dev Recover ETH stored in the contract
     * @param to The destination address
     * @param amount Amount to be sent
     * only callable by `owner()`
     */
    function recoverEth(address payable to, uint256 amount) external override onlyOwner {
        _recoverEth(to, amount);
    }

    /**
     * @dev Recover tokens stored in the contract
     * @param tokenAddress The token contract address
     * @param to The destination address
     * @param tokenAmount Number of tokens to be sent
     * only callable by `owner()`
     */
    function recoverTokens(
        address tokenAddress,
        address to,
        uint256 tokenAmount
    ) external override onlyOwner {
        _recoverTokens(tokenAddress, to, tokenAmount);
    }

    /**
     * @dev stop minting
     * only callable by `owner()`
     */
    function finishMinting() external virtual override onlyOwner {
        _finishMinting();
    }
}