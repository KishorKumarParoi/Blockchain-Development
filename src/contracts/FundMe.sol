// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "./PriceConverter.sol";

contract FundMe{
    using PriceConverter for uint;

    uint256 public constant MINIMUM_USD = 50 * 1e18;
    address public owner;
    address[] public funders;
    mapping (address => uint) public addressToAmountFunded;

    constructor(){
         owner = msg.sender;
    }

    function fund() public payable {
        require(msg.value.getConversionRate() >= MINIMUM_USD, "Didn't send Enough");  // 1e18 == 1 * 10 ** 18
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

      function getPrice() public  view returns(uint) {
        // ABI
        // Address : 0x694AA1769357215DE4FAC081bf1f309aDC325306
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (, int price,,,) = priceFeed.latestRoundData();
        return uint(price * 1e10);
    }

    function withdraw() public onlyOwner {
        for(uint funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }

        // reset the array
        funders = new address[](0);

        // actually withdraw fund in three ways
        // transfer
        payable(msg.sender).transfer(address(this).balance);

        // send
        bool isSuccess = payable(msg.sender).send(address(this).balance);
        require(isSuccess, "Send Failed!");

        // call
        // without ABI Calling
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, 'Call Failed!');
    }


    modifier onlyOwner{
        require(msg.sender == owner, "Sender is not owner!");
        _;
    }
}