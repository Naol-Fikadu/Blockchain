// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    // Variables ordered exactly to match expected storage slots 0, 1, and 2
    uint256 public a; // Slot 0
    uint256 public b; // Slot 1
    uint256 public c; // Slot 2
    
    address public owner;

    error NotOwner();

    constructor() {
        owner = msg.sender;
    }

    // Modifier ensuring only the deployer can run the functions
    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert NotOwner();
        }
        _;
    }

    function setA(uint256 _a) external onlyOwner {
        a = _a;
    }

    function setB(uint256 _b) external onlyOwner {
        b = _b;
    }

    function setC(uint256 _c) external onlyOwner {
        c = _c;
    }
}