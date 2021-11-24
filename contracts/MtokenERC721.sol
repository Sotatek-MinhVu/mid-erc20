// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../token/ERC721/ERC721.sol";
import "../token/utils/Counters.sol";

contract MtokenErc721 is ERC721 {

  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  constructor (
      string memory name_,
      string memory symbol_
  ) ERC721(name_, symbol_) {}

  function mint() public returns(uint256) {
    _tokenIds.increment();

    uint256 newTokenId = _tokenIds.current();
    _mint(msg.sender, newTokenId);

    return newTokenId;
  }
}
