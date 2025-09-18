// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title SkutiiVoting
 * @dev Simple voting contract where each address can vote once
 * @author skutii
 */
contract SkutiiVoting {
    // Struct to hold proposal details
    struct Proposal {
        string description;
        uint256 voteCount;
    }

    // Array of proposals
    Proposal[] public proposals;

    // Track who has voted
    mapping(address => bool) public hasVoted;

    // Event to log when a new vote is cast
    event Voted(address voter, uint256 proposalIndex);

    /**
     * @notice Add a new proposal to the ballot
     * @param description The text describing the proposal
     */
    function addProposal(string memory description) public {
        proposals.push(Proposal({
            description: description,
            voteCount: 0
        }));
    }

    /**
     * @notice Cast a vote for a specific proposal
     * @dev Each address can only vote once
     * @param proposalIndex Index of the proposal in the proposals array
     */
    function vote(uint256 proposalIndex) public {
        require(!hasVoted[msg.sender], "skutii says: You already voted!");
        require(proposalIndex < proposals.length, "skutii says: Invalid proposal");

        hasVoted[msg.sender] = true;
        proposals[proposalIndex].voteCount++;

        emit Voted(msg.sender, proposalIndex);
    }

    /**
     * @notice Get the winning proposal index
     * @return winnerIndex Index of the proposal with the highest votes
     */
    function winningProposal() public view returns (uint256 winnerIndex) {
        uint256 highestVotes = 0;
        for (uint256 i = 0; i < proposals.length; i++) {
            if (proposals[i].voteCount > highestVotes) {
                highestVotes = proposals[i].voteCount;
                winnerIndex = i;
            }
        }
    }
}
