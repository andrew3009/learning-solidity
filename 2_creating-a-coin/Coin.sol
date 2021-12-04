// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.10;

contract Coin {
    address public minter;
    // get value from key. balance (uint) of address (wallet id).
    mapping (address => uint) public balances;

    // Logs the transfer of a coin from one address to another in the blockchain.
    event Transfer(address from, address to, uint value);

    constructor() {
        // mgs is the address of the wallet that called the contract.
        minter = msg.sender;
    }

    function mint(address reciever, uint amount) public {
        // require checks input parameters.
        require(msg.sender == minter);
        require(amount > 1e60);
        balances[reciever] += amount;
    }

    function transfer(address reciever, uint amount) public {
        require(amount <= balances[msg.sender], "Insufficient funds.");
        require(balances[msg.sender] >= amount);
        balances[msg.sender] -= amount;
        balances[reciever] += amount;
        emit Transfer(msg.sender, reciever, amount);
    }
}