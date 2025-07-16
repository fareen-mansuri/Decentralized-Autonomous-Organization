// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title DAO - Decentralized Autonomous Organization
 * @dev A smart contract for managing proposals, voting, and governance
 */
contract DAO {
    // Struct to represent a proposal
    struct Proposal {
        uint256 id;
        string title;
        string description;
        address proposer;
        uint256 yesVotes;
        uint256 noVotes;
        uint256 deadline;
        bool executed;
        bool exists;
    }
    
    // State variables
    mapping(uint256 => Proposal) public proposals;
    mapping(uint256 => mapping(address => bool)) public hasVoted;
    mapping(address => bool) public isMember;
    
    uint256 public proposalCount;
    uint256 public memberCount;
    address public admin;
    uint256 public constant VOTING_PERIOD = 7 days;
    uint256 public constant QUORUM = 51; // 51% quorum required
    
    // Events
    event ProposalCreated(uint256 indexed proposalId, string title, address indexed proposer);
    event VoteCast(uint256 indexed proposalId, address indexed voter, bool support);
    event ProposalExecuted(uint256 indexed proposalId);
    event MemberAdded(address indexed member);
    event MemberRemoved(address indexed member);
    
    // Modifiers
    modifier onlyMember() {
        require(isMember[msg.sender], "Only members can perform this action");
        _;
    }
    
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }
    
    modifier proposalExists(uint256 _proposalId) {
        require(proposals[_proposalId].exists, "Proposal does not exist");
        _;
    }
    
    modifier votingActive(uint256 _proposalId) {
        require(block.timestamp < proposals[_proposalId].deadline, "Voting period has ended");
        _;
    }
    
    modifier notExecuted(uint256 _proposalId) {
        require(!proposals[_proposalId].executed, "Proposal already executed");
        _;
    }
    
    // Constructor
    constructor() {
        admin = msg.sender;
        isMember[msg.sender] = true;
        memberCount = 1;
    }
    
    /**
     * @dev Core Function 1: Create a new proposal
     * @param _title The title of the proposal
     * @param _description The description of the proposal
     */
    function createProposal(string memory _title, string memory _description) 
        external 
        onlyMember 
        returns (uint256) 
    {
        require(bytes(_title).length > 0, "Title cannot be empty");
        require(bytes(_description).length > 0, "Description cannot be empty");
        
        proposalCount++;
        uint256 proposalId = proposalCount;
        
        proposals[proposalId] = Proposal({
            id: proposalId,
            title: _title,
            description: _description,
            proposer: msg.sender,
            yesVotes: 0,
            noVotes: 0,
            deadline: block.timestamp + VOTING_PERIOD,
            executed: false,
            exists: true
        });
        
        emit ProposalCreated(proposalId, _title, msg.sender);
        return proposalId;
    }
    
    /**
     * @dev Core Function 2: Vote on a proposal
     * @param _proposalId The ID of the proposal to vote on
     * @param _support True for yes, false for no
     */
    function vote(uint256 _proposalId, bool _support) 
        external 
        onlyMember 
        proposalExists(_proposalId) 
        votingActive(_proposalId) 
        notExecuted(_proposalId) 
    {
        require(!hasVoted[_proposalId][msg.sender], "You have already voted on this proposal");
        
        hasVoted[_proposalId][msg.sender] = true;
        
        if (_support) {
            proposals[_proposalId].yesVotes++;
        } else {
            proposals[_proposalId].noVotes++;
        }
        
        emit VoteCast(_proposalId, msg.sender, _support);
    }
    
    /**
     * @dev Core Function 3: Execute a proposal if it passes
     * @param _proposalId The ID of the proposal to execute
     */
    function executeProposal(uint256 _proposalId) 
        external 
        proposalExists(_proposalId) 
        notExecuted(_proposalId) 
    {
        Proposal storage proposal = proposals[_proposalId];
        
        require(block.timestamp >= proposal.deadline, "Voting period is still active");
        
        uint256 totalVotes = proposal.yesVotes + proposal.noVotes;
        uint256 requiredQuorum = (memberCount * QUORUM) / 100;
        
        require(totalVotes >= requiredQuorum, "Quorum not reached");
        require(proposal.yesVotes > proposal.noVotes, "Proposal did not pass");
        
        proposal.executed = true;
        
        emit ProposalExecuted(_proposalId);
    }
    
    /**
     * @dev Add a new member to the DAO
     * @param _member The address of the new member
     */
    function addMember(address _member) external onlyAdmin {
        require(_member != address(0), "Invalid member address");
        require(!isMember[_member], "Address is already a member");
        
        isMember[_member] = true;
        memberCount++;
        
        emit MemberAdded(_member);
    }
    
    /**
     * @dev Remove a member from the DAO
     * @param _member The address of the member to remove
     */
    function removeMember(address _member) external onlyAdmin {
        require(isMember[_member], "Address is not a member");
        require(_member != admin, "Cannot remove admin");
        
        isMember[_member] = false;
        memberCount--;
        
        emit MemberRemoved(_member);
    }
    
    /**
     * @dev Get proposal details
     * @param _proposalId The ID of the proposal
     */
    function getProposal(uint256 _proposalId) 
        external 
        view 
        proposalExists(_proposalId) 
        returns (
            uint256 id,
            string memory title,
            string memory description,
            address proposer,
            uint256 yesVotes,
            uint256 noVotes,
            uint256 deadline,
            bool executed
        ) 
    {
        Proposal storage proposal = proposals[_proposalId];
        return (
            proposal.id,
            proposal.title,
            proposal.description,
            proposal.proposer,
            proposal.yesVotes,
            proposal.noVotes,
            proposal.deadline,
            proposal.executed
        );
    }
    
    /**
     * @dev Check if a proposal has passed
     * @param _proposalId The ID of the proposal
     */
    function hasProposalPassed(uint256 _proposalId) 
        external 
        view 
        proposalExists(_proposalId) 
        returns (bool) 
    {
        Proposal storage proposal = proposals[_proposalId];
        
        if (block.timestamp < proposal.deadline) {
            return false; // Voting still active
        }
        
        uint256 totalVotes = proposal.yesVotes + proposal.noVotes;
        uint256 requiredQuorum = (memberCount * QUORUM) / 100;
        
        return totalVotes >= requiredQuorum && proposal.yesVotes > proposal.noVotes;
    }
    
    /**
     * @dev Get the current voting status of a proposal
     * @param _proposalId The ID of the proposal
     */
    function getVotingStatus(uint256 _proposalId) 
        external 
        view 
        proposalExists(_proposalId) 
        returns (
            uint256 yesVotes,
            uint256 noVotes,
            uint256 totalVotes,
            uint256 requiredQuorum,
            bool votingActive,
            bool hasPassedQuorum
        ) 
    {
        Proposal storage proposal = proposals[_proposalId];
        uint256 total = proposal.yesVotes + proposal.noVotes;
        uint256 quorum = (memberCount * QUORUM) / 100;
        
        return (
            proposal.yesVotes,
            proposal.noVotes,
            total,
            quorum,
            block.timestamp < proposal.deadline,
            total >= quorum
        );
    }
}
