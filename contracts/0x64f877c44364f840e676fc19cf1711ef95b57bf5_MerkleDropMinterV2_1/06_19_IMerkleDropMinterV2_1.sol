// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import { IMinterModuleV2_1 } from "@core/interfaces/IMinterModuleV2_1.sol";

/**
 * @dev Data unique to a Merkle drop mint.
 */
struct EditionMintData {
    // Hash of the root node for the Merkle tree drop
    bytes32 merkleRootHash;
    // The maximum number of tokens that can can be minted for this sale.
    uint32 maxMintable;
    // The total number of tokens minted so far for this sale.
    uint32 totalMinted;
}

/**
 * @dev All the information about a Merkle drop mint (combines EditionMintData with BaseData).
 */
struct MintInfo {
    uint32 startTime;
    uint32 endTime;
    uint16 affiliateFeeBPS;
    bool mintPaused;
    uint96 price;
    uint32 maxMintable;
    uint32 maxMintablePerAccount;
    uint32 totalMinted;
    bytes32 merkleRootHash;
    bytes32 affiliateMerkleRoot;
    uint16 platformFeeBPS;
    uint96 platformFlatFee;
    uint96 platformPerTxFlatFee;
}

/**
 * @title IMerkleDropMinterV2_1
 * @dev Interface for the `MerkleDropMinterV2_1` module.
 * @author Sound.xyz
 */
interface IMerkleDropMinterV2_1 is IMinterModuleV2_1 {
    // =============================================================
    //                            EVENTS
    // =============================================================

    /**
     * @dev Emitted when a new Merkle drop mint is created.
     * @param edition               The edition address.
     * @param mintId                The mint ID.
     * @param merkleRootHash        The root of the Merkle tree of the approved addresses.
     * @param price                 The price at which each token will be sold, in ETH.
     * @param startTime             The time minting can begin.
     * @param endTime               The time minting will end.
     * @param affiliateFeeBPS       The affiliate fee in basis points.
     * @param maxMintable           The maximum number of tokens that can be minted.
     * @param maxMintablePerAccount The maximum number of tokens that an account can mint.
     */
    event MerkleDropMintCreated(
        address indexed edition,
        uint128 mintId,
        bytes32 merkleRootHash,
        uint96 price,
        uint32 startTime,
        uint32 endTime,
        uint16 affiliateFeeBPS,
        uint32 maxMintable,
        uint32 maxMintablePerAccount
    );

    /**
     * @dev Emitted when tokens are claimed by an account.
     * @param allowlisted  The address in the allowlist.
     * @param quantity     The quantity of tokens claimed.
     */
    event DropClaimed(address allowlisted, uint32 quantity);

    /**
     * @dev Emitted when the `price` is changed for (`edition`, `mintId`).
     * @param edition Address of the song edition contract we are minting for.
     * @param mintId  The mint ID.
     * @param price   Sale price in ETH for minting a single token in `edition`.
     */
    event PriceSet(address indexed edition, uint128 mintId, uint96 price);

    /**
     * @dev Emitted when the `maxMintable` is changed for (`edition`, `mintId`).
     * @param edition               Address of the song edition contract we are minting for.
     * @param mintId                The mint ID.
     * @param maxMintable The maximum number of tokens that can be minted on this schedule.
     */
    event MaxMintableSet(address indexed edition, uint128 mintId, uint32 maxMintable);

    /**
     * @dev Emitted when the `maxMintablePerAccount` is changed for (`edition`, `mintId`).
     * @param edition               Address of the song edition contract we are minting for.
     * @param mintId                The mint ID.
     * @param maxMintablePerAccount The maximum number of tokens that can be minted per account.
     */
    event MaxMintablePerAccountSet(address indexed edition, uint128 mintId, uint32 maxMintablePerAccount);

    /**
     * @dev Emitted when the `merkleRootHash` is changed for (`edition`, `mintId`).
     * @param edition        Address of the song edition contract we are minting for.
     * @param mintId         The mint ID.
     * @param merkleRootHash The merkle root hash of the entries.
     */
    event MerkleRootHashSet(address indexed edition, uint128 mintId, bytes32 merkleRootHash);

    // =============================================================
    //                            ERRORS
    // =============================================================

    /**
     * @dev The merkle proof is invalid.
     */
    error InvalidMerkleProof();

    /**
     * @dev The caller must be delegated by the allowlisted.
     */
    error CallerNotDelegated();

    /**
     * @dev The number of tokens minted has exceeded the number allowed for each account.
     */
    error ExceedsMaxPerAccount();

    /**
     * @dev The merkle root hash is empty.
     */
    error MerkleRootHashIsEmpty();

    /**
     * @dev The max mintable per account cannot be zero.
     */
    error MaxMintablePerAccountIsZero();

