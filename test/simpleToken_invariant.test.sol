// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/SimpleToken.sol";

contract InvariantTest is Test {
    SimpleToken token;

    function setUp() public {
        token = new SimpleToken();
    }

    function invariantTotalSupply() public {
        uint256 sumOfBalances = 0;
        uint256 holdersLength = token.getHoldersLength();

        // Iterate over all holders to sum up balances

        // token.holders(i) retrieves the address of the holder at index i in the holders array.
        // token.balances(token.holders(i)) retrieves the balance of tokens held by the holder at address token.holders(i).
        // The retrieved balance is added to sumOfBalances.
        //
        for (uint256 i = 0; i < holdersLength; i++) {
            sumOfBalances += token.balances(token.holders(i));
        }

        // Check the invariant: sum of balances should equal total supply
        assertEq(sumOfBalances, token.totalSupply());
    }


}
