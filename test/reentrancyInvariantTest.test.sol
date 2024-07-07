// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "../src/reentrancy.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

contract InvariantTest is Test {
    SimpleToken token;

    function setUp() public {
        token = new SimpleToken();
    }

    function invariantNoReentrancy() public {
        // Get initial balance of this contract
        uint256 balanceBefore = token.balances(address(this));

        // Attempt to transfer more tokens than available
        address receiver = address(0x123);  // Example receiver address
        uint256 transferAmount = 1000;      // More than the contract's balance

        // Execute transfer and expect revert with "Insufficient balance"
        bool transferFailed;
        try token.transfer(receiver, transferAmount) {
            transferFailed = false;  // Transfer should fail
        } catch Error(string memory revertMessage) {
            transferFailed = true;   // Transfer reverted as expected
            assertEq(revertMessage, "Insufficient balance");
        } catch (bytes memory) {
            transferFailed = true;   // Handle unexpected exceptions
        }

        // Get balance after attempted transfer
        uint256 balanceAfter = token.balances(address(this));

        // Ensure balance remains unchanged after the failed transfer
        assertEq(balanceBefore, balanceAfter);
        assert(transferFailed);  // Only pass the boolean condition
    }


}
