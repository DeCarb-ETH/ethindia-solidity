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
    address[] public users;
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
        require(msg.value == 1 ether, "Deposit amount must be 1 ETH");
    }

    // Function to add a user to the registry
    function addUser(address userAddress) external {
        require(userAddress != address(0), "Invalid user address");
        require(!isUserRegistered(userAddress), "User is already registered");

        users.push(userAddress);
    }
    // Function to check if a user is already registered
    function isUserRegistered(address userAddress) public view returns (bool) {
        for (uint256 i = 0; i < users.length; i++) {
            if (users[i] == userAddress) {
                return true;
            }
        }
        return false;
    }
}