// SPDX-License-Identifier: Apache-2.0

pragma solidity =0.8.9;

import "../interfaces/IMarginEngine.sol";
import "../interfaces/IVAMM.sol";
import "../utils/CustomErrors.sol";
import "../interfaces/IWETH.sol";

interface IPeriphery is CustomErrors {
    // structs for events
    struct PositionDetails {
        IMarginEngine marginEngine;
        address owner;
        int24 tickLower;
        int24 tickUpper;
    }

    struct SwapOutput {
        int256 fixedTokenDelta;
        int256 variableTokenDelta;
        uint256 cumulativeFeeIncurred;
        int256 fixedTokenDeltaUnbalanced;
        int256 marginRequirement;
    }

    // events
    /// @dev emitted after new lp margin cap is set
    event MarginCap(IVAMM vamm, int256 lpMarginCapNew);

    /// @dev emitted when new lp margin cumulative is set
    event MarginCumulative(IVAMM vamm, int256 lpMarginCumulative);

    /// @dev emitted when position is settled and all margin withdrawn
    event SettlePositionAndWithdrawMargin(PositionDetails position);

    /// @dev emitted when position margin is updated
    event UpdatePositionMargin(
        PositionDetails position,
        int256 marginDelta,
        bool fullyWithdraw
    );

    /// @dev emitted when liquidity is minted or burnt
    event MintOrBurn(
        PositionDetails position,
        uint256 notional,
        bool isMint,
        int256 positionMarginRequirement
    );

    /// @dev emitted when swap happens
    event Swap(
        PositionDetails position,
        bool isFT,
        uint256 notional,
        SwapOutput output
    );

    /// @dev emitted when position is rolled over with mint
    event RolloverWithMint(
        PositionDetails oldPosition,
        PositionDetails newPosition,
        uint256 notional,
        bool isMint,
        int256 newPositionMarginRequirement
    );

    /// @dev emitted when position is rolled over with swap
    event RolloverWithSwap(
        PositionDetails oldPosition,
        PositionDetails newPosition,
        bool isFT,
        uint256 notional,
        SwapOutput output
    );

    // structs

    struct MintOrBurnParams {
        IMarginEngine marginEngine;
        int24 tickLower;
        int24 tickUpper;
        uint256 notional;
        bool isMint;
        int256 marginDelta;
    }

    struct SwapPeripheryParams {
        IMarginEngine marginEngine;
        bool isFT;
        uint256 notional;
        uint160 sqrtPriceLimitX96;
        int24 tickLower;
        int24 tickUpper;
        int256 marginDelta;
    }

    /// @dev "constructor" for proxy instances
    function initialize(IWETH weth_) external;

    // view functions

    function getCurrentTick(IMarginEngine marginEngine)
        external
        view
        returns (int24 currentTick);

    /// @param vamm VAMM for which to get the lp cap in underlying tokens
    /// @return Notional Cap for liquidity providers that mint or burn via periphery (enforced in the core if isAlpha is set to true)
    function lpMarginCaps(IVAMM vamm) external view returns (int256);

    /// @param vamm VAMM for which to get the lp notional cumulative in underlying tokens
    /// @return Total amount of notional supplied by the LPs to a given VAMM via the periphery
    function lpMarginCumulatives(IVAMM vamm) external view returns (int256);

    function weth() external view returns (IWETH);

    // non-view functions

    function mintOrBurn(MintOrBurnParams memory params)
        external
        payable
        returns (int256 positionMarginRequirement);

    function swap(SwapPeripheryParams memory params)
        external
        payable
        returns (
            int256 _fixedTokenDelta,
            int256 _variableTokenDelta,
            uint256 _cumulativeFeeIncurred,
            int256 _fixedTokenDeltaUnbalanced,
            int256 _marginRequirement,
            int24 _tickAfter,
            int256 marginDelta
        );

    /// @dev Ensures a fully collateralised VT swap given that a proper value of the variable factor is passed.
    /// @param params Parameters to be passed to the swap function in the periphery.
    /// @param variableFactorFromStartToNowWad The variable factor between pool's start date and present (in wad).
    function fullyCollateralisedVTSwap(
        SwapPeripheryParams memory params,
        uint256 variableFactorFromStartToNowWad
    )
        external
        payable
        returns (
            int256 _fixedTokenDelta,
            int256 _variableTokenDelta,
            uint256 _cumulativeFeeIncurred,
            int256 _fixedTokenDeltaUnbalanced,
            int256 _marginRequirement,
            int24 _tickAfter,
            int256 marginDelta
        );

    function updatePositionMargin(
        IMarginEngine marginEngine,
        int24 tickLower,
        int24 tickUpper,
        int256 marginDelta,
        bool fullyWithdraw
    ) external payable returns (int256);

    function setLPMarginCap(IVAMM vamm, int256 lpMarginCapNew) external;

    function setLPMarginCumulative(IVAMM vamm, int256 lpMarginCumulative)
        external;

    function settlePositionAndWithdrawMargin(
        IMarginEngine marginEngine,
        address owner,
        int24 tickLower,
        int24 tickUpper
    ) external;

    function rolloverWithMint(
        IMarginEngine marginEngine,
        address owner,
        int24 tickLower,
        int24 tickUpper,
        MintOrBurnParams memory paramsNewPosition
    ) external payable returns (int256 newPositionMarginRequirement);

    function rolloverWithSwap(
        IMarginEngine marginEngine,
        address owner,
        int24 tickLower,
        int24 tickUpper,
        SwapPeripheryParams memory paramsNewPosition
    )
        external
        payable
        returns (
            int256 _fixedTokenDelta,
            int256 _variableTokenDelta,
            uint256 _cumulativeFeeIncurred,
            int256 _fixedTokenDeltaUnbalanced,
            int256 _marginRequirement,
            int24 _tickAfter
        );
}