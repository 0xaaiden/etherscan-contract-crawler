// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "tokens/LzOFTCoreV2.sol";
import "interfaces/ILzOFTV2.sol";
import "openzeppelin-contracts/utils/introspection/ERC165.sol";

abstract contract LzBaseOFTV2 is LzOFTCoreV2, ERC165, ILzOFTV2 {
    constructor(uint8 _sharedDecimals, address _lzEndpoint) LzOFTCoreV2(_sharedDecimals, _lzEndpoint) {}

    /************************************************************************
     * public functions
     ************************************************************************/
    function sendFrom(
        address _from,
        uint16 _dstChainId,
        bytes32 _toAddress,
        uint _amount,
        LzCallParams calldata _callParams
    ) public payable virtual override {
        _send(_from, _dstChainId, _toAddress, _amount, _callParams.refundAddress, _callParams.zroPaymentAddress, _callParams.adapterParams);
    }

    function sendAndCall(
        address _from,
        uint16 _dstChainId,
        bytes32 _toAddress,
        uint _amount,
        bytes calldata _payload,
        LzCallParams calldata _callParams
    ) public payable virtual override {
        _sendAndCall(
            _from,
            _dstChainId,
            _toAddress,
            _amount,
            _payload,
            _callParams.refundAddress,
            _callParams.zroPaymentAddress,
            _callParams.adapterParams
        );
    }

    /************************************************************************
     * public view functions
     ************************************************************************/
    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC165, IERC165) returns (bool) {
        return interfaceId == type(ILzOFTV2).interfaceId || super.supportsInterface(interfaceId);
    }

    function estimateSendFee(
        uint16 _dstChainId,
        bytes32 _toAddress,
        uint _amount,
        bool _useZro,
        bytes calldata _adapterParams
    ) public view virtual override returns (uint nativeFee, uint zroFee) {
        return _estimateSendFee(_dstChainId, _toAddress, _amount, _useZro, _adapterParams);
    }

    function estimateSendAndCallFee(
        uint16 _dstChainId,
        bytes32 _toAddress,
        uint _amount,
        bytes calldata _payload,
        bool _useZro,
        bytes calldata _adapterParams
    ) public view virtual override returns (uint nativeFee, uint zroFee) {
        return _estimateSendAndCallFee(_dstChainId, _toAddress, _amount, _payload, _useZro, _adapterParams);
    }

    function circulatingSupply() public view virtual override returns (uint);

    function token() public view virtual override returns (address);
}