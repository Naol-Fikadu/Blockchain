// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Escrow {
    // Public state variables for the three escrow parties
    address public depositor;
    address public beneficiary;
    address public arbiter;

    // Custom errors for gas efficiency
    error NotArbiter();
    error TransferFailed();

    // --- YOUR GOAL: Declare the event ---
    event Approved(uint256 balance);

    /**
     * @notice Initializes and funds the escrow contract with the roles
     * @param _arbiter The address responsible for approving the release of funds
     * @param _beneficiary The address that will receive the funds upon approval
     */
    constructor(address _arbiter, address _beneficiary) payable {
        arbiter = _arbiter;
        beneficiary = _beneficiary;
        depositor = msg.sender;
    }

    /**
     * @notice Moves the contract's full ether balance to the beneficiary's address.
     *         Can only be called by the designated arbiter.
     */
    function approve() external {
        // 1. Restrict access: Check if the caller is the arbiter
        if (msg.sender != arbiter) {
            revert NotArbiter();
        }

        // 2. Get the entire balance held by the contract
        uint256 balance = address(this).balance;

        // 3. --- YOUR GOAL: Emit the event before transferring or deleting state ---
        emit Approved(balance);

        // 4. Perform a low-level call to transfer the balance to the beneficiary
        (bool success, ) = beneficiary.call{ value: balance }("");
        if (!success) {
            revert TransferFailed();
        }
    }
}