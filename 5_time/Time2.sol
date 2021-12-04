// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.10;

contract Coin {
    uint contractStartTime;
    address public minter;
    mapping (address => uint) public balances;

    event Transfer(address from, address to, uint value);

    modifier onlyMinter {
        require(msg.sender == minter, "Only the minter can call this function");
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
        contractStartTime = block.timestamp;
    }

    function mint(address reciever, uint amount) public onlyMinter amountGreaterThan(amount) {
        balances[reciever] += amount;
    }

    function transfer(address reciever, uint amount) public balanceGreaterThanAmount(amount) {
        // limit transfer function to 7 days after release
        require(block.timestamp - contractStartTime < 604800);
        balances[msg.sender] -= amount;
        balances[reciever] += amount;
        emit Transfer(msg.sender, reciever, amount);
    }
}