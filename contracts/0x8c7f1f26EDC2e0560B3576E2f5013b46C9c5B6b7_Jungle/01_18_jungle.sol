// contracts/Jungle.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "./ERC721Enumerable.sol";

contract Jungle is ERC20Burnable, Ownable {
    /*
     ____.                    .__          
    |    |__ __  ____    ____ |  |   ____  
    |    |  |  \/    \  / ___\|  | _/ __ \ 
/\__|    |  |  /   |  \/ /_/  >  |_\  ___/ 
\________|____/|___|  /\___  /|____/\___  >
                    \//_____/           \/ 
*/

    using SafeMath for uint256;

    uint256 public EMISSIONS_RATE = 1028703700000000; // 88.88 per day
    uint256 public CLAIM_END_TIME = 1874980800; // Jun 01 2029 04:00:00 GMT+0000

    address nullAddress = 0x0000000000000000000000000000000000000000;

    address public apeMferAddress;

    //Mapping of apemfer to timestamp
    mapping(uint256 => uint256) internal tokenIdToTimeStamp;

    //Mapping of apemfer to staker
    mapping(uint256 => address) internal tokenIdToStaker;

    //Mapping of staker to apemfer
    mapping(address => uint256[]) internal stakerToTokenIds;

    constructor() ERC20("Jungle", "JUNGLE") {
        _mint(msg.sender, 150000 ether); // initial liquidity
    }

    function setApeMferAddress(address _apeMferAddress) public onlyOwner {
        apeMferAddress = _apeMferAddress;
        return;
    }

    function getTokensStaked(address staker)
        public
        view
        returns (uint256[] memory)
    {
        return stakerToTokenIds[staker];
    }

    function remove(address staker, uint256 index) internal {
        if (index >= stakerToTokenIds[staker].length) return;

        for (uint256 i = index; i < stakerToTokenIds[staker].length - 1; i++) {
            stakerToTokenIds[staker][i] = stakerToTokenIds[staker][i + 1];
        }
        stakerToTokenIds[staker].pop();
    }

    function removeTokenIdFromStaker(address staker, uint256 tokenId) internal {
        for (uint256 i = 0; i < stakerToTokenIds[staker].length; i++) {
            if (stakerToTokenIds[staker][i] == tokenId) {
                //This is the tokenId to remove;
                remove(staker, i);
            }
        }
    }

    function stakeByIds(uint256[] memory tokenIds) public {
        for (uint256 i = 0; i < tokenIds.length; i++) {
            require(
                IERC721(apeMferAddress).ownerOf(tokenIds[i]) == msg.sender &&
                    tokenIdToStaker[tokenIds[i]] == nullAddress,
                "Token must be stakable by you!"
            );

            IERC721(apeMferAddress).transferFrom(
                msg.sender,
                address(this),
                tokenIds[i]
            );

            stakerToTokenIds[msg.sender].push(tokenIds[i]);

            tokenIdToTimeStamp[tokenIds[i]] = block.timestamp;
            tokenIdToStaker[tokenIds[i]] = msg.sender;
        }
    }

    function unstakeAll() public {
        require(
            stakerToTokenIds[msg.sender].length > 0,
            "Must have at least one token staked!"
        );
        uint256 totalRewards = 0;

        for (uint256 i = stakerToTokenIds[msg.sender].length; i > 0; i--) {
            uint256 tokenId = stakerToTokenIds[msg.sender][i - 1];

            IERC721(apeMferAddress).transferFrom(
                address(this),
                msg.sender,
                tokenId
            );

            totalRewards =
                totalRewards +
                ((block.timestamp - tokenIdToTimeStamp[tokenId]) *
                    EMISSIONS_RATE);

            removeTokenIdFromStaker(msg.sender, tokenId);

            tokenIdToStaker[tokenId] = nullAddress;
        }

        _mint(msg.sender, totalRewards);
    }

    function unstakeByIds(uint256[] memory tokenIds) public {
        uint256 totalRewards = 0;

        for (uint256 i = 0; i < tokenIds.length; i++) {
            require(
                tokenIdToStaker[tokenIds[i]] == msg.sender,
                "Message Sender was not original staker!"
            );

            IERC721(apeMferAddress).transferFrom(
                address(this),
                msg.sender,
                tokenIds[i]
            );

            totalRewards =
                totalRewards +
                ((block.timestamp - tokenIdToTimeStamp[tokenIds[i]]) *
                    EMISSIONS_RATE);

            removeTokenIdFromStaker(msg.sender, tokenIds[i]);

            tokenIdToStaker[tokenIds[i]] = nullAddress;
        }

        _mint(msg.sender, totalRewards);
    }

    function claimByTokenId(uint256 tokenId) public {
        require(
            tokenIdToStaker[tokenId] == msg.sender,
            "Token is not claimable by you!"
        );
        require(block.timestamp < CLAIM_END_TIME, "Claim period is over!");

        _mint(
            msg.sender,
            ((block.timestamp - tokenIdToTimeStamp[tokenId]) * EMISSIONS_RATE)
        );

        tokenIdToTimeStamp[tokenId] = block.timestamp;
    }

    function claimAll() public {
        require(block.timestamp < CLAIM_END_TIME, "Claim period is over!");
        uint256[] memory tokenIds = stakerToTokenIds[msg.sender];
        uint256 totalRewards = 0;

        for (uint256 i = 0; i < tokenIds.length; i++) {
            require(
                tokenIdToStaker[tokenIds[i]] == msg.sender,
                "Token is not claimable by you!"
            );

            totalRewards =
                totalRewards +
                ((block.timestamp - tokenIdToTimeStamp[tokenIds[i]]) *
                    EMISSIONS_RATE);

            tokenIdToTimeStamp[tokenIds[i]] = block.timestamp;
        }

        _mint(msg.sender, totalRewards);
    }

    function getAllRewards(address staker) public view returns (uint256) {
        uint256[] memory tokenIds = stakerToTokenIds[staker];
        uint256 totalRewards = 0;

        for (uint256 i = 0; i < tokenIds.length; i++) {
            totalRewards =
                totalRewards +
                ((block.timestamp - tokenIdToTimeStamp[tokenIds[i]]) *
                    EMISSIONS_RATE);
        }

        return totalRewards;
    }

    function getRewardsByTokenId(uint256 tokenId)
        public
        view
        returns (uint256)
    {
        require(
            tokenIdToStaker[tokenId] != nullAddress,
            "Token is not staked!"
        );

        uint256 secondsStaked = block.timestamp - tokenIdToTimeStamp[tokenId];

        return secondsStaked * EMISSIONS_RATE;
    }

    function getStaker(uint256 tokenId) public view returns (address) {
        return tokenIdToStaker[tokenId];
    }
}