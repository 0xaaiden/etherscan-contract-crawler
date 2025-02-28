// SPDX-License-Identifier: MIT LICENSE

pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract FPulseG0ES2StakerV5 is Ownable, IERC721Receiver, ReentrancyGuard {
  using SafeERC20 for IERC20;

  uint256 public totalStaked;

  // Rewards per day per token deposited in wei.
  uint256 public rewardsPerDay;

  // struct to store a stake's token, owner, and earning values
  struct Stake {
    uint24 tokenId;
    uint48 timestamp;
    address owner;
  }

  event NFTStaked(address owner, uint256 tokenId, uint256 value);
  event NFTUnstaked(address owner, uint256 tokenId, uint256 value);
  event Claimed(address owner, uint256 amount);
  event StakeRewardUpdated(uint256 rewardsPerDay);
  event RewardsTokenUpdated(IERC20 rewardsToken);
  event nftCollectionUpdated(ERC721Enumerable nftCollection);

  // Interfaces for ERC20 and ERC721
  ERC721Enumerable public nftCollection;
  IERC20 public rewardsToken;

  // maps tokenId to stake
  mapping(uint256 => Stake) public vault;

   constructor(ERC721Enumerable _nftCollection, IERC20 _rewardsToken, uint256 _rewardsPerDay) {
    nftCollection = _nftCollection;
    rewardsToken = _rewardsToken;
    rewardsPerDay = _rewardsPerDay;
  }

  function stake(uint256[] calldata tokenIds) external {
    uint256 tokenId;
    totalStaked += tokenIds.length;
    for (uint i = 0; i < tokenIds.length; i++) {
      tokenId = tokenIds[i];
      require(nftCollection.ownerOf(tokenId) == msg.sender, "not your token");
      require(vault[tokenId].tokenId == 0, 'already staked');

      nftCollection.transferFrom(msg.sender, address(this), tokenId);
      emit NFTStaked(msg.sender, tokenId, block.timestamp);

      vault[tokenId] = Stake({
        owner: msg.sender,
        tokenId: uint24(tokenId),
        timestamp: uint48(block.timestamp)
      });
    }
  }

  function _unstakeMany(address account, uint256[] calldata tokenIds) internal {
    uint256 tokenId;
    totalStaked -= tokenIds.length;
    for (uint i = 0; i < tokenIds.length; i++) {
      tokenId = tokenIds[i];
      Stake memory staked = vault[tokenId];
      require(staked.owner == msg.sender, "not an owner");

      delete vault[tokenId];
      emit NFTUnstaked(account, tokenId, block.timestamp);
      nftCollection.transferFrom(address(this), account, tokenId);
    }
  }

  function claim(uint256[] calldata tokenIds) external {
      _claim(msg.sender, tokenIds, false);
  }

  function claimForAddress(address account, uint256[] calldata tokenIds) external {
      _claim(account, tokenIds, false);
  }

  function unstake(uint256[] calldata tokenIds) external {
      _claim(msg.sender, tokenIds, true);
  }

/* TOKEN REWARDS CALCULATION
/// rewardmath = 100000 wei .... (This gives 1 token per day per NFT staked)
/// rewardmath = 200000 wei .... (This gives 2 tokens per day per NFT staked)
/// rewardmath = 500000 wei .... (This gives 5 tokens per day per NFT staked)
*/
  function _claim(address account, uint256[] calldata tokenIds, bool _unstake) internal {
    uint256 tokenId;
    uint256 earned = 0;
    uint256 rewardmath = 0;

    for (uint i = 0; i < tokenIds.length; i++) {
      tokenId = tokenIds[i];
      Stake memory staked = vault[tokenId];
      require(staked.owner == account, "not an owner");
      uint256 stakedAt = staked.timestamp;
      rewardmath = rewardsPerDay * (block.timestamp - stakedAt) / 86400 ;
      earned = rewardmath / 100;
      vault[tokenId] = Stake({
        owner: account,
        tokenId: uint24(tokenId),
        timestamp: uint48(block.timestamp)
      });
    }
    if (earned > 0) {
      rewardsToken.safeTransfer(account, earned);
    }
    if (_unstake) {
      _unstakeMany(account, tokenIds);
    }
    emit Claimed(account, earned);
  }

  function earningInfo(address account, uint256[] calldata tokenIds) external view returns (uint256[1] memory info) {
     uint256 tokenId;
     uint256 earned = 0;
     uint256 rewardmath = 0;

    for (uint i = 0; i < tokenIds.length; i++) {
      tokenId = tokenIds[i];
      Stake memory staked = vault[tokenId];
      require(staked.owner == account, "not an owner");
      uint256 stakedAt = staked.timestamp;
      rewardmath = rewardsPerDay * (block.timestamp - stakedAt) / 86400;
      earned = rewardmath / 100;

    }
    if (earned > 0) {
      return [earned];
    }
}

  // should never be used inside of transaction because of gas fee
  function balanceOf(address account) public view returns (uint256) {
    uint256 balance = 0;
    uint256 supply = nftCollection.totalSupply();
    for(uint i = 1; i <= supply; i++) {
      if (vault[i].owner == account) {
        balance += 1;
      }
    }
    return balance;
  }

  // should never be used inside of transaction because of gas fee
  function tokensOfOwner(address account) public view returns (uint256[] memory ownerTokens) {

    uint256 supply = nftCollection.totalSupply();
    uint256[] memory tmp = new uint256[](supply);

    uint256 index = 0;
    for(uint tokenId = 1; tokenId <= supply; tokenId++) {
      if (vault[tokenId].owner == account) {
        tmp[index] = vault[tokenId].tokenId;
        index +=1;
      }
    }

    uint256[] memory tokens = new uint256[](index);
    for(uint i = 0; i < index; i++) {
      tokens[i] = tmp[i];
    }

    return tokens;
  }

  function onERC721Received(
        address,
        address from,
        uint256,
        bytes calldata
    ) external pure override returns (bytes4) {
      require(from == address(0x0), "Cannot send nfts to Vault directly");
      return IERC721Receiver.onERC721Received.selector;
    }

    //setting
    function changeRewardsPerDay(uint256 _rewardsPerDay) external onlyOwner {
        rewardsPerDay = _rewardsPerDay;

        emit StakeRewardUpdated(rewardsPerDay);
    }

    function setRewardsToken(IERC20 value) public onlyOwner {
	    rewardsToken = value;

        emit RewardsTokenUpdated(rewardsToken);
	}

    function setnftCollection(ERC721Enumerable value) public onlyOwner {
	    nftCollection = value;

        emit nftCollectionUpdated(nftCollection);
	}

    //utility extrasa

    //get sstuck tokens ftom contract
    function rescueToken(address tokenAddress, address to) external onlyOwner returns (bool success) {
        uint256 _contractBalance = IERC20(tokenAddress).balanceOf(address(this));


        return IERC20(tokenAddress).transfer(to, _contractBalance);
    }

    //gets stuck bnb from contract
    function rescueBNB(uint256 amount) external onlyOwner{
    payable(msg.sender).transfer(amount);
    }
}