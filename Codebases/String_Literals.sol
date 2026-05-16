// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    // Requirement 1: bytes32 with "Hello World"
    bytes32 public msg1 = "Hello World";
    
    // Requirement 2: string with > 32 bytes
    string public msg2 = "This is a very long message that definitely exceeds thirty two bytes of storage space!";
}
