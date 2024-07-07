//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "forge-std/console.sol";

contract FFITest is Test { 
    function testFFi() public { 
        string[] memory cmds = new string[](2);
        cmds[0] = "cat";
        cmds[1] = "/home/hisham/justtest/testyellow/test/ffi_test.txt";

        bytes memory res = vm.ffi(cmds);
        console.log(string(res));
    }
}