// SPDX-License-Identifier: BlueOak-1.0.0
pragma solidity 0.8.17;

import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableMap.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";
import "../interfaces/IAssetRegistry.sol";
import "../interfaces/IBasketHandler.sol";
import "../interfaces/IMain.sol";
import "../libraries/Array.sol";
import "../libraries/Fixed.sol";
import "./mixins/BasketLib.sol";
import "./mixins/Component.sol";

/**
 * @title BasketHandler
 * @notice Handles the basket configuration, definition, and evolution over time.
 */
contract BasketHandlerP1 is ComponentP1, IBasketHandler {
    using BasketLibP1 for Basket;
    using EnumerableMap for EnumerableMap.Bytes32ToUintMap;
    using CollateralStatusComparator for CollateralStatus;
    using FixLib for uint192;

    uint192 public constant MAX_TARGET_AMT = 1e3 * FIX_ONE; // {target/BU} max basket weight
    uint48 public constant MIN_WARMUP_PERIOD = 60; // {s} 1 minute
    uint48 public constant MAX_WARMUP_PERIOD = 31536000; // {s} 1 year

    // Peer components
    IAssetRegistry private assetRegistry;
    IBackingManager private backingManager;
    IERC20 private rsr;
    IRToken private rToken;
    IStRSR private stRSR;

    // config is the basket configuration, from which basket will be computed in a basket-switch
    // event. config is only modified by governance through setPrimeBakset and setBackupConfig
    BasketConfig private config;

    // basket, disabled, nonce, and timestamp are only ever set by `_switchBasket()`
    // basket is the current basket.
    Basket private basket;

    uint48 public nonce; // {basketNonce} A unique identifier for this basket instance
    uint48 public timestamp; // The timestamp when this basket was last set

    // If disabled is true, status() is DISABLED, the basket is invalid,
    // and everything except redemption should be paused.
    bool private disabled;

    // === Function-local transitory vars ===

    // These are effectively local variables of _switchBasket.
    // Nothing should use their values from previous transactions.
    EnumerableSet.Bytes32Set private _targetNames;
    Basket private _newBasket;

    // === Warmup Period ===
    // Added in 3.0.0

    // Warmup Period
    uint48 public warmupPeriod; // {s} how long to wait until issuance/trading after regaining SOUND

    // basket status changes, mainly set when `trackStatus()` is called
    // used to enforce warmup period, after regaining SOUND
    uint48 private lastStatusTimestamp;
    CollateralStatus private lastStatus;

    // === Historical basket nonces ===
    // Added in 3.0.0

    // A history of baskets by basket nonce; includes current basket
    mapping(uint48 => Basket) private basketHistory;

    // Effectively local variable of `requireConstantConfigTargets()`
    EnumerableMap.Bytes32ToUintMap private _targetAmts; // targetName -> {target/BU}

    // ===

    // ==== Invariants ====
    // basket is a valid Basket:
    //   basket.erc20s is a valid collateral array and basket.erc20s == keys(basket.refAmts)
    // config is a valid BasketConfig:
    //   erc20s == keys(targetAmts) == keys(targetNames)
    //   erc20s is a valid collateral array
    //   for b in vals(backups), b.erc20s is a valid collateral array.
    // if basket.erc20s is empty then disabled == true

    // BasketHandler.init() just leaves the BasketHandler state zeroed
    function init(IMain main_, uint48 warmupPeriod_) external initializer {
        __Component_init(main_);

        assetRegistry = main_.assetRegistry();
        backingManager = main_.backingManager();
        rsr = main_.rsr();
        rToken = main_.rToken();
        stRSR = main_.stRSR();

        setWarmupPeriod(warmupPeriod_);

        // Set last status to DISABLED (default)
        lastStatus = CollateralStatus.DISABLED;
        lastStatusTimestamp = uint48(block.timestamp);

        disabled = true;
    }

    /// Disable the basket in order to schedule a basket refresh
    /// @custom:protected
    // checks: caller is assetRegistry
    // effects: disabled' = true
    function disableBasket() external {
        require(_msgSender() == address(assetRegistry), "asset registry only");

        uint256 len = basket.erc20s.length;
        uint192[] memory refAmts = new uint192[](len);
        for (uint256 i = 0; i < len; ++i) refAmts[i] = basket.refAmts[basket.erc20s[i]];
        emit BasketSet(nonce, basket.erc20s, refAmts, true);
        disabled = true;
    }

    /// Switch the basket, only callable directly by governance or after a default
    /// @custom:interaction OR @custom:governance
    // checks: either caller has OWNER,
    //         or (basket is disabled after refresh and we're unpaused and unfrozen)
    // actions: calls assetRegistry.refresh(), then _switchBasket()
    // effects:
    //   Either: (basket' is a valid nonempty basket, without DISABLED collateral,
    //            that satisfies basketConfig) and disabled' = false
    //   Or no such basket exists and disabled' = true
    function refreshBasket() external {
        assetRegistry.refresh();

        require(
            main.hasRole(OWNER, _msgSender()) ||
                (status() == CollateralStatus.DISABLED && !main.tradingPausedOrFrozen()),
            "basket unrefreshable"
        );
        _switchBasket();

        trackStatus();
    }

    /// Track basket status changes if they ocurred
    // effects: lastStatus' = status(), and lastStatusTimestamp' = current timestamp
    /// @custom:refresher
    function trackStatus() public {
        CollateralStatus currentStatus = status();
        if (currentStatus != lastStatus) {
            emit BasketStatusChanged(lastStatus, currentStatus);
            lastStatus = currentStatus;
            lastStatusTimestamp = uint48(block.timestamp);
        }
    }

    /// Set the prime basket in the basket configuration, in terms of erc20s and target amounts
    /// @param erc20s The collateral for the new prime basket
    /// @param targetAmts The target amounts (in) {target/BU} for the new prime basket
    /// @custom:governance
    // checks:
    //   caller is OWNER
    //   len(erc20s) == len(targetAmts)
    //   erc20s is a valid collateral array
    //   for all i, erc20[i] is in AssetRegistry as collateral
    //   for all i, 0 < targetAmts[i] <= MAX_TARGET_AMT == 1000
    //
    // effects:
    //   config'.erc20s = erc20s
    //   config'.targetAmts[erc20s[i]] = targetAmts[i], for i from 0 to erc20s.length-1
    //   config'.targetNames[e] = assetRegistry.toColl(e).targetName, for e in erc20s
    function setPrimeBasket(IERC20[] calldata erc20s, uint192[] calldata targetAmts)
        external
        governance
    {
        require(erc20s.length > 0, "cannot empty basket");
        require(erc20s.length == targetAmts.length, "must be same length");
        requireValidCollArray(erc20s);

        // If this isn't initial setup, require targets remain constant
        if (config.erc20s.length > 0) requireConstantConfigTargets(erc20s, targetAmts);

        // Clean up previous basket config
        for (uint256 i = 0; i < config.erc20s.length; ++i) {
            delete config.targetAmts[config.erc20s[i]];
            delete config.targetNames[config.erc20s[i]];
        }
        delete config.erc20s;

        // Set up new config basket
        bytes32[] memory names = new bytes32[](erc20s.length);

        for (uint256 i = 0; i < erc20s.length; ++i) {
            // This is a nice catch to have, but in general it is possible for
            // an ERC20 in the prime basket to have its asset unregistered.
            require(assetRegistry.toAsset(erc20s[i]).isCollateral(), "erc20 is not collateral");
            require(0 < targetAmts[i], "invalid target amount; must be nonzero");
            require(targetAmts[i] <= MAX_TARGET_AMT, "invalid target amount; too large");

            config.erc20s.push(erc20s[i]);
            config.targetAmts[erc20s[i]] = targetAmts[i];
            names[i] = assetRegistry.toColl(erc20s[i]).targetName();
            config.targetNames[erc20s[i]] = names[i];
        }

        emit PrimeBasketSet(erc20s, targetAmts, names);
    }

    /// Set the backup configuration for some target name
    /// @custom:governance
    // checks:
    //   caller is OWNER
    //   erc20s is a valid collateral array
    //   for all i, erc20[i] is in AssetRegistry as collateral
    //
    // effects:
    //   config'.backups[targetName] = {max: max, erc20s: erc20s}
    function setBackupConfig(
        bytes32 targetName,
        uint256 max,
        IERC20[] calldata erc20s
    ) external governance {
        requireValidCollArray(erc20s);
        BackupConfig storage conf = config.backups[targetName];
        conf.max = max;
        delete conf.erc20s;

        for (uint256 i = 0; i < erc20s.length; ++i) {
            // This is a nice catch to have, but in general it is possible for
            // an ERC20 in the backup config to have its asset altered.
            require(assetRegistry.toAsset(erc20s[i]).isCollateral(), "erc20 is not collateral");
            conf.erc20s.push(erc20s[i]);
        }
        emit BackupConfigSet(targetName, max, erc20s);
    }

    /// @return Whether this contract owns enough collateral to cover rToken.basketsNeeded() BUs
    /// ie, whether the protocol is currently fully collateralized
    function fullyCollateralized() external view returns (bool) {
        BasketRange memory held = basketsHeldBy(address(backingManager));
        return held.bottom >= rToken.basketsNeeded();
    }

    /// @return status_ The status of the basket
    // returns DISABLED if disabled == true, and worst(status(coll)) otherwise
    function status() public view returns (CollateralStatus status_) {
        uint256 size = basket.erc20s.length;

        // untestable:
        //      disabled is only set in _switchBasket, and only if size > 0.
        if (disabled || size == 0) return CollateralStatus.DISABLED;

        for (uint256 i = 0; i < size; ++i) {
            CollateralStatus s = assetRegistry.toColl(basket.erc20s[i]).status();
            if (s.worseThan(status_)) status_ = s;
        }
    }

    /// @return Whether the basket is ready to issue and trade
    function isReady() external view returns (bool) {
        return
            status() == CollateralStatus.SOUND &&
            (block.timestamp >= lastStatusTimestamp + warmupPeriod);
    }

    /// @param erc20 The token contract to check for quantity for
    /// @return {tok/BU} The token-quantity of an ERC20 token in the basket.
    // Returns 0 if erc20 is not registered or not in the basket
    // Returns FIX_MAX (in lieu of +infinity) if Collateral.refPerTok() is 0.
    // Otherwise returns (token's basket.refAmts / token's Collateral.refPerTok())
    function quantity(IERC20 erc20) public view returns (uint192) {
        try assetRegistry.toColl(erc20) returns (ICollateral coll) {
            return _quantity(erc20, coll);
        } catch {
            return FIX_ZERO;
        }
    }

    /// Like quantity(), but unsafe because it DOES NOT CONFIRM THAT THE ASSET IS CORRECT
    /// @param erc20 The ERC20 token contract for the asset
    /// @param asset The registered asset plugin contract for the erc20
    /// @return {tok/BU} The token-quantity of an ERC20 token in the basket.
    // Returns 0 if erc20 is not registered or not in the basket
    // Returns FIX_MAX (in lieu of +infinity) if Collateral.refPerTok() is 0.
    // Otherwise returns (token's basket.refAmts / token's Collateral.refPerTok())
    function quantityUnsafe(IERC20 erc20, IAsset asset) public view returns (uint192) {
        if (!asset.isCollateral()) return FIX_ZERO;
        return _quantity(erc20, ICollateral(address(asset)));
    }

    /// @param erc20 The token contract
    /// @param coll The registered collateral plugin contract
    /// @return {tok/BU} The token-quantity of an ERC20 token in the basket.
    // Returns 0 if coll is not in the basket
    // Returns FIX_MAX (in lieu of +infinity) if Collateral.refPerTok() is 0.
    // Otherwise returns (token's basket.refAmts / token's Collateral.refPerTok())
    function _quantity(IERC20 erc20, ICollateral coll) internal view returns (uint192) {
        uint192 refPerTok = coll.refPerTok();
        if (refPerTok == 0) return FIX_MAX;

        // {tok/BU} = {ref/BU} / {ref/tok}
        return basket.refAmts[erc20].div(refPerTok, CEIL);
    }

    /// Should not revert
    /// @return {UoA/BU} The lower end of the price estimate
    /// @return {UoA/BU} The upper end of the price estimate
    // returns sum(quantity(erc20) * price(erc20) for erc20 in basket.erc20s)
    function price() external view returns (uint192, uint192) {
        (Price memory p, ) = prices();
        return (p.low, p.high);
    }

    /// Should not revert
    /// lowLow should be nonzero when the asset might be worth selling
    /// @return {UoA/BU} The lower end of the lot price estimate
    /// @return {UoA/BU} The upper end of the lot price estimate
    // returns sum(quantity(erc20) * lotPrice(erc20) for erc20 in basket.erc20s)
    function lotPrice() external view returns (uint192, uint192) {
        (, Price memory lotP) = prices();
        return (lotP.low, lotP.high);
    }

    /// Returns both the price() & lotPrice() at once, for gas optimization
    /// @return price_ {UoA/tok} The low and high price estimate of an RToken
    /// @return lotPrice_ {UoA/tok} The low and high lotprice of an RToken
    function prices() public view returns (Price memory price_, Price memory lotPrice_) {
        uint256 low256;
        uint256 high256;
        uint256 lotLow256;
        uint256 lotHigh256;

        uint256 len = basket.erc20s.length;
        for (uint256 i = 0; i < len; ++i) {
            uint192 qty = quantity(basket.erc20s[i]);
            if (qty == 0) continue;

            IAsset asset = assetRegistry.toAsset(basket.erc20s[i]);
            (uint192 lowP, uint192 highP) = asset.price();
            (uint192 lotLowP, uint192 lotHighP) = asset.lotPrice();

            low256 += qty.safeMul(lowP, RoundingMode.FLOOR);
            high256 += qty.safeMul(highP, RoundingMode.CEIL);
            lotLow256 += qty.safeMul(lotLowP, RoundingMode.FLOOR);
            lotHigh256 += qty.safeMul(lotHighP, RoundingMode.CEIL);
        }

        // safe downcast: FIX_MAX is type(uint192).max
        price_.low = low256 >= FIX_MAX ? FIX_MAX : uint192(low256);
        price_.high = high256 >= FIX_MAX ? FIX_MAX : uint192(high256);
        lotPrice_.low = lotLow256 >= FIX_MAX ? FIX_MAX : uint192(lotLow256);
        lotPrice_.high = lotHigh256 >= FIX_MAX ? FIX_MAX : uint192(lotHigh256);
    }

    /// Return the current issuance/redemption value of `amount` BUs
    /// @dev Subset of logic of quoteCustomRedemption; more gas efficient for current nonce
    /// @param amount {BU}
    /// @return erc20s The backing collateral erc20s
    /// @return quantities {qTok} ERC20 token quantities equal to `amount` BUs
    // Returns (erc20s, [quantity(e) * amount {as qTok} for e in erc20s])
    function quote(uint192 amount, RoundingMode rounding)
        external
        view
        returns (address[] memory erc20s, uint256[] memory quantities)
    {
        uint256 length = basket.erc20s.length;
        erc20s = new address[](length);
        quantities = new uint256[](length);

        for (uint256 i = 0; i < length; ++i) {
            erc20s[i] = address(basket.erc20s[i]);
            ICollateral coll = assetRegistry.toColl(IERC20(erc20s[i]));

            // {qTok} = {tok/BU} * {BU} * {tok} * {qTok/tok}
            quantities[i] = _quantity(basket.erc20s[i], coll)
                .safeMul(amount, rounding)
                .shiftl_toUint(
                    int8(IERC20Metadata(address(basket.erc20s[i])).decimals()),
                    rounding
                );
        }
    }

    /// Return the redemption value of `amount` BUs for a linear combination of historical baskets
    /// @param basketNonces An array of basket nonces to do redemption from
    /// @param portions {1} An array of Fix quantities
    /// @param amount {BU}
    /// @return erc20s The backing collateral erc20s
    /// @return quantities {qTok} ERC20 token quantities equal to `amount` BUs
    // Returns (erc20s, [quantity(e) * amount {as qTok} for e in erc20s])
    function quoteCustomRedemption(
        uint48[] memory basketNonces,
        uint192[] memory portions,
        uint192 amount
    ) external view returns (address[] memory erc20s, uint256[] memory quantities) {
        require(basketNonces.length == portions.length, "portions does not mirror basketNonces");

        IERC20[] memory erc20sAll = new IERC20[](assetRegistry.size());
        uint192[] memory refAmtsAll = new uint192[](erc20sAll.length);

        uint256 len; // length of return arrays

        // Calculate the linear combination basket
        for (uint48 i = 0; i < basketNonces.length; ++i) {
            require(basketNonces[i] <= nonce, "invalid basketNonce");
            Basket storage b = basketHistory[basketNonces[i]];

            // Add-in refAmts contribution from historical basket
            for (uint256 j = 0; j < b.erc20s.length; ++j) {
                IERC20 erc20 = b.erc20s[j];
                if (address(erc20) == address(0)) continue;

                // Ugly search through erc20sAll
                uint256 erc20Index = type(uint256).max;
                for (uint256 k = 0; k < len; ++k) {
                    if (erc20 == erc20sAll[k]) {
                        erc20Index = k;
                        continue;
                    }
                }

                // Add new ERC20 entry if not found
                uint192 amt = portions[i].mul(b.refAmts[erc20], FLOOR);
                if (erc20Index == type(uint256).max) {
                    erc20sAll[len] = erc20;

                    // {ref} = {1} * {ref}
                    refAmtsAll[len] = amt;
                    ++len;
                } else {
                    // {ref} = {1} * {ref}
                    refAmtsAll[erc20Index] += amt;
                }
            }
        }

        erc20s = new address[](len);
        quantities = new uint256[](len);

        // Calculate quantities
        for (uint256 i = 0; i < len; ++i) {
            erc20s[i] = address(erc20sAll[i]);

            try assetRegistry.toAsset(IERC20(erc20s[i])) returns (IAsset asset) {
                if (!asset.isCollateral()) continue; // skip token if no longer registered

                // {tok} = {BU} * {ref/BU} / {ref/tok}
                quantities[i] = safeMulDivFloor(
                    amount,
                    refAmtsAll[i],
                    ICollateral(address(asset)).refPerTok()
                ).shiftl_toUint(int8(asset.erc20Decimals()), FLOOR);
                // marginally more penalizing than its sibling calculation that uses _quantity()
                // because does not intermediately CEIL as part of the division
            } catch (bytes memory errData) {
                // see: docs/solidity-style.md#Catching-Empty-Data
                if (errData.length == 0) revert(); // solhint-disable-line reason-string
            }
        }
    }

    /// @return baskets {BU}
    ///          .top The number of partial basket units: e.g max(coll.map((c) => c.balAsBUs())
    ///          .bottom The number of whole basket units held by the account
    /// @dev Returns (FIX_ZERO, FIX_MAX) for an empty or DISABLED basket
    // Returns:
    //    (0, 0), if (basket.erc20s is empty) or (disabled is true) or (status() is DISABLED)
    //    min(e.balanceOf(account) / quantity(e) for e in basket.erc20s if quantity(e) > 0),
    function basketsHeldBy(address account) public view returns (BasketRange memory baskets) {
        uint256 length = basket.erc20s.length;
        if (length == 0 || disabled) return BasketRange(FIX_ZERO, FIX_MAX);
        baskets.bottom = FIX_MAX;

        for (uint256 i = 0; i < length; ++i) {
            ICollateral coll = assetRegistry.toColl(basket.erc20s[i]);
            if (coll.status() == CollateralStatus.DISABLED) return BasketRange(FIX_ZERO, FIX_MAX);

            uint192 refPerTok = coll.refPerTok();
            // If refPerTok is 0, then we have zero of coll's reference unit.
            // We know that basket.refAmts[basket.erc20s[i]] > 0, so we have no baskets.
            if (refPerTok == 0) return BasketRange(FIX_ZERO, FIX_MAX);

            // {tok/BU} = {ref/BU} / {ref/tok}.  0-division averted by condition above.
            uint192 q = basket.refAmts[basket.erc20s[i]].div(refPerTok, CEIL);
            // q > 0 because q = (n).div(_, CEIL) and n > 0

            // {BU} = {tok} / {tok/BU}
            uint192 inBUs = coll.bal(account).div(q);
            baskets.bottom = fixMin(baskets.bottom, inBUs);
            baskets.top = fixMax(baskets.top, inBUs);
        }
    }

    // === Governance Setters ===

    /// @custom:governance
    function setWarmupPeriod(uint48 val) public governance {
        require(val >= MIN_WARMUP_PERIOD && val <= MAX_WARMUP_PERIOD, "invalid warmupPeriod");
        emit WarmupPeriodSet(warmupPeriod, val);
        warmupPeriod = val;
    }

    // === Private ===

    /// Select and save the next basket, based on the BasketConfig and Collateral statuses
    function _switchBasket() private {
        // Mark basket disabled. Pause most protocol functions unless there is a next basket
        disabled = true;

        bool success = _newBasket.nextBasket(_targetNames, config, assetRegistry);
        // if success is true: _newBasket is the next basket

        if (success) {
            // nonce' = nonce + 1
            // basket' = _newBasket
            // timestamp' = now

            nonce += 1;
            basket.setFrom(_newBasket);
            basketHistory[nonce].setFrom(_newBasket);
            timestamp = uint48(block.timestamp);
            disabled = false;
        }

        // Keep records, emit event
        uint256 len = basket.erc20s.length;
        uint192[] memory refAmts = new uint192[](len);
        for (uint256 i = 0; i < len; ++i) {
            refAmts[i] = basket.refAmts[basket.erc20s[i]];
        }
        emit BasketSet(nonce, basket.erc20s, refAmts, disabled);
    }

    /// Require that newERC20s and newTargetAmts preserve the current config targets
    function requireConstantConfigTargets(
        IERC20[] calldata newERC20s,
        uint192[] calldata newTargetAmts
    ) private {
        // Empty _targetAmts mapping
        while (_targetAmts.length() > 0) {
            (bytes32 key, ) = _targetAmts.at(0);
            _targetAmts.remove(key);
        }

        // Populate _targetAmts mapping with old basket config
        uint256 len = config.erc20s.length;
        for (uint256 i = 0; i < len; ++i) {
            IERC20 erc20 = config.erc20s[i];
            bytes32 targetName = config.targetNames[erc20];
            (bool contains, uint256 amt) = _targetAmts.tryGet(targetName);
            _targetAmts.set(
                targetName,
                contains ? amt + config.targetAmts[erc20] : config.targetAmts[erc20]
            );
        }

        // Require new basket is exactly equal to old basket, in terms of targetAmts by targetName
        len = newERC20s.length;
        for (uint256 i = 0; i < len; ++i) {
            bytes32 targetName = assetRegistry.toColl(newERC20s[i]).targetName();
            (bool contains, uint256 amt) = _targetAmts.tryGet(targetName);
            require(contains && amt >= newTargetAmts[i], "new basket adds target weights");
            if (amt > newTargetAmts[i]) _targetAmts.set(targetName, amt - newTargetAmts[i]);
            else _targetAmts.remove(targetName);
        }
        require(_targetAmts.length() == 0, "new basket missing target weights");
    }

    /// Require that erc20s is a valid collateral array
    function requireValidCollArray(IERC20[] calldata erc20s) private view {
        IERC20 zero = IERC20(address(0));

        for (uint256 i = 0; i < erc20s.length; i++) {
            require(erc20s[i] != rsr, "RSR is not valid collateral");
            require(erc20s[i] != IERC20(address(rToken)), "RToken is not valid collateral");
            require(erc20s[i] != IERC20(address(stRSR)), "stRSR is not valid collateral");
            require(erc20s[i] != zero, "address zero is not valid collateral");
        }

        require(ArrayLib.allUnique(erc20s), "contains duplicates");
    }

    // ==== FacadeRead views ====
    // Not used in-protocol; helpful for reconstructing state

    /// Get a reference basket in today's collateral tokens, by nonce
    /// @param basketNonce {basketNonce}
    /// @return erc20s The erc20s in the reference basket
    /// @return quantities {qTok/BU} The quantity of whole tokens per whole basket unit
    function getHistoricalBasket(uint48 basketNonce)
        external
        view
        returns (IERC20[] memory erc20s, uint256[] memory quantities)
    {
        Basket storage b = basketHistory[basketNonce];
        erc20s = new IERC20[](b.erc20s.length);
        quantities = new uint256[](erc20s.length);

        for (uint256 i = 0; i < b.erc20s.length; ++i) {
            erc20s[i] = b.erc20s[i];

            // {qTok/BU} = {tok/BU} * {qTok/tok}
            quantities[i] = quantity(basket.erc20s[i]).shiftl_toUint(
                int8(IERC20Metadata(address(basket.erc20s[i])).decimals()),
                FLOOR
            );
        }
    }

    /// Getter part1 for `config` struct variable
    /// @dev Indices are shared across return values
    /// @return erc20s The erc20s in the prime basket
    /// @return targetNames The bytes32 name identifier of the target unit, per ERC20
    /// @return targetAmts {target/BU} The amount of the target unit in the basket, per ERC20
    function getPrimeBasket()
        external
        view
        returns (
            IERC20[] memory erc20s,
            bytes32[] memory targetNames,
            uint192[] memory targetAmts
        )
    {
        erc20s = new IERC20[](config.erc20s.length);
        targetNames = new bytes32[](erc20s.length);
        targetAmts = new uint192[](erc20s.length);

        for (uint256 i = 0; i < erc20s.length; ++i) {
            erc20s[i] = config.erc20s[i];
            targetNames[i] = config.targetNames[erc20s[i]];
            targetAmts[i] = config.targetAmts[erc20s[i]];
        }
    }

    /// Getter part2 for `config` struct variable
    /// @param targetName The name of the target unit to lookup the backup for
    /// @return erc20s The backup erc20s for the target unit, in order of most to least desirable
    /// @return max The maximum number of tokens from the array to use at a single time
    function getBackupConfig(bytes32 targetName)
        external
        view
        returns (IERC20[] memory erc20s, uint256 max)
    {
        BackupConfig storage backup = config.backups[targetName];
        erc20s = new IERC20[](backup.erc20s.length);
        for (uint256 i = 0; i < erc20s.length; ++i) {
            erc20s[i] = backup.erc20s[i];
        }
        max = backup.max;
    }

    // === Private ===

    /// @return The floored result of FixLib.mulDiv
    function safeMulDivFloor(
        uint192 x,
        uint192 y,
        uint192 z
    ) private view returns (uint192) {
        try backingManager.mulDiv(x, y, z, FLOOR) returns (uint192 result) {
            return result;
        } catch Panic(uint256 errorCode) {
            // 0x11: overflow
            // 0x12: div-by-zero
            assert(errorCode == 0x11 || errorCode == 0x12);
        } catch (bytes memory reason) {
            assert(keccak256(reason) == UIntOutofBoundsHash);
        }
        return FIX_MAX;
    }

    // ==== Storage Gap ====

    /**
     * @dev This empty reserved space is put in place to allow future versions to add new
     * variables without shifting down storage in the inheritance chain.
     * See https://docs.openzeppelin.com/contracts/4.x/upgradeable#storage_gaps
     */
    uint256[37] private __gap;
}