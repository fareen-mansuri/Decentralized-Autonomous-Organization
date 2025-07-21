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
        mapping(address => string) voteReasons;
        uint256 discussionDeadline;
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
        uint256 joinedAt;
        uint256 contributionScore;
        bool isBlacklisted;
        string email;
        string discord;
        string twitter;
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
        address chairperson;
        uint256[] committeeProposals;
        mapping(address => bool) hasVotingRights;
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
        address[] applicants;
        mapping(address => string) applications;
        uint256 approvalCount;
        mapping(address => bool) approvals;
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
        bool isRecurring;
        uint256 recurringInterval;
        uint256 nextExecution;
    }
    
    // Struct for voting snapshots
    struct VotingSnapshot {
        uint256 blockNumber;
        mapping(address => uint256) votingPowerAtSnapshot;
        uint256 totalSupplyAtSnapshot;
        string description;
        uint256 timestamp;
    }
    
    // Struct for governance parameters
    struct GovernanceParams {
        uint256 votingPeriod;
        uint256 quorum;
        uint256 minProposalStake;
        uint256 proposalExecutionDelay;
        uint256 reputationThreshold;
        uint256 maxVotingPeriod;
        uint256 minVotingPeriod;
        uint256 vetoWindow;
    }
    
    // Struct for member achievements
    struct Achievement {
        string title;
        string description;
        uint256 reputationReward;
        bool isActive;
        mapping(address => bool) hasAchievement;
        mapping(address => uint256) achievementDate;
    }
    
    // Struct for proposal discussions
    struct Discussion {
        uint256 proposalId;
        address[] participants;
        mapping(address => string[]) comments;
        mapping(address => uint256) commentCount;
        uint256 totalComments;
        bool isActive;
    }
    
    // Struct for staking mechanism
    struct Stake {
        uint256 amount;
        uint256 stakingTime;
        uint256 lockPeriod;
        uint256 rewardRate;
        bool isActive;
        uint256 lastRewardClaim;
    }
    
    // Struct for proposal metrics
    struct ProposalMetrics {
        uint256 engagementScore;
        uint256 participationRate;
        uint256 averageVoteTime;
        uint256 discussionActivity;
        mapping(address => uint256) voteTimestamps;
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
        STRATEGIC,
        GRANT,
        CODE_UPGRADE,
        POLICY_CHANGE
    }
    
    enum BountyStatus {
        OPEN,
        ASSIGNED,
        IN_PROGRESS,
        SUBMITTED,
        COMPLETED,
        CANCELLED,
        DISPUTED
    }
    
    enum ProposalCategory {
        DEVELOPMENT,
        MARKETING,
        OPERATIONS,
        RESEARCH,
        COMMUNITY,
        INFRASTRUCTURE,
        GRANTS,
        PARTNERSHIPS
    }
    
    enum VoteOption {
        YES,
        NO,
        ABSTAIN
    }
    
    enum MembershipTier {
        BASIC,
        PREMIUM,
        PLATINUM,
        DIAMOND
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
    mapping(address => mapping(uint256 => bool)) public memberCommittees;
    
    // New mappings for additional functionality
    mapping(address => MembershipTier) public membershipTiers;
    mapping(address => Stake) public memberStakes;
    mapping(uint256 => Discussion) public proposalDiscussions;
    mapping(uint256 => Achievement) public achievements;
    mapping(uint256 => ProposalMetrics) public proposalMetrics;
    mapping(address => uint256[]) public memberAchievements;
    mapping(address => bool) public isVerifiedMember;
    mapping(address => uint256) public memberNFTCount;
    mapping(address => mapping(address => uint256)) public memberRatings;
    mapping(address => uint256) public totalRatingsReceived;
    mapping(address => uint256) public averageRating;
    mapping(uint256 => address[]) public proposalEndorsers;
    mapping(uint256 => mapping(address => bool)) public hasEndorsed;
    mapping(address => uint256) public lastProposalTime;
    mapping(address => uint256) public proposalCooldown;
    mapping(uint256 => uint256) public proposalImplementationCost;
    mapping(address => bool) public isModerator;
    mapping(address => uint256) public moderatorSince;
    mapping(uint256 => bool) public isUrgentProposal;
    mapping(address => uint256) public memberContributions;
    mapping(address => string[]) public memberBadges;
    
    uint256 public proposalCount;
    uint256 public memberCount;
    uint256 public committeeCount;
    uint256 public bountyCount;
    uint256 public treasuryProposalCount;
    uint256 public snapshotCount;
    uint256 public achievementCount;
    uint256 public totalStakedTokens;
    uint256 public discussionCount;
    
    address public admin;
    GovernanceParams public governanceParams;
    uint256 public treasury;
    uint256 public stakingRewardPool;
    uint256 public membershipFee = 0.01 ether;
    uint256 public proposalFeeCollected;
    uint256 public minimumStakeAmount = 100 * 10**18;
    uint256 public stakingAPY = 500; // 5%
    
    // Token-based governance
    mapping(address => uint256) public tokenBalance;
    uint256 public totalTokenSupply;
    string public tokenName = "DAO Token";
    string public tokenSymbol = "DAOT";
    
    // Delegation system
    mapping(address => address) public delegates;
    mapping(address => uint256) public delegatedVotes;
    mapping(address => address[]) public delegators;
    mapping(address => bool) public isDelegateActive;
    mapping(address => uint256) public delegationReward;
    
    // Emergency system
    bool public emergencyMode = false;
    uint256 public emergencyDeadline;
    address[] public emergencyCouncil;
    mapping(address => bool) public isEmergencyCouncilMember;
    uint256 public emergencyProposalCount;
    mapping(uint256 => bool) public isEmergencyProposal;
    
    // Multi-signature system for critical operations
    mapping(bytes32 => uint256) public multiSigProposals;
    mapping(bytes32 => mapping(address => bool)) public multiSigVotes;
    mapping(bytes32 => bool) public multiSigExecuted;
    uint256 public multiSigThreshold = 3;
    address[] public multiSigSigners;
    
    // Veto system
    mapping(address => bool) public hasVetoPower;
    uint256 public vetoWindow = 3 days;
    mapping(uint256 => uint256) public vetoCount;
    
    // Proposal categories and filters
    mapping(ProposalCategory => uint256) public categoryBudgets;
    mapping(ProposalCategory => uint256) public categorySpent;
    mapping(ProposalCategory => bool) public categoryActive;
    
    // Time-locked proposals
    mapping(uint256 => uint256) public proposalUnlockTime;
    
    // Quadratic voting
    mapping(uint256 => mapping(address => uint256)) public quadraticVoteCredits;
    mapping(address => uint256) public memberVoteCredits;
    
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
    
    // New events for additional functionality
    event MemberStaked(address indexed member, uint256 amount, uint256 lockPeriod);
    event StakeWithdrawn(address indexed member, uint256 amount);
    event RewardsClaimedFromStaking(address indexed member, uint256 rewards);
    event AchievementUnlocked(address indexed member, uint256 achievementId, string title);
    event MembershipTierUpgraded(address indexed member, MembershipTier newTier);
    event ProposalEndorsed(uint256 indexed proposalId, address indexed endorser);
    event MemberRated(address indexed rater, address indexed rated, uint256 rating);
    event MemberVerified(address indexed member, address indexed verifier);
    event ProposalDiscussionStarted(uint256 indexed proposalId);
    event CommentAdded(uint256 indexed proposalId, address indexed commenter);
    event ModeratorAdded(address indexed moderator);
    event ModeratorRemoved(address indexed moderator);
    event UrgentProposalCreated(uint256 indexed proposalId);
    event BadgeAwarded(address indexed member, string badge);
    event QuadraticVoteCast(uint256 indexed proposalId, address indexed voter, uint256 credits, uint256 votes);
    
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
        require(isMember[msg.sender] && memberProfiles[msg.sender].isActive && !memberProfiles[msg.sender].isBlacklisted, "Only active, non-blacklisted members can perform this action");
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
    
    modifier onlyModerator() {
        require(isModerator[msg.sender] || msg.sender == admin, "Only moderators can perform this action");
        _;
    }
    
    modifier onlyVerifiedMember() {
        require(isVerifiedMember[msg.sender], "Only verified members can perform this action");
        _;
    }
    
    modifier respectsProposalCooldown() {
        require(block.timestamp >= lastProposalTime[msg.sender] + proposalCooldown[msg.sender], "Proposal cooldown period not met");
        _;
    }
    
    modifier notBlacklisted() {
        require(!memberProfiles[msg.sender].isBlacklisted, "Member is blacklisted");
        _;
    }
    
    // Constructor
    constructor() {
        admin = msg.sender;
        isMember[msg.sender] = true;
        memberSince[msg.sender] = block.timestamp;
        votingPower[msg.sender] = 100;
        tokenBalance[msg.sender] = 1000 * 10**18;
        totalTokenSupply = 1000 * 10**18;
        memberCount = 1;
        memberReputation[msg.sender] = 500;
        membershipTiers[msg.sender] = MembershipTier.DIAMOND;
        isVerifiedMember[msg.sender] = true;
        isModerator[msg.sender] = true;
        moderatorSince[msg.sender] = block.timestamp;
        memberVoteCredits[msg.sender] = 100;
        
        // Initialize governance parameters
        governanceParams = GovernanceParams({
            votingPeriod: 7 days,
            quorum: 51,
            minProposalStake: 0.1 ether,
            proposalExecutionDelay: 2 days,
            reputationThreshold: 100,
            maxVotingPeriod: 30 days,
            minVotingPeriod: 1 days,
            vetoWindow: 3 days
        });
        
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
            interests: new string[](0),
            joinedAt: block.timestamp,
            contributionScore: 100,
            isBlacklisted: false,
            email: "",
            discord: "",
            twitter: ""
        });
        
        // Add admin to emergency council
        emergencyCouncil.push(msg.sender);
        isEmergencyCouncilMember[msg.sender] = true;
        hasVetoPower[msg.sender] = true;
        multiSigSigners.push(msg.sender);
        
        // Initialize category budgets
        categoryBudgets[ProposalCategory.DEVELOPMENT] = 10 ether;
        categoryBudgets[ProposalCategory.MARKETING] = 5 ether;
        categoryBudgets[ProposalCategory.OPERATIONS] = 3 ether;
        categoryBudgets[ProposalCategory.RESEARCH] = 7 ether;
        categoryBudgets[ProposalCategory.COMMUNITY] = 2 ether;
        categoryBudgets[ProposalCategory.INFRASTRUCTURE] = 8 ether;
        categoryBudgets[ProposalCategory.GRANTS] = 15 ether;
        categoryBudgets[ProposalCategory.PARTNERSHIPS] = 5 ether;
        
        // Set all categories as active
        for (uint256 i = 0; i < 8; i++) {
            categoryActive[ProposalCategory(i)] = true;
        }
        
        // Initialize some achievements
        _createAchievement("First Proposal", "Created your first proposal", 25);
        _createAchievement("Active Voter", "Participated in 10 votes", 50);
        _createAchievement("Proposal Master", "Had 5 proposals approved", 100);
        _createAchievement("Community Builder", "Helped onboard 10 new members", 75);
    }
    
    // Receive function for treasury deposits
    receive() external payable {
        treasury += msg.value;
        stakingRewardPool += msg.value / 10; // 10% goes to staking rewards
        emit TreasuryDeposit(msg.sender, msg.value);
    }
    
    /**
     * @dev Join the DAO as a new member
     */
    function joinDAO(
        string memory _name,
        string memory _bio,
        string[] memory _skills,
        string[] memory _interests,
        string memory _email
    ) external payable {
        require(!isMember[msg.sender], "Already a member");
        require(msg.value >= membershipFee, "Insufficient membership fee");
        require(bytes(_name).length > 0, "Name required");
        
        isMember[msg.sender] = true;
        memberSince[msg.sender] = block.timestamp;
        votingPower[msg.sender] = 10; // Base voting power
        memberCount++;
        memberReputation[msg.sender] = 50; // Starting reputation
        membershipTiers[msg.sender] = MembershipTier.BASIC;
        memberVoteCredits[msg.sender] = 20; // Initial vote credits
        proposalCooldown[msg.sender] = 1 days; // Initial cooldown
        
        memberProfiles[msg.sender] = MemberProfile({
            name: _name,
            bio: _bio,
            avatarHash: "",
            reputation: 50,
            proposalsCreated: 0,
            votesParticipated: 0,
            isActive: true,
            lastActivity: block.timestamp,
            skills: _skills,
            interests: _interests,
            joinedAt: block.timestamp,
            contributionScore: 0,
            isBlacklisted: false,
            email: _email,
            discord: "",
            twitter: ""
        });
        
        treasury += msg.value;
        
        emit MemberAdded(msg.sender, votingPower[msg.sender]);
    }
    
    /**
     * @dev Stake tokens to earn rewards and increase voting power
     */
    function stakeTokens(uint256 _amount, uint256 _lockPeriod) external onlyActiveMember {
        require(_amount >= minimumStakeAmount, "Amount below minimum stake");
        require(tokenBalance[msg.sender] >= _amount, "Insufficient token balance");
        require(_lockPeriod >= 30 days && _lockPeriod <= 365 days, "Invalid lock period");
        
        // Transfer tokens to stake
        tokenBalance[msg.sender] -= _amount;
        totalStakedTokens += _amount;
        
        // Calculate reward rate based on lock period
        uint256 rewardMultiplier = _lockPeriod / 30 days; // Bonus for longer lock
        uint256 rewardRate = stakingAPY + (rewardMultiplier * 50); // Extra 0.5% per month
        
        memberStakes[msg.sender] = Stake({
            amount: _amount,
            stakingTime: block.timestamp,
            lockPeriod: _lockPeriod,
            rewardRate: rewardRate,
            isActive: true,
            lastRewardClaim: block.timestamp
        });
        
        // Increase voting power based on staked amount
        votingPower[msg.sender] += _amount / (10**18); // 1 token = 1 voting power
        
        emit MemberStaked(msg.sender, _amount, _lockPeriod);
        emit VotingPowerChanged(msg.sender, votingPower[msg.sender]);
    }
    
    /**
     * @dev Claim staking rewards
     */
    function claimStakingRewards() external onlyActiveMember {
        Stake storage stake = memberStakes[msg.sender];
        require(stake.isActive, "No active stake");
        
        uint256 timeSinceLastClaim = block.timestamp - stake.lastRewardClaim;
        uint256 rewards = (stake.amount * stake.rewardRate * timeSinceLastClaim) / (365 days * 10000);
        
        require(stakingRewardPool >= rewards, "Insufficient reward pool");
        
        stakingRewardPool -= rewards;
        tokenBalance[msg.sender] += rewards;
        totalTokenSupply += rewards;
        stake.lastRewardClaim = block.timestamp;
        
        // Increase reputation for long-term staking
        if (timeSinceLastClaim >= 30 days) {
            memberReputation[msg.sender] += 10;
            emit ReputationUpdated(msg.sender, memberReputation[msg.sender]);
        }
        
        emit RewardsClaimedFromStaking(msg.sender, rewards);
        emit TokensIssued(msg.sender, rewards);
    }
    
    /**
     * @dev Withdraw staked tokens (after lock period)
     */
    function withdrawStake() external onlyActiveMember {
        Stake storage stake = memberStakes[msg.sender];
        require(stake.isActive, "No active stake");
        require(block.timestamp >= stake.stakingTime + stake.lockPeriod, "Stake still locked");
        
        uint256 stakeAmount = stake.amount;
        
        // Return staked tokens
        tokenBalance[msg.sender] += stakeAmount;
        totalStakedTokens -= stakeAmount;
        
        // Reduce voting power
        votingPower[msg.sender] -= stakeAmount / (10**18);
        
        // Deactivate stake
        stake.isActive = false;
        
        emit StakeWithdrawn(msg.sender, stakeAmount);
        emit VotingPowerChanged(msg.sender, votingPower[msg.sender]);
    }
    
    /**
     * @dev Create achievement
     */
    function _createAchievement(string memory _title, string memory _description, uint256 _reputationReward) internal {
        uint256 achievementId = achievementCount++;
        Achievement storage achievement = achievements[achievementId];
        achievement.title = _title;
        achievement.description = _description;
        achievement.reputationReward = _reputationReward;
        achievement.isActive = true;
    }
    
    /**
     * @dev Award achievement to member
     */
    function awardAchievement(address _member, uint256 _achievementId) external onlyModerator {
        require(_achievementId < achievementCount, "Achievement does not exist");
        require(isMember[_member], "Not a member");
        require(achievements[_achievementId].isActive, "Achievement not active");
        require(!achievements[_achievementId].hasAchievement[_member], "Achievement already awarded");
        
        Achievement storage achievement = achievements[_achievementId];
        achievement.hasAchievement[_member] = true;
        achievement.achievementDate[_member] = block.timestamp;
        
        memberAchievements[_member].push(_achievementId);
        memberReputation[_member] += achievement.reputationReward;
        memberProfiles[_member].contributionScore += achievement.reputationReward / 5;
        
        emit AchievementUnlocked(_member, _achievementId, achievement.title);
        emit ReputationUpdated(_member, memberReputation[_member]);
    }
    
    /**
     * @dev Rate another member
     */
    function rateMember(address _member, uint256 _rating) external onlyActiveMember {
        require(isMember[_member], "Member does not exist");
        require(_member != msg.sender, "Cannot rate yourself");
        require(_rating >= 1 && _rating <= 5, "Rating must be between 1 and 5");
        require(memberRatings[msg.sender][_member] == 0, "Already rated this member");
        
        memberRatings[msg.sender][_member] = _rating;
        totalRatingsReceived[_member]++;
        
        // Recalculate average rating
        uint256 totalRating = 0;
        uint256 ratingCount = 0;
        
        for (uint256 i = 0; i < memberCount; i++) {
            // This is simplified - in production you'd iterate through actual raters
            if (memberRatings[msg.sender][_member] > 0) {
                totalRating += memberRatings[msg.sender][_member];
                ratingCount++;
            }
        }
        
        if (ratingCount > 0) {
            averageRating[_member] = totalRating / ratingCount;
        }
        
        emit MemberRated(msg.sender, _member, _rating);
    }
    
    /**
     * @dev Verify a member (only by existing verified members)
     */
    function verifyMember(address _member) external onlyVerifiedMember {
        require(isMember[_member], "Member does not exist");
        require(!isVerifiedMember[_member], "Member already verified");
        require(memberReputation[_member] >= 200, "Member needs more reputation");
        
        isVerifiedMember[_member] = true;
        memberReputation[_member] += 100; // Bonus for verification
        memberVoteCredits[_member] += 50; // Bonus vote credits
        
        emit MemberVerified(_member, msg.sender);
        emit ReputationUpdated(_member, memberReputation[_member]);
    }
    
    /**
     * @dev Endorse a proposal
     */
    function endorseProposal(uint256 _proposalId) external onlyVerifiedMember proposalExists(_proposalId) votingActive(_proposalId) {
        require(!hasEndorsed[_proposalId][msg.sender], "Already endorsed this proposal");
        
        hasEndorsed[_proposalId][msg.sender] = true;
        proposalEndorsers[_proposalId].push(msg.sender);
        
        // Endorsements can influence proposal visibility and priority
        proposalMetrics[_proposalId].engagementScore += 10;
        
        emit ProposalEndorsed(_proposalId, msg.sender);
    }
    
    /**
     * @dev Start discussion for a proposal
     */
    function startProposalDisc
