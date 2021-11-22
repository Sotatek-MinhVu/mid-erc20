// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../token/utils/Context.sol";
import "./Ownable.sol";


contract AccessRole is Context, Ownable {

  mapping(bytes32 => mapping(address=> bool)) private _roles;
  bytes32 private constant ADMIN_ROLE = 0x0000000000000000000000000000000000000000000000000000000000000000;
  bytes32 private constant MINT_ROLE =  0x3100000000000000000000000000000000000000000000000000000000000000;
  bytes32 private constant BURN_ROLE =  0x3200000000000000000000000000000000000000000000000000000000000000;

  modifier isAdmin() {
    require(_checkAdmin(), "User not is Admin");
    _;
  }

  modifier isMinter(){
    require(_checkMinter(), "User not is Minter");
    _;
  }

  modifier isBurner() {
    require(_checkBurnter(), "User not is Burner");
    _;
  }

  /**
  * @dev Check `role` with account; 
  */
  function _hasRole(bytes32 role, address account) internal view returns (bool) {
    return _roles[role][account];
  }

  /**
  * @dev Grants `role` to `account`.
  *
  * Internal function without access restriction.
  */
  function _grantRole(bytes32 role, address account) internal virtual {
      if (!_hasRole(role, account)) {
          _roles[role][account] = true;
      }
  }

  /**
  * @dev Grants `role admin` to `account modifier by owner`.
  *
  */
  function grantAdminRole(address account) public onlyOwner {
    _grantRole(ADMIN_ROLE, account);
  }

  /**
  * @dev Grants `role mint` to `account modifier by owner`.
  *
  */
  function grantMintRole(address account) public isAdmin {
    _grantRole(MINT_ROLE, account);
  }

  /**
  * @dev Grants `role burn` to `account modifier by owner`.
  *
  */
  function grantBurnRole(address account) public isAdmin {
    _grantRole(BURN_ROLE, account);
  }

  /**
  * @dev Check `role minter` by `account`.
  *
  * Internal function without access restriction.
  */
  function _checkMinter() internal virtual returns(bool) {
    return _hasRole(MINT_ROLE, msg.sender);
  }

  /**
  * @dev Check `role burn` by `account`.
  *
  * Internal function without access restriction.
  */
  function _checkBurnter() internal virtual returns(bool) {
    return _hasRole(BURN_ROLE, msg.sender);
  }

  /**
  * @dev Check `role admin` by `account`.
  *
  * Internal function without access restriction.
  */
  function _checkAdmin() internal virtual returns(bool) {
    return _hasRole(ADMIN_ROLE, msg.sender);
  }

  /**
  * @dev Check `role minter` by `account`.
  *
  * public function view return role minter of account.
  */
  function getMinter(address account) public view returns(bool) {
    return _hasRole(MINT_ROLE,account);
  }

  /**
  * @dev Check `role admin` by `account`.
  *
  * public function view return role admin of account.
  */
  function getAdmin(address account) public view returns(bool) {
    return _hasRole(ADMIN_ROLE,account);
  }

  /**
  * @dev Check `role admin` by `account`.
  *
  * public function view return role burn of account.
  */
  function getBurnter(address account) public view returns(bool) {
    return _hasRole(BURN_ROLE,account);
  }
}