//SPDX-License-Identifier: MIT 
pragma solidity ^0.8.20; //declaring the solidity version

contract FundMe {
    // function for funding the contract
    // the function will allow users too send $
    // have a minimum amount of $ sent
    // payable keyword allows the function to 
    function fund() public payable {
        require(msg.value >= 1e18, "didn't send enough ether");
    }

    //function for withdrawing the funds vy the owner
    function withdraw() public {}

}