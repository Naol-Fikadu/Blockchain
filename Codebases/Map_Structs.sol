// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    struct User {
        uint balance;
        bool isActive;
    }
    
    mapping(address => User) public users;
    
    function createUser() external {
        require(!users[msg.sender].isActive, "User already exists");
        users[msg.sender] = User({
            balance: 100,
            isActive: true
        });
    }
    
    // Transfer tokens between users
    function transfer(address recipient, uint amount) external {
        // Get storage references to both users
        User storage sender = users[msg.sender];
        User storage receiver = users[recipient];
        
        // Security checks
        require(sender.isActive, "Sender not active");
        require(receiver.isActive, "Recipient not active");
        require(sender.balance >= amount, "Insufficient balance");
        
        // Perform transfer
        sender.balance -= amount;
        receiver.balance += amount;
    }
}