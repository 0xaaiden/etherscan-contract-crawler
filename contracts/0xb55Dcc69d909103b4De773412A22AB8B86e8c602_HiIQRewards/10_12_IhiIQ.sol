// SPDX-License-Identifier: AGPL-3.0
pragma solidity 0.7.1;
pragma experimental ABIEncoderV2;

interface IhiIQ {
    struct LockedBalance {
        int128 amount;
        uint256 end;
    }

    /* ========== VIEWS ========== */
    function balanceOf(address addr) external view returns (uint256);

    function balanceOf(address addr, uint256 _t) external view returns (uint256);

    function balanceOfAt(address addr, uint256 _block) external returns (uint256);

    function totalSupply() external view returns (uint256);

    function totalSupply(uint256 t) external view returns (uint256);

    function totalSupplyAt(uint256 _block) external returns (uint256);

    function totalIQSupply() external view returns (uint256);

    function totalIQSupplyAt(uint256 _block) external view returns (uint256);

    function locked(address addr) external view returns (LockedBalance memory);

    /* ========== PUBLIC FUNCTIONS ========== */
    function checkpoint() external;
}