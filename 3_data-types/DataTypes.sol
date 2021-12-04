// SPDX-License-Identifier: Apache-2.0
pragma solidity >=0.4.16 <0.9.0;

contract myContract {
  // has to be greater than 0
  // can declear bite size
  uint public myUnit = 1;
  // can be less than 0
  int public myInt = -1;
  string public myString = "Hello";
  bool public myBool = true;
  // will alway be the same
  uint public constant myUnit2 = 1;
}

contract myGame {
  uint public playerCount = 0;
  // Cannot get player by reference, can only get by index
  // Player[] public players;

  // Allows to get player by address
  mapping(address => Player) public players;

  // Enums restrict a variable to have one of the only specified values
  enum Level {
    beginner,
    intermediate,
    advanced
  }

  // object structure
  struct Player {
    address playerAddress;
    Level playerLevel;
    string firstName;
    string lastName;
  }

  function addPlayer(string memory firstName, string memory lastName) public {
    // players.push(Player(firstName, lastName));
    players[msg.sender] = Player(msg.sender, Level.beginner, firstName, lastName);
    playerCount += 1;
  }

  // use player wallet address to get players level
  // view makes it so that the function can not be used to edit anything
  function getPlayerLevel(address playerAddress) public view returns(Level) {
    return players[playerAddress].playerLevel;
  }
}
