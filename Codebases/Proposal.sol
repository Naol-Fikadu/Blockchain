// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Voting {
    // Define the Proposal struct
    struct Proposal {
        address target;
        bytes data;
        uint yesCount;
        uint noCount;
    }
    
    // Public array of proposals
    Proposal[] public proposals;
    
    // Create a new proposal
    function newProposal(address target, bytes calldata data) external {
        // Create a new proposal with zero vote counts and add to array
        proposals.push(Proposal(target, data, 0, 0));
    }
}