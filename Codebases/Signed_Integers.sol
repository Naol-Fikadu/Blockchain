// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    int8 public a = 10;     // Positive value
    int8 public b = -15;    // Negative value
    int16 public difference = int16(a) - int16(b);  // 10 - (-15) = 25
}
