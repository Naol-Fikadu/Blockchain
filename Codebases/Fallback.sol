// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Sidekick {
    /**
     * @notice Triggers the fallback function of the target Hero contract
     * @param heroAddress The address of the Hero contract
     */
    function makeContact(address heroAddress) external {
        // Send arbitrary calldata ("invalid_call") that won't match any function identifier
        // This forces the EVM to route the execution directly to the fallback() function
        (bool success, ) = heroAddress.call(abi.encodePacked("invalid_call"));
        
        // Ensure the call completed successfully
        require(success, "Contact failed");
    }
}