// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ResearchPaperRegistry {
    struct Scientist {
        string name;
        string[] researchPaperCIDs;
    }
    constructor() {
        owner = payable(msg.sender);
    }
    address payable public owner;
    mapping(address => Scientist) public scientists;

    // Function to add a new scientist
    function registerScientist(string memory scientistName) external {
        require(bytes(scientistName).length > 0, "Scientist name must not be empty");

        Scientist storage scientist = scientists[msg.sender];
        scientist.name = scientistName;
    }

    // Function to add a new research paper CID for an existing scientist
    function addResearchPaper(string memory newResearchPaperCID) external {
        Scientist storage scientist = scientists[msg.sender];
        require(bytes(scientist.name).length > 0, "Scientist is not registered");

        scientist.researchPaperCIDs.push(newResearchPaperCID);
    }

    // Function to get the number of research papers for a scientist
    function getResearchPaperCount(address scientistAddress) external view returns (uint256) {
        return scientists[scientistAddress].researchPaperCIDs.length;
    }

    // Function to get a specific research paper CID for a scientist
    function getResearchPaperCID(address scientistAddress, uint256 index) external view returns (string memory) {
        Scientist storage scientist = scientists[scientistAddress];
        require(index < scientist.researchPaperCIDs.length, "Invalid index");

        return scientist.researchPaperCIDs[index];
    }

    function deposit() public payable {
        require(msg.value == 0.5 ether, "Deposit amount must be 0.4 ETH");
    }

    function withdraw() public {
        require(msg.sender == owner, "Only the owner can withdraw");
        require(address(this).balance >= 1 ether, "Not enough balance");
        owner.transfer(0.5 ether);
    }

}