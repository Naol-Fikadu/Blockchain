// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    // Enum provided by the test
    enum Choices { Yes, No }
    
    // Struct definition
    struct Vote {
        Choices choice;
        address voter;
    }
    
    // Public storage variable of type Vote
    Vote public vote;
    
    // Function to create and store a vote
    function createVote(Choices choice) external {
        // Create new Vote instance and store in storage
        vote = Vote(choice, msg.sender);
    }
}