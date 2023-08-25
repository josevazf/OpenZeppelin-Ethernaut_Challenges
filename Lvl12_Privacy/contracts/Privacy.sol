// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Privacy {

  bool public locked = true; // 1 bytes long -> slot[0] = 1 bytes
  uint256 public ID = block.timestamp; // 32 bytes long -> slot[1] = 32 bytes
  uint8 private flattening = 10; // 1 bytes long ->slot[2] = 1 bytes
  uint8 private denomination = 255; // 1 bytes long ->slot[2] = 1 + 1 = 2 bytes
  uint16 private awkwardness = uint16(block.timestamp); // 2 bytes long ->slot[2] = 2 + 2 = 4 bytes 
  bytes32[3] private data; // 32 * 3 ->slot[3], slot[4], slot[5]

  constructor(bytes32[3] memory _data) {
    data = _data;
  }
  
  function unlock(bytes16 _key) public {
    require(_key == bytes16(data[2]));
    locked = false;
  }

  /*
    A bunch of super advanced solidity algorithms...

      ,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`
      .,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,
      *.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^         ,---/V\
      `*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.    ~|__(o.o)
      ^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'  UU  UU
  */
}