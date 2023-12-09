// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DisputeContract {
    address payable public owner;
    mapping(address => uint256) public stakes;

    constructor() {
        owner = payable(msg.sender);
    }

    function slashStake(address user) public {
        require(msg.sender == owner, "Only the owner can slash stakes");
        require(stakes[user] >= 0.1 ether, "User does not have enough stake");

        stakes[user] -= 0.1 ether;
        owner.transfer(0.1 ether);
    }
}
