// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
// import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe{
    uint256 public minimumUsd = 50 * 1e18;

    function fund() public payable {
        require(getConversionRate(msg.value) >= minimumUsd, "Didn't send Enough");  // 1e18 == 1 * 10 ** 18
    }

    function getPrice() public view returns(uint) {
        // ABI
        // Address : 0x694AA1769357215DE4FAC081bf1f309aDC325306
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (, int price,,,) = priceFeed.latestRoundData();
        return uint(price * 1e10);
    }

    function getVersion() public view  returns (uint) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return priceFeed.version();
    }
    
    function getConversionRate(uint ethAmount) public view returns (uint) {
        uint ethPrice = getPrice();
        uint ethAmountInUsd = (ethPrice * ethAmount) / (1e18);
        return (ethAmountInUsd);
    }
}