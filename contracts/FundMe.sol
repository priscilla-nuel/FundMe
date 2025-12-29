//SPDX-License-Identifier: MIT 
pragma solidity ^0.8.20; //declaring the solidity version

// to tell the contract the minimum required 

// this allows your contract to interact with the chainlink price feed updates
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";


contract FundMe {
    // function for funding the contract
    // the function will allow users too send $
    // have a minimum amount of $ sent
    // payable keyword allows the function to 
function fund() public payable {
        require(msg.value >= 1e14, "didn't send enough ether");
    }
function getPrice() public view returns (uint256) {
    AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    (,int256 price,,,) = priceFeed.latestRoundData();
    //price variavle will rep ETH in USD

    return uint256(price) * 1e10;
}

function getConversionrate(uint256 ethAmount) public view returns (uint256) {
    uint256 ethPrice = getPrice();
    uint256 ethAmountInUSD = (ethPrice * ethAmount)/1e36;
    return (ethAmountInUSD);
}


    //function for withdrawing the funds vy the owner
    function withdraw() public {}

}