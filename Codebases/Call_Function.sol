// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Define the interface matching the function on the Hero contract
interface IHero {
    function alert() external;
}

contract Sidekick {
    // Call the alert function on the target hero address using the interface
    function sendAlert(address heroAddress) external {
        IHero(heroAddress).alert();
    }
}