// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <0.9.0;

import 'erc721a/contracts/ERC721A.sol';
import '@openzeppelin/contracts/access/Ownable.sol';
import '@openzeppelin/contracts/utils/Strings.sol';
import '@openzeppelin/contracts/security/ReentrancyGuard.sol';
import "operator-filter-registry/src/DefaultOperatorFilterer.sol";

contract PixelZuki is ERC721A, Ownable, ReentrancyGuard, DefaultOperatorFilterer {

  using Strings for uint256;

  string public uriPrefix = 'ipfs://QmVw9HmRJtiMArnk8JiJTz8QRzPcGcY4QrQL6rwkr2tpFJ/';
  string public uriSuffix = '.json';
  string public hiddenMetadataUri;

  uint256 public maxSupply = 3789;
  uint256 public maxMintAmountPerWallet = 20;
  uint256 public maxFreeMintAmountPerWallet = 1;
  uint256 public teamSupply = 1;

  mapping(address => bool) freeMint;

  uint256 public publicMintCost = 0.005 ether;

  bool public paused = true;
  bool public revealed = true;

  constructor(
    string memory _tokenName,
    string memory _tokenSymbol,
    string memory _hiddenMetadataUri
  )  ERC721A(_tokenName, _tokenSymbol)  {
    hiddenMetadataUri = _hiddenMetadataUri;
    _safeMint(msg.sender, 1);
  }


  modifier mintCompliance(uint256 _mintAmount) {
    require(totalSupply() + _mintAmount <= maxSupply - teamSupply, 'Max Supply Exceeded!');
    _;
  }

  function mint(uint256 _mintAmount) public payable mintCompliance(_mintAmount) nonReentrant {
    require(!paused, 'The portal is not open yet!');
    require(_numberMinted(_msgSender()) + _mintAmount <= maxMintAmountPerWallet, 'Max Limit per Wallet!');

    if(freeMint[_msgSender()]) {
      require(msg.value >= _mintAmount * publicMintCost, 'Insufficient Funds!');
    }
    else {
      require(msg.value >= (_mintAmount - 1) * publicMintCost, 'Insufficient Funds!');
      freeMint[_msgSender()] = true;
    }
    _safeMint(_msgSender(), _mintAmount);
  }

  function teamMint(address[] memory _staff_address) public onlyOwner payable {
    require(_staff_address.length <= teamSupply, '');
    for (uint256 i = 0; i < _staff_address.length; i ++) {
      _safeMint(_staff_address[i], 1);
    }
  }

  function _startTokenId() internal view virtual override returns (uint256) {
    return 1;
  }

  function tokenURI(uint256 _tokenId) public view virtual override returns (string memory) {
    require(_exists(_tokenId), 'ERC721Metadata: URI query for nonexistent token');

    if (revealed == false) {
      return hiddenMetadataUri;
    }

    string memory currentBaseURI = _baseURI();
    return bytes(currentBaseURI).length > 0
    ? string(abi.encodePacked(currentBaseURI, _tokenId.toString(), uriSuffix))
    : '';
  }

  function setRevealed(bool _state) public onlyOwner {
    revealed = _state;
  }

  function setHiddenMetadataUri(string memory _hiddenMetadataUri) public onlyOwner {
    hiddenMetadataUri = _hiddenMetadataUri;
  }

  function setUriPrefix(string memory _uriPrefix) public onlyOwner {
    uriPrefix = _uriPrefix;
  }

  function setUriSuffix(string memory _uriSuffix) public onlyOwner {
    uriSuffix = _uriSuffix;
  }

  function setMintCost(uint256 _cost) public onlyOwner {
      publicMintCost = _cost;
  }

  function setPaused(bool _state) public onlyOwner {
    paused = _state;
  }

  function setMaxSupply(uint256 _maxSupply) public onlyOwner {
    maxSupply = _maxSupply;
  }

  function setTeamAmount(uint256 _teamSupply) public onlyOwner {
    teamSupply = _teamSupply;
  }

  function withdraw() public onlyOwner {

    (bool os, ) = payable(owner()).call{value: address(this).balance}('');
    require(os);
  }

  function _baseURI() internal view virtual override returns (string memory) {
    return uriPrefix;
  }

  function setApprovalForAll(address operator, bool approved) public override onlyAllowedOperatorApproval(operator) {
    super.setApprovalForAll(operator, approved);
  }

  function approve(address operator, uint256 tokenId) public payable override onlyAllowedOperatorApproval(operator) {
    super.approve(operator, tokenId);
  }

  function transferFrom(address from, address to, uint256 tokenId) public payable override onlyAllowedOperator(from) {
    super.transferFrom(from, to, tokenId);
  }

  function safeTransferFrom(address from, address to, uint256 tokenId) public payable override onlyAllowedOperator(from) {
    super.safeTransferFrom(from, to, tokenId);
  }

  function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data)
  public payable
  override
  onlyAllowedOperator(from)
  {
    super.safeTransferFrom(from, to, tokenId, data);
  }
}