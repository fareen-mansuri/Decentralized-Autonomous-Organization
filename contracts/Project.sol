 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title Enhanced DAO - Decentralized Autonomous Organization
 * @dev A comprehensive smart contract for managing proposals, voting, governance with advanced features
 */
contract EnhancedDAO {
    // Struct to represent a proposal
    struct Proposal {
        uint256 id;
        string title;
        string description;
        address proposer;
        uint256 yesVotes;
        uint256 noVotes;
        uint256 abstainVotes;
        uint256 deadline;
        bool executed;
        bool exists;
        ProposalType proposalType;
        address targetAddress;
        uint256 value;
        bytes data;
        uint256 minQuorum;
        uint256 creationTime;
        string[] tags;
        uint256 executionDelay;
        bool vetoed;
        address vetoer;
    }
    
    // Struct for member profile
    struct MemberProfile {
        string name;
        string bio;
        string avatarHash; // IPFS hash
        uint256 reputation;
        uint256 proposalsCreated;
        uint256 votesParticipated;
        bool isActive;
        uint256 lastActivity;
        string[] skills;
        string[] interests;
    }
    
    // Struct for committees
    struct Committee {
        string name;
        string description;
        address[] members;
        mapping(address => bool) isMember;
        uint256 createdAt;
        bool isActive;
        string purpose;
        uint256 budget;
        uint256 spentBudget;
    }
    
    // Struct for bounties
    struct Bounty {
        uint256 id;
        string title;
        string description;
        uint256 reward;
        address creator;
        address assignee;
        uint256 deadline;
        bool completed;
        bool paid;
        string[] skills;
        BountyStatus status;
        string[] deliverables;
        uint256 createdAt;
    }
    
    // Struct for treasury proposals
    struct TreasuryProposal {
        uint256 id;
        address recipient;
        uint256 amount;
        string reason;
        uint256 votes;
        mapping(address => bool) hasVoted;
        bool executed;
        uint256 deadline;
        ProposalCategory category;
    }
    
    // Struct for voting snapshots
    struct VotingSnapshot {
        uint256 blockNumber;
        mapping(address => uint256) votingPowerAtSnapshot;
        uint256 totalSupplyAtSnapshot;
    }
    
    // Enums
    enum ProposalType {
        GENERAL,
        TREASURY,
        MEMBERSHIP,
        PARAMETER_CHANGE,
        COMMITTEE_CREATION,
        BOUNTY_CREATION,
        GOVERNANCE_UPGRADE,
        PARTNERSHIP,
        STRATEGIC
    }
    
    enum BountyStatus {
        OPEN,
        ASSIGNED,
        IN_PROGRESS,
        SUBMITTED,
        COMPLETED,
        CANCELLED
    }
    
    enum ProposalCategory {
        DEVELOPMENT,
        MARKETING,
        OPERATIONS,
        RESEARCH,
        COMMUNITY,
        INFRASTRUCTURE
    }
    
    enum VoteOption {
        YES,
        NO,
        ABSTAIN
    }
    
    // State variables
    mapping(uint256 => Proposal) public proposals;
    mapping(uint256 => mapping(address => bool)) public hasVoted;
    mapping(uint256 => mapping(address => VoteOption)) public memberVote;
    mapping(address => bool) public isMember;
    mapping(address => uint256) public memberSince;
    mapping(address => uint256) public votingPower;
    mapping(address => MemberProfile) public memberProfiles;
    mapping(uint256 => Committee) public committees;
    mapping(uint256 => Bounty) public bounties;
    mapping(uint256 => TreasuryProposal) public treasuryProposals;
    mapping(uint256 => VotingSnapshot) public votingSnapshots;
    mapping(address => uint256[]) public memberProposals;
    mapping(string => uint256[]) public proposalsByTag;
    mapping(address => uint256) public memberReputation;
    mapping(address => mapping(uint256 => bool)) public memberCommittees; // member => committeeId => isMember
    
    uint256 public proposalCount;
    uint256 public memberCount;
    uint256 public committeeCount;
    uint256 public bountyCount;
    uint256 public treasuryProposalCount;
    uint256 public snapshotCount;
    
    address public admin;
    uint256 public votingPeriod = 7 days;
    uint256 public quorum = 51; // 51% quorum required
    uint256 public minProposalStake = 0.1 ether;
    uint256 public treasury;
    uint256 public proposalExecutionDelay = 2 days;
    uint256 public maxVotingPeriod = 30 days;
    uint256 public minVotingPeriod = 1 days;
    uint256 public reputationThreshold = 100; // Minimum reputation to create proposals
    
    // Token-based governance
    mapping(address => uint256) public tokenBalance;
    uint256 public totalTokenSupply;
    string public tokenName = "DAO Token";
    string public tokenSymbol = "DAOT";
    
    // Delegation system
    mapping(address => address) public delegates;
    mapping(address => uint256) public delegatedVotes;
    mapping(address => address[]) public delegators;
    
    // Emergency system
    bool public emergencyMode = false;
    uint256 public emergencyDeadline;
    address[] public emergencyCouncil;
    mapping(address => bool) public isEmergencyCouncilMember;
    
    // Multi-signature system for critical operations
    mapping(bytes32 => uint256) public multiSigProposals;
    mapping(bytes32 => mapping(address => bool)) public multiSigVotes;
    mapping(bytes32 => bool) public multiSigExecuted;
    uint256 public multiSigThreshold = 3;
    
    // Veto system
    mapping(address => bool) public hasVetoPower;
    uint256 public vetoWindow = 3 days;
    
    // Proposal categories and filters
    mapping(ProposalCategory => uint256) public categoryBudgets;
    mapping(ProposalCategory => uint256) public categorySpent;
    
    // Time-locked proposals
    mapping(uint256 => uint256) public proposalUnlockTime;
    
    // Events
    event ProposalCreated(uint256 indexed proposalId, string title, address indexed proposer, ProposalType proposalType);
    event VoteCast(uint256 indexed proposalId, address indexed voter, VoteOption vote, uint256 votingPower);
    event ProposalExecuted(uint256 indexed proposalId);
    event ProposalVetoed(uint256 indexed proposalId, address indexed vetoer);
    event MemberAdded(address indexed member, uint256 votingPower);
    event MemberRemoved(address indexed member);
    event MemberProfileUpdated(address indexed member);
    event VotingPowerChanged(address indexed member, uint256 newVotingPower);
    event Delegation(address indexed delegator, address indexed delegate);
    event DelegationRevoked(address indexed delegator, address indexed delegate);
    event TreasuryDeposit(address indexed depositor, uint256 amount);
    event TreasuryWithdrawal(address indexed recipient, uint256 amount);
    event ParameterChanged(string parameter, uint256 newValue);
    event EmergencyModeActivated(uint256 deadline);
    event EmergencyModeDeactivated();
    event CommitteeCreated(uint256 indexed committeeId, string name, address[] members);
    event CommitteeMemberAdded(uint256 indexed committeeId, address indexed member);
    event CommitteeMemberRemoved(uint256 indexed committeeId, address indexed member);
    event BountyCreated(uint256 indexed bountyId, string title, uint256 reward, address indexed creator);
    event BountyAssigned(uint256 indexed bountyId, address indexed assignee);
    event BountyCompleted(uint256 indexed bountyId, address indexed assignee);
    event BountyPaid(uint256 indexed bountyId, address indexed assignee, uint256 amount);
    event TokensIssued(address indexed recipient, uint256 amount);
    event TokensBurned(address indexed account, uint256 amount);
    event ReputationUpdated(address indexed member, uint256 newReputation);
    event SnapshotTaken(uint256 indexed snapshotId, uint256 blockNumber);
    event MultiSigProposalCreated(bytes32 indexed proposalHash, string description);
    event MultiSigVoteCast(bytes32 indexed proposalHash, address indexed signer);
    event MultiSigProposalExecuted(bytes32 indexed proposalHash);
    
    // Modifiers
    modifier onlyMember() {
        require(isMember[msg.sender], "Only members can perform this action");
        _;
    }
    
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }
    
    modifier onlyActiveMember() {
        require(isMember[msg.sender] && memberProfiles[msg.sender].isActive, "Only active members can perform this action");
        _;
    }
    
    modifier proposalExists(uint256 _proposalId) {
        require(proposals[_proposalId].exists, "Proposal does not exist");
        _;
    }
    
    modifier votingActive(uint256 _proposalId) {
        require(block.timestamp < proposals[_proposalId].deadline, "Voting period has ended");
        require(!proposals[_proposalId].vetoed, "Proposal has been vetoed");
        _;
    }
    
    modifier notExecuted(uint256 _proposalId) {
        require(!proposals[_proposalId].executed, "Proposal already executed");
        _;
    }
    
    modifier notInEmergencyMode() {
        require(!emergencyMode, "DAO is in emergency mode");
        _;
    }
    
    modifier onlyEmergencyCouncil() {
        require(isEmergencyCouncilMember[msg.sender], "Only emergency council members can perform this action");
        _;
    }
    
    modifier hasReputation(uint256 _minReputation) {
        require(memberReputation[msg.sender] >= _minReputation, "Insufficient reputation");
        _;
    }
    
    modifier onlyVetoAuthority() {
        require(hasVetoPower[msg.sender], "No veto authority");
        _;
    }
    
    modifier committeeExists(uint256 _committeeId) {
        require(_committeeId < committeeCount, "Committee does not exist");
        _;
    }
    
    modifier bountyExists(uint256 _bountyId) {
        require(_bountyId < bountyCount, "Bounty does not exist");
        _;
    }
    
    // Constructor
    constructor() {
        admin = msg.sender;
        isMember[msg.sender] = true;
        memberSince[msg.sender] = block.timestamp;
        votingPower[msg.sender] = 100;
        tokenBalance[msg.sender] = 1000 * 10**18; // Initial token supply
        totalTokenSupply = 1000 * 10**18;
        memberCount = 1;
        memberReputation[msg.sender] = 500; // Admin starts with high reputation
        
        // Initialize admin profile
        memberProfiles[msg.sender] = MemberProfile({
            name: "DAO Admin",
            bio: "Founder and administrator of the DAO",
            avatarHash: "",
            reputation: 500,
            proposalsCreated: 0,
            votesParticipated: 0,
            isActive: true,
            lastActivity: block.timestamp,
            skills: new string[](0),
            interests: new string[](0)
        });
        
        // Add admin to emergency council
        emergencyCouncil.push(msg.sender);
        isEmergencyCouncilMember[msg.sender] = true;
        hasVetoPower[msg.sender] = true;
        
        // Initialize category budgets
        categoryBudgets[ProposalCategory.DEVELOPMENT] = 10 ether;
        categoryBudgets[ProposalCategory.MARKETING] = 5 ether;
        categoryBudgets[ProposalCategory.OPERATIONS] = 3 ether;
        categoryBudgets[ProposalCategory.RESEARCH] = 7 ether;
        categoryBudgets[ProposalCategory.COMMUNITY] = 2 ether;
        categoryBudgets[ProposalCategory.INFRASTRUCTURE] = 8 ether;
    }
    
    // Receive function for treasury deposits
    receive() external payable {
        treasury += msg.value;
        emit TreasuryDeposit(msg.sender, msg.value);
    }
    
    /**
     * @dev Enhanced proposal creation with more features
     */
    function createProposal(
        string memory _title, 
        string memory _description,
        ProposalType _proposalType,
        address _targetAddress,
        uint256 _value,
        bytes memory _data,
        string[] memory _tags,
        uint256 _customQuorum,
        uint256 _customVotingPeriod
    ) 
        external 
        payable
        onlyActiveMember
        notInEmergencyMode
        hasReputation(reputationThreshold)
    {
        require(bytes(_title).length > 0, "Title cannot be empty");
        require(bytes(_description).length > 0, "Description cannot be empty");
        require(msg.value >= minProposalStake, "Insufficient proposal stake");
        require(_customVotingPeriod >= minVotingPeriod && _customVotingPeriod <= maxVotingPeriod, "Invalid voting period");
        require(_customQuorum <= 100, "Quorum cannot exceed 100%");
        
        uint256 proposalId = proposalCount++;
        uint256 deadline = block.timestamp + (_customVotingPeriod > 0 ? _customVotingPeriod : votingPeriod);
        uint256 executionDelay = (_proposalType == ProposalType.GOVERNANCE_UPGRADE) ? proposalExecutionDelay * 2 : proposalExecutionDelay;
        
        proposals[proposalId] = Proposal({
            id: proposalId,
            title: _title,
            description: _description,
            proposer: msg.sender,
            yesVotes: 0,
            noVotes: 0,
            abstainVotes: 0,
            deadline: deadline,
            executed: false,
            exists: true,
            proposalType: _proposalType,
            targetAddress: _targetAddress,
            value: _value,
            data: _data,
            minQuorum: _customQuorum > 0 ? _customQuorum : quorum,
            creationTime: block.timestamp,
            tags: _tags,
            executionDelay: executionDelay,
            vetoed: false,
            vetoer: address(0)
        });
        
        memberProposals[msg.sender].push(proposalId);
        memberProfiles[msg.sender].proposalsCreated++;
        
        // Add to tags mapping
        for (uint256 i = 0; i < _tags.length; i++) {
            proposalsByTag[_tags[i]].push(proposalId);
        }
        
        // Update member activity
        memberProfiles[msg.sender].lastActivity = block.timestamp;
        
        emit ProposalCreated(proposalId, _title, msg.sender, _proposalType);
    }
    
    /**
     * @dev Enhanced voting with more options
     */
    function vote(uint256 _proposalId, VoteOption _vote, string memory _reason) 
        external 
        onlyActiveMember
        proposalExists(_proposalId)
        votingActive(_proposalId)
        notExecuted(_proposalId)
    {
        require(!hasVoted[_proposalId][msg.sender], "Already voted on this proposal");
        
        Proposal storage proposal = proposals[_proposalId];
        uint256 voterPower = getVotingPower(msg.sender);
        
        hasVoted[_proposalId][msg.sender] = true;
        memberVote[_proposalId][msg.sender] = _vote;
        
        if (_vote == VoteOption.YES) {
            proposal.yesVotes += voterPower;
        } else if (_vote == VoteOption.NO) {
            proposal.noVotes += voterPower;
        } else {
            proposal.abstainVotes += voterPower;
        }
        
        // Update member statistics
        memberProfiles[msg.sender].votesParticipated++;
        memberProfiles[msg.sender].lastActivity = block.timestamp;
        
        // Increase reputation for participation
        memberReputation[msg.sender] += 5;
        
        emit VoteCast(_proposalId, msg.sender, _vote, voterPower);
        emit ReputationUpdated(msg.sender, memberReputation[msg.sender]);
    }
    
    /**
     * @dev Delegate voting power to another member
     */
    function delegate(address _delegate) external onlyActiveMember {
        require(_delegate != msg.sender, "Cannot delegate to yourself");
        require(isMember[_delegate], "Delegate must be a member");
        require(memberProfiles[_delegate].isActive, "Delegate must be active");
        
        address currentDelegate = delegates[msg.sender];
        if (currentDelegate != address(0)) {
            // Remove from current delegate
            delegatedVotes[currentDelegate] -= votingPower[msg.sender];
            // Remove from delegators array
            address[] storage dels = delegators[currentDelegate];
            for (uint256 i = 0; i < dels.length; i++) {
                if (dels[i] == msg.sender) {
                    dels[i] = dels[dels.length - 1];
                    dels.pop();
                    break;
                }
            }
            emit DelegationRevoked(msg.sender, currentDelegate);
        }
        
        delegates[msg.sender] = _delegate;
        delegatedVotes[_delegate] += votingPower[msg.sender];
        delegators[_delegate].push(msg.sender);
        
        emit Delegation(msg.sender, _delegate);
    }
    
    /**
     * @dev Revoke delegation
     */
    function revokeDelegation() external onlyActiveMember {
        address currentDelegate = delegates[msg.sender];
        require(currentDelegate != address(0), "No active delegation");
        
        delegates[msg.sender] = address(0);
        delegatedVotes[currentDelegate] -= votingPower[msg.sender];
        
        // Remove from delegators array
        address[] storage dels = delegators[currentDelegate];
        for (uint256 i = 0; i < dels.length; i++) {
            if (dels[i] == msg.sender) {
                dels[i] = dels[dels.length - 1];
                dels.pop();
                break;
            }
        }
        
        emit DelegationRevoked(msg.sender, currentDelegate);
    }
    
    /**
     * @dev Create a committee
     */
    function createCommittee(
        string memory _name,
        string memory _description,
        address[] memory _members,
        string memory _purpose,
        uint256 _budget
    ) external onlyAdmin {
        require(bytes(_name).length > 0, "Committee name required");
        require(_members.length > 0, "At least one member required");
        require(_budget <= treasury, "Insufficient treasury funds");
        
        uint256 committeeId = committeeCount++;
        Committee storage committee = committees[committeeId];
        committee.name = _name;
        committee.description = _description;
        committee.members = _members;
        committee.purpose = _purpose;
        committee.budget = _budget;
        committee.createdAt = block.timestamp;
        committee.isActive = true;
        committee.spentBudget = 0;
        
        // Add members to committee mapping
        for (uint256 i = 0; i < _members.length; i++) {
            committee.isMember[_members[i]] = true;
            memberCommittees[_members[i]][committeeId] = true;
        }
        
        treasury -= _budget; // Allocate budget
        
        emit CommitteeCreated(committeeId, _name, _members);
    }
    
    /**
     * @dev Create a bounty
     */
    function createBounty(
        string memory _title,
        string memory _description,
        uint256 _reward,
        uint256 _deadline,
        string[] memory _skills,
        string[] memory _deliverables
    ) external onlyActiveMember {
        require(bytes(_title).length > 0, "Bounty title required");
        require(_reward > 0, "Reward must be greater than 0");
        require(_deadline > block.timestamp, "Deadline must be in the future");
        require(treasury >= _reward, "Insufficient treasury funds");
        
        uint256 bountyId = bountyCount++;
        
        bounties[bountyId] = Bounty({
            id: bountyId,
            title: _title,
            description: _description,
            reward: _reward,
            creator: msg.sender,
            assignee: address(0),
            deadline: _deadline,
            completed: false,
            paid: false,
            skills: _skills,
            status: BountyStatus.OPEN,
            deliverables: _deliverables,
            createdAt: block.timestamp
        });
        
        treasury -= _reward; // Reserve reward
        
        emit BountyCreated(bountyId, _title, _reward, msg.sender);
    }
    
    /**
     * @dev Apply for a bounty
     */
    function applyForBounty(uint256 _bountyId, string memory _proposal) external onlyActiveMember bountyExists(_bountyId) {
        Bounty storage bounty = bounties[_bountyId];
        require(bounty.status == BountyStatus.OPEN, "Bounty not open for applications");
        require(bounty.deadline > block.timestamp, "Bounty deadline passed");
        
        // In a full implementation, you'd store applications and let creator choose
        // For simplicity, we'll auto-assign if no one is assigned
        if (bounty.assignee == address(0)) {
            bounty.assignee = msg.sender;
            bounty.status = BountyStatus.ASSIGNED;
            emit BountyAssigned(_bountyId, msg.sender);
        }
    }
    
    /**
     * @dev Complete a bounty
     */
    function completeBounty(uint256 _bountyId, string memory _deliverableHash) external bountyExists(_bountyId) {
        Bounty storage bounty = bounties[_bountyId];
        require(bounty.assignee == msg.sender, "Only assignee can complete bounty");
        require(bounty.status == BountyStatus.ASSIGNED || bounty.status == BountyStatus.IN_PROGRESS, "Invalid bounty status");
        
        bounty.completed = true;
        bounty.status = BountyStatus.SUBMITTED;
        
        emit BountyCompleted(_bountyId, msg.sender);
    }
    
    /**
     * @dev Approve bounty completion and pay reward
     */
    function approveBountyCompletion(uint256 _bountyId) external bountyExists(_bountyId) {
        Bounty storage bounty = bounties[_bountyId];
        require(bounty.creator == msg.sender, "Only creator can approve completion");
        require(bounty.status == BountyStatus.SUBMITTED, "Bounty not submitted for approval");
        require(!bounty.paid, "Bounty already paid");
        
        bounty.paid = true;
        bounty.status = BountyStatus.COMPLETED;
        
        // Pay reward
        payable(bounty.assignee).transfer(bounty.reward);
        
        // Increase reputation for completion
        memberReputation[bounty.assignee] += 50;
        
        emit BountyPaid(_bountyId, bounty.assignee, bounty.reward);
        emit ReputationUpdated(bounty.assignee, memberReputation[bounty.assignee]);
    }
    
    /**
     * @dev Update member profile
     */
    function updateProfile(
        string memory _name,
        string memory _bio,
        string memory _avatarHash,
        string[] memory _skills,
        string[] memory _interests
    ) external onlyMember {
        MemberProfile storage profile = memberProfiles[msg.sender];
        profile.name = _name;
        profile.bio = _bio;
        profile.avatarHash = _avatarHash;
        profile.skills = _skills;
        profile.interests = _interests;
        profile.lastActivity = block.timestamp;
        
        emit MemberProfileUpdated(msg.sender);
    }
    
    /**
     * @dev Take a voting power snapshot
     */
    function takeSnapshot() external onlyAdmin returns (uint256) {
        uint256 snapshotId = snapshotCount++;
        VotingSnapshot storage snapshot = votingSnapshots[snapshotId];
        snapshot.blockNumber = block.number;
        snapshot.totalSupplyAtSnapshot = totalTokenSupply;
        
        emit SnapshotTaken(snapshotId, block.number);
        return snapshotId;
    }
    
    /**
     * @dev Veto a proposal (only for authorized addresses)
     */
    function vetoProposal(uint256 _proposalId, string memory _reason) external onlyVetoAuthority proposalExists(_proposalId) notExecuted(_proposalId) {
        Proposal storage proposal = proposals[_proposalId];
        require(!proposal.vetoed, "Proposal already vetoed");
        require(block.timestamp <= proposal.deadline + vetoWindow, "Veto window expired");
        
        proposal.vetoed = true;
        proposal.vetoer = msg.sender;
        
        emit ProposalVetoed(_proposalId, msg.sender);
    }
    
    /**
     * @dev Execute proposal with enhanced checks
     */
    function executeProposal(uint256 _proposalId) 
        external 
        proposalExists(_proposalId) 
        notExecuted(_proposalId) 
    {
        Proposal storage proposal = proposals[_proposalId];
        require(block.timestamp > proposal.deadline, "Voting still active");
        require(!proposal.vetoed, "Proposal has been vetoed");
        require(block.timestamp >= proposal.deadline + proposal.executionDelay, "Execution delay not met");
        
        uint256 totalVotes = proposal.yesVotes + proposal.noVotes + proposal.abstainVotes;
        uint256 requiredQuorum = (getTotalVotingPower() * proposal.minQuorum) / 100;
        
        require(totalVotes >= requiredQuorum, "Quorum not reached");
        require(proposal.yesVotes > proposal.noVotes, "Proposal rejected");
        
        proposal.executed = true;
        
        // Execute the proposal
        if (proposal.targetAddress != address(0) && proposal.value > 0) {
            require(treasury >= proposal.value, "Insufficient treasury funds");
            treasury -= proposal.value;
            
            (bool success, ) = proposal.targetAddress.call{value: proposal.value}(proposal.data);
            require(success, "Proposal execution failed");
        }
        
        // Increase reputation for successful proposal
        memberReputation[proposal.proposer] += 25;
        
        emit ProposalExecuted(_proposalId);
        emit ReputationUpdated(proposal.proposer, memberReputation[proposal.proposer]);
    }
    
    /**
     * @dev Issue tokens to a member
     */
    function issueTokens(address _to, uint256 _amount) external onlyAdmin {
        require(_to != address(0), "Invalid recipient");
        require(_amount > 0, "Amount must be greater than 0");
        
        tokenBalance[_to] += _amount;
        totalTokenSupply += _amount;
        
        emit TokensIssued(_to, _amount);
    }
    
    /**
     * @dev Burn tokens from a member
     */
    function burnTokens(address _from, uint256 _amount) external onlyAdmin {
        require(_from != address(0), "Invalid address");
        require(tokenBalance[_from] >= _amount, "Insufficient balance");
        
        tokenBalance[_from] -= _amount;
        totalTokenSupply -= _amount;
        
        emit TokensBurned(_from, _amount);
    }
    
    // View functions
    function getVotingPower(address _member) public view returns (uint256) {
        return votingPower[_member] + delegatedVotes[_member];
    }
    
    function getTotalVotingPower() public view returns (uint256) {
        return totalTokenSupply;
    }
    
    function getProposalsByTag(string memory _tag) external view returns (uint256[] memory) {
        return proposalsByTag[_tag];
    }
    
    function getMemberProposals(address _member) external view returns (uint256[] memory) {
        return memberProposals[_member];
    }
    
    function getDelegators(address _delegate) external view returns (address[] memory) {
        return delegators[_delegate];
    }
    
    function getCommitteeMembers(uint256 _committeeId) external view committeeExists(_committeeId) returns (address[] memory) {
        return committees[_committeeId].members;
    }
    
    function getProposalDetails(uint256 _proposalId) external view proposalExists(_proposalId) returns (
        Proposal memory proposal,
        uint256 totalVotes,
        uint256 requiredQuorum,
        bool canExecute
    ) {
        proposal = proposals[_proposalId];
        totalVotes = proposal.yesVotes + proposal.noVotes + proposal.abstainVotes;
        requiredQuorum = (getTotalVotingPower() * proposal.minQuorum) / 100;
        
        canExecute = !proposal.executed && 
                    !proposal.vetoed && 
                    block.timestamp > proposal.deadline &&
                    block.timestamp >= proposal.deadline + proposal.executionDelay &&
                    totalVotes >= requiredQuorum && 
                    proposal.yesVotes > proposal.noVotes;
    }
    
    function getMemberStats(address _member) external view returns (
        uint256 reputation,
        uint256 proposalsCreated,
        uint256 votesParticipated,
        uint256 tokens,
        uint256 votingPowerTotal,
        bool isActive
    ) {
        MemberProfile memory profile = memberProfiles[_member];
        return (
            memberReputation[_member],
            profile.proposalsCreated,
            profile.votesParticipated,
            tokenBalance[_member],
            getVotingPower(_member),
            profile.isActive                          ^
