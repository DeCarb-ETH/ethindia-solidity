// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DisputeToken is ERC20, Ownable {
    constructor() ERC20("DisputeToken", "DPT") Ownable(msg.sender) {
    _mint(msg.sender, 1000000 * 10 ** decimals());
}

    function raiseDispute(address user) public  onlyOwner {
        _mint(user, 1 * 10 ** decimals());
    }

    function resolveDispute(address user) public  onlyOwner {
        _burn(user, balanceOf(user));
    }
}
