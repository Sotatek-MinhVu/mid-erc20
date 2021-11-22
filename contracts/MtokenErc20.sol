// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../token/ERC20/ERC20.sol";
import "../libraries/AccessRole.sol";
import "../libraries/Pausable.sol";

contract Mtoken is ERC20, AccessRole, Pausable {

  constructor(string memory name, string memory symbol) ERC20(name, symbol) {
    _mint(msg.sender, 0);
  }

  modifier isMinter(){
    _checkMinter();
    _;
  }

  modifier isBurner() {
    _checkBurnter();
    _;
  }

  modifier isAdmin() {
    _checkAdmin();
    _;
  }

  modifier requireSupply() {
    require(totalSupply() < 1 * 10 ** 6);
    _;
  }

  function mint(address account, uint256 amount) public virtual isMinter requireSupply whenNotPaused{
    _mint(account, amount);
  }

  function burn(address account, uint256 amount) public virtual isBurner whenNotPaused{
    _burn(account, amount);
  }

  function pauseAdmin() public virtual isAdmin {
    _pause();
  } 

  function unPauseAdmin() public virtual isAdmin {
    _unpause();
  } 

}