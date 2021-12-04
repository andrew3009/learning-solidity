// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.10;

contract myGame {
  uint public playerCount = 0;

  mapping(address => Player) public players;

  enum Level {
    beginner,
    intermediate,
    advanced
  }

  struct Player {
    address playerAddress;
    Level playerLevel;
    string firstName;
    string lastName;
    uint created;
  }

  function addPlayer(string memory firstName, string memory lastName) public {
    players[msg.sender] = Player(msg.sender, Level.beginner, firstName, lastName, block.timestamp);
    playerCount += 1;
  }

  function getPlayerLevel(address playerAddress) public view returns(Level) {
    Player storage player = players[playerAddress];
    return player.playerLevel;
  }

  function changePlayerLevel(address playerAddress) public {
    Player storage player = players[playerAddress];
    if (block.timestamp >= player.created + 20) {
      player.playerLevel = Level.intermediate;
    }
  }
}