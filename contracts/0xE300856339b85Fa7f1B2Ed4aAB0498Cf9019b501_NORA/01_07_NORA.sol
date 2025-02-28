// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "erc721a/contracts/ERC721A.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract NORA is ERC721A, Ownable {
    using Strings for uint256;

    uint256 public maxSupply = 333;
    uint256 public mintPrice = .005 ether;
    uint256 public maxPerTransaction = 2;
    bool public paused = true;
    string public baseURI = "ipfs://QmPy2FmcxJ9PxZdwZ6SCg2sac15ttvd1SYeYxZzUoLvF6R/";
    mapping(address => uint256) public mintedPerAddress;

    constructor() ERC721A("NORA", "NORA") {}

    function mint(uint256 _quantity) external payable {
        require(paused == false, "Contract is paused.");
        require((totalSupply() + _quantity) <= maxSupply, "Max supply exceeded.");
        require((mintedPerAddress[msg.sender] + _quantity) <= maxPerTransaction, "Max mint per wallet exceeded.");
        require(msg.value >= (mintPrice * _quantity), "Wrong mint price.");

        mintedPerAddress[msg.sender] += _quantity;
        _safeMint(msg.sender, _quantity);
    }

    function airdrop(address receiver, uint256 amount) external onlyOwner {
        _safeMint(receiver, amount);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        require(
            _exists(tokenId),
            "ERC721Metadata: URI query for nonexistent token"
        );
        return string(abi.encodePacked(baseURI, tokenId.toString(), ".json"));
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return baseURI;
    }

    function _startTokenId() internal view virtual override returns (uint256) {
        return 1;
    }

    function setBaseURI(string memory uri) public onlyOwner {
        baseURI = uri;
    }

    function togglePaused() external onlyOwner {
        paused = !paused;
    }

    function setPrice(uint256 _newPrice) external onlyOwner {
        mintPrice = _newPrice;
    }

    function withdraw() external onlyOwner {
        (bool success, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(success, "Transfer failed.");
    }
}