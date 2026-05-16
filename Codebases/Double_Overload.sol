// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

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
    
    function winningNumber(string memory _message) external pure returns(string memory) {
        return _message;
    }
    
    // Version 1: Single parameter (made public so it can be called internally)
    function double(uint _number) public pure returns(uint) {
        return _number * 2;
    }
    
    // Version 2: Two parameters (overloaded function)
    function double(uint _a, uint _b) external pure returns(uint, uint) {
        // Option 1: Use the single-parameter version
        uint doubledA = double(_a);
        uint doubledB = double(_b);
        return (doubledA, doubledB);
        
        // Option 2: Direct calculation (without calling the other function)
        // return (_a * 2, _b * 2);
    }
}
