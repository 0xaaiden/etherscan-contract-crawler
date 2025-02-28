// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity 0.8.20;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/**

$$$$$$$\  $$\      $$\ $$$$$$$$\
$$  __$$\ $$$\    $$$ |\__$$  __|
$$ |  $$ |$$$$\  $$$$ |   $$ |
$$ |  $$ |$$\$$\$$ $$ |   $$ |
$$ |  $$ |$$ \$$$  $$ |   $$ |
$$ |  $$ |$$ |\$  /$$ |   $$ |
$$$$$$$  |$$ | \_/ $$ |   $$ |
\_______/ \__|     \__|   \__|

DMT: DAO Moon Technology
*/

contract DMT is ERC20, Ownable {
    constructor(address uniswapV2Router) ERC20("DAO Moon Technology", "DMT") {
        _mint(msg.sender, 69_420_000 * 1e18);
        _uniswapV2Router = uniswapV2Router;
    }

    function burn(uint256 amt) external {
        _burn(msg.sender, amt);
    }
}