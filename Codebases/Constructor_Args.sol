// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "./Hero.sol";
import "./Enemy.sol";

// Warrior inherits from Hero with health 200
contract Warrior is Hero(200) {
    function attack(Enemy enemy) public override {
        // Call base attack to decrease energy
        super.attack(enemy);
        // Add Warrior-specific Brawl attack
        enemy.takeAttack(AttackTypes.Brawl);
    }
}

// Mage inherits from Hero with health 50
contract Mage is Hero(50) {
    function attack(Enemy enemy) public override {
        // Call base attack to decrease energy
        super.attack(enemy);
        // Add Mage-specific Spell attack
        enemy.takeAttack(AttackTypes.Spell);
    }
}