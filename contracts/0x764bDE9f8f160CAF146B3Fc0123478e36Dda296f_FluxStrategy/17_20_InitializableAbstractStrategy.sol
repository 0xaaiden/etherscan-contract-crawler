// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { SafeERC20 } from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

import { Initializable } from "../utils/Initializable.sol";
import { Governable } from "../governance/Governable.sol";
import { IVault } from "../interfaces/IVault.sol";

abstract contract InitializableAbstractStrategy is Initializable, Governable {
    using SafeERC20 for IERC20;

    event PTokenAdded(address indexed _asset, address _pToken);
    event PTokenRemoved(address indexed _asset, address _pToken);
    event Deposit(address indexed _asset, address _pToken, uint256 _amount);
    event Withdrawal(address indexed _asset, address _pToken, uint256 _amount);
    event RewardTokenCollected(
        address recipient,
        address rewardToken,
        uint256 amount
    );
    event RewardTokenAddressesUpdated(
        address[] _oldAddresses,
        address[] _newAddresses
    );
    event HarvesterAddressesUpdated(
        address _oldHarvesterAddress,
        address _newHarvesterAddress
    );

    /// @notice Address of the underlying platform
    address public immutable platformAddress;
    /// @notice Address of the OToken vault
    address public immutable vaultAddress;

    /// @dev Replaced with an immutable variable
    // slither-disable-next-line constable-states
    address private _deprecated_platformAddress;

    /// @dev Replaced with an immutable
    // slither-disable-next-line constable-states
    address private _deprecated_vaultAddress;

    // asset => pToken (Platform Specific Token Address)
    mapping(address => address) public assetToPToken;

    // Full list of all assets supported here
    address[] internal assetsMapped;

    // Deprecated: Reward token address
    // slither-disable-next-line constable-states
    address private _deprecated_rewardTokenAddress;

    // Deprecated: now resides in Harvester's rewardTokenConfigs
    // slither-disable-next-line constable-states
    uint256 private _deprecated_rewardLiquidationThreshold;

    // Address of the one address allowed to collect reward tokens
    address public harvesterAddress;

    // Reward token addresses
    address[] public rewardTokenAddresses;
    /* Reserved for future expansion. Used to be 100 storage slots
     * and has decreased to accommodate:
     * - harvesterAddress
     * - rewardTokenAddresses
     */
    int256[98] private _reserved;

    struct BaseStrategyConfig {
        address platformAddress; // Address of the underlying platform
        address vaultAddress; // Address of the OToken's Vault
    }

    /**
     * @param _config The platform and OToken vault addresses
     */
    constructor(BaseStrategyConfig memory _config) {
        platformAddress = _config.platformAddress;
        vaultAddress = _config.vaultAddress;
    }

    /**
     * @notice Internal initialize function, to set up initial internal state
     * @param _rewardTokenAddresses Address of reward token for platform
     * @param _assets Addresses of initial supported assets
     * @param _pTokens Platform Token corresponding addresses
     */
    function initialize(
        address[] calldata _rewardTokenAddresses,
        address[] calldata _assets,
        address[] calldata _pTokens
    ) external virtual onlyGovernor initializer {
        InitializableAbstractStrategy._initialize(
            _rewardTokenAddresses,
            _assets,
            _pTokens
        );
    }

    function _initialize(
        address[] memory _rewardTokenAddresses,
        address[] memory _assets,
        address[] memory _pTokens
    ) internal {
        rewardTokenAddresses = _rewardTokenAddresses;

        uint256 assetCount = _assets.length;
        require(assetCount == _pTokens.length, "Invalid input arrays");
        for (uint256 i = 0; i < assetCount; ++i) {
            _setPTokenAddress(_assets[i], _pTokens[i]);
        }
    }

    /**
     * @dev Collect accumulated reward token and send to Vault.
     */
    function collectRewardTokens() external virtual onlyHarvester nonReentrant {
        _collectRewardTokens();
    }

    /**
     * @dev Default implementation that transfers reward tokens to the Vault.
     * Implementing strategies need to add custom logic to collect the rewards.
     */
    function _collectRewardTokens() internal virtual {
        uint256 rewardTokenCount = rewardTokenAddresses.length;
        for (uint256 i = 0; i < rewardTokenCount; ++i) {
            IERC20 rewardToken = IERC20(rewardTokenAddresses[i]);
            uint256 balance = rewardToken.balanceOf(address(this));
            if (balance > 0) {
                emit RewardTokenCollected(
                    harvesterAddress,
                    address(rewardToken),
                    balance
                );
                rewardToken.safeTransfer(harvesterAddress, balance);
            }
        }
    }

    /**
     * @dev Verifies that the caller is the Vault.
     */
    modifier onlyVault() {
        require(msg.sender == vaultAddress, "Caller is not the Vault");
        _;
    }

    /**
     * @dev Verifies that the caller is the Harvester.
     */
    modifier onlyHarvester() {
        require(msg.sender == harvesterAddress, "Caller is not the Harvester");
        _;
    }

    /**
     * @dev Verifies that the caller is the Vault or Governor.
     */
    modifier onlyVaultOrGovernor() {
        require(
            msg.sender == vaultAddress || msg.sender == governor(),
            "Caller is not the Vault or Governor"
        );
        _;
    }

    /**
     * @dev Verifies that the caller is the Vault, Governor, or Strategist.
     */
    modifier onlyVaultOrGovernorOrStrategist() {
        require(
            msg.sender == vaultAddress ||
                msg.sender == governor() ||
                msg.sender == IVault(vaultAddress).strategistAddr(),
            "Caller is not the Vault, Governor, or Strategist"
        );
        _;
    }

    /**
     * @dev Set the reward token addresses.
     * @param _rewardTokenAddresses Address array of the reward token
     */
    function setRewardTokenAddresses(address[] calldata _rewardTokenAddresses)
        external
        onlyGovernor
    {
        uint256 rewardTokenCount = rewardTokenAddresses.length;
        for (uint256 i = 0; i < rewardTokenCount; ++i) {
            require(
                _rewardTokenAddresses[i] != address(0),
                "Can not set an empty address as a reward token"
            );
        }

        emit RewardTokenAddressesUpdated(
            rewardTokenAddresses,
            _rewardTokenAddresses
        );
        rewardTokenAddresses = _rewardTokenAddresses;
    }

    /**
     * @dev Get the reward token addresses.
     * @return address[] the reward token addresses.
     */
    function getRewardTokenAddresses()
        external
        view
        returns (address[] memory)
    {
        return rewardTokenAddresses;
    }

    /**
     * @dev Provide support for asset by passing its pToken address.
     *      This method can only be called by the system Governor
     * @param _asset    Address for the asset
     * @param _pToken   Address for the corresponding platform token
     */
    function setPTokenAddress(address _asset, address _pToken)
        external
        virtual
        onlyGovernor
    {
        _setPTokenAddress(_asset, _pToken);
    }

    /**
     * @dev Remove a supported asset by passing its index.
     *      This method can only be called by the system Governor
     * @param _assetIndex Index of the asset to be removed
     */
    function removePToken(uint256 _assetIndex) external virtual onlyGovernor {
        require(_assetIndex < assetsMapped.length, "Invalid index");
        address asset = assetsMapped[_assetIndex];
        address pToken = assetToPToken[asset];

        if (_assetIndex < assetsMapped.length - 1) {
            assetsMapped[_assetIndex] = assetsMapped[assetsMapped.length - 1];
        }
        assetsMapped.pop();
        assetToPToken[asset] = address(0);

        emit PTokenRemoved(asset, pToken);
    }

    /**
     * @dev Provide support for asset by passing its pToken address.
     *      Add to internal mappings and execute the platform specific,
     * abstract method `_abstractSetPToken`
     * @param _asset    Address for the asset
     * @param _pToken   Address for the corresponding platform token
     */
    function _setPTokenAddress(address _asset, address _pToken) internal {
        require(assetToPToken[_asset] == address(0), "pToken already set");
        require(
            _asset != address(0) && _pToken != address(0),
            "Invalid addresses"
        );

        assetToPToken[_asset] = _pToken;
        assetsMapped.push(_asset);

        emit PTokenAdded(_asset, _pToken);

        _abstractSetPToken(_asset, _pToken);
    }

    /**
     * @dev Transfer token to governor. Intended for recovering tokens stuck in
     *      strategy contracts, i.e. mistaken sends.
     * @param _asset Address for the asset
     * @param _amount Amount of the asset to transfer
     */
    function transferToken(address _asset, uint256 _amount)
        public
        onlyGovernor
    {
        IERC20(_asset).safeTransfer(governor(), _amount);
    }

    /**
     * @dev Set the reward token addresses.
     * @param _harvesterAddress Address of the harvester
     */
    function setHarvesterAddress(address _harvesterAddress)
        external
        onlyGovernor
    {
        harvesterAddress = _harvesterAddress;
        emit HarvesterAddressesUpdated(harvesterAddress, _harvesterAddress);
    }

    /***************************************
                 Abstract
    ****************************************/

    function _abstractSetPToken(address _asset, address _pToken)
        internal
        virtual;

    function safeApproveAllTokens() external virtual;

    /**
     * @dev Deposit an amount of asset into the platform
     * @param _asset               Address for the asset
     * @param _amount              Units of asset to deposit
     */
    function deposit(address _asset, uint256 _amount) external virtual;

    /**
     * @dev Deposit balance of all supported assets into the platform
     */
    function depositAll() external virtual;

    /**
     * @dev Withdraw an amount of asset from the platform.
     * @param _recipient         Address to which the asset should be sent
     * @param _asset             Address of the asset
     * @param _amount            Units of asset to withdraw
     */
    function withdraw(
        address _recipient,
        address _asset,
        uint256 _amount
    ) external virtual;

    /**
     * @dev Withdraw all assets from strategy sending assets to Vault.
     */
    function withdrawAll() external virtual;

    /**
     * @dev Get the total asset value held in the platform.
     *      This includes any interest that was generated since depositing.
     * @param _asset      Address of the asset
     * @return balance    Total value of the asset in the platform
     */
    function checkBalance(address _asset)
        external
        view
        virtual
        returns (uint256 balance);

    /**
     * @dev Check if an asset is supported.
     * @param _asset    Address of the asset
     * @return bool     Whether asset is supported
     */
    function supportsAsset(address _asset) external view virtual returns (bool);
}