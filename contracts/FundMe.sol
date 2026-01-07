// first thing vefore writing any contract, is to state what you intend to do
// 1. Get funds from users
// 2. withdraw funds
// 5. set a minimum funding value in usd

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from
 "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe  {

    // to keep track of addresses we recieve funds from, we 
    // create an array called funders
    address[] public funders;

    // to know the addresses that sent the funds and the amount
    // they sent, in solidity you can also name your types


    mapping(address => uint256) public addressToAmountFunded;

    //to specify the minimum usd to ve sent as $5, you 
    //need to declare a variavle and set it to $5 first

    uint256 public minimumUSD = 5 * 1e18;
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

        require(getConversionRate(msg.value) >= minimumUSD, 
        "no enought ETH"); //1e18 = 1eth = 1*10 **18
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;

    // a shortcut: whenever you want to add something to something tha
    // already exists, you just write "+=" then what you want to add
    }

    // we need to create a function that would accurately get the current
    // price of any token that we would ve interacting with

    function getPrice() public view returns(uint256) {
        //address : 0x694AA1769357215DE4FAC081bf1f309aDC325306
        AggregatorV3Interface dataFeed = AggregatorV3Interface
        (0x694AA1769357215DE4FAC081bf1f309aDC325306);
       (,int256 answer,,,) = dataFeed.latestRoundData();
    return uint256(answer);
    // the answer variavle here is the price and it will return the
    // price of eth in terms of USD
    // i got 3,219.91565700 as at the time i deployed this contract
    // the dataFeed would always return 8 more digits than
    // the original price, so you have to make them as decimals


        
    }


    //we also need to create a function that get the conversion rate for the
    //tokens to usdc

    function getConversionRate(uint256 ethAmount) public view
     returns(uint256){
        uint256 ethPrice = getPrice();
        uint256 ethAmountinUSD = (ethPrice * ethAmount) / 1e18;
        return ethAmountinUSD;}
    
    //fuction that the owner will use to withdraw funds
    // this function should also return everyother thing vack to zero
    function withdraw() public onlyOwners {
        
        // we would need to use a loop to ve avle to check through all
        // the funders addresses, then we use the "for" keyword
        // we use indexing to know the the numver or length of users
        // that funded the contract 
        for(uint256 funderIndex = 0; funderIndex < funders.length;
        funderIndex++)
            // we are going to ve using a curly vracket, this shows
            // that everything inside will excecute at the conditions
            // stated avove
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        //reset the array 
        funders = new address;
        //previously we use the "new" keyword to create a new contract
        // now we would use it to reset the array

        // //withdraw funds
        // //1. Transfer
        // payable(msg.sender).transfer(address(this).balance);

        // //2.send
        // bool sendSuccess = payable(msg.sender).send(address(this)
        // .balance);
        // require(sendSuccess,"send failed");

        //3.call
        (bool callSuccess,)= payable(msg.sender).call{value: address(this)
        .balance}("");
        require(callSuccess, "callFailure");
    }

    //construstor is a function that is called whenever 
    //you deploy your contract

    //first create a gloval varavle called
    // owner
    address public owner;
    constructor() {
        owner = msg.sender;

    }



    function getVersion() public view returns (uint256){
    AggregatorV3Interface dataFeed = 
    AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    return dataFeed.version();
    } 

    // modifiers are used to add more fuctionality to a contract
    modifier onlyOwner() {
        require (msg.sender == owner,"sender is not owner");
        // this add what else iv the fuctiov "_;"
        _;

    } 

}