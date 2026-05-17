// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    enum Choices { Yes, No }
    
    struct Vote {
        Choices choice;
        address voter;
    }
    
    // Create and return a Vote struct in memory
    function createVote(Choices choice) external view returns (Vote memory) {
        return Vote(choice, msg.sender);
    }
}