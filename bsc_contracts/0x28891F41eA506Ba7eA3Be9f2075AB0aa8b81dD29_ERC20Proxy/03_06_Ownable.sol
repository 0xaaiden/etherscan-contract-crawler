// SPDX-License-Identifier: Apache 2.0
/*
  Copyright 2019 ZeroEx Intl.
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at
    http://www.apache.org/licenses/LICENSE-2.0
  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
*/

pragma solidity >=0.5.9 <0.9.0;

import "./interfaces/IOwnable.sol";

abstract contract Ownable is IOwnable {
    /// @dev The owner of this contract.
    /// @return 0 The owner address.
    address public owner;

    constructor(address newOwner) {
        owner = newOwner;
    }

    modifier onlyOwner() {
        _assertSenderIsOwner();
        _;
    }

    /// @dev Change the owner of this contract.
    /// @param newOwner New owner address.
    function transferOwnership(address newOwner) public override onlyOwner {
        require(newOwner != address(0), "INPUT_ADDRESS_NULL_ERROR");
        owner = newOwner;
        emit OwnershipTransferred(msg.sender, newOwner);
    }

    function _assertSenderIsOwner() internal view {
        require(msg.sender == owner, "CALLER_NOT_OWNER_ERROR");
    }
}