// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../token/ERC20/ERC20.sol";
import "../libraries/AccessRole.sol";
import "../libraries/Pausable.sol";

contract Mtoken is ERC20, AccessRole, Pausable {



  constructor(string memory name, string memory symbol) ERC20(name, symbol) {
    _mint(msg.sender, 0);
  }

  modifier requireSupply() {
    require(totalSupply() < 1 * 10 ** 6);
    _;
  }

  /** @dev Creates `amount` tokens and assigns them to `account`, increasing
    * the total supply.
    *
    * Requirements:
    *
    * - The contract must not be paused, role of account is isMinter and totalSupply < 1 billion.
    */
  function mint(address account, uint256 amount) public isMinter requireSupply whenNotPaused{
    _mint(account, amount);
  }


  /**
    * @dev Destroys `amount` tokens from `account`, reducing the
    * total supply.
    *
    * Requirements:
    *
    * - `account` cannot be the zero address.
    * - `account` must have at least `amount` tokens.
    * - `account` must be Bunrner.
    * - The contract must not be paused.
    */
  function burn(address account, uint256 amount) public isBurner whenNotPaused{
    _burn(account, amount);
  }


  /**
    * @dev change status of the contract to paused.
    *
    * Requirements:
    *
    * - `account` cannot be the zero address.
    * - `account` must be Bunrner.
    */
  function pauseAdmin() public isAdmin {
    _pause();
  } 

  /**
    * @dev change status of the contract to not paused.
    *
    * Requirements:
    *
    * - `account` cannot be the zero address.
    * - `account` must be Bunrner.
    */ 
  function unPauseAdmin() public isAdmin {
    _unpause();
  } 

}