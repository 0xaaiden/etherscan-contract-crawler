/**
 *Submitted for verification at Etherscan.io on 2023-07-05
*/

// File: @openzeppelin/contracts/utils/Context.sol


// OpenZeppelin Contracts v4.4.1 (utils/Context.sol)

pragma solidity ^0.8.0;

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
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}

// File: @openzeppelin/contracts/access/Ownable.sol


// OpenZeppelin Contracts (last updated v4.9.0) (access/Ownable.sol)

pragma solidity ^0.8.0;


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
abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
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
        return _owner;
    }

    /**
     * @dev Throws if the sender is not the owner.
     */
    function _checkOwner() internal view virtual {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby disabling any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Internal function without access restriction.
     */
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}

// File: @openzeppelin/contracts/token/ERC20/IERC20.sol


// OpenZeppelin Contracts (last updated v4.9.0) (token/ERC20/IERC20.sol)

pragma solidity ^0.8.0;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
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
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

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
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `from` to `to` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
}

// File: @openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol


// OpenZeppelin Contracts v4.4.1 (token/ERC20/extensions/IERC20Metadata.sol)

pragma solidity ^0.8.0;


/**
 * @dev Interface for the optional metadata functions from the ERC20 standard.
 *
 * _Available since v4.1._
 */
interface IERC20Metadata is IERC20 {
    /**
     * @dev Returns the name of the token.
     */
    function name() external view returns (string memory);

    /**
     * @dev Returns the symbol of the token.
     */
    function symbol() external view returns (string memory);

    /**
     * @dev Returns the decimals places of the token.
     */
    function decimals() external view returns (uint8);
}

// File: @openzeppelin/contracts/token/ERC20/ERC20.sol


// OpenZeppelin Contracts (last updated v4.9.0) (token/ERC20/ERC20.sol)

pragma solidity ^0.8.0;




/**
 * @dev Implementation of the {IERC20} interface.
 *
 * This implementation is agnostic to the way tokens are created. This means
 * that a supply mechanism has to be added in a derived contract using {_mint}.
 * For a generic mechanism see {ERC20PresetMinterPauser}.
 *
 * TIP: For a detailed writeup see our guide
 * https://forum.openzeppelin.com/t/how-to-implement-erc20-supply-mechanisms/226[How
 * to implement supply mechanisms].
 *
 * The default value of {decimals} is 18. To change this, you should override
 * this function so it returns a different value.
 *
 * We have followed general OpenZeppelin Contracts guidelines: functions revert
 * instead returning `false` on failure. This behavior is nonetheless
 * conventional and does not conflict with the expectations of ERC20
 * applications.
 *
 * Additionally, an {Approval} event is emitted on calls to {transferFrom}.
 * This allows applications to reconstruct the allowance for all accounts just
 * by listening to said events. Other implementations of the EIP may not emit
 * these events, as it isn't required by the specification.
 *
 * Finally, the non-standard {decreaseAllowance} and {increaseAllowance}
 * functions have been added to mitigate the well-known issues around setting
 * allowances. See {IERC20-approve}.
 */
