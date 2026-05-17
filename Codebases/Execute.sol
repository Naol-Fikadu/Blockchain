// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Voting {
    event ProposalCreated(uint proposalId);
    event VoteCast(uint proposalId, address voter);
    event ProposalExecuted(uint proposalId);
    
    struct Proposal {
        address target;
        bytes data;
        uint yesCount;
        uint noCount;
        bool executed;  // Track if proposal has been executed
    }
    
    Proposal[] public proposals;
    
    mapping(uint => mapping(address => bool)) public hasVoted;
    mapping(uint => mapping(address => bool)) public votedYes;
    
    mapping(address => bool) public isMember;
    
    constructor(address[] memory initialMembers) {
        isMember[msg.sender] = true;
        for(uint i = 0; i < initialMembers.length; i++) {
            isMember[initialMembers[i]] = true;
        }
    }
    
    modifier onlyMember() {
        require(isMember[msg.sender], "Not a member");
        _;
    }
    
    function newProposal(address target, bytes calldata data) external onlyMember {
        uint proposalId = proposals.length;
        proposals.push(Proposal({
            target: target,
            data: data,
            yesCount: 0,
            noCount: 0,
            executed: false
        }));
        emit ProposalCreated(proposalId);
    }
    
    function castVote(uint proposalId, bool support) external onlyMember {
        require(proposalId < proposals.length, "Invalid proposal");
        
        Proposal storage proposal = proposals[proposalId];
        require(!proposal.executed, "Proposal already executed");
        
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
        
        // Execute proposal if threshold reached and not executed
        if (proposal.yesCount >= 10 && !proposal.executed) {
            proposal.executed = true;
            
            // Execute the proposal by sending data to target
            (bool success, ) = proposal.target.call(proposal.data);
            require(success, "Execution failed");
            
            emit ProposalExecuted(proposalId);
        }
    }
    
    // Optional: Get proposal details
    function getProposal(uint proposalId) external view returns (
        address target,
        bytes memory data,
        uint yesCount,
        uint noCount,
        bool executed
    ) {
        require(proposalId < proposals.length, "Invalid proposal");
        Proposal storage proposal = proposals[proposalId];
        return (proposal.target, proposal.data, proposal.yesCount, proposal.noCount, proposal.executed);
    }
}