    // =============================================================
    //               PUBLIC / EXTERNAL WRITE FUNCTIONS
    // =============================================================

    /**
     * @dev Initializes Merkle drop mint instance.
     * @param edition                Address of the song edition contract we are minting for.
     * @param merkleRootHash         bytes32 hash of the Merkle tree representing eligible mints.
     * @param price                  Sale price in ETH for minting a single token in `edition`.
     * @param startTime              Start timestamp of sale (in seconds since unix epoch).
     * @param endTime                End timestamp of sale (in seconds since unix epoch).
     * @param affiliateFeeBPS        The affiliate fee in basis points.
     * @param maxMintable_           The maximum number of tokens that can can be minted for this sale.
     * @param maxMintablePerAccount_ The maximum number of tokens that a single account can mint.
     * @return mintId The ID of the new mint instance.
     */
    function createEditionMint(
        address edition,
        bytes32 merkleRootHash,
        uint96 price,
        uint32 startTime,
        uint32 endTime,
        uint16 affiliateFeeBPS,
        uint32 maxMintable_,
        uint32 maxMintablePerAccount_
    ) external returns (uint128 mintId);

    /**
     * @dev Mints a token for a particular mint instance.
     * @param edition        Address of the song edition contract we are minting for.
     * @param mintId         The mint ID.
     * @param to             The address to mint to.
     * @param quantity       The quantity of tokens to mint.
     * @param allowlisted    The address authorized to mint the tokens.
     * @param proof          The Merkle proof.
     * @param affiliate      The affiliate address.
     * @param affiliateProof The Merkle proof needed for verifying the affiliate, if any.
     * @param attributionId  The attribution ID.
     */
    function mintTo(
        address edition,
        uint128 mintId,
        address to,
        uint32 quantity,
        address allowlisted,
        bytes32[] calldata proof,
        address affiliate,
        bytes32[] calldata affiliateProof,
        uint256 attributionId
    ) external payable;

    /**
     * @dev Mints a token for a particular mint instance.
     * @param edition   Address of the song edition contract we are minting for.
     * @param mintId    The mint ID..
     * @param quantity  The quantity of tokens to mint.
     * @param proof     The Merkle proof.
     * @param affiliate The affiliate address.
     */
    function mint(
        address edition,
        uint128 mintId,
        uint32 quantity,
        bytes32[] calldata proof,
        address affiliate
    ) external payable;

    /**
     * @dev Sets the `price` for (`edition`, `mintId`).
     * @param edition Address of the song edition contract we are minting for.
     * @param mintId  The mint ID.
     * @param price   Sale price in ETH for minting a single token in `edition`.
     */
    function setPrice(
        address edition,
        uint128 mintId,
        uint96 price
    ) external;

    /**
     * @dev Sets the `maxMintablePerAccount` for (`edition`, `mintId`).
     * @param edition               Address of the song edition contract we are minting for.
     * @param mintId                The mint ID.
     * @param maxMintablePerAccount The maximum number of tokens that can be minted by an account.
     */
    function setMaxMintablePerAccount(
        address edition,
        uint128 mintId,
        uint32 maxMintablePerAccount
    ) external;

    /**
     * @dev Sets the `maxMintable` for (`edition`, `mintId`).
     * @param edition               Address of the song edition contract we are minting for.
     * @param mintId                The mint ID.
     * @param maxMintable The maximum number of tokens that can be minted on this schedule.
     */
    function setMaxMintable(
        address edition,
        uint128 mintId,
        uint32 maxMintable
    ) external;

    /**
     * @dev Sets the `merkleRootHash` for (`edition`, `mintId`).
     * @param edition        Address of the song edition contract we are minting for.
     * @param mintId         The mint ID.
     * @param merkleRootHash The Merkle root hash of the entries.
     */
    function setMerkleRootHash(
        address edition,
        uint128 mintId,
        bytes32 merkleRootHash
    ) external;

    // =============================================================
    //               PUBLIC / EXTERNAL VIEW FUNCTIONS
    // =============================================================

    /**
     * @dev Returns the number of tokens minted to address `to`, for (`edition`, `mintId`).
     * @param edition Address of the song edition contract we are minting for.
     * @param mintId  The mint ID.
     * @param to      The address to mint to.
     * @return count The number of tokens minted.
     */
    function mintCount(
        address edition,
        uint128 mintId,
        address to
    ) external view returns (uint256 count);

    /**
     * @dev Returns IMerkleDropMinterV2_1.MintInfo instance containing the full minter parameter set.
     * @param edition The edition to get the mint instance for.
     * @param mintId The ID of the mint instance.
     * @return mintInfo Information about this mint.
     */
    function mintInfo(address edition, uint128 mintId) external view returns (MintInfo memory);

    /**
     * @dev To prevent ERC165 selector collision.
     */
    function isV2_1() external pure returns (bool);
}