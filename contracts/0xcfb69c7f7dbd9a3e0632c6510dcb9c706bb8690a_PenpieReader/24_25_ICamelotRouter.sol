pragma solidity ^0.8.0;

interface ICamelotRouter {
    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
}