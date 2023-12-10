// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract DisputeContract {
    address payable public owner;
    mapping(address => uint256) public stakes;

    constructor() {
        owner = payable(msg.sender);
    }
    // salshing stake of user
    function slashStake(address user) public {
        require(msg.sender == owner, "Only the owner can slash stakes");
        require(stakes[user] >= 0.1 ether, "User does not have enough stake");

        stakes[user] -= 0.1 ether;
        
        OffsetCarbon(50000000000000000);
    }
    
    //contract address of toucanHelper in polygon
    address public toucanOffsetHelper = 0x66B1B59F9D59413dDC1539122D7d5F6b70869717;

    address public wethAddress = 0x66B1B59F9D59413dDC1539122D7d5F6b70869717;
    //not sure what is the pool address have to check 
    address public poolTokenAddress;

    function OffsetCarbon(uint256 _amount) public {

        (bool success, ) = toucanOffsetHelper.call(abi.encodeWithSignature("autoOffsetExactInToken(address, address, uint256)",wethAddress,poolTokenAddress,_amount ));
        require(success,"offseting call failed ");

    }

    function convertMaticToWmatic(uint256 _amount) public payable {
        (bool success, ) = address(0x9c3C9283D3e44854697Cd22D3Faa240Cfb032889).call{value: msg.value}(abi.encodeWithSignature("deposit(uint256)", _amount));
        require(success,"Convertion from matic to wamtic failed");
    }
}
