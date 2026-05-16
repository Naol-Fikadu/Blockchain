// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    // The provided enum (you can change the foods)
    enum Foods { Pizza, Pasta, Salad, Burger }
    
    // Store each food in its own variable
    Foods public food1 = Foods.Pizza;
    Foods public food2 = Foods.Pasta;
    Foods public food3 = Foods.Salad;
    Foods public food4 = Foods.Burger;
}
