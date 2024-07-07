// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleToken {
    mapping(address => uint256) public balances;

    function transfer(address to, uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        
        // Vulnerable to reentrancy
        balances[msg.sender] -= amount;
        balances[to] += amount;

        // Corrected handling of call return values
        (bool success, bytes memory data) = msg.sender.call{value: 0}("");
        if (!success) {
            revert("External call failed");
        }

        // Continue with the function logic
    }
}
