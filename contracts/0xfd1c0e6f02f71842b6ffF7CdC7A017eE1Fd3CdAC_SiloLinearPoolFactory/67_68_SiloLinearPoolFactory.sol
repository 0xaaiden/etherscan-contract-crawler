// SPDX-License-Identifier: GPL-3.0-or-later
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

pragma solidity ^0.7.0;
pragma experimental ABIEncoderV2;

import "@balancer-labs/v2-interfaces/contracts/vault/IVault.sol";
import "@balancer-labs/v2-interfaces/contracts/standalone-utils/IBalancerQueries.sol";
import "@balancer-labs/v2-interfaces/contracts/pool-utils/ILastCreatedPoolFactory.sol";
import "@balancer-labs/v2-interfaces/contracts/pool-utils/IFactoryCreatedPoolVersion.sol";

import "@balancer-labs/v2-pool-utils/contracts/Version.sol";
import "@balancer-labs/v2-pool-utils/contracts/factories/BasePoolFactory.sol";
import "@balancer-labs/v2-pool-utils/contracts/factories/FactoryWidePauseWindow.sol";

import "@balancer-labs/v2-solidity-utils/contracts/openzeppelin/Create2.sol";
import "@balancer-labs/v2-solidity-utils/contracts/openzeppelin/ReentrancyGuard.sol";

import "./SiloLinearPool.sol";
import "./SiloLinearPoolRebalancer.sol";

contract SiloLinearPoolFactory is
    ILastCreatedPoolFactory,
    IFactoryCreatedPoolVersion,
    Version,
    BasePoolFactory,
    ReentrancyGuard
{
    // Used for create2 deployments
    uint256 private _nextRebalancerSalt;

    IBalancerQueries private immutable _queries;

    address private _lastCreatedPool;
    string private _poolVersion;

    // This event allows off-chain tools to differentiate between different protocols that use this factory
    event SiloLinearPoolCreated(address indexed pool, uint256 indexed protocolId);

    constructor(
        IVault vault,
        IProtocolFeePercentagesProvider protocolFeeProvider,
        IBalancerQueries queries,
        string memory factoryVersion,
        string memory poolVersion,
        uint256 initialPauseWindowDuration,
        uint256 bufferPeriodDuration
    )
        BasePoolFactory(
            vault,
            protocolFeeProvider,
            initialPauseWindowDuration,
            bufferPeriodDuration,
            type(SiloLinearPool).creationCode
        )
        Version(factoryVersion)
    {
        _queries = queries;
        _poolVersion = poolVersion;
    }

    function getLastCreatedPool() external view override returns (address) {
        return _lastCreatedPool;
    }

    function getPoolVersion() public view override returns (string memory) {
        return _poolVersion;
    }

    function _create(bytes memory constructorArgs) internal virtual override returns (address) {
        address pool = super._create(constructorArgs);
        _lastCreatedPool = pool;

        return pool;
    }

    /**
     * @dev Deploys a new `SiloLinearPool`.
     */
    function create(
        string memory name,
        string memory symbol,
        IERC20 mainToken,
        IERC20 wrappedToken,
        uint256 upperTarget,
        uint256 swapFeePercentage,
        address owner,
        uint256 protocolId
    ) external nonReentrant returns (SiloLinearPool) {
        // We are going to deploy both an SiloLinearPool and an SiloLinearPoolRebalancer set as its Asset Manager, but
        // this creates a circular dependency problem: the Pool must know the Asset Manager's address in order to call
        // `IVault.registerTokens` with it, and the Asset Manager must know about the Pool in order to store its Pool
        // ID, wrapped and main tokens, etc., as immutable variables.
        // We could forego immutable storage in the Rebalancer and simply have a two-step initialization process that
        // uses storage, but we can keep those gas savings by instead making the deployment a bit more complicated.
        //
        // Note that the Pool does not interact with the Asset Manager: it only needs to know about its address.
        // We therefore use create2 to deploy the Asset Manager, first computing the address where it will be deployed.
        // With that knowledge, we can then create the Pool, and finally the Asset Manager. The only issue with this
        // approach is that create2 requires the full creation code, including constructor arguments, and among those is
        // the Pool's address. To work around this, we have the Rebalancer fetch this address from `getLastCreatedPool`,
        // which will hold the Pool's address after we call `_create`.

        bytes32 rebalancerSalt = bytes32(_nextRebalancerSalt);
        _nextRebalancerSalt += 1;
        bytes memory rebalancerCreationCode = abi.encodePacked(
            type(SiloLinearPoolRebalancer).creationCode,
            abi.encode(getVault(), _queries, address(wrappedToken))
        );

        address expectedRebalancerAddress = Create2.computeAddress(rebalancerSalt, keccak256(rebalancerCreationCode));

        (uint256 pauseWindowDuration, uint256 bufferPeriodDuration) = getPauseConfiguration();

        SiloLinearPool.ConstructorArgs memory args;
        args.vault = getVault();
        args.name = name;
        args.symbol = symbol;
        args.mainToken = mainToken;
        args.wrappedToken = wrappedToken;
        args.assetManager = expectedRebalancerAddress;
        args.upperTarget = upperTarget;
        args.swapFeePercentage = swapFeePercentage;
        args.pauseWindowDuration = pauseWindowDuration;
        args.bufferPeriodDuration = bufferPeriodDuration;
        args.owner = owner;
        args.version = getPoolVersion();

        SiloLinearPool pool = SiloLinearPool(_create(abi.encode(args)));

        // LinearPools have a separate post-construction initialization step: we perform it here to
        // ensure deployment and initialization are atomic.
        pool.initialize();

        // Not that the Linear Pool's deployment is complete, we can deploy the Rebalancer, verifying that we correctly
        // predicted its deployment address.
        address actualRebalancerAddress = Create2.deploy(0, rebalancerSalt, rebalancerCreationCode);
        require(expectedRebalancerAddress == actualRebalancerAddress, "Rebalancer deployment failed");

        // Identify the protocolId associated with this pool. We do not require that protocolId be registered.
        emit SiloLinearPoolCreated(address(pool), protocolId);

        // We don't return the Rebalancer's address, but that can be queried in the Vault by calling `getPoolTokenInfo`.
        return pool;
    }
}