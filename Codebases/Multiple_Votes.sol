// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Voting {
    // Events
    event ProposalCreated(uint proposalId);
    event VoteCast(uint proposalId, address voter);
    
    struct Proposal {
        address target;
        bytes data;
        uint yesCount;
        uint noCount;
    }
    
    Proposal[] public proposals;
    
    mapping(uint => mapping(address => bool)) public hasVoted;
    mapping(uint => mapping(address => bool)) public votedYes;
    
    mapping(address => bool) public isMember;
    
    constructor() {
        // Empty constructor for this lesson
    }
    
    modifier onlyMember() {
        require(isMember[msg.sender], "Not a member");
        _;
    }
    
    function newProposal(address target, bytes calldata data) external {
        uint proposalId = proposals.length;
        proposals.push(Proposal(target, data, 0, 0));
        emit ProposalCreated(proposalId);
    }
    
    function castVote(uint proposalId, bool support) external {
        require(proposalId < proposals.length, "Invalid proposal");
        
        Proposal storage proposal = proposals[proposalId];
        
        if (hasVoted[proposalId][msg.sender]) {
            bool oldVote = votedYes[proposalId][msg.sender];
            if (oldVote != support) {
                if (oldVote) {
                    proposal.yesCount--;
                } else {
                    proposal.noCount--;
                }
                
                if (support) {
                    proposal.yesCount++;
                } else {
                    proposal.noCount++;
                }
                
                votedYes[proposalId][msg.sender] = support;
            }
        } else {
            if (support) {
                proposal.yesCount++;
            } else {
                proposal.noCount++;
            }
            
            hasVoted[proposalId][msg.sender] = true;
            votedYes[proposalId][msg.sender] = support;
        }
        
        emit VoteCast(proposalId, msg.sender);
    }
    
    // Add member function for testing (optional)
    function addMember(address member) external {
        isMember[member] = true;
    }
}