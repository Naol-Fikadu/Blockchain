// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Sidekick {
    function sendAlert(address heroAddress, uint256 enemies, bool armed) external {
        // 1. Manually encode the function signature with its explicit types and arguments
        // CRITICAL: We use "uint256" inside the signature string instead of "uint"
        bytes memory payload = abi.encodeWithSignature(
            "alert(uint256,bool)", 
            enemies, 
            armed
        );

        // 2. Perform the low-level call passing the encoded payload
        (bool success, ) = heroAddress.call(payload);
        
        // 3. Confirm the execution succeeded
        require(success, "Alert failed");
    }
}