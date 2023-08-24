// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ForceTransaction {

    address payable public force;

    constructor (address payable toSend) {
        force = toSend;
    }

    function killAndSend() public {
        selfdestruct(force);
    }

    receive () external payable {}
}