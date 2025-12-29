//SPDX-License-Identifier: MIT 

pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {

    // uint256 internal minimumUSD = 5e18;

    // // this line defines the variavle for the funders address
    // address[] internal funders;
    // mapping (address funder =>uint256 amountFunded) internal addressToAmountFunded;


function getPrice() internal view returns (uint256) {
    AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    (,int256 price,,,) = priceFeed.latestRoundData();
    //price variavle will rep ETH in USD

    return uint256(price) * 1e10;
}

function getConversionRate(uint256 ethAmount) internal view returns (uint256) {
    uint256 ethPrice = getPrice();
    uint256 ethAmountInUSD = (ethPrice * ethAmount)/1e18;
    return (ethAmountInUSD);
}
 function getConversionRate() internal view returns(uint256) {
    return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
 }
    
}