// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import { OperatorFiltererUpgradeable } from "./OperatorFiltererUpgradeable.sol";
import { CANONICAL_CORI_SUBSCRIPTION } from "./Constants.sol";

/**
 * @title  DefaultOperatorFiltererUpgradeable
 * @notice Inherits from OperatorFiltererUpgradeable and automatically subscribes to the default OpenSea subscription
 *         when the init function is called.
 */
abstract contract DefaultOperatorFiltererUpgradeable is OperatorFiltererUpgradeable {
  /// @dev The upgradeable initialize function that should be called when the contract is being deployed.
  function __DefaultOperatorFilterer_init() internal onlyInitializing {
    OperatorFiltererUpgradeable.__OperatorFilterer_init(CANONICAL_CORI_SUBSCRIPTION, true);
  }
}