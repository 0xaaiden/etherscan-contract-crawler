// SPDX-License-Identifier: GPL-3.0
// presented by Wildxyz

pragma solidity ^0.8.17;

import {Strings} from "./Strings.sol";
import {WildNFT} from "./WildNFT.sol";
import {Base64} from "./Base64.sol";
import {Math} from "./Math.sol";

contract BlueChips is WildNFT {

    constructor(address _minter, uint256 _maxSupply, string memory _baseURI) WildNFT("Blue Chips", "BLUECHIPS", _minter, _maxSupply, _baseURI) {}

    function tokenURI(uint256 _tokenId)
        public
        view
        override
        returns (string memory)
        {
            require(_exists(_tokenId), "Token does not exist.");
            return string(
                abi.encodePacked(
                    baseURI,
                    Strings.toString(_tokenId),
                    ".json"
                )
            );
        }
}