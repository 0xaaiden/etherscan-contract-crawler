// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "./ERC721A.sol";

contract Capsule is ERC721A, Ownable, ReentrancyGuard {
    using Strings for uint256;

    enum Status {
        Pending,
        PublicSale,
        Finished
    }

    Status public status;
    string public baseURI;
    uint256 public tokensReserved;
    uint256 public immutable maxMint;
    uint256 public immutable maxSupply;
    uint256 public immutable reserveAmount;
    uint256 public constant PRICE = 0.1 ether; // 0.1 ETH
    bool public isReveal;

    mapping(address => bool) public publicMinted;

    event Minted(address minter, uint256 amount);
    event StatusChanged(Status status);
    event ReservedToken(address minter, address recipient, uint256 amount);
    event BaseURIChanged(string newBaseURI);

    constructor(
        string memory initBaseURI,
        uint256 _maxBatchSize,
        uint256 _collectionSize,
        uint256 _reserveAmount
    ) ERC721A("Capsule", "Cap", _maxBatchSize, _collectionSize) {
        baseURI = initBaseURI;
        maxMint = _maxBatchSize;
        maxSupply = _collectionSize;
        reserveAmount = _reserveAmount;
    }

    //ipfs://QmafZb6njGmxN57JD2uQUYjNMvyZUcCTkeuQj8ZUK89y99

    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }

    function reserve(address recipient, uint256 amount) external onlyOwner {
        require(recipient != address(0), "Capsule: zero address");
        require(amount > 0, "Capsule: invalid amount");
        require(
            totalSupply() + amount <= collectionSize,
            "Capsule: max supply exceeded"
        );
        require(
            tokensReserved + amount <= reserveAmount,
            "Capsule: max reserve amount exceeded"
        );
        require(
            amount % maxBatchSize == 0,
            "Capsule: can only mint a multiple of the maxBatchSize"
        );

        uint256 numChunks = amount / maxBatchSize;
        for (uint256 i = 0; i < numChunks; i++) {
            _safeMint(recipient, maxBatchSize);
        }
        tokensReserved += amount;
        emit ReservedToken(msg.sender, recipient, amount);
    }

    
    function mint(uint256 amount) external payable {
        require(status == Status.PublicSale, "Capsule: Public sale is not active.");

        require(
            totalSupply() + amount + reserveAmount - tokensReserved <=
                collectionSize,
            "Capsule: Max supply exceeded."
        );

        _safeMint(msg.sender, amount);
        refundIfOver(PRICE * amount);

        emit Minted(msg.sender, amount);
    }

    function refundIfOver(uint256 price) private {
        require(msg.value >= price, "Capsule: Need to send more ETH.");
        if (msg.value > price) {
            payable(msg.sender).transfer(msg.value - price);
        }
    }

    function reveal(string calldata newBaseURI) external onlyOwner {
        baseURI = newBaseURI;
        isReveal = true;
        emit BaseURIChanged(newBaseURI);

    }
    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory){
            require(
            _exists(tokenId),
            "ERC721Metadata: URI query for nonexistent token"
        );

        string memory currentBaseURI = _baseURI();
        return isReveal?
            bytes(currentBaseURI).length > 0
                ? string(abi.encodePacked(currentBaseURI, tokenId.toString()))
                : "" : currentBaseURI;

    }

    function withdraw() external nonReentrant onlyOwner {
        uint256 balance = address(this).balance;
        (bool success1, ) = payable(msg.sender)
            .call{value: balance}("");
        require(success1, "Transfer 1 failed.");
    }

    function setBaseURI(string calldata newBaseURI) external onlyOwner {
        baseURI = newBaseURI;
        emit BaseURIChanged(newBaseURI);
    }

    function setStatus(Status _status) external onlyOwner {
        status = _status;
        emit StatusChanged(_status);
    }


    function setOwnersExplicit(uint256 quantity)
        external
        onlyOwner
        nonReentrant
    {
        _setOwnersExplicit(quantity);
    }

    function numberMinted(address owner) public view returns (uint256) {
        return _numberMinted(owner);
    }

    function getOwnershipData(uint256 tokenId)
        external
        view
        returns (TokenOwnership memory)
    {
        return ownershipOf(tokenId);
    }
}