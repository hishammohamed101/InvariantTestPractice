// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleToken {
    mapping(address => uint256) public balances;
    uint256 public totalSupply;
    address[] public holders;
    mapping(address => bool) public holderExists;

    function mint(address to, uint256 amount) public {
        if (balances[to] == 0 && !holderExists[to]) {
            holders.push(to);
            holderExists[to] = true;
        }
        balances[to] += amount;
        totalSupply += amount;
    }

    function transfer(address to, uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        if (balances[to] == 0 && !holderExists[to]) {
            holders.push(to);
            holderExists[to] = true;
        }
        balances[msg.sender] -= amount;
        balances[to] += amount;
    }

    function getHoldersLength() public view returns (uint256) {
        return holders.length;
    }
}
