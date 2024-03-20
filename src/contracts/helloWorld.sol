// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Test{
    uint public favoriteNumber = 100;
    function store(uint _favoriteNumber) public {
        favoriteNumber = _favoriteNumber +  10;
    }

    mapping(string => uint) public nameToFavoriteNumber;

    function retrieve() public view returns(uint){
        return favoriteNumber;
    }

    struct People{
        string name;
        uint favoriteNumber;
        string codingTime;
    }

    People public person1 = People({name: 'Kishor', favoriteNumber:108, codingTime : "18 hours"});
    People[] public people;

    function addPerson(string memory _name, uint _favoriteNumber, string memory _codingTime) public {
        People memory newPerson = People({name : _name, favoriteNumber: _favoriteNumber, codingTime : _codingTime});
        people.push(newPerson);
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }

    function getLength() public  view returns(uint){
        return people.length;
    }
}