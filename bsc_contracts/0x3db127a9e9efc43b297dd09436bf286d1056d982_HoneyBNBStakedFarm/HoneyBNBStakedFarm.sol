/**
 *Submitted for verification at BscScan.com on 2023-02-28
*/

// Sources flattened with hardhat v2.12.5 https://hardhat.org

// File @openzeppelin/contracts-upgradeable/access/[email protected]
//SPDX-License-Identifier: UNLICENSED

// OpenZeppelin Contracts v4.4.1 (access/IAccessControl.sol)

pragma solidity ^ 0.8.0;

/**
 * @dev External interface of AccessControl declared to support ERC165 detection.
 */
interface IAccessControlUpgradeable {
    /**
     * @dev Emitted when `newAdminRole` is set as ``role``'s admin role, replacing `previousAdminRole`
     *
     * `DEFAULT_ADMIN_ROLE` is the starting admin for all roles, despite
     * {RoleAdminChanged} not being emitted signaling this.
     *
     * _Available since v3.1._
     */
    event RoleAdminChanged(bytes32 indexed role, bytes32 indexed previousAdminRole, bytes32 indexed newAdminRole);

    /**
     * @dev Emitted when `account` is granted `role`.
     *
     * `sender` is the account that originated the contract call, an admin role
     * bearer except when using {AccessControl-_setupRole}.
     */
    event RoleGranted(bytes32 indexed role, address indexed account, address indexed sender);

    /**
     * @dev Emitted when `account` is revoked `role`.
     *
     * `sender` is the account that originated the contract call:
     *   - if using `revokeRole`, it is the admin role bearer
     *   - if using `renounceRole`, it is the role bearer (i.e. `account`)
     */
    event RoleRevoked(bytes32 indexed role, address indexed account, address indexed sender);

/**
 * @dev Returns `true` if `account` has been granted `role`.
 */
function hasRole(bytes32 role, address account) external view returns(bool);

/**
 * @dev Returns the admin role that controls `role`. See {grantRole} and
 * {revokeRole}.
 *
 * To change a role's admin, use {AccessControl-_setRoleAdmin}.
 */
function getRoleAdmin(bytes32 role) external view returns(bytes32);

/**
 * @dev Grants `role` to `account`.
 *
 * If `account` had not been already granted `role`, emits a {RoleGranted}
 * event.
 *
 * Requirements:
 *
 * - the caller must have ``role``'s admin role.
 */
function grantRole(bytes32 role, address account) external;

/**
 * @dev Revokes `role` from `account`.
 *
 * If `account` had been granted `role`, emits a {RoleRevoked} event.
 *
 * Requirements:
 *
 * - the caller must have ``role``'s admin role.
 */
function revokeRole(bytes32 role, address account) external;

/**
 * @dev Revokes `role` from the calling account.
 *
 * Roles are often managed via {grantRole} and {revokeRole}: this function's
 * purpose is to provide a mechanism for accounts to lose their privileges
 * if they are compromised (such as when a trusted device is misplaced).
 *
 * If the calling account had been granted `role`, emits a {RoleRevoked}
 * event.
 *
 * Requirements:
 *
 * - the caller must be `account`.
 */
function renounceRole(bytes32 role, address account) external;
}


// File @openzeppelin/contracts-upgradeable/utils/[email protected]


// OpenZeppelin Contracts (last updated v4.5.0) (utils/Address.sol)

pragma solidity ^ 0.8.1;

/**
 * @dev Collection of functions related to the address type
 */
