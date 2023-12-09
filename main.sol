// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract safeTransfer {
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    function deposit() public payable {
        require(msg.value == 0.5 ether, "Deposit amount must be 0.5 ETH");
    }

    function withdraw() public {
        require(msg.sender == owner, "Only the owner can withdraw");
        require(address(this).balance >= 1 ether, "Not enough balance");
        owner.transfer(0.5 ether);
    }
}