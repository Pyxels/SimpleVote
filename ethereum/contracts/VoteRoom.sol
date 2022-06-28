// // SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.8.0;

/// @title Vote room smart contract, a proof-of-concept voting system with private and public voting
/// @author Group 3 (Jonas Buse, Emir Simsek, Felix Pollok, Michael Meissner)
/// @notice A smart contract that lets managers create new votes which either designated adresses can partake in, or which everybody can use
contract VoteRoom {

    /// A single vote which can be public or private
    struct VoteData {
        string description;
        bool isFinalized;
        mapping(address=>bool) hasVoted;
        uint inFavor;
        uint againt;
        uint abstain;
        uint minimumVotes;
        bool isPublic;
    }

    /// Owner and manager who can whitelist people and start votes
    address public manager;

    /// Mapping of all whitelisted voters
    mapping(address=>bool) public invitedVoters;

    /// Number of whitelisted voters
    uint public voterCount;

    /// Array of votes
    VoteData[] public votes;

    /// Description of the room
    string public voteRoomDescription;


    /// Only the manager can access
    modifier managerGuard() {
        require(msg.sender == manager);
        _;
    }

    /// Only a whitelisted voter can access
    modifier voterGuard() {
        require(invitedVoters[msg.sender]);
        _;
    }


    /**
    * @dev constructor that already takes new voters
    * @param author manager of the new vote room
    * @param description description for the whole room
    * @param newVoters a list of addresses of whitelisted voters
    */
    constructor (address author, string memory description, address[] memory newVoters) public {
        manager = author;
        voteRoomDescription = description;
        for (uint256 index = 0; index < newVoters.length; index++) {
            invitedVoters[newVoters[index]] = true;
            voterCount++;
        }
    }
}

