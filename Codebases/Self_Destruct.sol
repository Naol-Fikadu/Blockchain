// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    address public owner;
    address public charity;
    uint public x;
    
    // Constructor now takes charity address
    constructor(address _charity) {
        owner = msg.sender;
        charity = _charity;
        x = 0;
    }
    
    receive() external payable {}
    
    function tip() public payable {
        require(msg.value > 0, "Must send Ether");
        (bool success, ) = owner.call{ value: msg.value }("");
        require(success, "Transfer failed");
    }
    
    // Donate function that selfdestructs
    function donate() public {
        // Selfdestruct and send all funds to charity
        selfdestruct(payable(charity));
    }
    
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
    
    // All previous functions...
    function increment() external {
        x++;
    }
    
    function add(uint _value) external view returns(uint) {
        return x + _value;
    }
    
    function winningNumber(string memory _message) external pure returns(string memory) {
        return _message;
    }
    
    function double(uint _number) public pure returns(uint) {
        return _number * 2;
    }
    
    function double(uint _a, uint _b) external pure returns(uint, uint) {
        return (_a * 2, _b * 2);
    }
}