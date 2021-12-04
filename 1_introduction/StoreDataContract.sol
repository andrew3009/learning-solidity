// SPDX-License-Identifier: Apache-2.0
pragma solidity >=0.4.16 <0.9.0;

contract SimpleStorage {
  uint public storedData;

  function set(uint x) public {
    storedData = x;
  }

  // View key word makes immutable
  function get() public view returns (uint) {
    return storedData;
  }
}