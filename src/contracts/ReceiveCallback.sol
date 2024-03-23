// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract RCCallBack{
    uint public result  = 10;
    receive() external payable { 
        result = 100;
    }
    fallback() external payable { 
        result = 900;
    }
}