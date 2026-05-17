// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    address public owner;

    // Custom errors for gas efficiency
    error NotOwner();
    error TransferFailed();

    // Constructor is payable so it can accept the 1 ether sent via hoax()
    constructor() payable {
        owner = msg.sender;
    }

    // Public withdraw function required by your test
    function withdraw() public {
        // Restrict access to only the deployer/owner
        if (msg.sender != owner) {
            revert NotOwner();
        }

        // Get the contract's total balance
        uint256 balance = address(this).balance;

        // Send all funds to the owner
        (bool success, ) = owner.call{ value: balance }("");
        if (!success) {
            revert TransferFailed();
        }
    }

    // Allows the contract to receive funds if necessary
    receive() external payable {}
}