// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Voting {
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
    
    // Member tracking
    mapping(address => bool) public isMember;
    
    // Constructor takes array of initial members
    constructor(address[] memory initialMembers) {
        // Add the deployer as a member
        isMember[msg.sender] = true;
        
        // Add all initial members
        for(uint i = 0; i < initialMembers.length; i++) {
            isMember[initialMembers[i]] = true;
        }
    }
    
    // Modifier to restrict to members only
    modifier onlyMember() {
        require(isMember[msg.sender], "Not a member");
        _;
    }
    
    function newProposal(address target, bytes calldata data) external onlyMember {
        uint proposalId = proposals.length;
        proposals.push(Proposal(target, data, 0, 0));
        emit ProposalCreated(proposalId);
    }
    
    function castVote(uint proposalId, bool support) external onlyMember {
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
    
    // Get proposal details
    function getProposal(uint proposalId) external view returns (
        address target,
        bytes memory data,
        uint yesCount,
        uint noCount
    ) {
        require(proposalId < proposals.length, "Invalid proposal");
        Proposal storage proposal = proposals[proposalId];
        return (proposal.target, proposal.data, proposal.yesCount, proposal.noCount);
    }
}