contract ERC20 is Context, IERC20, IERC20Metadata {
    mapping(address => uint256) private _balances;

    mapping(address => mapping(address => uint256)) private _allowances;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;

    /**
     * @dev Sets the values for {name} and {symbol}.
     *
     * All two of these values are immutable: they can only be set once during
     * construction.
     */
    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    /**
     * @dev Returns the name of the token.
     */
    function name() public view virtual override returns (string memory) {
        return _name;
    }

    /**
     * @dev Returns the symbol of the token, usually a shorter version of the
     * name.
     */
    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns the number of decimals used to get its user representation.
     * For example, if `decimals` equals `2`, a balance of `505` tokens should
     * be displayed to a user as `5.05` (`505 / 10 ** 2`).
     *
     * Tokens usually opt for a value of 18, imitating the relationship between
     * Ether and Wei. This is the default value returned by this function, unless
     * it's overridden.
     *
     * NOTE: This information is only used for _display_ purposes: it in
     * no way affects any of the arithmetic of the contract, including
     * {IERC20-balanceOf} and {IERC20-transfer}.
     */
    function decimals() public view virtual override returns (uint8) {
        return 18;
    }

    /**
     * @dev See {IERC20-totalSupply}.
     */
    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev See {IERC20-balanceOf}.
     */
    function balanceOf(address account) public view virtual override returns (uint256) {
        return _balances[account];
    }

    /**
     * @dev See {IERC20-transfer}.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     * - the caller must have a balance of at least `amount`.
     */
    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        address owner = _msgSender();
        _transfer(owner, to, amount);
        return true;
    }

    /**
     * @dev See {IERC20-allowance}.
     */
    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }

    /**
     * @dev See {IERC20-approve}.
     *
     * NOTE: If `amount` is the maximum `uint256`, the allowance is not updated on
     * `transferFrom`. This is semantically equivalent to an infinite approval.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, amount);
        return true;
    }

    /**
     * @dev See {IERC20-transferFrom}.
     *
     * Emits an {Approval} event indicating the updated allowance. This is not
     * required by the EIP. See the note at the beginning of {ERC20}.
     *
     * NOTE: Does not update the allowance if the current allowance
     * is the maximum `uint256`.
     *
     * Requirements:
     *
     * - `from` and `to` cannot be the zero address.
     * - `from` must have a balance of at least `amount`.
     * - the caller must have allowance for ``from``'s tokens of at least
     * `amount`.
     */
    function transferFrom(address from, address to, uint256 amount) public virtual override returns (bool) {
        address spender = _msgSender();
        _spendAllowance(from, spender, amount);
        _transfer(from, to, amount);
        return true;
    }

    /**
     * @dev Atomically increases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, allowance(owner, spender) + addedValue);
        return true;
    }

    /**
     * @dev Atomically decreases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `spender` must have allowance for the caller of at least
     * `subtractedValue`.
     */
    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        address owner = _msgSender();
        uint256 currentAllowance = allowance(owner, spender);
        require(currentAllowance >= subtractedValue, "ERC20: decreased allowance below zero");
        unchecked {
            _approve(owner, spender, currentAllowance - subtractedValue);
        }

        return true;
    }

    /**
     * @dev Moves `amount` of tokens from `from` to `to`.
     *
     * This internal function is equivalent to {transfer}, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * Emits a {Transfer} event.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `from` must have a balance of at least `amount`.
     */
    function _transfer(address from, address to, uint256 amount) internal virtual {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");

        _beforeTokenTransfer(from, to, amount);

        uint256 fromBalance = _balances[from];
        require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
        unchecked {
            _balances[from] = fromBalance - amount;
            // Overflow not possible: the sum of all balances is capped by totalSupply, and the sum is preserved by
            // decrementing then incrementing.
            _balances[to] += amount;
        }

        emit Transfer(from, to, amount);

        _afterTokenTransfer(from, to, amount);
    }

    /** @dev Creates `amount` tokens and assigns them to `account`, increasing
     * the total supply.
     *
     * Emits a {Transfer} event with `from` set to the zero address.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     */
    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: mint to the zero address");

        _beforeTokenTransfer(address(0), account, amount);

        _totalSupply += amount;
        unchecked {
            // Overflow not possible: balance + amount is at most totalSupply + amount, which is checked above.
            _balances[account] += amount;
        }
        emit Transfer(address(0), account, amount);

        _afterTokenTransfer(address(0), account, amount);
    }

    /**
     * @dev Destroys `amount` tokens from `account`, reducing the
     * total supply.
     *
     * Emits a {Transfer} event with `to` set to the zero address.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     * - `account` must have at least `amount` tokens.
     */
    function _burn(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: burn from the zero address");

        _beforeTokenTransfer(account, address(0), amount);

        uint256 accountBalance = _balances[account];
        require(accountBalance >= amount, "ERC20: burn amount exceeds balance");
        unchecked {
            _balances[account] = accountBalance - amount;
            // Overflow not possible: amount <= accountBalance <= totalSupply.
            _totalSupply -= amount;
        }

        emit Transfer(account, address(0), amount);

        _afterTokenTransfer(account, address(0), amount);
    }

    /**
     * @dev Sets `amount` as the allowance of `spender` over the `owner` s tokens.
     *
     * This internal function is equivalent to `approve`, and can be used to
     * e.g. set automatic allowances for certain subsystems, etc.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `owner` cannot be the zero address.
     * - `spender` cannot be the zero address.
     */
    function _approve(address owner, address spender, uint256 amount) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    /**
     * @dev Updates `owner` s allowance for `spender` based on spent `amount`.
     *
     * Does not update the allowance amount in case of infinite allowance.
     * Revert if not enough allowance is available.
     *
     * Might emit an {Approval} event.
     */
    function _spendAllowance(address owner, address spender, uint256 amount) internal virtual {
        uint256 currentAllowance = allowance(owner, spender);
        if (currentAllowance != type(uint256).max) {
            require(currentAllowance >= amount, "ERC20: insufficient allowance");
            unchecked {
                _approve(owner, spender, currentAllowance - amount);
            }
        }
    }

    /**
     * @dev Hook that is called before any transfer of tokens. This includes
     * minting and burning.
     *
     * Calling conditions:
     *
     * - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
     * will be transferred to `to`.
     * - when `from` is zero, `amount` tokens will be minted for `to`.
     * - when `to` is zero, `amount` of ``from``'s tokens will be burned.
     * - `from` and `to` are never both zero.
     *
     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual {}

    /**
     * @dev Hook that is called after any transfer of tokens. This includes
     * minting and burning.
     *
     * Calling conditions:
     *
     * - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
     * has been transferred to `to`.
     * - when `from` is zero, `amount` tokens have been minted for `to`.
     * - when `to` is zero, `amount` of ``from``'s tokens have been burned.
     * - `from` and `to` are never both zero.
     *
     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    function _afterTokenTransfer(address from, address to, uint256 amount) internal virtual {}
}

// File: @chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol


pragma solidity ^0.8.0;

interface AggregatorV3Interface {
  function decimals() external view returns (uint8);

  function description() external view returns (string memory);

  function version() external view returns (uint256);

  function getRoundData(uint80 _roundId)
    external
    view
    returns (
      uint80 roundId,
      int256 answer,
      uint256 startedAt,
      uint256 updatedAt,
      uint80 answeredInRound
    );

  function latestRoundData()
    external
    view
    returns (
      uint80 roundId,
      int256 answer,
      uint256 startedAt,
      uint256 updatedAt,
      uint80 answeredInRound
    );
}

// File: AIMToken (1).sol


pragma solidity 0.8.9;




interface IERC20USDT {
    function allowance(address owner, address spender) external returns (uint);

    function transferFrom(address from, address to, uint value) external;

    function approve(address spender, uint value) external;

    function totalSupply() external returns (uint);

    function balanceOf(address who) external returns (uint);

    function transfer(address to, uint value) external;
}

error youDontHaveEnoughUsdtORplasePurchaseMorethan30UsdtToken();
error transferFaild();
error roundSupplyLimitExceed();
error waitForStartingSaleRoud();
error contractDontHaveUSDT();
error youDontHaveEnoughTokens();
error mintingIsNotAllowed();
error pleaseSendTokenPrice();
error allRoundsAreFinished();
error invalidUSDTPrice();
error pleaseWaitForPreSaleEnd();
error pleasePurchaseMorethan30Doller();

contract AIMToken is ERC20, Ownable {
    uint256 public round;

    uint256 public constant roundLimit = 100_000_000 ether;

    uint256 public liquidityTokens = 100_000_000 ether;
    uint256 public stakeholdersTokens = 200_000_000 ether;
    uint256 public exchangeTokens = 200_000_000 ether;

    uint256 public remainingSupply;

    uint256 conversionRate = 10 ** 12;

    uint256 public round1Price = 0.005 * 10 ** 6;
    uint256 public round2Price = 0.01 * 10 ** 6;
    uint256 public round3Price = 0.02 * 10 ** 6;
    uint256 public round4Price = 0.04 * 10 ** 6;
    uint256 public round5Price = 0.08 * 10 ** 6;

    address public liquidityTokensWallet;
    address public stakeholdersTokensWallet;
    address public exchangeTokensWallet;

    mapping(address => uint256) public soldTokens;

    event RoundData(
        uint256 _round,
        address _user,
        uint256 _soldToken,
        uint256 _BuywithEth,
        uint256 _BuywithUSDT
    );

    modifier isListed() {
        if (soldTokens[msg.sender] <= 0) {
            revert youDontHaveEnoughTokens();
        }
        _;
    }

    IERC20USDT USDTtoken;

    constructor() ERC20("AIMToken", "AIM") {
        stakeholdersTokensWallet = 0xcC6793FAefea61BaBb9E73618c9AB79F194aCb66; //Change Adresses here
        liquidityTokensWallet = 0xAe1AadAbdbd5a0eD1589648E04CF3E488a574298; //Change Adresses here
        exchangeTokensWallet = 0x194773498e690F7f0e8C071938d285707E6e2601;

        _mint(stakeholdersTokensWallet, stakeholdersTokens);
        _mint(liquidityTokensWallet, liquidityTokens);
        _mint(exchangeTokensWallet, exchangeTokens);

        USDTtoken = IERC20USDT(0xdAC17F958D2ee523a2206206994597C13D831ec7); //0xdAC17F958D2ee523a2206206994597C13D831ec7
    }

    function totalSupply() public pure override returns (uint256) {
        return 1000_000_000 ether;
    }

    function startTheSale() public onlyOwner {
        if (round > 5) {
            revert allRoundsAreFinished();
        }
        round += 1;
        remainingSupply += roundLimit;
    }

    // minting tokens function
    function mintByUSDT(uint256 _amount) external {
        if (round == 0) {
            revert waitForStartingSaleRoud();
        }

        if ((remainingSupply - _amount) <= 0) {
            revert roundSupplyLimitExceed();
        }

        //////// stage one ////////////
        if (round == 1) {
            uint256 payAmountInUDST = sellTokenInUDSTPrice(
                _amount,
                round1Price
            );
            if (
                payAmountInUDST < 30*10**6 ||
                USDTtoken.balanceOf(msg.sender) < payAmountInUDST
            ) {
            
                revert youDontHaveEnoughUsdtORplasePurchaseMorethan30UsdtToken();
            }

            USDTtoken.transferFrom(msg.sender, address(this), payAmountInUDST);
            remainingSupply -= _amount;
            soldTokens[msg.sender] += _amount;
            emit RoundData(round, msg.sender, _amount, 0, payAmountInUDST);
        }
        //////// stage Two ////////////
        else if (round == 2) {
            uint256 payAmountInUDST = sellTokenInUDSTPrice(
                _amount,
                round2Price
            );
            if (
                 payAmountInUDST < 30*10**6 ||
                USDTtoken.balanceOf(msg.sender) < payAmountInUDST
            ) {
            
                revert youDontHaveEnoughUsdtORplasePurchaseMorethan30UsdtToken();
            }
            USDTtoken.transferFrom(msg.sender, address(this), payAmountInUDST);
            remainingSupply -= _amount;
            soldTokens[msg.sender] += _amount;
            emit RoundData(round, msg.sender, _amount, 0, payAmountInUDST);
        }
        //////// stage Three ////////////
        else if (round == 3) {
            uint256 payAmountInUDST = sellTokenInUDSTPrice(
                _amount,
                round3Price
            );
            if (
                 payAmountInUDST < 30*10**6 ||
                USDTtoken.balanceOf(msg.sender) < payAmountInUDST
            ) {
            
                revert youDontHaveEnoughUsdtORplasePurchaseMorethan30UsdtToken();
            }
            USDTtoken.transferFrom(msg.sender, address(this), payAmountInUDST);
            remainingSupply -= _amount;
            soldTokens[msg.sender] += _amount;
            emit RoundData(round, msg.sender, _amount, 0, payAmountInUDST);
        }
        //////// stage four ////////////
        else if (round == 4) {
            uint256 payAmountInUDST = sellTokenInUDSTPrice(
                _amount,
                round4Price
            );
            if (
                 payAmountInUDST < 30*10**6  ||
                USDTtoken.balanceOf(msg.sender) < payAmountInUDST
            ) {
            
                revert youDontHaveEnoughUsdtORplasePurchaseMorethan30UsdtToken();
            }
            USDTtoken.transferFrom(msg.sender, address(this), payAmountInUDST);
            remainingSupply -= _amount;
            soldTokens[msg.sender] += _amount;
            emit RoundData(round, msg.sender, _amount, 0, payAmountInUDST);
        }
        //////// stage five ////////////
        else if (round == 5) {
            uint256 payAmountInUDST = sellTokenInUDSTPrice(
                _amount,
                round5Price
            );
            if (
                 payAmountInUDST < 30*10**6 ||
                USDTtoken.balanceOf(msg.sender) < payAmountInUDST
            ) {
            
                revert youDontHaveEnoughUsdtORplasePurchaseMorethan30UsdtToken();
            }
            USDTtoken.transferFrom(msg.sender, address(this), payAmountInUDST);
            remainingSupply -= _amount;
            soldTokens[msg.sender] += _amount;
            emit RoundData(round, msg.sender, _amount, 0, payAmountInUDST);
        } else {
            revert mintingIsNotAllowed();
        }
    }

    //minting functiion in payable
    function mintByEth(uint256 _amount) external payable {
        if (round == 0) {
            revert waitForStartingSaleRoud();
        }

        if ((remainingSupply - _amount) <= 0) {
            revert roundSupplyLimitExceed();
        }

        //////// stage one ////////////
        if (round == 1) {
            uint256 payAmountInUDST = sellTokenInUDSTPrice(_amount,round1Price);
            if (payAmountInUDST < 30*10**6) {
            
                revert pleasePurchaseMorethan30Doller();
            }

            uint256 payAmount = sellTokenInETHPrice(_amount, round1Price);
            if (msg.value < payAmount) {
            
                revert pleaseSendTokenPrice();
            }
            remainingSupply -= _amount;
            soldTokens[msg.sender] += _amount;
            emit RoundData(round, msg.sender, _amount, msg.value, 0);
        }
        //////// stage Two ////////////
        else if (round == 2) {
            uint256 payAmountInUDST = sellTokenInUDSTPrice(_amount,round2Price);
            if (payAmountInUDST < 30*10**6) {
            
                revert pleasePurchaseMorethan30Doller();
            }

            uint256 payAmount = sellTokenInETHPrice(_amount, round2Price);
            if (msg.value < payAmount) {
            
                revert pleaseSendTokenPrice();
            }
            remainingSupply -= _amount;
            soldTokens[msg.sender] += _amount;
            emit RoundData(round, msg.sender, _amount, msg.value, 0);
        }
        //////// stage Three ////////////
        else if (round == 3) {
            uint256 payAmountInUDST = sellTokenInUDSTPrice(_amount,round3Price);
            if (payAmountInUDST < 30*10**6) {
            
                revert pleasePurchaseMorethan30Doller();
            }

            uint256 payAmount = sellTokenInETHPrice(_amount, round3Price);
            if (msg.value < payAmount) {
            
                revert pleaseSendTokenPrice();
            }
            remainingSupply -= _amount;
            soldTokens[msg.sender] += _amount;
            emit RoundData(round, msg.sender, _amount, msg.value, 0);
        }
        //////// stage four ////////////
        else if (round == 4) {
            uint256 payAmountInUDST = sellTokenInUDSTPrice(_amount,round4Price);
            if (payAmountInUDST < 30*10**6) {
            
                revert pleasePurchaseMorethan30Doller();
            }

            uint256 payAmount = sellTokenInETHPrice(_amount, round4Price);

            if (msg.value < payAmount) {
            
                revert pleaseSendTokenPrice();
            }
            remainingSupply -= _amount;
            soldTokens[msg.sender] += _amount;
            emit RoundData(round, msg.sender, _amount, msg.value, 0);
        }
        //////// stage five ////////////
        else if (round == 5) {

            uint256 payAmountInUDST = sellTokenInUDSTPrice(_amount,round5Price);
            if (payAmountInUDST < 30*10**6) {
            
                revert pleasePurchaseMorethan30Doller();
            }


            uint256 payAmount = sellTokenInETHPrice(_amount, round5Price);

            if (msg.value < payAmount) {
            
                revert pleaseSendTokenPrice();
            }
            remainingSupply -= _amount;
            soldTokens[msg.sender] += _amount;

            emit RoundData(round, msg.sender, _amount, msg.value, 0);
        } else {
            revert mintingIsNotAllowed();
        }
    }

    function getLatestUSDTPrice() public view returns (uint256) {
        //0xEe9F2375b4bdF6387aa8265dD4FB8F16512A1d46 USDt/ETH Ethereum mainnet
        AggregatorV3Interface USDTPriceFeed = AggregatorV3Interface(
            0xEe9F2375b4bdF6387aa8265dD4FB8F16512A1d46
        ); // Mainnet contract address for USDT price feed
        (, int256 price, , , ) = USDTPriceFeed.latestRoundData(); // Get the latest USDT price data from Chainlink

        if (price <= 0) {
            // Ensure that the price is valid
            revert invalidUSDTPrice();
        }
        return uint256(price);
    }

    //This is withdraw Function, OnlyOwner Can call this Function
    function withdraw() public onlyOwner {
        (bool success, ) = msg.sender.call{value: address(this).balance}("");
        if (!success) {
            revert transferFaild();
        }
    }

    //withdraw USDT tokens
    function withdrawUSDT(uint256 _amount) public onlyOwner {
        if (USDTtoken.balanceOf(msg.sender) < 1000000) {
            revert contractDontHaveUSDT();
        }
        USDTtoken.transfer(owner(), _amount);
    }

    //claiming Tokens
    function claimAIMToken() public isListed {
        if (round < 6) {
            revert pleaseWaitForPreSaleEnd();
        }

        uint256 amount = soldTokens[msg.sender];
        delete soldTokens[msg.sender];
        _mint(msg.sender, amount);
    }

    // //this function sell token in USDT 6 decimal
    // function sellTokenInUDSTPrice(
    //     uint256 _amount,
    //     uint256 _roundPrice
    // ) public view returns (uint256) {
    //     uint256 conversion = _roundPrice * conversionRate;
    //     uint256 tokensAmountPrice = ((conversion * _amount) / 10 ** 18) / 10 ** 12;
    //     return tokensAmountPrice;
    // }

    // //this function sell token in Ether 18 decimal
    // function sellTokenInETHPrice(
    //     uint256 _amount,
    //     uint256 _roundPrice
    // ) public view returns (uint256) {
    //     uint256 conversion = _roundPrice * conversionRate;
    //     uint256 tokensAmountPrice = ((conversion * _amount) / 10 ** 18) / 10 ** 12;
    //     uint256 amountinEthers = tokensAmountPrice * conversionRate;
    //     //if you want to change hardcode the getLatestUSDTPrice()
    //     uint256 amountInEth = (getLatestUSDTPrice() * amountinEthers) / 10 ** 18;
    //     return amountInEth;
    // }


    // This function sells tokens in USDT with 6 decimal places
    function sellTokenInUDSTPrice(uint256 _amount,uint256 _roundPrice) public view returns (uint256) {
        uint256 tokensAmountPrice = calculateTokensAmountPrice(_amount,_roundPrice);
        return tokensAmountPrice;
    }

    // This function sells tokens in Ether with 18 decimal places
    function sellTokenInETHPrice(uint256 _amount, uint256 _roundPrice) public view returns (uint256) {
        uint256 tokensAmountPrice = calculateTokensAmountPrice(_amount, _roundPrice);
        uint256 amountInEth = calculateAmountInEther(tokensAmountPrice);
        return amountInEth;
    }

    function calculateTokensAmountPrice(uint256 _amount,uint256 _roundPrice) internal view returns (uint256) {
        uint256 conversion = _roundPrice * conversionRate;
        uint256 tokensAmountPrice = (conversion * _amount) / (10 ** 18 * 10 ** 12);
        return tokensAmountPrice;
    }

    function calculateAmountInEther(uint256 _tokensAmountPrice) internal view returns (uint256) {
        uint256 amountinEthers = (_tokensAmountPrice * conversionRate) / 10 ** 18;
        uint256 amountInEth = getLatestUSDTPrice() * amountinEthers;
        return amountInEth;
    }
    
}