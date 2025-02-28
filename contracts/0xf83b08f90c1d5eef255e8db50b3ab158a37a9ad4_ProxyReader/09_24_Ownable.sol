// @author Unstoppable Domains, Inc.
// @date May 23th, 2023

pragma solidity ^0.8.0;

import '@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol';
import '@openzeppelin/contracts-upgradeable/utils/StorageSlotUpgradeable.sol';

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Initializable {
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    // This is the keccak-256 hash of 'uns.ownable.owner' subtracted by 1
    bytes32 internal constant _OWNER_SLOT = 0xe1b9c5b9c6f25fc6c03fdb76829a7257b1cdb10ff4bc4f62e0a94358c8121905;

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    // solhint-disable-next-line func-name-mixedcase
    function __Ownable_init() internal onlyInitializing {
        __Ownable_init_unchained();
    }

    // solhint-disable-next-line func-name-mixedcase
    function __Ownable_init_unchained() internal onlyInitializing {
        _transferOwnership(_msgSender());
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        _checkOwner();
        _;
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return StorageSlotUpgradeable.getAddressSlot(_OWNER_SLOT).value;
    }

    /**
     * @dev Throws if the sender is not the owner.
     */
    function _checkOwner() internal view virtual {
        require(owner() == _msgSender(), 'Ownable: caller is not the owner');
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), 'Ownable: new owner is the zero address');
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Internal function without access restriction.
     */
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = owner();
        StorageSlotUpgradeable.getAddressSlot(_OWNER_SLOT).value = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }

    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}