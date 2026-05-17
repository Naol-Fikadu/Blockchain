// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    enum ConnectionTypes { Unacquainted, Friend, Family }
    
    // Nested mapping: address -> (address -> ConnectionType)
    mapping(address => mapping(address => ConnectionTypes)) public connections;
    
    // Connect with another address
    function connectWith(address other, ConnectionTypes connectionType) external {
        connections[msg.sender][other] = connectionType;
    }
}