// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract VotingSystem {
    struct Voter {
        bool voted;
        uint vote;
    }

    struct Candidate {
        bytes32 name;
        uint voteCount;
    }

    address public owner;
    uint public votingStartTime;
    uint public votingEndTime;
    bool public votingStarted;
    mapping(address => Voter) public voters;
    Candidate[2] public candidates;

    modifier onlyDuringVotingPeriod() {
        require(votingStarted, "Voting has not started.");
        require(block.timestamp >= votingStartTime && block.timestamp <= votingEndTime, "Voting period has ended or not started.");
        _;
    }

    constructor() {
        owner = msg.sender;
        candidates[0] = Candidate({name: "Approve", voteCount: 0});
        candidates[1] = Candidate({name: "Reject", voteCount: 0});
        votingStarted = false;
    }
    //to start the voting process
    function startVoting(uint startID) public {
        require(msg.sender == owner, "Only owner can start the voting.");
        require(!votingStarted, "Voting has already started.");
        require(startID == 12345, "Invalid start ID."); 
        votingStartTime = block.timestamp;
        votingEndTime = votingStartTime + 100; 
        votingStarted = true;
    }
    //voting
    function vote(uint candidateIndex) public onlyDuringVotingPeriod {
        require(!voters[msg.sender].voted, "Already voted.");
        require(candidateIndex < 2, "Invalid candidate.");

        voters[msg.sender].voted = true;
        voters[msg.sender].vote = candidateIndex;
        candidates[candidateIndex].voteCount += 1;
    }
    //results
    function winningCandidate() public view returns (uint winningCandidateIndex, uint voteCount1, uint voteCount2) {
    require(votingStarted, "Voting has not started.");
    require(block.timestamp > votingEndTime, "Voting period has not ended yet.");
    if (candidates[0].voteCount > candidates[1].voteCount) {
        winningCandidateIndex = 0;
    } else if (candidates[0].voteCount < candidates[1].voteCount) {
        winningCandidateIndex = 1;
    } else {
        
        winningCandidateIndex = 2;
    }
    return (winningCandidateIndex, candidates[0].voteCount, candidates[1].voteCount);
}

}
