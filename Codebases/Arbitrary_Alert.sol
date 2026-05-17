// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Sidekick {
    /**
     * @notice Relays arbitrary calldata execution payloads to a target address
     * @param heroAddress The contract to invoke (Hero)
     * @param data The pre-encoded arbitrary calldata payload
     */
    function relay(address heroAddress, bytes calldata data) external {
        // Perform the low-level call passing the raw calldata bytes directly
        (bool success, ) = heroAddress.call(data);
        
        // Ensure the call completed successfully 
        require(success, "Relay execution failed");
    }
}