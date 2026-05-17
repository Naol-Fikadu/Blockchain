// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

// Ownable base contract
contract Ownable {
    address public owner;
    
    constructor() {
        owner = msg.sender;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call");
        _;
    }
}

// Transferable - must be able to access owner
// Solution: Make Transferable inherit from Ownable
contract Transferable is Ownable {
    function transfer(address newOwner) external onlyOwner {
        require(newOwner != address(0), "Cannot transfer to zero address");
        owner = newOwner;
    }
}