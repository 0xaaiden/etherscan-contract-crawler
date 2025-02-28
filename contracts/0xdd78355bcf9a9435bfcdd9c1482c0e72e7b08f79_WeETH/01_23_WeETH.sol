// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import "@openzeppelin-upgradeable/contracts/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin-upgradeable/contracts/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin-upgradeable/contracts/access/OwnableUpgradeable.sol";
import "@openzeppelin-upgradeable/contracts/token/ERC20/extensions/draft-ERC20PermitUpgradeable.sol";
import "./interfaces/IeETH.sol";
import "./interfaces/ILiquidityPool.sol";

contract WeETH is ERC20Upgradeable, UUPSUpgradeable, OwnableUpgradeable, ERC20PermitUpgradeable {
    //--------------------------------------------------------------------------------------
    //---------------------------------  STATE-VARIABLES  ----------------------------------
    //--------------------------------------------------------------------------------------

    IeETH public eETH;
    ILiquidityPool public liquidityPool;

    //--------------------------------------------------------------------------------------
    //----------------------------  STATE-CHANGING FUNCTIONS  ------------------------------
    //--------------------------------------------------------------------------------------

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(address _liquidityPool, address _eETH) external initializer {
        require(_liquidityPool != address(0), "No zero addresses");
        require(_eETH != address(0), "No zero addresses");
        
        __ERC20_init("EtherFi wrapped ETH", "weETH");
        __ERC20Permit_init("EtherFi wrapped ETH");
        __UUPSUpgradeable_init();
        __Ownable_init();
        eETH = IeETH(_eETH);
        liquidityPool = ILiquidityPool(_liquidityPool);
    }

    /// @notice Wraps eEth
    /// @param _eETHAmount the amount of eEth to wrap
    /// @return returns the amount of weEth the user receives
    function wrap(uint256 _eETHAmount) external returns (uint256) {
        require(_eETHAmount > 0, "weETH: can't wrap zero eETH");
        uint256 weEthAmount = liquidityPool.sharesForAmount(_eETHAmount);
        _mint(msg.sender, weEthAmount);
        eETH.transferFrom(msg.sender, address(this), _eETHAmount);
        return weEthAmount;
    }

    /// @notice Unwraps weETH
    /// @param _weETHAmount the amount of weETH to unwrap
    /// @return returns the amount of eEth the user receives
    function unwrap(uint256 _weETHAmount) external returns (uint256) {
        require(_weETHAmount > 0, "Cannot unwrap a zero amount");
        uint256 eETHAmount = liquidityPool.amountForShare(_weETHAmount);
        _burn(msg.sender, _weETHAmount);
        eETH.transfer(msg.sender, eETHAmount);
        return eETHAmount;
    }

    //--------------------------------------------------------------------------------------
    //-------------------------------  INTERNAL FUNCTIONS  ---------------------------------
    //--------------------------------------------------------------------------------------

    function _authorizeUpgrade(
        address newImplementation
    ) internal override onlyOwner {}

    //--------------------------------------------------------------------------------------
    //------------------------------------  GETTERS  ---------------------------------------
    //--------------------------------------------------------------------------------------

    /// @notice Fetches the amount of weEth respective to the amount of eEth sent in
    /// @param _eETHAmount amount sent in
    /// @return The total number of shares for the specified amount
    function getWeETHByeETH(uint256 _eETHAmount) external view returns (uint256) {
        return liquidityPool.sharesForAmount(_eETHAmount);
    }
    
    /// @notice Fetches the amount of eEth respective to the amount of weEth sent in
    /// @param _weETHAmount amount sent in
    /// @return The total amount for the number of shares sent in
    function getEETHByWeETH(uint256 _weETHAmount) external view returns (uint256) {
        return liquidityPool.amountForShare(_weETHAmount);
    }

    function getImplementation() external view returns (address) {
        return _getImplementation();
    }
}