library AddressUpgradeable {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     *
     * [IMPORTANT]
     * ====
     * You shouldn't rely on `isContract` to protect against flash loan attacks!
     *
     * Preventing calls from contracts is highly discouraged. It breaks composability, breaks support for smart wallets
     * like Gnosis Safe, and does not provide security since it can be circumvented by calling from a contract
     * constructor.
     * ====
     */
    function isContract(address account) internal view returns(bool) {
        // This method relies on extcodesize/address.code.length, which returns 0
        // for contracts in construction, since the code is only stored at the end
        // of the constructor execution.

        return account.code.length > 0;
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        (bool success, ) = recipient.call{ value: amount } ("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain `call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data) internal returns(bytes memory) {
        return functionCall(target, data, "Address: low-level call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns(bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value
    ) internal returns(bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value,
        string memory errorMessage
    ) internal returns(bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        require(isContract(target), "Address: call to non-contract");

        (bool success, bytes memory returndata) = target.call{ value: value } (data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(address target, bytes memory data) internal view returns(bytes memory) {
        return functionStaticCall(target, data, "Address: low-level static call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal view returns(bytes memory) {
        require(isContract(target), "Address: static call to non-contract");

        (bool success, bytes memory returndata) = target.staticcall(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Tool to verifies that a low level call was successful, and revert if it wasn't, either by bubbling the
     * revert reason using the provided one.
     *
     * _Available since v4.3._
     */
    function verifyCallResult(
        bool success,
        bytes memory returndata,
        string memory errorMessage
    ) internal pure returns(bytes memory) {
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                assembly {
                    let returndata_size:= mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}


// File @openzeppelin/contracts-upgradeable/proxy/utils/[email protected]


// OpenZeppelin Contracts (last updated v4.6.0) (proxy/utils/Initializable.sol)

pragma solidity ^ 0.8.2;

/**
 * @dev This is a base contract to aid in writing upgradeable contracts, or any kind of contract that will be deployed
 * behind a proxy. Since proxied contracts do not make use of a constructor, it's common to move constructor logic to an
 * external initializer function, usually called `initialize`. It then becomes necessary to protect this initializer
 * function so it can only be called once. The {initializer} modifier provided by this contract will have this effect.
 *
 * The initialization functions use a version number. Once a version number is used, it is consumed and cannot be
 * reused. This mechanism prevents re-execution of each "step" but allows the creation of new initialization steps in
 * case an upgrade adds a module that needs to be initialized.
 *
 * For example:
 *
 * [.hljs-theme-light.nopadding]
 * ```
 * contract MyToken is ERC20Upgradeable {
 *     function initialize() initializer public {
 *         __ERC20_init("MyToken", "MTK");
 *     }
 * }
 * contract MyTokenV2 is MyToken, ERC20PermitUpgradeable {
 *     function initializeV2() reinitializer(2) public {
 *         __ERC20Permit_init("MyToken");
 *     }
 * }
 * ```
 *
 * TIP: To avoid leaving the proxy in an uninitialized state, the initializer function should be called as early as
 * possible by providing the encoded function call as the `_data` argument to {ERC1967Proxy-constructor}.
 *
 * CAUTION: When used with inheritance, manual care must be taken to not invoke a parent initializer twice, or to ensure
 * that all initializers are idempotent. This is not verified automatically as constructors are by Solidity.
 *
 * [CAUTION]
 * ====
 * Avoid leaving a contract uninitialized.
 *
 * An uninitialized contract can be taken over by an attacker. This applies to both a proxy and its implementation
 * contract, which may impact the proxy. To prevent the implementation contract from being used, you should invoke
 * the {_disableInitializers} function in the constructor to automatically lock it when it is deployed:
 *
 * [.hljs-theme-light.nopadding]
 * ```
 * /// @custom:oz-upgrades-unsafe-allow constructor
 * constructor() {
 *     _disableInitializers();
 * }
 * ```
 * ====
 */
abstract contract Initializable {
    /**
     * @dev Indicates that the contract has been initialized.
     * @custom:oz-retyped-from bool
     */
    uint8 private _initialized;

    /**
     * @dev Indicates that the contract is in the process of being initialized.
     */
    bool private _initializing;

    /**
     * @dev Triggered when the contract has been initialized or reinitialized.
     */
    event Initialized(uint8 version);

    /**
     * @dev A modifier that defines a protected initializer function that can be invoked at most once. In its scope,
     * `onlyInitializing` functions can be used to initialize parent contracts. Equivalent to `reinitializer(1)`.
     */
    modifier initializer() {
        bool isTopLevelCall = _setInitializedVersion(1);
        if (isTopLevelCall) {
            _initializing = true;
        }
        _;
        if (isTopLevelCall) {
            _initializing = false;
            emit Initialized(1);
        }
    }

    /**
     * @dev A modifier that defines a protected reinitializer function that can be invoked at most once, and only if the
     * contract hasn't been initialized to a greater version before. In its scope, `onlyInitializing` functions can be
     * used to initialize parent contracts.
     *
     * `initializer` is equivalent to `reinitializer(1)`, so a reinitializer may be used after the original
     * initialization step. This is essential to configure modules that are added through upgrades and that require
     * initialization.
     *
     * Note that versions can jump in increments greater than 1; this implies that if multiple reinitializers coexist in
     * a contract, executing them in the right order is up to the developer or operator.
     */
    modifier reinitializer(uint8 version) {
        bool isTopLevelCall = _setInitializedVersion(version);
        if (isTopLevelCall) {
            _initializing = true;
        }
        _;
        if (isTopLevelCall) {
            _initializing = false;
            emit Initialized(version);
        }
    }

    /**
     * @dev Modifier to protect an initialization function so that it can only be invoked by functions with the
     * {initializer} and {reinitializer} modifiers, directly or indirectly.
     */
    modifier onlyInitializing() {
        require(_initializing, "Initializable: contract is not initializing");
        _;
    }

    /**
     * @dev Locks the contract, preventing any future reinitialization. This cannot be part of an initializer call.
     * Calling this in the constructor of a contract will prevent that contract from being initialized or reinitialized
     * to any version. It is recommended to use this to lock implementation contracts that are designed to be called
     * through proxies.
     */
    function _disableInitializers() internal virtual {
        _setInitializedVersion(type(uint8).max);
    }

    function _setInitializedVersion(uint8 version) private returns(bool) {
        // If the contract is initializing we ignore whether _initialized is set in order to support multiple
        // inheritance patterns, but we only do this in the context of a constructor, and for the lowest level
        // of initializers, because in other contexts the contract may have been reentered.
        if (_initializing) {
            require(
                version == 1 && !AddressUpgradeable.isContract(address(this)),
                "Initializable: contract is already initialized"
            );
            return false;
        } else {
            require(_initialized < version, "Initializable: contract is already initialized");
            _initialized = version;
            return true;
        }
    }
}


// File @openzeppelin/contracts-upgradeable/utils/[email protected]


// OpenZeppelin Contracts v4.4.1 (utils/Context.sol)

pragma solidity ^ 0.8.0;

/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract ContextUpgradeable is Initializable {
    function __Context_init() internal onlyInitializing {
    }

    function __Context_init_unchained() internal onlyInitializing {
    }
    function _msgSender() internal view virtual returns(address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns(bytes calldata) {
        return msg.data;
    }

    /**
     * @dev This empty reserved space is put in place to allow future versions to add new
     * variables without shifting down storage in the inheritance chain.
     * See https://docs.openzeppelin.com/contracts/4.x/upgradeable#storage_gaps
     */
    uint256[50] private __gap;
}


// File @openzeppelin/contracts-upgradeable/utils/introspection/[email protected]


// OpenZeppelin Contracts v4.4.1 (utils/introspection/IERC165.sol)

pragma solidity ^ 0.8.0;

/**
 * @dev Interface of the ERC165 standard, as defined in the
 * https://eips.ethereum.org/EIPS/eip-165[EIP].
 *
 * Implementers can declare support of contract interfaces, which can then be
 * queried by others ({ERC165Checker}).
 *
 * For an implementation, see {ERC165}.
 */
interface IERC165Upgradeable {
    /**
     * @dev Returns true if this contract implements the interface defined by
     * `interfaceId`. See the corresponding
     * https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[EIP section]
     * to learn more about how these ids are created.
     *
     * This function call must use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns(bool);
}


// File @openzeppelin/contracts-upgradeable/utils/introspection/[email protected]


// OpenZeppelin Contracts v4.4.1 (utils/introspection/ERC165.sol)

pragma solidity ^ 0.8.0;


/**
 * @dev Implementation of the {IERC165} interface.
 *
 * Contracts that want to implement ERC165 should inherit from this contract and override {supportsInterface} to check
 * for the additional interface id that will be supported. For example:
 *
 * ```solidity
 * function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
 *     return interfaceId == type(MyInterface).interfaceId || super.supportsInterface(interfaceId);
 * }
 * ```
 *
 * Alternatively, {ERC165Storage} provides an easier to use but more expensive implementation.
 */
abstract contract ERC165Upgradeable is Initializable, IERC165Upgradeable {
    function __ERC165_init() internal onlyInitializing {
    }

    function __ERC165_init_unchained() internal onlyInitializing {
    }
    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId) public view virtual override returns(bool) {
        return interfaceId == type(IERC165Upgradeable).interfaceId;
    }

    /**
     * @dev This empty reserved space is put in place to allow future versions to add new
     * variables without shifting down storage in the inheritance chain.
     * See https://docs.openzeppelin.com/contracts/4.x/upgradeable#storage_gaps
     */
    uint256[50] private __gap;
}


// File @openzeppelin/contracts-upgradeable/utils/[email protected]


// OpenZeppelin Contracts v4.4.1 (utils/Strings.sol)

pragma solidity ^ 0.8.0;

/**
 * @dev String operations.
 */
library StringsUpgradeable {
    bytes16 private constant _HEX_SYMBOLS = "0123456789abcdef";

    /**
     * @dev Converts a `uint256` to its ASCII `string` decimal representation.
     */
    function toString(uint256 value) internal pure returns(string memory) {
        // Inspired by OraclizeAPI's implementation - MIT licence
        // https://github.com/oraclize/ethereum-api/blob/b42146b063c7d6ee1358846c198246239e9360e8/oraclizeAPI_0.4.25.sol

        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }

    /**
     * @dev Converts a `uint256` to its ASCII `string` hexadecimal representation.
     */
    function toHexString(uint256 value) internal pure returns(string memory) {
        if (value == 0) {
            return "0x00";
        }
        uint256 temp = value;
        uint256 length = 0;
        while (temp != 0) {
            length++;
            temp >>= 8;
        }
        return toHexString(value, length);
    }

    /**
     * @dev Converts a `uint256` to its ASCII `string` hexadecimal representation with fixed length.
     */
    function toHexString(uint256 value, uint256 length) internal pure returns(string memory) {
        bytes memory buffer = new bytes(2 * length + 2);
        buffer[0] = "0";
        buffer[1] = "x";
        for (uint256 i = 2 * length + 1; i > 1; --i) {
            buffer[i] = _HEX_SYMBOLS[value & 0xf];
            value >>= 4;
        }
        require(value == 0, "Strings: hex length insufficient");
        return string(buffer);
    }
}


// File @openzeppelin/contracts-upgradeable/access/[email protected]


// OpenZeppelin Contracts (last updated v4.6.0) (access/AccessControl.sol)

pragma solidity ^ 0.8.0;





/**
 * @dev Contract module that allows children to implement role-based access
 * control mechanisms. This is a lightweight version that doesn't allow enumerating role
 * members except through off-chain means by accessing the contract event logs. Some
 * applications may benefit from on-chain enumerability, for those cases see
 * {AccessControlEnumerable}.
 *
 * Roles are referred to by their `bytes32` identifier. These should be exposed
 * in the external API and be unique. The best way to achieve this is by
 * using `public constant` hash digests:
 *
 * ```
 * bytes32 public constant MY_ROLE = keccak256("MY_ROLE");
 * ```
 *
 * Roles can be used to represent a set of permissions. To restrict access to a
 * function call, use {hasRole}:
 *
 * ```
 * function foo() public {
 *     require(hasRole(MY_ROLE, msg.sender));
 *     ...
 * }
 * ```
 *
 * Roles can be granted and revoked dynamically via the {grantRole} and
 * {revokeRole} functions. Each role has an associated admin role, and only
 * accounts that have a role's admin role can call {grantRole} and {revokeRole}.
 *
 * By default, the admin role for all roles is `DEFAULT_ADMIN_ROLE`, which means
 * that only accounts with this role will be able to grant or revoke other
 * roles. More complex role relationships can be created by using
 * {_setRoleAdmin}.
 *
 * WARNING: The `DEFAULT_ADMIN_ROLE` is also its own admin: it has permission to
 * grant and revoke this role. Extra precautions should be taken to secure
 * accounts that have been granted it.
 */
abstract contract AccessControlUpgradeable is Initializable, ContextUpgradeable, IAccessControlUpgradeable, ERC165Upgradeable {
    function __AccessControl_init() internal onlyInitializing {
    }

    function __AccessControl_init_unchained() internal onlyInitializing {
    }
    struct RoleData {
        mapping(address => bool) members;
        bytes32 adminRole;
    }

    mapping(bytes32 => RoleData) private _roles;

    bytes32 public constant DEFAULT_ADMIN_ROLE = 0x00;

    /**
     * @dev Modifier that checks that an account has a specific role. Reverts
     * with a standardized message including the required role.
     *
     * The format of the revert reason is given by the following regular expression:
     *
     *  /^AccessControl: account (0x[0-9a-f]{40}) is missing role (0x[0-9a-f]{64})$/
     *
     * _Available since v4.1._
     */
    modifier onlyRole(bytes32 role) {
        _checkRole(role);
        _;
    }

    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId) public view virtual override returns(bool) {
        return interfaceId == type(IAccessControlUpgradeable).interfaceId || super.supportsInterface(interfaceId);
    }

    /**
     * @dev Returns `true` if `account` has been granted `role`.
     */
    function hasRole(bytes32 role, address account) public view virtual override returns(bool) {
        return _roles[role].members[account];
    }

    /**
     * @dev Revert with a standard message if `_msgSender()` is missing `role`.
     * Overriding this function changes the behavior of the {onlyRole} modifier.
     *
     * Format of the revert message is described in {_checkRole}.
     *
     * _Available since v4.6._
     */
    function _checkRole(bytes32 role) internal view virtual {
        _checkRole(role, _msgSender());
    }

    /**
     * @dev Revert with a standard message if `account` is missing `role`.
     *
     * The format of the revert reason is given by the following regular expression:
     *
     *  /^AccessControl: account (0x[0-9a-f]{40}) is missing role (0x[0-9a-f]{64})$/
     */
    function _checkRole(bytes32 role, address account) internal view virtual {
        if (!hasRole(role, account)) {
            revert(
                string(
                    abi.encodePacked(
                        "AccessControl: account ",
                        StringsUpgradeable.toHexString(uint160(account), 20),
                        " is missing role ",
                        StringsUpgradeable.toHexString(uint256(role), 32)
                    )
                )
            );
        }
    }

    /**
     * @dev Returns the admin role that controls `role`. See {grantRole} and
     * {revokeRole}.
     *
     * To change a role's admin, use {_setRoleAdmin}.
     */
    function getRoleAdmin(bytes32 role) public view virtual override returns(bytes32) {
        return _roles[role].adminRole;
    }

    /**
     * @dev Grants `role` to `account`.
     *
     * If `account` had not been already granted `role`, emits a {RoleGranted}
     * event.
     *
     * Requirements:
     *
     * - the caller must have ``role``'s admin role.
     */
    function grantRole(bytes32 role, address account) public virtual override onlyRole(getRoleAdmin(role)) {
        _grantRole(role, account);
    }

    /**
     * @dev Revokes `role` from `account`.
     *
     * If `account` had been granted `role`, emits a {RoleRevoked} event.
     *
     * Requirements:
     *
     * - the caller must have ``role``'s admin role.
     */
    function revokeRole(bytes32 role, address account) public virtual override onlyRole(getRoleAdmin(role)) {
        _revokeRole(role, account);
    }

    /**
     * @dev Revokes `role` from the calling account.
     *
     * Roles are often managed via {grantRole} and {revokeRole}: this function's
     * purpose is to provide a mechanism for accounts to lose their privileges
     * if they are compromised (such as when a trusted device is misplaced).
     *
     * If the calling account had been revoked `role`, emits a {RoleRevoked}
     * event.
     *
     * Requirements:
     *
     * - the caller must be `account`.
     */
    function renounceRole(bytes32 role, address account) public virtual override {
        require(account == _msgSender(), "AccessControl: can only renounce roles for self");

        _revokeRole(role, account);
    }

    /**
     * @dev Grants `role` to `account`.
     *
     * If `account` had not been already granted `role`, emits a {RoleGranted}
     * event. Note that unlike {grantRole}, this function doesn't perform any
     * checks on the calling account.
     *
     * [WARNING]
     * ====
     * This function should only be called from the constructor when setting
     * up the initial roles for the system.
     *
     * Using this function in any other way is effectively circumventing the admin
     * system imposed by {AccessControl}.
     * ====
     *
     * NOTE: This function is deprecated in favor of {_grantRole}.
     */
    function _setupRole(bytes32 role, address account) internal virtual {
        _grantRole(role, account);
    }

    /**
     * @dev Sets `adminRole` as ``role``'s admin role.
     *
     * Emits a {RoleAdminChanged} event.
     */
    function _setRoleAdmin(bytes32 role, bytes32 adminRole) internal virtual {
        bytes32 previousAdminRole = getRoleAdmin(role);
        _roles[role].adminRole = adminRole;
        emit RoleAdminChanged(role, previousAdminRole, adminRole);
    }

    /**
     * @dev Grants `role` to `account`.
     *
     * Internal function without access restriction.
     */
    function _grantRole(bytes32 role, address account) internal virtual {
        if (!hasRole(role, account)) {
            _roles[role].members[account] = true;
            emit RoleGranted(role, account, _msgSender());
        }
    }

    /**
     * @dev Revokes `role` from `account`.
     *
     * Internal function without access restriction.
     */
    function _revokeRole(bytes32 role, address account) internal virtual {
        if (hasRole(role, account)) {
            _roles[role].members[account] = false;
            emit RoleRevoked(role, account, _msgSender());
        }
    }

    /**
     * @dev This empty reserved space is put in place to allow future versions to add new
     * variables without shifting down storage in the inheritance chain.
     * See https://docs.openzeppelin.com/contracts/4.x/upgradeable#storage_gaps
     */
    uint256[49] private __gap;
}


// File @openzeppelin/contracts-upgradeable/security/[email protected]


// OpenZeppelin Contracts v4.4.1 (security/Pausable.sol)

pragma solidity ^ 0.8.0;


/**
 * @dev Contract module which allows children to implement an emergency stop
 * mechanism that can be triggered by an authorized account.
 *
 * This module is used through inheritance. It will make available the
 * modifiers `whenNotPaused` and `whenPaused`, which can be applied to
 * the functions of your contract. Note that they will not be pausable by
 * simply including this module, only once the modifiers are put in place.
 */
abstract contract PausableUpgradeable is Initializable, ContextUpgradeable {
    /**
     * @dev Emitted when the pause is triggered by `account`.
     */
    event Paused(address account);

    /**
     * @dev Emitted when the pause is lifted by `account`.
     */
    event Unpaused(address account);

    bool private _paused;

    /**
     * @dev Initializes the contract in unpaused state.
     */
    function __Pausable_init() internal onlyInitializing {
        __Pausable_init_unchained();
    }

    function __Pausable_init_unchained() internal onlyInitializing {
        _paused = false;
    }

    /**
     * @dev Returns true if the contract is paused, and false otherwise.
     */
    function paused() public view virtual returns(bool) {
        return _paused;
    }

    /**
     * @dev Modifier to make a function callable only when the contract is not paused.
     *
     * Requirements:
     *
     * - The contract must not be paused.
     */
    modifier whenNotPaused() {
        require(!paused(), "Pausable: paused");
        _;
    }

    /**
     * @dev Modifier to make a function callable only when the contract is paused.
     *
     * Requirements:
     *
     * - The contract must be paused.
     */
    modifier whenPaused() {
        require(paused(), "Pausable: not paused");
        _;
    }

    /**
     * @dev Triggers stopped state.
     *
     * Requirements:
     *
     * - The contract must not be paused.
     */
    function _pause() internal virtual whenNotPaused {
        _paused = true;
        emit Paused(_msgSender());
    }

    /**
     * @dev Returns to normal state.
     *
     * Requirements:
     *
     * - The contract must be paused.
     */
    function _unpause() internal virtual whenPaused {
        _paused = false;
        emit Unpaused(_msgSender());
    }

    /**
     * @dev This empty reserved space is put in place to allow future versions to add new
     * variables without shifting down storage in the inheritance chain.
     * See https://docs.openzeppelin.com/contracts/4.x/upgradeable#storage_gaps
     */
    uint256[49] private __gap;
}


// File @openzeppelin/contracts-upgradeable/security/[email protected]


// OpenZeppelin Contracts v4.4.1 (security/ReentrancyGuard.sol)

pragma solidity ^ 0.8.0;

/**
 * @dev Contract module that helps prevent reentrant calls to a function.
 *
 * Inheriting from `ReentrancyGuard` will make the {nonReentrant} modifier
 * available, which can be applied to functions to make sure there are no nested
 * (reentrant) calls to them.
 *
 * Note that because there is a single `nonReentrant` guard, functions marked as
 * `nonReentrant` may not call one another. This can be worked around by making
 * those functions `private`, and then adding `external` `nonReentrant` entry
 * points to them.
 *
 * TIP: If you would like to learn more about reentrancy and alternative ways
 * to protect against it, check out our blog post
 * https://blog.openzeppelin.com/reentrancy-after-istanbul/[Reentrancy After Istanbul].
 */
abstract contract ReentrancyGuardUpgradeable is Initializable {
    // Booleans are more expensive than uint256 or any type that takes up a full
    // word because each write operation emits an extra SLOAD to first read the
    // slot's contents, replace the bits taken up by the boolean, and then write
    // back. This is the compiler's defense against contract upgrades and
    // pointer aliasing, and it cannot be disabled.

    // The values being non-zero value makes deployment a bit more expensive,
    // but in exchange the refund on every call to nonReentrant will be lower in
    // amount. Since refunds are capped to a percentage of the total
    // transaction's gas, it is best to keep them low in cases like this one, to
    // increase the likelihood of the full refund coming into effect.
    uint256 private constant _NOT_ENTERED = 1;
    uint256 private constant _ENTERED = 2;

    uint256 private _status;

    function __ReentrancyGuard_init() internal onlyInitializing {
        __ReentrancyGuard_init_unchained();
    }

    function __ReentrancyGuard_init_unchained() internal onlyInitializing {
        _status = _NOT_ENTERED;
    }

    /**
     * @dev Prevents a contract from calling itself, directly or indirectly.
     * Calling a `nonReentrant` function from another `nonReentrant`
     * function is not supported. It is possible to prevent this from happening
     * by making the `nonReentrant` function external, and making it call a
     * `private` function that does the actual work.
     */
    modifier nonReentrant() {
        // On the first call to nonReentrant, _notEntered will be true
        require(_status != _ENTERED, "ReentrancyGuard: reentrant call");

        // Any calls to nonReentrant after this point will fail
        _status = _ENTERED;

        _;

        // By storing the original value once again, a refund is triggered (see
        // https://eips.ethereum.org/EIPS/eip-2200)
        _status = _NOT_ENTERED;
    }

    /**
     * @dev This empty reserved space is put in place to allow future versions to add new
     * variables without shifting down storage in the inheritance chain.
     * See https://docs.openzeppelin.com/contracts/4.x/upgradeable#storage_gaps
     */
    uint256[49] private __gap;
}


// File @openzeppelin/contracts-upgradeable/token/ERC20/[email protected]


// OpenZeppelin Contracts (last updated v4.6.0) (token/ERC20/IERC20.sol)

pragma solidity ^ 0.8.0;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20Upgradeable {
    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);

/**
 * @dev Returns the amount of tokens in existence.
 */
function totalSupply() external view returns(uint256);

/**
 * @dev Returns the amount of tokens owned by `account`.
 */
function balanceOf(address account) external view returns(uint256);

/**
 * @dev Moves `amount` tokens from the caller's account to `to`.
 *
 * Returns a boolean value indicating whether the operation succeeded.
 *
 * Emits a {Transfer} event.
 */
function transfer(address to, uint256 amount) external returns(bool);

/**
 * @dev Returns the remaining number of tokens that `spender` will be
 * allowed to spend on behalf of `owner` through {transferFrom}. This is
 * zero by default.
 *
 * This value changes when {approve} or {transferFrom} are called.
 */
function allowance(address owner, address spender) external view returns(uint256);

/**
 * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
 *
 * Returns a boolean value indicating whether the operation succeeded.
 *
 * IMPORTANT: Beware that changing an allowance with this method brings the risk
 * that someone may use both the old and the new allowance by unfortunate
 * transaction ordering. One possible solution to mitigate this race
 * condition is to first reduce the spender's allowance to 0 and set the
 * desired value afterwards:
 * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
 *
 * Emits an {Approval} event.
 */
function approve(address spender, uint256 amount) external returns(bool);

/**
 * @dev Moves `amount` tokens from `from` to `to` using the
 * allowance mechanism. `amount` is then deducted from the caller's
 * allowance.
 *
 * Returns a boolean value indicating whether the operation succeeded.
 *
 * Emits a {Transfer} event.
 */
function transferFrom(
    address from,
    address to,
    uint256 amount
) external returns(bool);
}


// File @openzeppelin/contracts-upgradeable/token/ERC20/utils/[email protected]


// OpenZeppelin Contracts v4.4.1 (token/ERC20/utils/SafeERC20.sol)

pragma solidity ^ 0.8.0;


/**
 * @title SafeERC20
 * @dev Wrappers around ERC20 operations that throw on failure (when the token
 * contract returns false). Tokens that return no value (and instead revert or
 * throw on failure) are also supported, non-reverting calls are assumed to be
 * successful.
 * To use this library you can add a `using SafeERC20 for IERC20;` statement to your contract,
 * which allows you to call the safe operations as `token.safeTransfer(...)`, etc.
 */
library SafeERC20Upgradeable {
    using AddressUpgradeable for address;

        function safeTransfer(
            IERC20Upgradeable token,
            address to,
            uint256 value
        ) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));
    }

    function safeTransferFrom(
        IERC20Upgradeable token,
        address from,
        address to,
        uint256 value
    ) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));
    }

    /**
     * @dev Deprecated. This function has issues similar to the ones found in
     * {IERC20-approve}, and its usage is discouraged.
     *
     * Whenever possible, use {safeIncreaseAllowance} and
     * {safeDecreaseAllowance} instead.
     */
    function safeApprove(
        IERC20Upgradeable token,
        address spender,
        uint256 value
    ) internal {
        // safeApprove should only be called when setting an initial allowance,
        // or when resetting it to zero. To increase and decrease it, use
        // 'safeIncreaseAllowance' and 'safeDecreaseAllowance'
        require(
            (value == 0) || (token.allowance(address(this), spender) == 0),
            "SafeERC20: approve from non-zero to non-zero allowance"
        );
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));
    }

    function safeIncreaseAllowance(
        IERC20Upgradeable token,
        address spender,
        uint256 value
    ) internal {
        uint256 newAllowance = token.allowance(address(this), spender) + value;
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
    }

    function safeDecreaseAllowance(
        IERC20Upgradeable token,
        address spender,
        uint256 value
    ) internal {
        unchecked {
            uint256 oldAllowance = token.allowance(address(this), spender);
            require(oldAllowance >= value, "SafeERC20: decreased allowance below zero");
            uint256 newAllowance = oldAllowance - value;
            _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
        }
    }

    /**
     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
     * on the return value: the return value is optional (but if data is returned, it must not be false).
     * @param token The token targeted by the call.
     * @param data The call data (encoded using abi.encode or one of its variants).
     */
    function _callOptionalReturn(IERC20Upgradeable token, bytes memory data) private {
        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
        // we're implementing it ourselves. We use {Address.functionCall} to perform this call, which verifies that
        // the target address contains contract code and also asserts for success in the low-level call.

        bytes memory returndata = address(token).functionCall(data, "SafeERC20: low-level call failed");
        if (returndata.length > 0) {
            // Return data is optional
            require(abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");
        }
    }
}


// File contracts/Interfaces/IBiswapMasterChef.sol

 
pragma solidity ^ 0.8.4;

interface IBiswapMasterChef {
    function BSW() external pure returns(address);

function pendingBSW(uint256 _pid, address _user)
external
view
returns(uint256);

function poolInfo(
    uint256 _pid
)
external
view
returns(
    address lpToken,
    uint256 allocPoint,
    uint256 lastRewardBlock,
    uint256 accBSWPerShare
);

function userInfo(
    uint256 _pid,
    address _userAddress
)
external
view
returns(
    uint256 amount,
    uint256 rewardDebt
);

function deposit(uint256 _pid, uint256 _amount) external;

function withdraw(uint256 _pid, uint256 _amount) external;
}


// File contracts/Interfaces/IUniswapV2Router01.sol

 
pragma solidity >= 0.6.2;

interface IUniswapV2Router01 {
    function factory() external pure returns(address);
function WETH() external pure returns(address);

function addLiquidity(
    address tokenA,
    address tokenB,
    uint amountADesired,
    uint amountBDesired,
    uint amountAMin,
    uint amountBMin,
    address to,
    uint deadline
) external returns(uint amountA, uint amountB, uint liquidity);
function addLiquidityETH(
    address token,
    uint amountTokenDesired,
    uint amountTokenMin,
    uint amountETHMin,
    address to,
    uint deadline
) external payable returns(uint amountToken, uint amountETH, uint liquidity);
function removeLiquidity(
    address tokenA,
    address tokenB,
    uint liquidity,
    uint amountAMin,
    uint amountBMin,
    address to,
    uint deadline
) external returns(uint amountA, uint amountB);
function removeLiquidityETH(
    address token,
    uint liquidity,
    uint amountTokenMin,
    uint amountETHMin,
    address to,
    uint deadline
) external returns(uint amountToken, uint amountETH);
function removeLiquidityWithPermit(
    address tokenA,
    address tokenB,
    uint liquidity,
    uint amountAMin,
    uint amountBMin,
    address to,
    uint deadline,
    bool approveMax, uint8 v, bytes32 r, bytes32 s
) external returns(uint amountA, uint amountB);
function removeLiquidityETHWithPermit(
    address token,
    uint liquidity,
    uint amountTokenMin,
    uint amountETHMin,
    address to,
    uint deadline,
    bool approveMax, uint8 v, bytes32 r, bytes32 s
) external returns(uint amountToken, uint amountETH);
function swapExactTokensForTokens(
    uint amountIn,
    uint amountOutMin,
    address[] calldata path,
    address to,
    uint deadline
) external returns(uint[] memory amounts);
function swapTokensForExactTokens(
    uint amountOut,
    uint amountInMax,
    address[] calldata path,
    address to,
    uint deadline
) external returns(uint[] memory amounts);
function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
external
payable
returns(uint[] memory amounts);
function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
external
returns(uint[] memory amounts);
function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
external
returns(uint[] memory amounts);
function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
external
payable
returns(uint[] memory amounts);

function quote(uint amountA, uint reserveA, uint reserveB) external pure returns(uint amountB);
function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns(uint amountOut);
function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns(uint amountIn);
function getAmountsOut(uint amountIn, address[] calldata path) external view returns(uint[] memory amounts);
function getAmountsIn(uint amountOut, address[] calldata path) external view returns(uint[] memory amounts);
}


// File contracts/Interfaces/IDEX.sol

 
pragma solidity ^ 0.8.4;
interface IDEX {
    function SwapRouter() external returns(IUniswapV2Router01);

function convertEthToPairLP(address lpAddress)
external
payable
returns(
    uint256 lpAmount,
    uint256 unusedTokenA,
    uint256 unusedTokenB
);

function convertEthToTokenLP(address token)
external
payable
returns(
    uint256 lpAmount,
    uint256 unusedEth,
    uint256 unusedToken
);

function convertPairLpToEth(address lpAddress, uint256 amount)
external
returns(uint256 ethAmount);

function convertTokenLpToEth(address token, uint256 amount)
external
returns(uint256 ethAmount);

function convertEthToToken(address token)
external
payable
returns(uint256 tokenAmount);

function convertTokenToEth(uint256 amount, address token)
external
returns(uint256 ethAmount);

function getTokenEthPrice(address token) external view returns(uint256);

function totalPendingReward(uint256 poolID) external view returns(uint256);

function totalStakedAmount(uint256 poolID) external view returns(uint256);

function checkSlippage(
    address[] memory fromToken,
    address[] memory toToken,
    uint256[] memory amountIn,
    uint256[] memory amountOut,
    uint256 slippage
) external view;

function recoverFunds() external;
}


// File contracts/Interfaces/IHoney.sol

 
pragma solidity ^ 0.8.4;

interface IHoney {
    function totalClaimed(address claimer) external view returns(uint256);

function claimTokens(uint256 amount) external;

function setDevelopmentFounders(address _developmentFounders) external;

function setAdvisors(address _advisors) external;

function setMarketingReservesPool(address _marketingReservesPool) external;

function setDevTeam(address _devTeam) external;

function claimTokensWithoutAdditionalTokens(uint256 amount) external;
}


// File contracts/Interfaces/IUniswapV2Pair.sol

 
pragma solidity >= 0.6.2;

interface IUniswapV2Pair {
    event Approval(
    address indexed owner,
    address indexed spender,
    uint256 value
);
    event Transfer(address indexed from, address indexed to, uint256 value);

function name() external pure returns(string memory);

function symbol() external pure returns(string memory);

function decimals() external pure returns(uint8);

function totalSupply() external view returns(uint256);

function balanceOf(address owner) external view returns(uint256);

function allowance(address owner, address spender)
external
view
returns(uint256);

function approve(address spender, uint256 value) external returns(bool);

function transfer(address to, uint256 value) external returns(bool);

function transferFrom(
    address from,
    address to,
    uint256 value
) external returns(bool);

function DOMAIN_SEPARATOR() external view returns(bytes32);

function PERMIT_TYPEHASH() external pure returns(bytes32);

function nonces(address owner) external view returns(uint256);

function permit(
    address owner,
    address spender,
    uint256 value,
    uint256 deadline,
    uint8 v,
    bytes32 r,
    bytes32 s
) external;

    event Mint(address indexed sender, uint256 amount0, uint256 amount1);
    event Burn(
    address indexed sender,
    uint256 amount0,
    uint256 amount1,
    address indexed to
);
    event Swap(
    address indexed sender,
    uint256 amount0In,
    uint256 amount1In,
    uint256 amount0Out,
    uint256 amount1Out,
    address indexed to
);
    event Sync(uint112 reserve0, uint112 reserve1);

function MINIMUM_LIQUIDITY() external pure returns(uint256);

function factory() external view returns(address);

function token0() external view returns(address);

function token1() external view returns(address);

function getReserves()
external
view
returns(
    uint112 reserve0,
    uint112 reserve1,
    uint32 blockTimestampLast
);

function price0CumulativeLast() external view returns(uint256);

function price1CumulativeLast() external view returns(uint256);

function kLast() external view returns(uint256);

function mint(address to) external returns(uint256 liquidity);

function burn(address to)
external
returns(uint256 amount0, uint256 amount1);

function swap(
    uint256 amount0Out,
    uint256 amount1Out,
    address to,
    bytes calldata data
) external;

function skim(address to) external;

function sync() external;
}


// File contracts/HoneyBNBStakedFarm.sol

 
pragma solidity ^ 0.8.4;
/// @title Honey-BNB-LP Staking pool
/// @notice The Honey-BNB-LP staking pool allows investors to deposit Honey-BNB-LP tokens. The investor recieves each block a certain reward in honey tokens. This blockReward can be updated by an account with UPDATER_ROLE.
/// @dev AccessControl from openzeppelin implementation is used to handle the UPDATER_ROLE, which can update the blockReward
/// User with DEFAULT_ADMIN_ROLE can grant UPDATER_ROLE to any address.
/// The DEFAULT_ADMIN_ROLE is intended to be a 2 out of 3 multisig wallet in the beginning and then be moved to governance in the future.
/// The Honey-BNB-LP staking pool uses EIP-1973 to for scalable rewards
contract HoneyBNBStakedFarm is
Initializable,
    AccessControlUpgradeable,
    ReentrancyGuardUpgradeable,
    PausableUpgradeable
{
    receive() external payable { }

    using SafeERC20Upgradeable for IERC20Upgradeable;

        struct ParticipantData {
        uint256 stakedAmount;
        uint256 claimedTokens;
        uint256 rewardMask;
        uint256 claimedRewardTokens;
        uint256 masterchefRewardMask;
    }

    bytes32 public constant UPDATER_ROLE = keccak256("UPDATER_ROLE");
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");
    bytes32 public constant FUNDS_RECOVERY_ROLE =
        keccak256("FUNDS_RECOVERY_ROLE");
    bytes32 public constant ZAP_ROLE = keccak256("ZAP_ROLE");
    uint256 private constant DECIMAL_OFFSET = 10e12;

    IDEX public DEX;
    IHoney public HoneyToken;
    IUniswapV2Pair public LPToken;
    IERC20Upgradeable public RewardToken;
    IBiswapMasterChef public MasterChef;

    uint256 public totalDeposits;
    uint256 private roundMask;
    uint256 private masterchefRoundMask;
    uint256 private poolId;
    uint256 private lastRoundMaskUpdateBlock;
    uint256 private blockRewardPhase1End;
    uint256 private blockRewardPhase2Start;
    uint256 private blockRewardPhase1Amount;
    uint256 private blockRewardPhase2Amount;

    mapping(address => ParticipantData) public participantData;

    event Stake(address indexed _staker, uint256 amount);
    event Unstake(address indexed _staker, uint256 amount);
    event ClaimRewards(address indexed _staker, uint256 amount);
    event ClaimRewardTokens(address indexed _staker, uint256 amount);

    function initialize(
        address _honeyTokenAddress,
        address _lpTokenAddress,
        address _dexAddress,
        address _admin,
        address _masterchefAddress,
        uint256 _poolId
    ) public initializer {
        roundMask = 1;
        masterchefRoundMask = 1;
        HoneyToken = IHoney(_honeyTokenAddress);
        LPToken = IUniswapV2Pair(_lpTokenAddress);
        MasterChef = IBiswapMasterChef(_masterchefAddress);
        RewardToken = IERC20Upgradeable(MasterChef.BSW());

        LPToken.approve(_masterchefAddress, type(uint256).max);

        DEX = IDEX(_dexAddress);
        poolId = _poolId;

        __AccessControl_init();
        _grantRole(DEFAULT_ADMIN_ROLE, _admin);
        __Pausable_init();
    }

    /// @notice pause
    /// @dev pause the contract
    function pause() external whenNotPaused onlyRole(PAUSER_ROLE) {
        _pause();
    }

    /// @notice unpause
    /// @dev unpause the contract
    function unpause() external whenPaused onlyRole(PAUSER_ROLE) {
        _unpause();
    }

    function depositLp(
        address to,
        uint256 amount,
        address referralGiver,
        address[] memory fromToken,
        address[] memory toToken,
        uint256[] memory amountIn,
        uint256[] memory amountOut,
        uint256 slippage,
        uint256 deadline
    ) external whenNotPaused onlyRole(ZAP_ROLE) returns(uint256) {
        require(amount > 0, "Amount must be greater than zero");

        // The first person to stake will initiate reward distribution
        if (lastRoundMaskUpdateBlock == 0)
            lastRoundMaskUpdateBlock = block.number;

        claimRewardsInternal(to);
        participantData[to].stakedAmount += amount;
        totalDeposits += amount;

        IERC20Upgradeable(address(LPToken)).safeTransferFrom(
            msg.sender,
            address(this),
            amount
        );
        MasterChef.deposit(poolId, amount);

        emit Stake(to, amount);
        return amount;
    }

    /// @notice Stakes the desired amount of Honey-BNB-LP tokens into the pool
    /// @dev Executes claimRewards before the staking to get a clean state for the roundMask and the rewards
    /// @param amount The desired staking amount for an investor in Honey-BNB-LP tokens
    function stakeLp(uint256 amount) external whenNotPaused {
        require(amount > 0, "Amount must be greater than zero");

        // The first person to stake will initiate reward distribution
        if (lastRoundMaskUpdateBlock == 0)
            lastRoundMaskUpdateBlock = block.number;

        claimRewardsInternal(msg.sender);
        participantData[msg.sender].stakedAmount += amount;
        totalDeposits += amount;

        IERC20Upgradeable(address(LPToken)).safeTransferFrom(
            msg.sender,
            address(this),
            amount
        );
        MasterChef.deposit(poolId, amount);

        emit Stake(msg.sender, amount);
    }

    function withdrawToLp(
        address to,
        uint256 amount,
        address[] memory fromToken,
        address[] memory toToken,
        uint256[] memory amountIn,
        uint256[] memory amountOut,
        uint256 slippage,
        uint256 deadline
    ) external nonReentrant onlyRole(ZAP_ROLE) returns(uint256) {
        require(amount > 0, "Amount must be greater than zero");
        require(
            amount <= participantData[to].stakedAmount,
            "Amount exceeds current staked amount"
        );

        claimRewardsInternal(to);
        participantData[to].stakedAmount -= amount;
        totalDeposits -= amount;
        MasterChef.withdraw(poolId, amount);

        IERC20Upgradeable(address(LPToken)).safeTransfer(msg.sender, amount);

        emit Unstake(to, amount);
        return amount;
    }

    /// @notice Unstakes the desired amount of Honey-BNB-LP tokens from the pool
    /// @dev Executes claimRewards before the unstaking to get a clean state for the roundMask and the rewards
    /// @param amount The desired amount to unstake for an investor in Honey-BNB-LP tokens
    function unstakeLp(uint256 amount) external whenNotPaused {
        require(amount > 0, "Amount must be greater than zero");
        require(
            amount <= participantData[msg.sender].stakedAmount,
            "Amount exceeds current staked amount"
        );

        claimRewardsInternal(msg.sender);
        participantData[msg.sender].stakedAmount -= amount;
        totalDeposits -= amount;
        MasterChef.withdraw(poolId, amount);

        IERC20Upgradeable(address(LPToken)).safeTransfer(msg.sender, amount);

        emit Unstake(msg.sender, amount);
    }

    /// @notice Converts the supplied amount of ETH into Honey-BNB-LP tokens, then stakes it into the pool
    /// @dev Executes claimRewards before the staking to get a clean state for the roundMask and the rewards
    function stakeFromEth(
        address[] memory fromToken,
        address[] memory toToken,
        uint256[] memory amountIn,
        uint256[] memory amountOut,
        uint256 slippage
    ) external payable nonReentrant whenNotPaused {
        require(msg.value > 0, "Amount must be greater than zero");

        // Checks for slippage
        DEX.checkSlippage(fromToken, toToken, amountIn, amountOut, slippage);

        // The first person to stake will initiate reward distribution
        if (lastRoundMaskUpdateBlock == 0)
            lastRoundMaskUpdateBlock = block.number;

        // Convert supplied ETH into LP tokens
        (uint256 amount, uint256 unusedToken0, uint256 unusedToken1) = DEX
            .convertEthToPairLP{ value: msg.value } (address(LPToken));

        // Send back unused Token 0
        IERC20Upgradeable(LPToken.token0()).transfer(msg.sender, unusedToken0);

        // Send back unused Token 0
        IERC20Upgradeable(LPToken.token1()).transfer(msg.sender, unusedToken1);

        claimRewardsInternal(msg.sender);
        participantData[msg.sender].stakedAmount += amount;
        totalDeposits += amount;
        MasterChef.deposit(poolId, amount);

        emit Stake(msg.sender, amount);
    }

    /// @notice Unstakes the desired amount of Honey-BNB-LP tokens from the pool, then converts it into ETH and sends it back to the caller
    /// @dev Executes claimRewards before the unstaking to get a clean state for the roundMask and the rewards
    /// @param amount The desired amount to unstake for an investor in Honey-BNB-LP tokens
    function unstakeToEth(
        uint256 amount,
        address[] memory fromToken,
        address[] memory toToken,
        uint256[] memory amountIn,
        uint256[] memory amountOut,
        uint256 slippage
    ) external nonReentrant whenNotPaused {
        require(amount > 0, "Amount must be greater than zero");
        require(
            amount <= participantData[msg.sender].stakedAmount,
            "Amount exceeds current staked amount"
        );

        // Checks for slippage
        DEX.checkSlippage(fromToken, toToken, amountIn, amountOut, slippage);

        claimRewardsInternal(msg.sender);
        participantData[msg.sender].stakedAmount -= amount;
        totalDeposits -= amount;
        MasterChef.withdraw(poolId, amount);

        // Allow DEX to spend supplied LP
        LPToken.approve(address(DEX), amount);

        // Convert LP tokens into ETH
        uint256 ethAmount = DEX.convertPairLpToEth(address(LPToken), amount);

        // Send back the ETH
        (bool transferSuccess, ) = payable(msg.sender).call{ value: ethAmount } (
            ""
        );
        require(transferSuccess, "Transfer failed");

        emit Unstake(msg.sender, amount);
    }

    /// @notice Converts the specified amount of the specified token into Honey-BNB-LP tokens, then stakes it into the pool
    /// @dev Executes claimRewards before the staking to get a clean state for the roundMask and the rewards
    /// @param token the address of the token to be converted into Honey-BNB-LP tokens
    /// @param tokenAmount the amount of tokens to be converted into Honey-BNB-LP tokens
    function stakeFromToken(
        address token,
        uint256 tokenAmount,
        address[] memory fromToken,
        address[] memory toToken,
        uint256[] memory amountIn,
        uint256[] memory amountOut,
        uint256 slippage
    ) external payable nonReentrant whenNotPaused {
        require(tokenAmount > 0, "Amount must be greater than zero");

        // The first person to stake will initiate reward distribution
        if (lastRoundMaskUpdateBlock == 0)
            lastRoundMaskUpdateBlock = block.number;

        require(
            IERC20Upgradeable(token).allowance(msg.sender, address(this)) >=
            tokenAmount,
            "Token not approved"
        );

        // Checks for slippage
        DEX.checkSlippage(fromToken, toToken, amountIn, amountOut, slippage);

        // Pull tokens from caller
        IERC20Upgradeable(token).transferFrom(
            msg.sender,
            address(this),
            tokenAmount
        );

        // Allow DEX to spend supplied tokens
        IERC20Upgradeable(token).approve(address(DEX), tokenAmount);

        // Convert supplied tokens into ETH
        uint256 ethAmount = DEX.convertTokenToEth(tokenAmount, token);

        // Convert supplied ETH into LP tokens
        (uint256 amount, uint256 unusedToken0, uint256 unusedToken1) = DEX
            .convertEthToPairLP{ value: ethAmount } (address(LPToken));

        // Send back unused Token 0
        IERC20Upgradeable(LPToken.token0()).transfer(msg.sender, unusedToken0);

        // Send back unused Token 1
        IERC20Upgradeable(LPToken.token1()).transfer(msg.sender, unusedToken1);

        claimRewardsInternal(msg.sender);
        participantData[msg.sender].stakedAmount += amount;
        totalDeposits += amount;
        MasterChef.deposit(poolId, amount);

        emit Stake(msg.sender, amount);
    }

    /// @notice Unstakes the desired amount of Honey-BNB-LP tokens from the pool, then converts it into the specified token
    /// @dev Executes claimRewards before the unstaking to get a clean state for the roundMask and the rewards
    /// @param token The address of the token into which the Honey-BNB-LP tokens will be converted
    /// @param amount The desired amount to unstake for an investor in Honey-BNB-LP tokens
    function unstakeToToken(
        address token,
        uint256 amount,
        address[] memory fromToken,
        address[] memory toToken,
        uint256[] memory amountIn,
        uint256[] memory amountOut,
        uint256 slippage
    ) external nonReentrant whenNotPaused {
        require(amount > 0, "Amount must be greater than zero");
        require(
            amount <= participantData[msg.sender].stakedAmount,
            "Amount exceeds current staked amount"
        );

        // Checks for slippage
        DEX.checkSlippage(fromToken, toToken, amountIn, amountOut, slippage);

        claimRewardsInternal(msg.sender);
        participantData[msg.sender].stakedAmount -= amount;
        totalDeposits -= amount;
        MasterChef.withdraw(poolId, amount);

        // Allow DEX to spend unstaked LP tokens
        LPToken.approve(address(DEX), amount);

        // Convert LP tokens into ETH
        uint256 ethAmount = DEX.convertPairLpToEth(address(LPToken), amount);

        // Convert ETH into tokens
        uint256 tokenAmount = DEX.convertEthToToken{ value: ethAmount } (token);

        // Send tokens back to the caller
        IERC20Upgradeable(token).transfer(msg.sender, tokenAmount);

        emit Unstake(msg.sender, amount);
    }

    /// @notice Returns the rewards generated in a specific block range
    /// @param fromBlock The starting block (exclusive)
    /// @param toBlock The ending block (inclusive)
    function getHoneyMintRewardsInRange(uint256 fromBlock, uint256 toBlock)
    public
    view
    returns(uint256)
    {
        uint256 phase1Rewards = 0;
        uint256 linearPhaseRewards = 0;
        uint256 phase2Rewards = 0;

        if (blockRewardPhase1End > fromBlock) {
            uint256 phaseEndBlock = toBlock < blockRewardPhase1End
                ? toBlock
                : blockRewardPhase1End;
            phase1Rewards =
                (phaseEndBlock - fromBlock) *
                blockRewardPhase1Amount;
        }

        if (
            fromBlock < blockRewardPhase2Start && blockRewardPhase1End < toBlock
        ) {
            uint256 phaseStartBlock = fromBlock < blockRewardPhase1End
                ? blockRewardPhase1End
                : fromBlock;
            uint256 phaseEndBlock = toBlock < blockRewardPhase2Start
                ? toBlock
                : blockRewardPhase2Start;

            uint256 linearPhaseRewardDifference = blockRewardPhase1Amount -
                blockRewardPhase2Amount;
            uint256 linearPhaseBlockLength = blockRewardPhase2Start -
                blockRewardPhase1End;
            uint256 phaseStartBlockReward = blockRewardPhase1Amount -
                ((phaseStartBlock - blockRewardPhase1End) *
                    linearPhaseRewardDifference) /
                linearPhaseBlockLength;
            uint256 phaseEndBlockReward = blockRewardPhase1Amount -
                ((phaseEndBlock - blockRewardPhase1End) *
                    linearPhaseRewardDifference) /
                linearPhaseBlockLength;

            linearPhaseRewards =
                ((phaseEndBlock - phaseStartBlock) *
                    (phaseStartBlockReward + phaseEndBlockReward)) /
                2;
        }

        if (blockRewardPhase2Start < toBlock) {
            uint256 phaseStartBlock = fromBlock < blockRewardPhase2Start
                ? blockRewardPhase2Start
                : fromBlock;
            phase2Rewards =
                (toBlock - phaseStartBlock) *
                blockRewardPhase2Amount;
        }

        return phase1Rewards + linearPhaseRewards + phase2Rewards;
    }

    /// @notice Returns the pending rewards for an investor
    /// @dev Caluclates the pending rewards by using the differrence of the currentRoundMask of the pool and the investors rewardMask and the share of the total staked amount.
    /// @return pendingHoney The pending honey rewards for the investor
    /// @return pendingRewardTokens The pending reward tokens for the investor
    function pendingRewards()
    external
    view
    returns(uint256 pendingHoney, uint256 pendingRewardTokens)
    {
        uint256 currentRoundMask = roundMask;
        uint256 currentMasterchefRoundMask = masterchefRoundMask;

        if (totalDeposits > 0) {
            uint256 totalPendingRewards = getHoneyMintRewardsInRange(
            lastRoundMaskUpdateBlock,
            block.number
        );

            currentRoundMask +=
                (DECIMAL_OFFSET * totalPendingRewards) /
                totalDeposits;

            uint256 totalPendingRewardTokens = MasterChef.pendingBSW(
                    poolId,
                    address(this)
                );

            currentMasterchefRoundMask +=
                (DECIMAL_OFFSET * totalPendingRewardTokens) /
                totalDeposits;
        }

        pendingHoney =
            ((currentRoundMask - participantData[msg.sender].rewardMask) *
                participantData[msg.sender].stakedAmount) /
            DECIMAL_OFFSET;

        pendingRewardTokens =
            ((currentMasterchefRoundMask -
                participantData[msg.sender].masterchefRewardMask) *
                participantData[msg.sender].stakedAmount) /
            DECIMAL_OFFSET;
    }

    /// @notice Claims the current rewards for an investor
    /// @dev The round mask is updated in the first place to update the current rewards for the investor. The rewards in honey tokens are then minted and transferred to the investor
    function claimRewards() external whenNotPaused {
        claimRewardsInternal(msg.sender);
    }

    function claimRewardsInternal(address to) internal {
        updateRoundMask();
        updateMasterchefRoundMask();

        uint256 rewardsToTransfer = ((roundMask -
            participantData[to].rewardMask) *
            participantData[to].stakedAmount) / DECIMAL_OFFSET;

        participantData[to].rewardMask = roundMask;

        if (rewardsToTransfer > 0) {
            HoneyToken.claimTokens(rewardsToTransfer);
            participantData[to].claimedTokens += rewardsToTransfer;

            IERC20Upgradeable(address(HoneyToken)).safeTransfer(
                to,
                rewardsToTransfer
            );
            emit ClaimRewards(to, rewardsToTransfer);
        }

        uint256 rewardTokensToTransfer = ((masterchefRoundMask -
            participantData[to].masterchefRewardMask) *
            participantData[to].stakedAmount) / DECIMAL_OFFSET;

        participantData[to].masterchefRewardMask = masterchefRoundMask;

        if (rewardTokensToTransfer > 0) {
            participantData[to].claimedRewardTokens += rewardTokensToTransfer;

            IERC20Upgradeable(address(RewardToken)).safeTransfer(
                to,
                rewardTokensToTransfer
            );
            emit ClaimRewardTokens(to, rewardTokensToTransfer);
        }
    }

    /// @notice Sets the honey minting transition times and amounts
    /// @param _blockRewardPhase1End the block after which Phase 1 ends
    /// @param _blockRewardPhase2Start the block after which Phase 2 starts
    /// @param _blockRewardPhase1Amount the block rewards during Phase 1
    /// @param _blockRewardPhase2Amount the block rewards during Phase 2
    function setHoneyMintingRewards(
        uint256 _blockRewardPhase1End,
        uint256 _blockRewardPhase2Start,
        uint256 _blockRewardPhase1Amount,
        uint256 _blockRewardPhase2Amount
    ) public onlyRole(UPDATER_ROLE) {
        require(
            _blockRewardPhase1End < _blockRewardPhase2Start,
            "Phase 1 must end before Phase 2 starts"
        );
        require(
            _blockRewardPhase2Amount < _blockRewardPhase1Amount,
            "Phase 1 amount must be greater than Phase 2 amount"
        );

        blockRewardPhase1End = _blockRewardPhase1End;
        blockRewardPhase2Start = _blockRewardPhase2Start;
        blockRewardPhase1Amount = _blockRewardPhase1Amount;
        blockRewardPhase2Amount = _blockRewardPhase2Amount;
    }

    /// @notice Updates the round mask for the pool
    /// @dev The round mask is calculated using block reward multiplied by the difference of the current block and the block where round mask was last updated at
    function updateRoundMask() internal {
        if (totalDeposits == 0) return;

        uint256 totalPendingRewards = getHoneyMintRewardsInRange(
            lastRoundMaskUpdateBlock,
            block.number
        );

        lastRoundMaskUpdateBlock = block.number;
        roundMask += (DECIMAL_OFFSET * totalPendingRewards) / totalDeposits;
    }

    function updateMasterchefRoundMask() internal {
        if (totalDeposits == 0) return;

        uint256 beforeAmount = RewardToken.balanceOf(address(this));
        MasterChef.deposit(poolId, 0);
        uint256 afterAmount = RewardToken.balanceOf(address(this));
        uint256 newRewards = afterAmount - beforeAmount;

        masterchefRoundMask += (DECIMAL_OFFSET * newRewards) / totalDeposits;
    }

    /// @notice Used to recover funds sent to this contract by mistake
    function recoverFunds(uint256 amount)
    external
    nonReentrant
    onlyRole(FUNDS_RECOVERY_ROLE)
    {
        require(amount <= address(this).balance, "Insufficient funds");
        (bool transferSuccess, ) = payable(msg.sender).call{ value: amount } ("");
        require(transferSuccess, "Transfer failed");
    }

    uint256[50] private __gap;
}