// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.4;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@prb/contracts/token/erc20/IErc20.sol";
import "@prb/contracts/token/erc20/SafeErc20.sol";
import "@prb/math/contracts/PRBMathUD60x18.sol";

import "./IBalanceSheetV2.sol";
import "./SBalanceSheetV2.sol";
import "../fintroller/IFintroller.sol";
import "../../access/OwnableUpgradeable.sol";

/// @title BalanceSheetV2
/// @author Hifi
/// @dev Due to the upgradeability pattern requirements, we have to inherit from the storage contract last.
contract BalanceSheetV2 is
    Initializable, // no dependency
    OwnableUpgradeable, // two dependencies
    IBalanceSheetV2, // one dependency
    SBalanceSheetV2 // no dependency
{
    using PRBMathUD60x18 for uint256;
    using SafeErc20 for IErc20;

    /// INITIALIZER ///

    /// @notice The upgradeability variant of the contract constructor.
    /// @param fintroller_ The address of the Fintroller contract.
    /// @param oracle_ The address of the oracle contract.
    function initialize(IFintroller fintroller_, IChainlinkOperator oracle_) public initializer {
        // Initialize the owner.
        __Ownable_init();

        // Set the Fintroller contract.
        fintroller = fintroller_;

        // Set the oracle contract.
        oracle = oracle_;
    }

    /// PUBLIC CONSTANT FUNCTIONS ///

    /// @inheritdoc IBalanceSheetV2
    function getBondList(address account) external view override returns (IHToken[] memory) {
        return vaults[account].bondList;
    }

    /// @inheritdoc IBalanceSheetV2
    function getCollateralAmount(address account, IErc20 collateral)
        external
        view
        override
        returns (uint256 collateralAmount)
    {
        return vaults[account].collateralAmounts[collateral];
    }

    /// @inheritdoc IBalanceSheetV2
    function getCollateralList(address account) external view override returns (IErc20[] memory) {
        return vaults[account].collateralList;
    }

    /// @inheritdoc IBalanceSheetV2
    function getCurrentAccountLiquidity(address account)
        public
        view
        override
        returns (uint256 excessLiquidity, uint256 shortfallLiquidity)
    {
        return getHypotheticalAccountLiquidity(account, IErc20(address(0)), 0, IHToken(address(0)), 0);
    }

    /// @inheritdoc IBalanceSheetV2
    function getDebtAmount(address account, IHToken bond) external view override returns (uint256 debtAmount) {
        return vaults[account].debtAmounts[bond];
    }

    struct HypotheticalAccountLiquidityLocalVars {
        uint256 bondListLength;
        uint256 collateralAmount;
        uint256 collateralDecimals;
        uint256 collateralListLength;
        uint256 collateralRatio;
        uint256 collateralValueUsd;
        uint256 debtAmount;
        uint256 debtValueUsd;
        uint256 normalizedCollateralAmount;
        uint256 normalizedCollateralPrice;
        uint256 totalDebtValueUsd;
        uint256 totalWeightedCollateralValueUsd;
        uint256 normalizedUnderlyingPrice;
        uint256 weightedCollateralValueUsd;
    }

    /// @inheritdoc IBalanceSheetV2
    function getHypotheticalAccountLiquidity(
        address account,
        IErc20 collateralModify,
        uint256 collateralAmountModify,
        IHToken bondModify,
        uint256 debtAmountModify
    ) public view override returns (uint256 excessLiquidity, uint256 shortfallLiquidity) {
        HypotheticalAccountLiquidityLocalVars memory vars;

        // Load into memory for faster iteration.
        IErc20[] memory collateralList = vaults[account].collateralList;
        vars.collateralListLength = collateralList.length;

        // Sum up each collateral USD value divided by the collateral ratio.
        for (uint256 i = 0; i < vars.collateralListLength; i++) {
            IErc20 collateral = collateralList[i];

            if (collateralModify != collateral) {
                vars.collateralAmount = vaults[account].collateralAmounts[collateral];
            } else {
                vars.collateralAmount = collateralAmountModify;
            }

            // Normalize the collateral amount.
            vars.collateralDecimals = collateral.decimals();
            if (vars.collateralDecimals != 18) {
                vars.normalizedCollateralAmount = vars.collateralAmount.div(10**vars.collateralDecimals);
            } else {
                vars.normalizedCollateralAmount = vars.collateralAmount;
            }

            // Grab the normalized USD price of the collateral.
            vars.normalizedCollateralPrice = oracle.getNormalizedPrice(collateral.symbol());

            // Calculate the USD value of the collateral amount.
            vars.collateralValueUsd = vars.normalizedCollateralAmount.mul(vars.normalizedCollateralPrice);

            // Calculate the USD value of the weighted collateral by dividing the USD value of the collateral amount
            // by the collateral ratio.
            vars.collateralRatio = fintroller.getCollateralRatio(collateral);
            vars.weightedCollateralValueUsd = vars.collateralValueUsd.div(vars.collateralRatio);

            // Add the previously calculated USD value of the weighted collateral to the totals.
            vars.totalWeightedCollateralValueUsd += vars.weightedCollateralValueUsd;
        }

        // Load into memory for faster iteration.
        IHToken[] memory bondList = vaults[account].bondList;
        vars.bondListLength = bondList.length;

        // Sum up all bond debts.
        for (uint256 i = 0; i < vars.bondListLength; i++) {
            IHToken bond = bondList[i];

            if (bondModify != bond) {
                vars.debtAmount = vaults[account].debtAmounts[bond];
            } else {
                vars.debtAmount = debtAmountModify;
            }

            // Grab the normalized USD price of the underlying.
            vars.normalizedUnderlyingPrice = oracle.getNormalizedPrice(bond.underlying().symbol());

            // Calculate the USD value of the collateral amount.
            vars.debtValueUsd = vars.debtAmount.mul(vars.normalizedUnderlyingPrice);

            // Add the previously calculated USD value to the totals.
            vars.totalDebtValueUsd += vars.debtValueUsd;
        }

        // Excess liquidity when there is more weighted collateral than debt, and shortfall liquidity when there is
        // less weighted collateral than debt.
        unchecked {
            if (vars.totalWeightedCollateralValueUsd > vars.totalDebtValueUsd) {
                excessLiquidity = vars.totalWeightedCollateralValueUsd - vars.totalDebtValueUsd;
            } else {
                shortfallLiquidity = vars.totalDebtValueUsd - vars.totalWeightedCollateralValueUsd;
            }
        }
    }

    /// @inheritdoc IBalanceSheetV2
    function getRepayAmount(
        IErc20 collateral,
        uint256 seizableCollateralAmount,
        IHToken bond
    ) public view override returns (uint256 repayAmount) {
        // Normalize the collateral amount.
        uint256 normalizedSeizableAmount;
        uint256 collateralDecimals = collateral.decimals();
        if (collateralDecimals != 18) {
            normalizedSeizableAmount = seizableCollateralAmount.div(10**collateralDecimals);
        } else {
            normalizedSeizableAmount = seizableCollateralAmount;
        }

        // Grab the normalized USD price of the collateral.
        uint256 normalizedCollateralPrice = oracle.getNormalizedPrice(collateral.symbol());

        // Grab the normalized USD price of the underlying.
        uint256 normalizedUnderlyingPrice = oracle.getNormalizedPrice(bond.underlying().symbol());

        // Calculate the top part of the equation.
        uint256 numerator = normalizedSeizableAmount.mul(normalizedCollateralPrice);

        // Calculate the repay amount.
        uint256 liquidationIncentive = fintroller.getLiquidationIncentive(collateral);
        repayAmount = numerator.div(liquidationIncentive.mul(normalizedUnderlyingPrice));
    }

    /// @inheritdoc IBalanceSheetV2
    function getSeizableCollateralAmount(
        IHToken bond,
        uint256 repayAmount,
        IErc20 collateral
    ) public view override returns (uint256 seizableCollateralAmount) {
        // Grab the normalized USD price of the collateral.
        uint256 normalizedCollateralPrice = oracle.getNormalizedPrice(collateral.symbol());

        // Grab the normalized USD price of the underlying.
        uint256 normalizedUnderlyingPrice = oracle.getNormalizedPrice(bond.underlying().symbol());

        // Calculate the top part of the equation.
        uint256 liquidationIncentive = fintroller.getLiquidationIncentive(collateral);
        uint256 numerator = repayAmount.mul(liquidationIncentive.mul(normalizedUnderlyingPrice));

        // Calculate the normalized seizable collateral amount.
        uint256 normalizedSeizableCollateralAmount = numerator.div(normalizedCollateralPrice);

        // Denormalize the collateral amount.
        unchecked {
            uint256 collateralDecimals = collateral.decimals();
            if (collateralDecimals != 18) {
                seizableCollateralAmount = normalizedSeizableCollateralAmount.mul(10**collateralDecimals);
            } else {
                seizableCollateralAmount = normalizedSeizableCollateralAmount;
            }
        }
    }

    /// PUBLIC NON-CONSTANT FUNCTIONS ///

    // @inheritdoc IHToken
    function borrow(IHToken bond, uint256 borrowAmount) public override {
        // Checks: the Fintroller allows this action to be performed.
        if (!fintroller.getBorrowAllowed(bond)) {
            revert BalanceSheet__BorrowNotAllowed(bond);
        }

        // Checks: bond not matured.
        if (bond.isMatured()) {
            revert BalanceSheet__BondMatured(bond);
        }

        // Checks: the zero edge case.
        if (borrowAmount == 0) {
            revert BalanceSheet__BorrowZero();
        }

        // Checks: debt ceiling.
        uint256 newTotalSupply = bond.totalSupply() + borrowAmount;
        uint256 debtCeiling = fintroller.getDebtCeiling(bond);
        if (newTotalSupply > debtCeiling) {
            revert BalanceSheet__DebtCeilingOverflow(newTotalSupply, debtCeiling);
        }

        // Add the borrow amount to the borrower account's current debt.
        uint256 newDebtAmount = vaults[msg.sender].debtAmounts[bond] + borrowAmount;

        // Effects: add the bond to the redundant list if it hasn't been added already.
        if (vaults[msg.sender].debtAmounts[bond] == 0) {
            // Checks: below max bonds limit.
            unchecked {
                uint256 newBondListLength = vaults[msg.sender].bondList.length + 1;
                uint256 maxBonds = fintroller.maxBonds();
                if (newBondListLength > maxBonds) {
                    revert BalanceSheet__BorrowMaxBonds(bond, newBondListLength, maxBonds);
                }
            }
            vaults[msg.sender].bondList.push(bond);
        }

        // Checks: there is no liquidity shortfall.
        (, uint256 hypotheticalShortfallLiquidity) = getHypotheticalAccountLiquidity(
            msg.sender,
            IErc20(address(0)),
            0,
            bond,
            newDebtAmount
        );
        if (hypotheticalShortfallLiquidity > 0) {
            revert BalanceSheet__LiquidityShortfall(msg.sender, hypotheticalShortfallLiquidity);
        }

        // Effects: increase the amount of debt in the vault.
        vaults[msg.sender].debtAmounts[bond] = newDebtAmount;

        // Interactions: print the new hTokens into existence.
        bond.mint(msg.sender, borrowAmount);

        // Emit a Borrow event.
        emit Borrow(msg.sender, bond, borrowAmount);
    }

    /// @inheritdoc IBalanceSheetV2
    function depositCollateral(IErc20 collateral, uint256 depositAmount) external override {
        // Checks: the Fintroller allows this action to be performed.
        if (!fintroller.getDepositCollateralAllowed(collateral)) {
            revert BalanceSheet__DepositCollateralNotAllowed(collateral);
        }

        // Checks: the zero edge case.
        if (depositAmount == 0) {
            revert BalanceSheet__DepositCollateralZero();
        }

        // Checks: collateral ceiling.
        uint256 newCollateralAmount = collateral.balanceOf(address(this)) + depositAmount;
        uint256 collateralCeiling = fintroller.getCollateralCeiling(collateral);
        if (newCollateralAmount > collateralCeiling) {
            revert BalanceSheet__CollateralCeilingOverflow(newCollateralAmount, collateralCeiling);
        }

        // Effects: add the collateral to the redundant list, if this is the first time collateral is added.
        uint256 collateralAmount = vaults[msg.sender].collateralAmounts[collateral];
        if (collateralAmount == 0) {
            // Checks: below max collaterals limit.
            unchecked {
                uint256 newCollateralListLength = vaults[msg.sender].collateralList.length + 1;
                uint256 maxCollaterals = fintroller.maxCollaterals();
                if (newCollateralListLength > maxCollaterals) {
                    revert BalanceSheet__DepositMaxCollaterals(collateral, newCollateralListLength, maxCollaterals);
                }
            }
            vaults[msg.sender].collateralList.push(collateral);
        }

        // Effects: increase the amount of collateral in the vault.
        vaults[msg.sender].collateralAmounts[collateral] = collateralAmount + depositAmount;

        // Interactions: perform the Erc20 transfer.
        collateral.safeTransferFrom(msg.sender, address(this), depositAmount);

        // Emit a DepositCollateral event.
        emit DepositCollateral(msg.sender, collateral, depositAmount);
    }

    /// @inheritdoc IBalanceSheetV2
    function liquidateBorrow(
        address borrower,
        IHToken bond,
        uint256 repayAmount,
        IErc20 collateral
    ) external override {
        // Checks: caller not the borrower.
        if (msg.sender == borrower) {
            revert BalanceSheet__LiquidateBorrowSelf(borrower);
        }

        // Checks: the Fintroller allows this action to be performed.
        if (!fintroller.getLiquidateBorrowAllowed(bond)) {
            revert BalanceSheet__LiquidateBorrowNotAllowed(bond);
        }

        // After maturation, any vault can be liquidated, irrespective of account liquidity.
        if (!bond.isMatured()) {
            // Checks: the borrower has a shortfall of liquidity.
            (, uint256 shortfallLiquidity) = getCurrentAccountLiquidity(borrower);
            if (shortfallLiquidity == 0) {
                revert BalanceSheet__NoLiquidityShortfall(borrower);
            }
        }

        // Checks: there is enough collateral in the vault.
        uint256 vaultCollateralAmount = vaults[borrower].collateralAmounts[collateral];
        uint256 seizableCollateralAmount = getSeizableCollateralAmount(bond, repayAmount, collateral);
        if (vaultCollateralAmount < seizableCollateralAmount) {
            revert BalanceSheet__LiquidateBorrowInsufficientCollateral(
                borrower,
                vaultCollateralAmount,
                seizableCollateralAmount
            );
        }

        // Effects & Interactions: repay the borrower's debt.
        repayBorrowInternal(msg.sender, borrower, bond, repayAmount);

        // Calculate the new collateral amount.
        uint256 newCollateralAmount;
        unchecked {
            newCollateralAmount = vaults[borrower].collateralAmounts[collateral] - seizableCollateralAmount;
        }

        // Effects: decrease the amount of collateral in the vault.
        vaults[borrower].collateralAmounts[collateral] = newCollateralAmount;

        // Effects: delete the collateral from the redundant list, if the resultant amount of collateral is zero.
        if (newCollateralAmount == 0) {
            removeCollateralFromList(borrower, collateral);
        }

        // Interactions: seize the collateral.
        collateral.safeTransfer(msg.sender, seizableCollateralAmount);

        // Emit a LiquidateBorrow event.
        emit LiquidateBorrow(msg.sender, borrower, bond, repayAmount, collateral, seizableCollateralAmount);
    }

    /// @inheritdoc IBalanceSheetV2
    function repayBorrow(IHToken bond, uint256 repayAmount) external override {
        repayBorrowInternal(msg.sender, msg.sender, bond, repayAmount);
    }

    /// @inheritdoc IBalanceSheetV2
    function repayBorrowBehalf(
        address borrower,
        IHToken bond,
        uint256 repayAmount
    ) external override onlyOwner {
        repayBorrowInternal(msg.sender, borrower, bond, repayAmount);
    }

    /// @inheritdoc IBalanceSheetV2
    function setFintroller(IFintroller newFintroller) external override onlyOwner {
        if (address(newFintroller) == address(0)) {
            revert BalanceSheet__FintrollerZeroAddress();
        }
        address oldFintroller = address(fintroller);
        fintroller = newFintroller;
        emit SetFintroller(owner, oldFintroller, address(newFintroller));
    }

    /// @inheritdoc IBalanceSheetV2
    function setOracle(IChainlinkOperator newOracle) external override onlyOwner {
        if (address(newOracle) == address(0)) {
            revert BalanceSheet__OracleZeroAddress();
        }
        address oldOracle = address(oracle);
        oracle = newOracle;
        emit SetOracle(owner, oldOracle, address(newOracle));
    }

    /// @inheritdoc IBalanceSheetV2
    function withdrawCollateral(IErc20 collateral, uint256 withdrawAmount) external override {
        // Checks: the zero edge case.
        if (withdrawAmount == 0) {
            revert BalanceSheet__WithdrawCollateralZero();
        }

        // Checks: there is enough collateral in the vault.
        uint256 vaultCollateralAmount = vaults[msg.sender].collateralAmounts[collateral];
        if (vaultCollateralAmount < withdrawAmount) {
            revert BalanceSheet__WithdrawCollateralUnderflow(msg.sender, vaultCollateralAmount, withdrawAmount);
        }

        // Calculate the new collateral amount.
        uint256 newCollateralAmount;
        unchecked {
            newCollateralAmount = vaultCollateralAmount - withdrawAmount;
        }

        // Checks: the hypothetical account liquidity is okay.
        if (vaults[msg.sender].bondList.length > 0) {
            (, uint256 hypotheticalShortfallLiquidity) = getHypotheticalAccountLiquidity(
                msg.sender,
                collateral,
                newCollateralAmount,
                IHToken(address(0)),
                0
            );
            if (hypotheticalShortfallLiquidity > 0) {
                revert BalanceSheet__LiquidityShortfall(msg.sender, hypotheticalShortfallLiquidity);
            }
        }

        // Effects: decrease the amount of collateral in the vault.
        vaults[msg.sender].collateralAmounts[collateral] = newCollateralAmount;

        // Effects: delete the collateral from the redundant list, if the resultant amount of collateral is zero.
        if (newCollateralAmount == 0) {
            removeCollateralFromList(msg.sender, collateral);
        }

        // Interactions: perform the Erc20 transfer.
        collateral.safeTransfer(msg.sender, withdrawAmount);

        // Emit a WithdrawCollateral event.
        emit WithdrawCollateral(msg.sender, collateral, withdrawAmount);
    }

    /// INTERNAL NON-CONSTANT FUNCTIONS ///

    /// @dev Removes the bond from the redundant bond list.
    function removeBondFromList(address account, IHToken bond) internal {
        // Load into memory for faster iteration.
        IHToken[] memory memoryBondList = vaults[account].bondList;
        uint256 length = memoryBondList.length;

        // Find the index where the bond is stored at.
        uint256 bondIndex = length;
        for (uint256 i = 0; i < length; i++) {
            if (memoryBondList[i] == bond) {
                bondIndex = i;
                break;
            }
        }

        // We must have found the bond in the list or the redundant data structure is broken.
        assert(bondIndex < length);

        // Copy last item in list to location of item to be removed, reduce length by 1.
        IHToken[] storage storedBondList = vaults[account].bondList;
        storedBondList[bondIndex] = storedBondList[length - 1];
        storedBondList.pop();
    }

    /// @dev Removes the collateral from the redundant collateral list.
    function removeCollateralFromList(address account, IErc20 collateral) internal {
        // Load into memory for faster iteration.
        IErc20[] memory memoryCollateralList = vaults[account].collateralList;
        uint256 length = memoryCollateralList.length;

        // Find the index where the collateral is stored at.
        uint256 collateralIndex = length;
        for (uint256 i = 0; i < length; i++) {
            if (memoryCollateralList[i] == collateral) {
                collateralIndex = i;
                break;
            }
        }

        // We must have found the collateral in the list or the redundant data structure is broken.
        assert(collateralIndex < length);

        // Copy last item in list to location of item to be removed, reduce length by 1.
        IErc20[] storage storedCollateralList = vaults[account].collateralList;
        storedCollateralList[collateralIndex] = storedCollateralList[length - 1];
        storedCollateralList.pop();
    }

    /// @dev See the documentation for the public functions that call this internal function.
    function repayBorrowInternal(
        address payer,
        address borrower,
        IHToken bond,
        uint256 repayAmount
    ) internal {
        // Checks: the Fintroller allows this action to be performed.
        if (!fintroller.getRepayBorrowAllowed(bond)) {
            revert BalanceSheet__RepayBorrowNotAllowed(bond);
        }

        // Checks: the zero edge case.
        if (repayAmount == 0) {
            revert BalanceSheet__RepayBorrowZero();
        }

        // Checks: borrower has debt.
        uint256 debtAmount = vaults[borrower].debtAmounts[bond];
        if (debtAmount < repayAmount) {
            revert BalanceSheet__RepayBorrowInsufficientDebt(bond, repayAmount, debtAmount);
        }

        // Checks: the payer has enough hTokens.
        uint256 hTokenBalance = bond.balanceOf(payer);
        if (hTokenBalance < repayAmount) {
            revert BalanceSheet__RepayBorrowInsufficientBalance(bond, repayAmount, hTokenBalance);
        }

        // Effects: decrease the amount of debt in the vault.
        uint256 newDebtAmount;
        unchecked {
            newDebtAmount = vaults[borrower].debtAmounts[bond] - repayAmount;
            vaults[borrower].debtAmounts[bond] = newDebtAmount;
        }

        // Effects: delete the bond from the redundant list, if the resultant amount of debt is zero.
        if (newDebtAmount == 0) {
            removeBondFromList(borrower, bond);
        }

        // Interactions: burn the hTokens.
        bond.burn(payer, repayAmount);

        // Emit a RepayBorrow event.
        emit RepayBorrow(payer, borrower, bond, repayAmount, newDebtAmount);
    }
}