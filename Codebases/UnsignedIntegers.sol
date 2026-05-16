// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    uint8 public a = 100;      // Any value 0-255 (I chose 100)
    uint16 public b = 256;      // At least 256 (minimum requirement)
    uint256 public sum = uint256(a) + uint256(b);  // Convert to uint256 first
}
