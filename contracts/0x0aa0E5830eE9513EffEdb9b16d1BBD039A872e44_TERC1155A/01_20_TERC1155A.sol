// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

// OZ imports
import "../openzeppelin-contracts-upgradeable/contracts/token/ERC1155/ERC1155Upgradeable.sol";
import "../openzeppelin-contracts-upgradeable/contracts/access/OwnableUpgradeable.sol";
import "../openzeppelin-contracts-upgradeable/contracts/access/AccessControlUpgradeable.sol";
// Module imports
import "./module/MetaTxModule.sol";
import "./module/ERC1155Module.sol";
import "./module/AccessControlModule.sol";

/**
@title Main contracts
*/
contract TERC1155A is ERC1155Module, MetaTxModule {
    string public name;
    string public symbol;

    /** 
    @notice create the contract
    @param forwarderIrrevocable address of the forwarder, required for the gasless support
    */
    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor(
        address forwarderIrrevocable
    ) MetaTxModule(forwarderIrrevocable) {
        // Disable the possibility to initialize the implementation
        _disableInitializers();
    }

    /**
    @notice 
    initialize the proxy contract
    The calls to this function will revert if the contract was deployed without a proxy
    */
    function initialize(
        address admin,
        string memory uri_,
        string memory name_,
        string memory symbol_
    ) public initializer {
        require(admin != address(0), "admin is the zero address");
        __TERC1155A_init(admin, uri_, name_, symbol_);
    }

    /**
    @dev calls the different initialize functions from the different modules
    */
    function __TERC1155A_init(
        address admin,
        string memory uri_,
        string memory name_,
        string memory symbol_
    ) internal onlyInitializing {
        /* OpenZeppelin library */
        // OZ init_unchained functions are called first due to inheritance
        __Context_init_unchained();
        __ERC1155_init_unchained(uri_);
        __Ownable_init_unchained();
        __AccessControl_init_unchained();

        // Module
        __ERC1155Module_init_unchained();
        __AuthorizationModule_init_unchained(admin);

        /* own function */
        __TERC1155A_init_unchained(name_, symbol_);
    }

    /**
    Initialize the variables of the contract
    */
    function __TERC1155A_init_unchained(
        string memory name_,
        string memory symbol_
    ) internal onlyInitializing {
        name = name_;
        symbol = symbol_;
    }
    
    /** 
    @dev This surcharge is not necessary if you do not use the MetaTxModule
    */
    function _msgSender()
        internal
        view
        override(MetaTxModule, ContextUpgradeable)
        returns (address sender)
    {
        return MetaTxModule._msgSender();
    }

    /** 
    @dev This surcharge is not necessary if you do not use the MetaTxModule
    */
    function _msgData()
        internal
        view
        override(MetaTxModule, ContextUpgradeable)
        returns (bytes calldata)
    {
        return MetaTxModule._msgData();
    }
}