// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    // Mapping to store membership status
    mapping(address => bool) public members;
    
    // Add a member
    function addMember(address newMember) external {
        members[newMember] = true;
    }
    
    // Check if an address is a member
    function isMember(address user) external view returns(bool) {
        return members[user];
    }
    
    // Remove a member by setting to false
    function removeMember(address member) external {
        members[member] = false;
    }
}