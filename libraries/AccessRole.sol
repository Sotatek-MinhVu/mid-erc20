// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../token/utils/Context.sol";
import "./Ownable.sol";


contract AccessRole is Context, Ownable {

  mapping(bytes32 => mapping(address=> bool)) private _roles;
  bytes32 private constant ADMIN_ROLE = 0x0000000000000000000000000000000000000000000000000000000000000000;
  bytes32 private constant MINT_ROLE =  0x3100000000000000000000000000000000000000000000000000000000000000;
  bytes32 private constant BURN_ROLE =  0x3200000000000000000000000000000000000000000000000000000000000000;

  constructor() {
    _roles[ADMIN_ROLE][_msgSender()] = true;
  }

  modifier isAdmin() {
    _checkAdmin();
    _;
  }

  modifier isMinter(){
    _checkMinter();
    _;
  }

  modifier isBurner() {
    _checkBurnter();
    _;
  }

  /**
  * @dev Check `role` with account; 
  */
  function _hasRole(bytes32 role, address account) internal virtual returns (bool) {
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

  function grantAdminRole(address account) public virtual onlyOwner {
    _grantRole(ADMIN_ROLE, account);
  }

  function grantMintRole(address account) public virtual isAdmin {
    _grantRole(MINT_ROLE, account);
  }

  function grantBurnRole(address account) public virtual isAdmin {
    _grantRole(BURN_ROLE, account);
  }

  function _checkMinter() internal virtual returns(bool) {
    return _hasRole(MINT_ROLE, msg.sender);
  }

  function _checkBurnter() internal virtual returns(bool) {
    return _hasRole(BURN_ROLE, msg.sender);
  }

  function _checkAdmin() internal virtual returns(bool) {
    return _hasRole(ADMIN_ROLE, msg.sender);
  }

}