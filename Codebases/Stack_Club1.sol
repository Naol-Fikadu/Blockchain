// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract StackClub {
    // Dynamic array of member addresses
    address[] public members;
    
    // Constructor: Add the deployer as the first member
    constructor() {
        members.push(msg.sender);
    }
    
    // Modifier to restrict access to members only
    modifier onlyMember() {
        require(isMember(msg.sender), "Caller is not a member");
        _;
    }
    
    // Add a new member (only existing members can call)
    function addMember(address newMember) external onlyMember {
        require(!isMember(newMember), "Already a member");
        members.push(newMember);
    }
    
    // Remove the last member (only existing members can call)
    function removeLastMember() external onlyMember {
        require(members.length > 0, "No members to remove");
        members.pop();
    }
    
    // Check if an address is a member
    function isMember(address user) public view returns(bool) {
        for(uint i = 0; i < members.length; i++) {
            if(members[i] == user) {
                return true;
            }
        }
        return false;
    }
    
    // Get total number of members
    function getMemberCount() external view returns(uint) {
        return members.length;
    }
    
    // Get the most recent member (top of stack)
    function getLastMember() external view returns(address) {
        require(members.length > 0, "No members");
        return members[members.length - 1];
    }
}