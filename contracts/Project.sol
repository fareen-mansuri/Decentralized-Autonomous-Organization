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
        uint256 fundingGoal;
        uint256 currentFunding;
        bool isFundingGoalMet;
        mapping(address => uint256) fundingContributions;
        uint256 priorityScore;
        bool requiresKYC;
        uint256 minimumParticipation;
        // New proposal fields
        uint256 sentimentScore;
        mapping(address => uint256) memberEngagement;
        bool requiresAudit;
        address auditor;
        bool auditPassed;
        uint256 estimatedImpact;
        string[] dependencies;
        uint256 carbonFootprint;
        bool isUrgent;
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
        uint256 referralsCount;
        address referredBy;
        uint256 totalEarnings;
        bool isPremiumMember;
        uint256 premiumMembershipExpiry;
        string[] certifications;
        uint256 activityStreak;
        uint256 lastStreakUpdate;
        mapping(string => uint256) skillEndorsements;
        uint256 mentorshipScore;
        // New member fields
        uint256 innovationIndex;
        mapping(string => uint256) badgeCount;
        uint256 communityRanking;
        uint256 collaborationScore;
        bool isInfluencer;
        uint256 followerCount;
        string[] achievements;
        uint256 learningCredits;
        mapping(address => bool) trustedConnections;
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
        uint256 performanceScore;
        uint256 lastReviewDate;
        mapping(address => uint256) memberContributions;
        bool requiresElection;
        uint256 termLength;
        uint256 termEndDate;
        // New committee fields
        uint256 efficiency;
        mapping(string => uint256) specializations;
        bool isPublic;
        uint256 maxMembers;
        string[] workingGroups;
        mapping(address => uint256) memberRatings;
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
        uint256 milestoneCount;
        mapping(uint256 => Milestone) milestones;
        uint256 escrowAmount;
        bool isRecurring;
        uint256 recurrenceInterval;
        uint256 difficultyLevel;
        mapping(address => uint256) bidAmounts;
        bool allowsBidding;
        // New bounty fields
        uint256 qualityScore;
        mapping(address => uint256) workerPerformance;
        bool requiresTeam;
        uint256 maxTeamSize;
        address[] team;
        uint256 urgencyLevel;
        string[] mentorshipOffered;
    }
    
    // New struct for NFT rewards and achievements
    struct NFTReward {
        uint256 tokenId;
        string name;
        string description;
        string metadataURI;
        address recipient;
        uint256 mintedAt;
        AchievementType achievementType;
        uint256 rarity; // 1-5 scale
        bool isTransferable;
        uint256 bonusReputation;
        mapping(address => bool) hasApproved; // For rare NFTs requiring approval
    }
    
    // Struct for DAO events and activities
    struct DAOEvent {
        uint256 id;
        string title;
        string description;
        uint256 startTime;
        uint256 endTime;
        address organizer;
        string location; // Can be virtual
        uint256 maxAttendees;
        uint256 currentAttendees;
        mapping(address => bool) attendees;
        EventType eventType;
        uint256 cost;
        bool requiresRSVP;
        string[] speakers;
        mapping(address => string) feedback;
        uint256 avgRating;
        bool isRecurring;
        uint256 seriesId;
    }
    
    // Struct for liquidity mining and staking
    struct StakingPool {
        uint256 id;
        string name;
        uint256 totalStaked;
        uint256 rewardRate; // per block
        uint256 lockupPeriod;
        mapping(address => uint256) userStakes;
        mapping(address => uint256) userRewards;
        mapping(address => uint256) stakeTimestamp;
        bool isActive;
        uint256 minStake;
        uint256 maxStake;
        StakeType stakeType;
        uint256 poolStartTime;
        uint256 poolEndTime;
    }
    
    // Struct for governance proposals analysis and prediction
    struct ProposalAnalytics {
        uint256 proposalId;
        uint256 predictedOutcome; // 0-100 probability of passing
        uint256 stakeholderSentiment;
        mapping(string => uint256) topicRelevance;
        uint256 economicImpact;
        uint256 riskAssessment;
        string[] similarProposals;
        mapping(address => uint256) influencerSupport;
        uint256 timeToDecision;
        bool hasControversy;
    }
    
    // Struct for cross-DAO collaboration
    struct InterDAOCollaboration {
        uint256 id;
        address[] participatingDAOs;
        string objective;
        uint256 sharedBudget;
        mapping(address => uint256) contributions;
        uint256 startTime;
        uint256 endTime;
        bool isActive;
        mapping(address => bool) hasApproved;
        string[] deliverables;
        address coordinator;
        uint256 successMetrics;
    }
    
    // Struct for governance education and onboarding
    struct EducationModule {
        uint256 id;
        string title;
        string content; // IPFS hash
        uint256 difficulty; // 1-5
        uint256 estimatedTime; // in minutes
        string[] prerequisites;
        uint256 rewardCredits;
        mapping(address => bool) completed;
        mapping(address => uint256) scores;
        address instructor;
        bool isActive;
        string[] tags;
        uint256 completionCount;
    }
    
    // Struct for proposal templates and automation
    struct ProposalTemplate {
        uint256 id;
        string name;
        string description;
        ProposalType category;
        string[] requiredFields;
        uint256 defaultVotingPeriod;
        uint256 defaultQuorum;
        bool requiresDeposit;
        uint256 depositAmount;
        address creator;
        uint256 usageCount;
        bool isPublic;
        mapping(address => bool) canUse;
    }
    
    // Enhanced enums
    enum AchievementType {
        FIRST_PROPOSAL,
        ACTIVE_VOTER,
        COMMITTEE_LEADER,
        BOUNTY_HUNTER,
        MENTOR,
        INNOVATOR,
        COMMUNITY_BUILDER,
        LONG_TIME_MEMBER,
        HIGH_REPUTATION,
        EDUCATOR,
        COLLABORATOR,
        EARLY_ADOPTER
    }
    
    enum EventType {
        GOVERNANCE_MEETING,
        EDUCATIONAL_WORKSHOP,
        NETWORKING,
        HACKATHON,
        CONFERENCE,
        SOCIAL,
        STRATEGIC_PLANNING,
        ONBOARDING,
        VOTING_SESSION,
        CELEBRATION
    }
    
    enum StakeType {
        GOVERNANCE,
        LIQUIDITY_PROVISION,
        VALIDATOR,
        INSURANCE,
        DEVELOPMENT_FUND,
        MARKETING_FUND,
        EMERGENCY_FUND
    }
    
    // Existing enums (keeping all previous ones)
    enum DisputeCategory {
        CONTRACT_BREACH,
        GOVERNANCE_VIOLATION,
        MISCONDUCT,
        BOUNTY_DISPUTE,
        PARTNERSHIP_ISSUE,
        TECHNICAL_DISPUTE
    }
    
    enum MemberRole {
        BASIC_MEMBER,
        COMMITTEE_MEMBER,
        MODERATOR,
        ADMIN,
        EMERGENCY_COUNCIL,
        ARBITRATOR,
        MENTOR,
        AMBASSADOR
    }
    
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
        POLICY_CHANGE,
        CROSS_CHAIN,
        AUTOMATED_ACTION,
        DISPUTE_RESOLUTION
    }
    
    enum BountyStatus {
        OPEN,
        ASSIGNED,
        IN_PROGRESS,
        SUBMITTED,
        COMPLETED,
        CANCELLED,
        DISPUTED,
        MILESTONE_PENDING,
        ESCROW_RELEASED
    }
    
    enum ProposalCategory {
        DEVELOPMENT,
        MARKETING,
        OPERATIONS,
        RESEARCH,
        COMMUNITY,
        INFRASTRUCTURE,
        GRANTS,
        PARTNERSHIPS,
        EDUCATION,
        LEGAL_COMPLIANCE,
        TREASURY_MANAGEMENT,
        CROSS_CHAIN_OPERATIONS
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
        DIAMOND,
        FOUNDER,
        LIFETIME
    }
    
    // State variables for new functionality
    mapping(uint256 => NFTReward) public nftRewards;
    mapping(uint256 => DAOEvent) public daoEvents;
    mapping(uint256 => StakingPool) public stakingPools;
    mapping(uint256 => ProposalAnalytics) public proposalAnalytics;
    mapping(uint256 => InterDAOCollaboration) public interDAOCollaborations;
    mapping(uint256 => EducationModule) public educationModules;
    mapping(uint256 => ProposalTemplate) public proposalTemplates;
    
    mapping(address => uint256[]) public memberNFTs;
    mapping(address => uint256) public memberLearningCredits;
    mapping(address => uint256[]) public memberEducationCompleted;
    mapping(address => mapping(uint256 => uint256)) public stakingRewards;
    mapping(address => uint256) public totalStakedByMember;
    mapping(string => uint256) public skillMarketDemand;
    mapping(address => bool) public isInfluencer;
    mapping(address => uint256) public influencerFollowers;
    mapping(address => string[]) public memberBadges;
    mapping(uint256 => address[]) public eventAttendees;
    mapping(address => uint256) public memberEventCount;
    mapping(address => mapping(string => uint256)) public skillCertifications;
    
    // New counters
    uint256 public nftRewardCount;
    uint256 public daoEventCount;
    uint256 public stakingPoolCount;
    uint256 public interDAOCollaborationCount;
    uint256 public educationModuleCount;
    uint256 public proposalTemplateCount;
    
    // Enhanced governance parameters
    struct GovernanceParams {
        uint256 votingPeriod;
        uint256 quorum;
        uint256 minProposalStake;
        uint256 proposalExecutionDelay;
        uint256 reputationThreshold;
        uint256 maxVotingPeriod;
        uint256 minVotingPeriod;
        uint256 vetoWindow;
        // New parameters
        uint256 nftRewardThreshold;
        uint256 stakingRewardRate;
        uint256 learningCreditRate;
        uint256 influencerThreshold;
        uint256 collaborationBonus;
        uint256 innovationIncentive;
        uint256 sustainabilityWeight;
        uint256 diversityBonus;
    }
    
    // Events for new functionality
    event NFTRewardMinted(uint256 indexed tokenId, address indexed recipient, AchievementType achievementType);
    event DAOEventCreated(uint256 indexed eventId, address indexed organizer, string title);
    event EventAttendanceMarked(uint256 indexed eventId, address indexed attendee);
    event StakingPoolCreated(uint256 indexed poolId, string name, uint256 rewardRate);
    event TokensStaked(address indexed user, uint256 indexed poolId, uint256 amount);
    event RewardsClaimed(address indexed user, uint256 indexed poolId, uint256 amount);
    event EducationModuleCompleted(address indexed member, uint256 indexed moduleId, uint256 score);
    event SkillCertified(address indexed member, string skill, uint256 level);
    event InterDAOCollaborationStarted(uint256 indexed collaborationId, address[] participatingDAOs);
    event ProposalTemplateCreated(uint256 indexed templateId, string name, address creator);
    event BadgeAwarded(address indexed member, string badge);
    event LearningCreditsEarned(address indexed member, uint256 credits);
    event InfluencerStatusChanged(address indexed member, bool isInfluencer);
    event ProposalAnalyticsUpdated(uint256 indexed proposalId, uint256 predictedOutcome);
    
    // Existing state variables and mappings (keep all previous ones)
    mapping(uint256 => Proposal) public proposals;
    mapping(uint256 => mapping(address => bool)) public hasVoted;
    mapping(uint256 => mapping(address => VoteOption)) public memberVote;
    mapping(address => bool) public isMember;
    mapping(address => uint256) public memberSince;
    mapping(address => uint256) public votingPower;
    mapping(address => MemberProfile) public memberProfiles;
    mapping(address => uint256) public memberReputation;
    mapping(address => MembershipTier) public membershipTiers;
    mapping(address => bool) public isVerifiedMember;
    mapping(address => bool) public isModerator;
    mapping(address => uint256) public moderatorSince;
    mapping(address => uint256) public memberVoteCredits;
    
    uint256 public proposalCount;
    uint256 public memberCount;
    uint256 public treasury;
    address public admin;
    GovernanceParams public governanceParams;
    
    // Modifiers for new functionality
    modifier hasLearningCredits(uint256 _requiredCredits) {
        require(memberLearningCredits[msg.sender] >= _requiredCredits, "Insufficient learning credits");
        _;
    }
    
    modifier onlyInfluencer() {
        require(isInfluencer[msg.sender], "Only influencers can perform this action");
        _;
    }
    
    modifier eventExists(uint256 _eventId) {
        require(_eventId < daoEventCount, "Event does not exist");
        _;
    }
    
    modifier stakingPoolExists(uint256 _poolId) {
        require(_poolId < stakingPoolCount, "Staking pool does not exist");
        _;
    }
    
    // Keep existing modifiers
    modifier onlyMember() {
        require(isMember[msg.sender], "Only members can perform this action");
        _;
    }
    
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }
    
    modifier onlyModerator() {
        require(isModerator[msg.sender], "Only moderators can perform this action");
        _;
    }
    
    modifier hasReputation(uint256 _minReputation) {
        require(memberReputation[msg.sender] >= _minReputation, "Insufficient reputation");
        _;
    }
    
    modifier onlyActiveMember() {
        require(isMember[msg.sender] && memberProfiles[msg.sender].isActive, "Only active members allowed");
        _;
    }
    
    modifier onlyVerifiedMember() {
        require(isVerifiedMember[msg.sender], "Only verified members allowed");
        _;
    }
    
    modifier proposalExists(uint256 _proposalId) {
        require(proposals[_proposalId].exists, "Proposal does not exist");
        _;
    }
    
    // Constructor (enhanced with new features)
    constructor() {
        admin = msg.sender;
        isMember[msg.sender] = true;
        memberSince[msg.sender] = block.timestamp;
        votingPower[msg.sender] = 100;
        memberCount = 1;
        memberReputation[msg.sender] = 1000;
        membershipTiers[msg.sender] = MembershipTier.FOUNDER;
        isVerifiedMember[msg.sender] = true;
        isModerator[msg.sender] = true;
        moderatorSince[msg.sender] = block.timestamp;
        memberVoteCredits[msg.sender] = 100;
        memberLearningCredits[msg.sender] = 100;
        isInfluencer[msg.sender] = true;
        influencerFollowers[msg.sender] = 1000;
        
        // Initialize governance parameters with new fields
        governanceParams = GovernanceParams({
            votingPeriod: 7 days,
            quorum: 51,
            minProposalStake: 0.1 ether,
            proposalExecutionDelay: 2 days,
            reputationThreshold: 100,
            maxVotingPeriod: 30 days,
            minVotingPeriod: 1 days,
            vetoWindow: 3 days,
            nftRewardThreshold: 500,
            stakingRewardRate: 100, // 1% per day
            learningCreditRate: 10,
            influencerThreshold: 500,
            collaborationBonus: 50,
            innovationIncentive: 100,
            sustainabilityWeight: 25,
            diversityBonus: 30
        });
        
        // Create initial education modules
        _createEducationModule(
            "DAO Governance Fundamentals",
            "QmEducationContent1",
            1,
            30,
            new string[](0),
            25
        );
        
        // Create initial staking pool
        _createStakingPool(
            "Governance Staking",
            100, // 1% reward rate
            30 days,
            0.1 ether,
            10 ether,
            StakeType.GOVERNANCE
        );
        
        // Award founder NFT
        _mintNFTReward(msg.sender, AchievementType.EARLY_ADOPTER, 5);
    }
    
    /**
     * @dev Create a new DAO event
     */
    function createDAOEvent(
        string memory _title,
        string memory _description,
        uint256 _startTime,
        uint256 _endTime,
        string memory _location,
        uint256 _maxAttendees,
        EventType _eventType,
        uint256 _cost,
        bool _requiresRSVP,
        string[] memory _speakers
    ) external onlyMember hasReputation(100) {
        require(_startTime > block.timestamp, "Event must be in the future");
        require(_endTime > _startTime, "End time must be after start time");
        
        uint256 eventId = daoEventCount++;
        DAOEvent storage newEvent = daoEvents[eventId];
        newEvent.id = eventId;
        newEvent.title = _title;
        newEvent.description = _description;
        newEvent.startTime = _startTime;
        newEvent.endTime = _endTime;
        newEvent.organizer = msg.sender;
        newEvent.location = _location;
        newEvent.maxAttendees = _maxAttendees;
        newEvent.eventType = _eventType;
        newEvent.cost = _cost;
        newEvent.requiresRSVP = _requiresRSVP;
        newEvent.speakers = _speakers;
        
        // Award reputation bonus for organizing events
        memberReputation[msg.sender] += 25;
        memberProfiles[msg.sender].contributionScore += 15;
        
        emit DAOEventCreated(eventId, msg.sender, _title);
    }
    
    /**
     * @dev RSVP or attend a DAO event
     */
    function attendEvent(uint256 _eventId) external payable eventExists(_eventId) onlyMember {
        DAOEvent storage eventData = daoEvents[_eventId];
        require(block.timestamp <= eventData.endTime, "Event has ended");
        require(!eventData.attendees[msg.sender], "Already registered");
        require(eventData.currentAttendees < eventData.maxAttendees, "Event is full");
        
        if (eventData.cost > 0) {
            require(msg.value >= eventData.cost, "Insufficient payment");
        }
        
        eventData.attendees[msg.sender] = true;
        eventData.currentAttendees++;
        eventAttendees[_eventId].push(msg.sender);
        memberEventCount[msg.sender]++;
        
        // Award attendance benefits
        memberReputation[msg.sender] += 5;
        memberLearningCredits[msg.sender] += 2;
        
        // Special rewards for educational events
        if (eventData.eventType == EventType.EDUCATIONAL_WORKSHOP) {
            memberLearningCredits[msg.sender] += 5;
        }
        
        emit EventAttendanceMarked(_eventId, msg.sender);
        
        // Check for community builder achievement
        if (memberEventCount[msg.sender] >= 10) {
            _mintNFTReward(msg.sender, AchievementType.COMMUNITY_BUILDER, 3);
        }
    }
    
    /**
     * @dev Create a new staking pool
     */
    function _createStakingPool(
        string memory _name,
        uint256 _rewardRate,
        uint256 _lockupPeriod,
        uint256 _minStake,
        uint256 _maxStake,
        StakeType _stakeType
    ) internal returns (uint256) {
        uint256 poolId = stakingPoolCount++;
        StakingPool storage pool = stakingPools[poolId];
        pool.id = poolId;
        pool.name = _name;
        pool.rewardRate = _rewardRate;
        pool.lockupPeriod = _lockupPeriod;
        pool.minStake = _minStake;
        pool.maxStake = _maxStake;
        pool.stakeType = _stakeType;
        pool.isActive = true;
        pool.poolStartTime = block.timestamp;
        pool.poolEndTime = block.timestamp + 365 days; // Default 1 year
        
        emit StakingPoolCreated(poolId, _name, _rewardRate);
        return poolId;
    }
    
    /**
     * @dev Stake tokens in a specific pool
     */
    function stakeTokens(uint256 _poolId, uint256 _amount) external payable stakingPoolExists(_poolId) onlyMember {
        StakingPool storage pool = stakingPools[_poolId];
        require(pool.isActive, "Pool is not active");
        require(block.timestamp >= pool.poolStartTime && block.timestamp <= pool.poolEndTime, "Pool not available");
        require(_amount >= pool.minStake, "Below minimum stake");
        require(_amount <= pool.maxStake, "Exceeds maximum stake");
        require(msg.value >= _amount, "Insufficient funds sent");
        
        // Calculate existing rewards before updating stake
        _updateStakingRewards(msg.sender, _poolId);
        
        pool.userStakes[msg.sender] += _amount;
        pool.totalStaked += _amount;
        pool.stakeTimestamp[msg.sender] = block.timestamp;
        totalStakedByMember[msg.sender] += _amount;
        
        // Reputation bonus for staking
        memberReputation[msg.sender] += _amount / 0.1 ether; // 1 reputation per 0.1 ETH
        
        emit TokensStaked(msg.sender, _poolId, _amount);
        
        // Check for validator achievement
        if (totalStakedByMember[msg.sender] >= 10 ether) {
            _mintNFTReward(msg.sender, AchievementType.HIGH_REPUTATION, 4);
        }
    }
    
    /**
     * @dev Update staking rewards for a user
     */
    function _updateStakingRewards(address _user, uint256 _poolId) internal {
        StakingPool storage pool = stakingPools[_poolId];
        if (pool.userStakes[_user] > 0) {
            uint256 stakeDuration = block.timestamp - pool.stakeTimestamp[_user];
            uint256 reward = (pool.userStakes[_user] * pool.rewardRate * stakeDuration) / (100 * 1 days);
            stakingRewards[_user][_poolId] += reward;
        }
    }
    
    /**
     * @dev Claim staking rewards
     */
    function claimStakingRewards(uint256 _poolId) external stakingPoolExists(_poolId) onlyMember {
        _updateStakingRewards(msg.sender, _poolId);
        uint256 reward = stakingRewards[msg.sender][_poolId];
        require(reward > 0, "No rewards to claim");
        
        stakingRewards[msg.sender][_poolId] = 0;
        stakingPools[_poolId].stakeTimestamp[msg.sender] = block.timestamp;
        
        // Transfer rewards (in a real implementation, this would come from a reward pool)
        payable(msg.sender).transfer(reward);
        
        emit RewardsClaimed(msg.sender, _poolId, reward);
    }
    
    /**
     * @dev Create educational module
     */
    function _createEducationModule(
        string memory _title,
        string memory _contentHash,
        uint256 _difficulty,
        uint256 _estimatedTime,
        string[] memory _prerequisites,
        uint256 _rewardCredits
    ) internal returns (uint256) {
        uint256 moduleId = educationModuleCount++;
        EducationModule storage module = educationModules[moduleId];
        module.id = moduleId;
        module.title = _title;
        module.content = _contentHash;
        module.difficulty = _difficulty;
        module.estimatedTime = _estimatedTime;
        module.prerequisites = _prerequisites;
        module.rewardCredits = _rewardCredits;
        module.instructor = msg.sender;
        module.isActive = true;
        
        return moduleId;
    }
    
    /**
     * @dev Complete an education module
     */
    function completeEducationModule(uint256 _moduleId, uint256 _score) external onlyMember {
        require(_moduleId < educationModuleCount, "Module does not exist");
        EducationModule storage module = educationModules[_moduleId];
        require(module.isActive, "Module is not active");
        require(!module.completed[msg.sender], "Module already completed");
        require(_score >= 70, "Minimum score of 70 required");
        
        // Check prerequisites
        for (uint256 i = 0; i < module.prerequisites.length; i++) {
            // In a real implementation, check if prerequisite modules are completed
        }
        
        module.completed[msg.sender] = true;
        module.scores[msg.sender] = _score;
        module.completionCount++;
        
        memberEducationCompleted[msg.sender].push(_moduleId);
        memberLearningCredits[msg.sender] += module.rewardCredits;
        
        // Bonus reputation for high scores
        if (_score >= 90) {
            memberReputation[msg.sender] += 20;
        } else if (_score >= 80) {
            memberReputation[msg.sender] += 10;
        }
        
        emit EducationModuleCompleted(msg.sender, _moduleId, _score);
        emit LearningCreditsEarned(msg.sender, module.rewardCredits);
        
        // Check for educator achievement
        if (memberEducationCompleted[msg.sender].length >= 5) {
            _mintNFTReward(msg.sender, AchievementType.EDUCATOR, 3);
        }
    }
    
    /**
     * @dev Mint NFT reward for achievements
     */
    function _mintNFTReward(address _recipient, AchievementType _achievementType, uint256 _rarity) internal {
        uint256 tokenId = nftRewardCount++;
        NFTReward storage reward = nftRewards[tokenId];
        reward.tokenId = tokenId;
        reward.recipient = _recipient;
        reward.achievementType = _achievementType;
        reward.rarity = _rarity;
        reward.mintedAt = block.timestamp;
        reward.isTransferable = true;
        
        // Set name and bonus reputation based on achievement type
        if (_achievementType == AchievementType.FIRST_PROPOSAL) {// SPDX-License-Identifier: MIT
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
        uint256 fundingGoal;
        uint256 currentFunding;
        bool isFundingGoalMet;
        mapping(address => uint256) fundingContributions;
        uint256 priorityScore;
        bool requiresKYC;
        uint256 minimumParticipation;
        // New proposal fields
        uint256 sentimentScore;
        mapping(address => uint256) memberEngagement;
        bool requiresAudit;
        address auditor;
        bool auditPassed;
        uint256 estimatedImpact;
        string[] dependencies;
        uint256 carbonFootprint;
        bool isUrgent;
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
        uint256 referralsCount;
        address referredBy;
        uint256 totalEarnings;
        bool isPremiumMember;
        uint256 premiumMembershipExpiry;
        string[] certifications;
        uint256 activityStreak;
        uint256 lastStreakUpdate;
        mapping(string => uint256) skillEndorsements;
        uint256 mentorshipScore;
        // New member fields
        uint256 innovationIndex;
        mapping(string => uint256) badgeCount;
        uint256 communityRanking;
        uint256 collaborationScore;
        bool isInfluencer;
        uint256 followerCount;
        string[] achievements;
        uint256 learningCredits;
        mapping(address => bool) trustedConnections;
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
        uint256 performanceScore;
        uint256 lastReviewDate;
        mapping(address => uint256) memberContributions;
        bool requiresElection;
        uint256 termLength;
        uint256 termEndDate;
        // New committee fields
        uint256 efficiency;
        mapping(string => uint256) specializations;
        bool isPublic;
        uint256 maxMembers;
        string[] workingGroups;
        mapping(address => uint256) memberRatings;
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
        uint256 milestoneCount;
        mapping(uint256 => Milestone) milestones;
        uint256 escrowAmount;
        bool isRecurring;
        uint256 recurrenceInterval;
        uint256 difficultyLevel;
        mapping(address => uint256) bidAmounts;
        bool allowsBidding;
        // New bounty fields
        uint256 qualityScore;
        mapping(address => uint256) workerPerformance;
        bool requiresTeam;
        uint256 maxTeamSize;
        address[] team;
        uint256 urgencyLevel;
        string[] mentorshipOffered;
    }
    
    // New struct for NFT rewards and achievements
    struct NFTReward {
        uint256 tokenId;
        string name;
        string description;
        string metadataURI;
        address recipient;
        uint256 mintedAt;
        AchievementType achievementType;
        uint256 rarity; // 1-5 scale
        bool isTransferable;
        uint256 bonusReputation;
        mapping(address => bool) hasApproved; // For rare NFTs requiring approval
    }
    
    // Struct for DAO events and activities
    struct DAOEvent {
        uint256 id;
        string title;
        string description;
        uint256 startTime;
        uint256 endTime;
        address organizer;
        string location; // Can be virtual
        uint256 maxAttendees;
        uint256 currentAttendees;
        mapping(address => bool) attendees;
        EventType eventType;
        uint256 cost;
        bool requiresRSVP;
        string[] speakers;
        mapping(address => string) feedback;
        uint256 avgRating;
        bool isRecurring;
        uint256 seriesId;
    }
    
    // Struct for liquidity mining and staking
    struct StakingPool {
        uint256 id;
        string name;
        uint256 totalStaked;
        uint256 rewardRate; // per block
        uint256 lockupPeriod;
        mapping(address => uint256) userStakes;
        mapping(address => uint256) userRewards;
        mapping(address => uint256) stakeTimestamp;
        bool isActive;
        uint256 minStake;
        uint256 maxStake;
        StakeType stakeType;
        uint256 poolStartTime;
        uint256 poolEndTime;
    }
    
    // Struct for governance proposals analysis and prediction
    struct ProposalAnalytics {
        uint256 proposalId;
        uint256 predictedOutcome; // 0-100 probability of passing
        uint256 stakeholderSentiment;
        mapping(string => uint256) topicRelevance;
        uint256 economicImpact;
        uint256 riskAssessment;
        string[] similarProposals;
        mapping(address => uint256) influencerSupport;
        uint256 timeToDecision;
        bool hasControversy;
    }
    
    // Struct for cross-DAO collaboration
    struct InterDAOCollaboration {
        uint256 id;
        address[] participatingDAOs;
        string objective;
        uint256 sharedBudget;
        mapping(address => uint256) contributions;
        uint256 startTime;
        uint256 endTime;
        bool isActive;
        mapping(address => bool) hasApproved;
        string[] deliverables;
        address coordinator;
        uint256 successMetrics;
    }
    
    // Struct for governance education and onboarding
    struct EducationModule {
        uint256 id;
        string title;
        string content; // IPFS hash
        uint256 difficulty; // 1-5
        uint256 estimatedTime; // in minutes
        string[] prerequisites;
        uint256 rewardCredits;
        mapping(address => bool) completed;
        mapping(address => uint256) scores;
        address instructor;
        bool isActive;
        string[] tags;
        uint256 completionCount;
    }
    
    // Struct for proposal templates and automation
    struct ProposalTemplate {
        uint256 id;
        string name;
        string description;
        ProposalType category;
        string[] requiredFields;
        uint256 defaultVotingPeriod;
        uint256 defaultQuorum;
        bool requiresDeposit;
        uint256 depositAmount;
        address creator;
        uint256 usageCount;
        bool isPublic;
        mapping(address => bool) canUse;
    }
    
    // Enhanced enums
    enum AchievementType {
        FIRST_PROPOSAL,
        ACTIVE_VOTER,
        COMMITTEE_LEADER,
        BOUNTY_HUNTER,
        MENTOR,
        INNOVATOR,
        COMMUNITY_BUILDER,
        LONG_TIME_MEMBER,
        HIGH_REPUTATION,
        EDUCATOR,
        COLLABORATOR,
        EARLY_ADOPTER
    }
    
    enum EventType {
        GOVERNANCE_MEETING,
        EDUCATIONAL_WORKSHOP,
        NETWORKING,
        HACKATHON,
        CONFERENCE,
        SOCIAL,
        STRATEGIC_PLANNING,
        ONBOARDING,
        VOTING_SESSION,
        CELEBRATION
    }
    
    enum StakeType {
        GOVERNANCE,
        LIQUIDITY_PROVISION,
        VALIDATOR,
        INSURANCE,
        DEVELOPMENT_FUND,
        MARKETING_FUND,
        EMERGENCY_FUND
    }
    
    // Existing enums (keeping all previous ones)
    enum DisputeCategory {
        CONTRACT_BREACH,
        GOVERNANCE_VIOLATION,
        MISCONDUCT,
        BOUNTY_DISPUTE,
        PARTNERSHIP_ISSUE,
        TECHNICAL_DISPUTE
    }
    
    enum MemberRole {
        BASIC_MEMBER,
        COMMITTEE_MEMBER,
        MODERATOR,
        ADMIN,
        EMERGENCY_COUNCIL,
        ARBITRATOR,
        MENTOR,
        AMBASSADOR
    }
    
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
        POLICY_CHANGE,
        CROSS_CHAIN,
        AUTOMATED_ACTION,
        DISPUTE_RESOLUTION
    }
    
    enum BountyStatus {
        OPEN,
        ASSIGNED,
        IN_PROGRESS,
        SUBMITTED,
        COMPLETED,
        CANCELLED,
        DISPUTED,
        MILESTONE_PENDING,
        ESCROW_RELEASED
    }
    
    enum ProposalCategory {
        DEVELOPMENT,
        MARKETING,
        OPERATIONS,
        RESEARCH,
        COMMUNITY,
        INFRASTRUCTURE,
        GRANTS,
        PARTNERSHIPS,
        EDUCATION,
        LEGAL_COMPLIANCE,
        TREASURY_MANAGEMENT,
        CROSS_CHAIN_OPERATIONS
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
        DIAMOND,
        FOUNDER,
        LIFETIME
    }
    
    // State variables for new functionality
    mapping(uint256 => NFTReward) public nftRewards;
    mapping(uint256 => DAOEvent) public daoEvents;
    mapping(uint256 => StakingPool) public stakingPools;
    mapping(uint256 => ProposalAnalytics) public proposalAnalytics;
    mapping(uint256 => InterDAOCollaboration) public interDAOCollaborations;
    mapping(uint256 => EducationModule) public educationModules;
    mapping(uint256 => ProposalTemplate) public proposalTemplates;
    
    mapping(address => uint256[]) public memberNFTs;
    mapping(address => uint256) public memberLearningCredits;
    mapping(address => uint256[]) public memberEducationCompleted;
    mapping(address => mapping(uint256 => uint256)) public stakingRewards;
    mapping(address => uint256) public totalStakedByMember;
    mapping(string => uint256) public skillMarketDemand;
    mapping(address => bool) public isInfluencer;
    mapping(address => uint256) public influencerFollowers;
    mapping(address => string[]) public memberBadges;
    mapping(uint256 => address[]) public eventAttendees;
    mapping(address => uint256) public memberEventCount;
    mapping(address => mapping(string => uint256)) public skillCertifications;
    
    // New counters
    uint256 public nftRewardCount;
    uint256 public daoEventCount;
    uint256 public stakingPoolCount;
    uint256 public interDAOCollaborationCount;
    uint256 public educationModuleCount;
    uint256 public proposalTemplateCount;
    
    // Enhanced governance parameters
    struct GovernanceParams {
        uint256 votingPeriod;
        uint256 quorum;
        uint256 minProposalStake;
        uint256 proposalExecutionDelay;
        uint256 reputationThreshold;
        uint256 maxVotingPeriod;
        uint256 minVotingPeriod;
        uint256 vetoWindow;
        // New parameters
        uint256 nftRewardThreshold;
        uint256 stakingRewardRate;
        uint256 learningCreditRate;
        uint256 influencerThreshold;
        uint256 collaborationBonus;
        uint256 innovationIncentive;
        uint256 sustainabilityWeight;
        uint256 diversityBonus;
    }
    
    // Events for new functionality
    event NFTRewardMinted(uint256 indexed tokenId, address indexed recipient, AchievementType achievementType);
    event DAOEventCreated(uint256 indexed eventId, address indexed organizer, string title);
    event EventAttendanceMarked(uint256 indexed eventId, address indexed attendee);
    event StakingPoolCreated(uint256 indexed poolId, string name, uint256 rewardRate);
    event TokensStaked(address indexed user, uint256 indexed poolId, uint256 amount);
    event RewardsClaimed(address indexed user, uint256 indexed poolId, uint256 amount);
    event EducationModuleCompleted(address indexed member, uint256 indexed moduleId, uint256 score);
    event SkillCertified(address indexed member, string skill, uint256 level);
    event InterDAOCollaborationStarted(uint256 indexed collaborationId, address[] participatingDAOs);
    event ProposalTemplateCreated(uint256 indexed templateId, string name, address creator);
    event BadgeAwarded(address indexed member, string badge);
    event LearningCreditsEarned(address indexed member, uint256 credits);
    event InfluencerStatusChanged(address indexed member, bool isInfluencer);
    event ProposalAnalyticsUpdated(uint256 indexed proposalId, uint256 predictedOutcome);
    
    // Existing state variables and mappings (keep all previous ones)
    mapping(uint256 => Proposal) public proposals;
    mapping(uint256 => mapping(address => bool)) public hasVoted;
    mapping(uint256 => mapping(address => VoteOption)) public memberVote;
    mapping(address => bool) public isMember;
    mapping(address => uint256) public memberSince;
    mapping(address => uint256) public votingPower;
    mapping(address => MemberProfile) public memberProfiles;
    mapping(address => uint256) public memberReputation;
    mapping(address => MembershipTier) public membershipTiers;
    mapping(address => bool) public isVerifiedMember;
    mapping(address => bool) public isModerator;
    mapping(address => uint256) public moderatorSince;
    mapping(address => uint256) public memberVoteCredits;
    
    uint256 public proposalCount;
    uint256 public memberCount;
    uint256 public treasury;
    address public admin;
    GovernanceParams public governanceParams;
    
    // Modifiers for new functionality
    modifier hasLearningCredits(uint256 _requiredCredits) {
        require(memberLearningCredits[msg.sender] >= _requiredCredits, "Insufficient learning credits");
        _;
    }
    
    modifier onlyInfluencer() {
        require(isInfluencer[msg.sender], "Only influencers can perform this action");
        _;
    }
    
    modifier eventExists(uint256 _eventId) {
        require(_eventId < daoEventCount, "Event does not exist");
        _;
    }
    
    modifier stakingPoolExists(uint256 _poolId) {
        require(_poolId < stakingPoolCount, "Staking pool does not exist");
        _;
    }
    
    // Keep existing modifiers
    modifier onlyMember() {
        require(isMember[msg.sender], "Only members can perform this action");
        _;
    }
    
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }
    
    modifier onlyModerator() {
        require(isModerator[msg.sender], "Only moderators can perform this action");
        _;
    }
    
    modifier hasReputation(uint256 _minReputation) {
        require(memberReputation[msg.sender] >= _minReputation, "Insufficient reputation");
        _;
    }
    
    modifier onlyActiveMember() {
        require(isMember[msg.sender] && memberProfiles[msg.sender].isActive, "Only active members allowed");
        _;
    }
    
    modifier onlyVerifiedMember() {
        require(isVerifiedMember[msg.sender], "Only verified members allowed");
        _;
    }
    
    modifier proposalExists(uint256 _proposalId) {
        require(proposals[_proposalId].exists, "Proposal does not exist");
        _;
    }
    
    // Constructor (enhanced with new features)
    constructor() {
        admin = msg.sender;
        isMember[msg.sender] = true;
        memberSince[msg.sender] = block.timestamp;
        votingPower[msg.sender] = 100;
        memberCount = 1;
        memberReputation[msg.sender] = 1000;
        membershipTiers[msg.sender] = MembershipTier.FOUNDER;
        isVerifiedMember[msg.sender] = true;
        isModerator[msg.sender] = true;
        moderatorSince[msg.sender] = block.timestamp;
        memberVoteCredits[msg.sender] = 100;
        memberLearningCredits[msg.sender] = 100;
        isInfluencer[msg.sender] = true;
        influencerFollowers[msg.sender] = 1000;
        
        // Initialize governance parameters with new fields
        governanceParams = GovernanceParams({
            votingPeriod: 7 days,
            quorum: 51,
            minProposalStake: 0.1 ether,
            proposalExecutionDelay: 2 days,
            reputationThreshold: 100,
            maxVotingPeriod: 30 days,
            minVotingPeriod: 1 days,
            vetoWindow: 3 days,
            nftRewardThreshold: 500,
            stakingRewardRate: 100, // 1% per day
            learningCreditRate: 10,
            influencerThreshold: 500,
            collaborationBonus: 50,
            innovationIncentive: 100,
            sustainabilityWeight: 25,
            diversityBonus: 30
        });
        
        // Create initial education modules
        _createEducationModule(
            "DAO Governance Fundamentals",
            "QmEducationContent1",
            1,
            30,
            new string[](0),
            25
        );
        
        // Create initial staking pool
        _createStakingPool(
            "Governance Staking",
            100, // 1% reward rate
            30 days,
            0.1 ether,
            10 ether,
            StakeType.GOVERNANCE
        );
        
        // Award founder NFT
        _mintNFTReward(msg.sender, AchievementType.EARLY_ADOPTER, 5);
    }
    
    /**
     * @dev Create a new DAO event
     */
    function createDAOEvent(
        string memory _title,
        string memory _description,
        uint256 _startTime,
        uint256 _endTime,
        string memory _location,
        uint256 _maxAttendees,
        EventType _eventType,
        uint256 _cost,
        bool _requiresRSVP,
        string[] memory _speakers
    ) external onlyMember hasReputation(100) {
        require(_startTime > block.timestamp, "Event must be in the future");
        require(_endTime > _startTime, "End time must be after start time");
        
        uint256 eventId = daoEventCount++;
        DAOEvent storage newEvent = daoEvents[eventId];
        newEvent.id = eventId;
        newEvent.title = _title;
        newEvent.description = _description;
        newEvent.startTime = _startTime;
        newEvent.endTime = _endTime;
        newEvent.organizer = msg.sender;
        newEvent.location = _location;
        newEvent.maxAttendees = _maxAttendees;
        newEvent.eventType = _eventType;
        newEvent.cost = _cost;
        newEvent.requiresRSVP = _requiresRSVP;
        newEvent.speakers = _speakers;
        
        // Award reputation bonus for organizing events
        memberReputation[msg.sender] += 25;
        memberProfiles[msg.sender].contributionScore += 15;
        
        emit DAOEventCreated(eventId, msg.sender, _title);
    }
    
    /**
     * @dev RSVP or attend a DAO event
     */
    function attendEvent(uint256 _eventId) external payable eventExists(_eventId) onlyMember {
        DAOEvent storage eventData = daoEvents[_eventId];
        require(block.timestamp <= eventData.endTime, "Event has ended");
        require(!eventData.attendees[msg.sender], "Already registered");
        require(eventData.currentAttendees < eventData.maxAttendees, "Event is full");
        
        if (eventData.cost > 0) {
            require(msg.value >= eventData.cost, "Insufficient payment");
        }
        
        eventData.attendees[msg.sender] = true;
        eventData.currentAttendees++;
        eventAttendees[_eventId].push(msg.sender);
        memberEventCount[msg.sender]++;
        
        // Award attendance benefits
        memberReputation[msg.sender] += 5;
        memberLearningCredits[msg.sender] += 2;
        
        // Special rewards for educational events
        if (eventData.eventType == EventType.EDUCATIONAL_WORKSHOP) {
            memberLearningCredits[msg.sender] += 5;
        }
        
        emit EventAttendanceMarked(_eventId, msg.sender);
        
        // Check for community builder achievement
        if (memberEventCount[msg.sender] >= 10) {
            _mintNFTReward(msg.sender, AchievementType.COMMUNITY_BUILDER, 3);
        }
    }
    
    /**
     * @dev Create a new staking pool
     */
    function _createStakingPool(
        string memory _name,
        uint256 _rewardRate,
        uint256 _lockupPeriod,
        uint256 _minStake,
        uint256 _maxStake,
        StakeType _stakeType
    ) internal returns (uint256) {
        uint256 poolId = stakingPoolCount++;
        StakingPool storage pool = stakingPools[poolId];
        pool.id = poolId;
        pool.name = _name;
        pool.rewardRate = _rewardRate;
        pool.lockupPeriod = _lockupPeriod;
        pool.minStake = _minStake;
        pool.maxStake = _maxStake;
        pool.stakeType = _stakeType;
        pool.isActive = true;
        pool.poolStartTime = block.timestamp;
        pool.poolEndTime = block.timestamp + 365 days; // Default 1 year
        
        emit StakingPoolCreated(poolId, _name, _rewardRate);
        return poolId;
    }
    
    /**
     * @dev Stake tokens in a specific pool
     */
    function stakeTokens(uint256 _poolId, uint256 _amount) external payable stakingPoolExists(_poolId) onlyMember {
        StakingPool storage pool = stakingPools[_poolId];
        require(pool.isActive, "Pool is not active");
        require(block.timestamp >= pool.poolStartTime && block.timestamp <= pool.poolEndTime, "Pool not available");
        require(_amount >= pool.minStake, "Below minimum stake");
        require(_amount <= pool.maxStake, "Exceeds maximum stake");
        require(msg.value >= _amount, "Insufficient funds sent");
        
        // Calculate existing rewards before updating stake
        _updateStakingRewards(msg.sender, _poolId);
        
        pool.userStakes[msg.sender] += _amount;
        pool.totalStaked += _amount;
        pool.stakeTimestamp[msg.sender] = block.timestamp;
        totalStakedByMember[msg.sender] += _amount;
        
        // Reputation bonus for staking
        memberReputation[msg.sender] += _amount / 0.1 ether; // 1 reputation per 0.1 ETH
        
        emit TokensStaked(msg.sender, _poolId, _amount);
        
        // Check for validator achievement
        if (totalStakedByMember[msg.sender] >= 10 ether) {
            _mintNFTReward(msg.sender, AchievementType.HIGH_REPUTATION, 4);
        }
    }
    
    /**
     * @dev Update staking rewards for a user
     */
    function _updateStakingRewards(address _user, uint256 _poolId) internal {
        StakingPool storage pool = stakingPools[_poolId];
        if (pool.userStakes[_user] > 0) {
            uint256 stakeDuration = block.timestamp - pool.stakeTimestamp[_user];
            uint256 reward = (pool.userStakes[_user] * pool.rewardRate * stakeDuration) / (100 * 1 days);
            stakingRewards[_user][_poolId] += reward;
        }
    }
    
    /**
     * @dev Claim staking rewards
     */
    function claimStakingRewards(uint256 _poolId) external stakingPoolExists(_poolId) onlyMember {
        _updateStakingRewards(msg.sender, _poolId);
        uint256 reward = stakingRewards[msg.sender][_poolId];
        require(reward > 0, "No rewards to claim");
        
        stakingRewards[msg.sender][_poolId] = 0;
        stakingPools[_poolId].stakeTimestamp[msg.sender] = block.timestamp;
        
        // Transfer rewards (in a real implementation, this would come from a reward pool)
        payable(msg.sender).transfer(reward);
        
        emit RewardsClaimed(msg.sender, _poolId, reward);
    }
    
    /**
     * @dev Create educational module
     */
    function _createEducationModule(
        string memory _title,
        string memory _contentHash,
        uint256 _difficulty,
        uint256 _estimatedTime,
        string[] memory _prerequisites,
        uint256 _rewardCredits
    ) internal returns (uint256) {
        uint256 moduleId = educationModuleCount++;
        EducationModule storage module = educationModules[moduleId];
        module.id = moduleId;
        module.title = _title;
        module.content = _contentHash;
        module.difficulty = _difficulty;
        module.estimatedTime = _estimatedTime;
        module.prerequisites = _prerequisites;
        module.rewardCredits = _rewardCredits;
        module.instructor = msg.sender;
        module.isActive = true;
        
        return moduleId;
    }
    
    /**
     * @dev Complete an education module
     */
    function completeEducationModule(uint256 _moduleId, uint256 _score) external onlyMember {
        require(_moduleId < educationModuleCount, "Module does not exist");
        EducationModule storage module = educationModules[_moduleId];
        require(module.isActive, "Module is not active");
        require(!module.completed[msg.sender], "Module already completed");
        require(_score >= 70, "Minimum score of 70 required");
        
        // Check prerequisites
        for (uint256 i = 0; i < module.prerequisites.length; i++) {
            // In a real implementation, check if prerequisite modules are completed
        }
        
        module.completed[msg.sender] = true;
        module.scores[msg.sender] = _score;
        module.completionCount++;
        
        memberEducationCompleted[msg.sender].push(_moduleId);
        memberLearningCredits[msg.sender] += module.rewardCredits;
        
        // Bonus reputation for high scores
        if (_score >= 90) {
            memberReputation[msg.sender] += 20;
        } else if (_score >= 80) {
            memberReputation[msg.sender] += 10;
        }
        
        emit EducationModuleCompleted(msg.sender, _moduleId, _score);
        emit LearningCreditsEarned(msg.sender, module.rewardCredits);
        
        // Check for educator achievement
        if (memberEducationCompleted[msg.sender].length >= 5) {
            _mintNFTReward(msg.sender, AchievementType.EDUCATOR, 3);
        }
    }
    
    /**
     * @dev Mint NFT reward for achievements
     */
    function _mintNFTReward(address _recipient, AchievementType _achievementType, uint256 _rarity) internal {
        uint256 tokenId = nftRewardCount++;
        NFTReward storage reward = nftRewards[tokenId];
        reward.tokenId = tokenId;
        reward.recipient = _recipient;
        reward.achievementType = _achievementType;
        reward.rarity = _rarity;
        reward.mintedAt = block.timestamp;
        reward.isTransferable = true;
        
        // Set name and bonus reputation based on achievement type
        if (_achievementType == AchievementType.FIRST_PROPOSAL) {
        
         
