//SPDX-License-Identifier: MIT 

pragma solidity ^0.8.0;

contract SafeMathTester {

    uint8 public Largeno = 255;

    function add() public {
        unchecked {Largeno = Largeno + 1;}
    }

}