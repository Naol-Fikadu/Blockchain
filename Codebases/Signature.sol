// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Sidekick {
    function sendAlert(address heroAddress) external {
        // 1. Get the 4-byte function selector from the signature string
        bytes4 selector = bytes4(keccak256("alert()"));

        // 2. Perform a manual low-level call passing only the selector as calldata
        (bool success, ) = heroAddress.call(abi.encodePacked(selector));
        
        // 3. Ensure the call succeeded
        require(success, "Alert failed");
    }
}