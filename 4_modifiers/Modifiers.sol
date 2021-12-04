// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.10;

contract Coin {
    address public minter;
    mapping (address => uint) public balances;

    event Transfer(address from, address to, uint value);

    // modifier makes it so that line 12 can be removed from the mint function.
    // modifiers are inheritable by all contracts.
    modifier onlyMinter {
        require(msg.sender == minter, "Only the minter can call this function");
        // last line of modifier has to end with _;
        _;
    }

    modifier amountGreaterThan(uint amount) {
        require(amount < 1e60);
        _;
    }

    modifier balanceGreaterThanAmount(uint amount) {
        require(amount <= balances[msg.sender], "Insufficient funds.");
        _;
    }

    constructor() {
        minter = msg.sender;
    }

    function mint(address reciever, uint amount) public onlyMinter amountGreaterThan(amount) {
        balances[reciever] += amount;
    }

    function transfer(address reciever, uint amount) public balanceGreaterThanAmount(amount) {
        // require(balances[msg.sender] >= amount);
        balances[msg.sender] -= amount;
        balances[reciever] += amount;
        emit Transfer(msg.sender, reciever, amount);
    }
}