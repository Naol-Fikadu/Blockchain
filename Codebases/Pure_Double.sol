// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/console.sol";

contract Contract {
    uint public x;
    
    constructor() {
        x = 0;
    }
    
    function increment() external {
        x++;
    }
    
    function add(uint _value) external view returns(uint) {
        return x + _value;
    }
    
    function winningNumber(string calldata _message) external pure returns (uint) {
        return 794;
    }
}
