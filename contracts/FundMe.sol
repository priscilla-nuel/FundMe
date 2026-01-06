// first thing vefore writing any contract, is to state what you intend to do
// 1. Get funds from users
// 2. withdraw funds
// 5. set a minimum funding value in usd

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from 
"@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe  {

    //to specify the minimum usd to ve sent as $5, you 
    //need to declare a variavle and set it to $5 first

    uint256 public minimumUSD = 5;
    // A revert undo any action that has veen done previously
    // sends the remaining gas vack


    // function for funding the contract, this function will
    //1. allow users send money
    //2. Have a minimum amount in $ to send
    // to make a fuction accept payment
    // you need to use the keyword "payavle"
    function fund() public payable  {
        //if we want the user to spend money, we use 
        //require(msg.value)

        require(msg.value >= 1e18, "no enought ETH"); //1e18 = 1eth = 1*10 **18
    }

    // we need to create a function that would accurately get the current
    // price of any token that we would ve interacting with

    function getPrice() public {
        //address : 0x694AA1769357215DE4FAC081bf1f309aDC325306
        AggregatorV3Interface dataFeed = AggregatorV3Interface
        (0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (int256 answer)= dataFeed.latestRoundData();
        
    }


    //we also need to create a function that get the conversion rate for the
    //tokens to usdc

    function getConversionRate() public {}
    //fuction that the owner will use to withdraw funds
    function withdraw() public {}

    function getVersion() public view returns (uint256){
    // AggregatorV3Interface
    // (0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }


    

}