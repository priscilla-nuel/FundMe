//SPDX-License-Identifier: MIT 
pragma solidity ^0.8.20; //declaring the solidity version

// to tell the contract the minimum required 

// this allows your contract to interact with the chainlink price feed updates
import {PriceConverter} from "./PriceConverter.sol";


contract FundMe {
    // function for funding the contract
    // the function will allow users too send $
    // have a minimum amount of $ sent
    // payable keyword allows the contract to keep funds
    address[] public funders;
    mapping (address funders =>uint256 amountFunded) public addressToAmountFunded;

    using PriceConverter for uint256;

    uint256 public minimumUSD = 5e18;

    // this line defines the variavle for the funders address
    
function fund() public  payable {
require(msg.value.getConversionRate() >= 1e10, "didn't send enough ether");
        funders.push(msg.sender);

        // this line returns the funders address and amount paid
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    }

    

    //function for withdrawing the funds vy the owner
    function withdraw() public {}

}