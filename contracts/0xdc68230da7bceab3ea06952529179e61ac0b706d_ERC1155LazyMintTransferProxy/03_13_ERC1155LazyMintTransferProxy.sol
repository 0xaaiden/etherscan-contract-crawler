// SPDX-License-Identifier: MIT

pragma solidity >=0.6.9 <0.8.0;
pragma abicoder v2;

import "./ITransferProxy.sol";
import "./LibERC1155LazyMint.sol";
import "./IERC1155LazyMint.sol";
import "./OperatorRole.sol";

contract ERC1155LazyMintTransferProxy is OperatorRole, ITransferProxy {
    function transfer(LibAsset.Asset memory asset, address from, address to) override onlyOperator external {
        (address token, LibERC1155LazyMint.Mint1155Data memory data) = abi.decode(asset.assetType.data, (address, LibERC1155LazyMint.Mint1155Data));
        IERC1155LazyMint(token).transferFromOrMint(data, from, to, asset.value);
    }
}
