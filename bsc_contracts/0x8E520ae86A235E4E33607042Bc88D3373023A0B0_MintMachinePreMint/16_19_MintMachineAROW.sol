// SPDX-License-Identifier: UNLICENSED
pragma solidity >= 0.8.17;

//---------------------------------------------------------
// Imports
//---------------------------------------------------------
import "./MintMachine.sol";

//---------------------------------------------------------
// Contract
//---------------------------------------------------------
contract MintMachineAROW is MintMachine
{
	constructor(address _address_deposit_vault, address _address_reward_vault) MintMachine(_address_deposit_vault, _address_reward_vault)
	{
	}
}