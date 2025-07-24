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
        if (_achievementType == AchievementType.FIRST_PROPOSAL) {
            reward.name = "First Proposal Creator";
            reward.description = "Created the first proposal in the DAO";
            reward.bonusReputation = 50;
        } else if (_achievementType == AchievementType.ACTIVE_VOTER) {
            reward.name = "Active Voter";
            reward.description = "Participated in 50+ governance votes";
            reward.bonusReputation = 100;
        } else if (_achievementType == AchievementType.COMMITTEE_LEADER) {
            reward.name = "Committee Leader";
            reward.description = "Successfully led a DAO committee";
            reward.bonusReputation = 150;
        } else if (_achievementType == AchievementType.BOUNTY_HUNTER) {
            reward.name = "Bounty Hunter";
            reward.description = "Completed 10+ bounties";
            reward.bonusReputation = 75;
        } else if (_achievementType == AchievementType.MENTOR) {
            reward.name = "Mentor";
            reward.description = "Successfully mentored new members";
            reward.bonusReputation = 200;
        } else if (_achievementType == AchievementType.INNOVATOR) {
            reward.name = "Innovator";
            reward.description = "Proposed groundbreaking innovations";
            reward.bonusReputation = 300;
        } else if (_achievementType == AchievementType.COMMUNITY_BUILDER) {
            reward.name = "Community Builder";
            reward.description = "Attended 10+ DAO events";
            reward.bonusReputation = 125;
        } else if (_achievementType == AchievementType.LONG_TIME_MEMBER) {
            reward.name = "Veteran Member";
            reward.description = "1+ year of active membership";
            reward.bonusReputation = 250;
        } else if (_achievementType == AchievementType.HIGH_REPUTATION) {
            reward.name = "Reputation Master";
            reward.description = "Achieved high reputation score";
            reward.bonusReputation = 100;
        } else if (_achievementType == AchievementType.EDUCATOR) {
            reward.name = "Knowledge Sharer";
            reward.description = "Completed multiple education modules";
            reward.bonusReputation = 175;
        } else if (_achievementType == AchievementType.COLLABORATOR) {
            reward.name = "Team Player";
            reward.description = "Excellent collaboration skills";
            reward.bonusReputation = 150;
        } else if (_achievementType == AchievementType.EARLY_ADOPTER) {
            reward.name = "Pioneer";
            reward.description = "Early supporter of the DAO";
            reward.bonusReputation = 500;
        }
        
        memberNFTs[_recipient].push(tokenId);
        memberReputation[_recipient] += reward.bonusReputation;
        
        emit NFTRewardMinted(tokenId, _recipient, _achievementType);
    }
    
    // ============ NEW ADVANCED FUNCTIONALITIES ============
    
    // Struct for advanced governance features
    struct QuadraticVoting {
        uint256 proposalId;
        mapping(address => uint256) voteCredits;
        mapping(address => uint256) creditsUsed;
        uint256 totalCreditsUsed;
        bool isActive;
    }
    
    // Struct for prediction markets
    struct PredictionMarket {
        uint256 id;
        string question;
        string[] outcomes;
        mapping(string => uint256) bets;
        mapping(address => mapping(string => uint256)) userBets;
        uint256 totalPool;
        uint256 resolutionTime;
        string correctOutcome;
        bool resolved;
        address oracle;
        uint256 createdAt;
        uint256 minBet;
        uint256 maxBet;
    }
    
    // Struct for DAO insurance system
    struct InsurancePolicy {
        uint256 id;
        string policyType;
        uint256 coverage;
        uint256 premium;
        uint256 duration;
        address policyholder;
        bool isActive;
        uint256 startTime;
        mapping(address => bool) hasVoted;
        uint256 claimCount;
        uint256 totalClaims;
        bool autoRenewal;
    }
    
    // Struct for reputation-based lending
    struct LoanRequest {
        uint256 id;
        address borrower;
        uint256 amount;
        uint256 interestRate;
        uint256 duration;
        uint256 collateral;
        string purpose;
        LoanStatus status;
        mapping(address => uint256) lenderContributions;
        uint256 totalFunded;
        uint256 repaidAmount;
        uint256 dueDate;
        uint256 reputationRequirement;
        address[] lenders;
    }
    
    // Struct for skill-based matching system
    struct SkillRequest {
        uint256 id;
        address requester;
        string[] requiredSkills;
        uint256 budget;
        string description;
        uint256 deadline;
        address[] applicants;
        mapping(address => uint256) skillScores;
        address selectedProvider;
        bool completed;
        uint256 rating;
    }
    
    // Struct for DAO analytics and insights
    struct DAOMetrics {
        uint256 totalValueLocked;
        uint256 avgProposalTime;
        uint256 memberRetentionRate;
        uint256 treasuryGrowthRate;
        uint256 votingParticipationRate;
        uint256 proposalSuccessRate;
        mapping(string => uint256) activityByCategory;
        uint256 lastUpdated;
    }
    
    // Struct for automated treasury management
    struct TreasuryStrategy {
        uint256 id;
        string name;
        uint256 allocation; // percentage
        address targetProtocol;
        uint256 expectedReturn;
        uint256 riskLevel; // 1-10
        bool isActive;
        uint256 currentValue;
        uint256 historicalReturns;
        address strategist;
    }
    
    // Struct for decentralized recruitment
    struct JobPosting {
        uint256 id;
        string title;
        string description;
        string[] requiredSkills;
        uint256 salary;
        address employer;
        JobType jobType;
        uint256 duration;
        address[] applicants;
        mapping(address => string) applications;
        address selectedCandidate;
        bool filled;
        uint256 deadline;
        uint256 experienceLevel;
    }
    
    // New enums for additional functionality
    enum LoanStatus {
        REQUESTED,
        FUNDING,
        ACTIVE,
        REPAYING,
        COMPLETED,
        DEFAULTED
    }
    
    enum JobType {
        FULL_TIME,
        PART_TIME,
        CONTRACT,
        BOUNTY,
        INTERNSHIP,
        CONSULTING
    }
    
    // Additional state variables
    mapping(uint256 => QuadraticVoting) public quadraticVotes;
    mapping(uint256 => PredictionMarket) public predictionMarkets;
    mapping(uint256 => InsurancePolicy) public insurancePolicies;
    mapping(uint256 => LoanRequest) public loanRequests;
    mapping(uint256 => SkillRequest) public skillRequests;
    mapping(uint256 => TreasuryStrategy) public treasuryStrategies;
    mapping(uint256 => JobPosting) public jobPostings;
    
    mapping(address => uint256) public memberInsuranceScore;
    mapping(address => uint256) public memberCreditScore;
    mapping(address => uint256[]) public memberLoans;
    mapping(address => mapping(string => uint256)) public skillVerifications;
    mapping(string => address[]) public skillProviders;
    mapping(address => uint256) public treasuryContributions;
    mapping(address => bool) public isStrategist;
    mapping(address => uint256) public jobApplicationCount;
    
    // New counters
    uint256 public predictionMarketCount;
    uint256 public insurancePolicyCount;
    uint256 public loanRequestCount;
    uint256 public skillRequestCount;
    uint256 public treasuryStrategyCount;
    uint256 public jobPostingCount;
    
    // DAO metrics
    DAOMetrics public daoMetrics;
    
    // New events
    event QuadraticVoteStarted(uint256 indexed proposalId);
    event PredictionMarketCreated(uint256 indexed marketId, string question);
    event PredictionMarketResolved(uint256 indexed marketId, string outcome);
    event InsurancePolicyCreated(uint256 indexed policyId, address indexed policyholder);
    event LoanRequested(uint256 indexed loanId, address indexed borrower, uint256 amount);
    event LoanFunded(uint256 indexed loanId, address indexed lender, uint256 amount);
    event LoanRepaid(uint256 indexed loanId, uint256 amount);
    event SkillRequestCreated(uint256 indexed requestId, address indexed requester);
    event SkillMatched(uint256 indexed requestId, address indexed provider);
    event TreasuryStrategyDeployed(uint256 indexed strategyId, uint256 allocation);
    event JobPosted(uint256 indexed jobId, address indexed employer, string title);
    event JobApplicationSubmitted(uint256 indexed jobId, address indexed applicant);
    event CandidateHired(uint256 indexed jobId, address indexed candidate);
    event SkillVerified(address indexed member, string skill, address indexed verifier);
    event CreditScoreUpdated(address indexed member, uint256 newScore);
    event DAOMetricsUpdated(uint256 timestamp);
    
    /**
     * @dev Enable quadratic voting for a proposal
     */
    function enableQuadraticVoting(uint256 _proposalId) external onlyModerator proposalExists(_proposalId) {
        require(!quadraticVotes[_proposalId].isActive, "Quadratic voting already enabled");
        
        QuadraticVoting storage qv = quadraticVotes[_proposalId];
        qv.proposalId = _proposalId;
        qv.isActive = true;
        
        // Distribute vote credits based on reputation
        // This would need to be called for each member or done in batches
        
        emit QuadraticVoteStarted(_proposalId);
    }
    
    /**
     * @dev Vote using quadratic voting mechanism
     */
    function quadraticVote(uint256 _proposalId, VoteOption _vote, uint256 _credits) external onlyMember {
        require(quadraticVotes[_proposalId].isActive, "Quadratic voting not enabled");
        require(_credits > 0, "Must use at least 1 credit");
        
        QuadraticVoting storage qv = quadraticVotes[_proposalId];
        require(qv.voteCredits[msg.sender] >= _credits, "Insufficient vote credits");
        
        qv.voteCredits[msg.sender] -= _credits;
        qv.creditsUsed[msg.sender] += _credits;
        qv.totalCreditsUsed += _credits;
        
        // Calculate quadratic impact (square root of credits)
        uint256 voteWeight = sqrt(_credits);
        
        Proposal storage proposal = proposals[_proposalId];
        if (_vote == VoteOption.YES) {
            proposal.yesVotes += voteWeight;
        } else if (_vote == VoteOption.NO) {
            proposal.noVotes += voteWeight;
        } else {
            proposal.abstainVotes += voteWeight;
        }
        
        hasVoted[_proposalId][msg.sender] = true;
        memberVote[_proposalId][msg.sender] = _vote;
    }
    
    /**
     * @dev Create a prediction market
     */
    function createPredictionMarket(
        string memory _question,
        string[] memory _outcomes,
        uint256 _resolutionTime,
        uint256 _minBet,
        uint256 _maxBet
    ) external onlyMember hasReputation(200) {
        require(_outcomes.length >= 2, "Need at least 2 outcomes");
        require(_resolutionTime > block.timestamp, "Resolution time must be in future");
        
        uint256 marketId = predictionMarketCount++;
        PredictionMarket storage market = predictionMarkets[marketId];
        market.id = marketId;
        market.question = _question;
        market.outcomes = _outcomes;
        market.resolutionTime = _resolutionTime;
        market.oracle = msg.sender;
        market.createdAt = block.timestamp;
        market.minBet = _minBet;
        market.maxBet = _maxBet;
        
        emit PredictionMarketCreated(marketId, _question);
    }
    
    /**
     * @dev Bet on prediction market outcome
     */
    function betOnOutcome(uint256 _marketId, string memory _outcome) external payable onlyMember {
        require(_marketId < predictionMarketCount, "Market does not exist");
        PredictionMarket storage market = predictionMarkets[_marketId];
        require(block.timestamp < market.resolutionTime, "Market has closed");
        require(msg.value >= market.minBet && msg.value <= market.maxBet, "Invalid bet amount");
        
        // Verify outcome exists
        bool outcomeExists = false;
        for (uint256 i = 0; i < market.outcomes.length; i++) {
            if (keccak256(bytes(market.outcomes[i])) == keccak256(bytes(_outcome))) {
                outcomeExists = true;
                break;
            }
        }
        require(outcomeExists, "Invalid outcome");
        
        market.bets[_outcome] += msg.value;
        market.userBets[msg.sender][_outcome] += msg.value;
        market.totalPool += msg.value;
    }
    
    /**
     * @dev Resolve prediction market
     */
    function resolvePredictionMarket(uint256 _marketId, string memory _correctOutcome) external {
        require(_marketId < predictionMarketCount, "Market does not exist");
        PredictionMarket storage market = predictionMarkets[_marketId];
        require(msg.sender == market.oracle, "Only oracle can resolve");
        require(block.timestamp >= market.resolutionTime, "Market not ready for resolution");
        require(!market.resolved, "Market already resolved");
        
        market.correctOutcome = _correctOutcome;
        market.resolved = true;
        
        emit PredictionMarketResolved(_marketId, _correctOutcome);
    }
    
    /**
     * @dev Create insurance policy
     */
    function createInsurancePolicy(
        string memory _policyType,
        uint256 _coverage,
        uint256 _premium,
        uint256 _duration
    ) external payable onlyMember {
        require(msg.value >= _premium, "Insufficient premium payment");
        require(memberInsuranceScore[msg.sender] >= 500, "Insufficient insurance score");
        
        uint256 policyId = insurancePolicyCount++;
        InsurancePolicy storage policy = insurancePolicies[policyId];
        policy.id = policyId;
        policy.policyType = _policyType;
        policy.coverage = _coverage;
        policy.premium = _premium;
        policy.duration = _duration;
        policy.policyholder = msg.sender;
        policy.isActive = true;
        policy.startTime = block.timestamp;
        
        memberInsuranceScore[msg.sender] += 10; // Reward for responsible behavior
        
        emit InsurancePolicyCreated(policyId, msg.sender);
    }
    
    /**
     * @dev Request a loan based on reputation
     */
    function requestLoan(
        uint256 _amount,
        uint256 _interestRate,
        uint256 _duration,
        string memory _purpose,
        uint256 _reputationRequirement
    ) external onlyMember hasReputation(_reputationRequirement) {
        require(_amount > 0, "Amount must be positive");
        require(memberCreditScore[msg.sender] >= 600, "Insufficient credit score");
        
        uint256 loanId = loanRequestCount++;
        LoanRequest storage loan = loanRequests[loanId];
        loan.id = loanId;
        loan.borrower = msg.sender;
        loan.amount = _amount;
        loan.interestRate = _interestRate;
        loan.duration = _duration;
        loan.purpose = _purpose;
        loan.status = LoanStatus.REQUESTED;
        loan.reputationRequirement = _reputationRequirement;
        
        memberLoans[msg.sender].push(loanId);
        
        emit LoanRequested(loanId, msg.sender, _amount);
    }
    
    /**
     * @dev Fund a loan request
     */
    function fundLoan(uint256 _loanId, uint256 _amount) external payable onlyMember {
        require(_loanId < loanRequestCount, "Loan does not exist");
        require(msg.value >= _amount, "Insufficient funds sent");
        
        LoanRequest storage loan = loanRequests[_loanId];
        require(loan.status == LoanStatus.REQUESTED || loan.status == LoanStatus.FUNDING, "Invalid loan status");
        require(loan.totalFunded + _amount <= loan.amount, "Exceeds loan amount");
        
        loan.lenderContributions[msg.sender] += _amount;
        loan.totalFunded += _amount;
        loan.lenders.push(msg.sender);
        
        if (loan.totalFunded == loan.amount) {
            loan.status = LoanStatus.ACTIVE;
            loan.dueDate = block.timestamp + loan.duration;
            // Transfer funds to borrower
            payable(loan.borrower).transfer(loan.amount);
        } else {
            loan.status = LoanStatus.FUNDING;
        }
        
        emit LoanFunded(_loanId, msg.sender, _amount);
    }
    
    /**
     * @dev Repay loan
     */
    function repayLoan(uint256 _loanId, uint256 _amount) external payable {
        require(_loanId < loanRequestCount, "Loan does not exist");
        LoanRequest storage loan = loanRequests[_loanId];
        require(msg.sender == loan.borrower, "Only borrower can repay");
        require(loan.status == LoanStatus.ACTIVE, "Loan not active");
        require(msg.value >= _amount, "Insufficient payment");
        
        loan.repaidAmount += _amount;
        
        uint256 totalOwed = loan.amount + (loan.amount * loan.interestRate / 100);
        if (loan.repaidAmount >= totalOwed) {
            loan.status = LoanStatus.COMPLETED;
            memberCreditScore[loan.borrower] += 50; // Reward for timely repayment
        }
        
        // Distribute repayment to lenders proportionally
        for (uint256 i = 0; i < loan.lenders.length; i++) {
            address lender = loan.lenders[i];
            uint256 lenderShare = (loan.lenderContributions[lender] * _amount) / loan.amount;
            payable(lender).transfer(lenderShare);
        }
        
        emit LoanRepaid(_loanId, _amount);
    }
    
    /**
     * @dev Create skill-based service request
     */
    function createSkillRequest(
        string[] memory _requiredSkills,
        uint256 _budget,
        string memory _description,
        uint256 _deadline
    ) external payable onlyMember {
        require(msg.value >= _budget, "Must escrow the budget");
        require(_deadline > block.timestamp, "Deadline must be in future");
        
        uint256 requestId = skillRequestCount++;
        SkillRequest storage request = skillRequests[requestId];
        request.id = requestId;
        request.requester = msg.sender;
        request.requiredSkills = _requiredSkills;
        request.budget = _budget;
        request.description = _description;
        request.deadline = _deadline;
        
        emit SkillRequestCreated(requestId, msg.sender);
    }
    
    /**
     * @dev Apply for skill-based service
     */
    function applyForSkillRequest(uint256 _requestId) external onlyMember {
        require(_requestId < skillRequestCount, "Request does not exist");
        SkillRequest storage request = skillRequests[_requestId];
        require(block.timestamp < request.deadline, "Application deadline passed");
        require(!request.completed, "Request already completed");
        
        // Calculate skill match score
        uint256 skillScore = _calculateSkillMatch(msg.sender, request.requiredSkills);
        require(skillScore >= 70, "Insufficient skill match");
        
        request.applicants.push(msg.sender);
        request.skillScores[msg.sender] = skillScore;
        
        jobApplicationCount[msg.sender]++;
    }
    
    /**
     * @dev Select skill provider
     */
    function selectSkillProvider(uint256 _requestId, address _provider) external {
        require(_requestId < skillRequestCount, "Request does not exist");
        SkillRequest storage request = skillRequests[_requestId];
        require(msg.sender == request.requester, "Only requester can select");
        require(request.skillScores[_provider] > 0, "Provider not eligible");
        
        request.selectedProvider = _provider;
        
        emit SkillMatched(_requestId, _provider);
    }
    
    /**
     * @dev Complete skill request and release payment
     */
    function completeSkillRequest(uint256 _requestId, uint256 _rating) external {
        require(_requestId < skillRequestCount, "Request does not exist");
        SkillRequest storage request = skillRequests[_requestId];
        require(msg.sender == request.requester, "Only requester can complete");
        require(request.selectedProvider != address(0), "No provider selected");
        require(!request.completed, "Already completed");
        require(_rating >= 1 && _rating <= 5, "Invalid rating");
        
        request.completed = true;
        request.rating = _rating;
        
        // Transfer payment to provider
        payable(request.selectedProvider).transfer(request.budget);
        
        // Update provider reputation based on rating
        if (_rating >= 4) {
            memberReputation[request.selectedProvider] += 25;
        } else if (_rating >= 3) {
            memberReputation[request.selectedProvider] += 10;
        }
        
        // Update skill verifications
        for (uint256 i = 0; i < request.requiredSkills.length; i++) {
            skillVerifications[request.selectedProvider][request.requiredSkills[i]] += _rating;
        }
    }
    
    /**
     * @dev Post a job opening
     */
    function postJob(
        string memory _title,
        string memory _description,
        string[] memory _requiredSkills,
        uint256 _salary,
        JobType _jobType,
        uint256 _duration,
        uint256 _deadline,
        uint256 _experienceLevel
    ) external onlyMember hasReputation(300) {
        uint256 jobId = jobPostingCount++;
        JobPosting storage job = jobPostings[jobId];
        job.id = jobId;
        job.title = _title;
        job.description = _description;
        job.requiredSkills = _requiredSkills;
        job.salary = _salary;
        job.employer = msg.sender;
        job.jobType = _jobType;
        job.duration = _duration;
        job.deadline = _deadline;
        job.experienceLevel = _experienceLevel;
        
        emit JobPosted(jobId, msg.sender, _title);
    }
    
    /**
     * @dev Apply for a job
     */
    function applyForJob(uint256 _jobId, string memory _application) external onlyMember {
        require(_jobId < jobPostingCount, "Job does not exist");
        JobPosting storage job = jobPostings[_jobId];
        require(block.timestamp < job.deadline, "Application deadline passed");
        require(!job.filled, "Position already filled");
        require(bytes(job.applications[msg.sender]).length == 0, "Already applied");
        
        job.applicants.push(msg.sender);
        job.applications[msg.sender] = _application;
        
        emit JobApplicationSubmitted(_jobId, msg.sender);
    }
    
    /**
     * @dev Hire candidate
     */
    function hireCandidate(uint256 _jobId, address _candidate) external {
        require(_jobId < jobPostingCount, "Job does not exist");
        JobPosting storage job = jobPostings[_jobId];
        require(msg.sender == job.employer, "Only employer can hire");
        require(bytes(job.applications[_candidate]).length > 0, "Candidate did not apply");
        require(!job.filled, "Position already filled");
        
        job.selectedCandidate = _candidate;
        job.filled = true;
        
        // Award reputation bonuses
        memberReputation[_candidate] += 100; // Hired candidate bonus
        memberReputation[job.employer] += 25; // Employer hiring bonus
        
        emit CandidateHired(_jobId, _candidate);
    }
    
    /**
     * @dev Verify member's skill
     */
    function verifySkill(address _member, string memory _skill) external onlyMember hasReputation(500) {
        require(isMember[_member], "Member does not exist");
        require(skillVerifications[msg.sender][_skill] >= 3, "Verifier lacks skill credibility");
        
        skillVerifications[_member][_skill] += 1;
        skillProviders[_skill].push(_member);
        
        // Award reputation for skill verification
        memberReputation[_member] += 15;
        memberReputation[msg.sender] += 5; // Verifier bonus
        
        emit SkillVerified(_member, _skill, msg.sender);
    }
    
    /**
     * @dev Update member credit score based on activity
     */
    function updateCreditScore(address _member) external onlyModerator {
        uint256 baseScore = 600;
        
        // Factor in reputation
        baseScore += (memberReputation[_member] / 10);
        
        // Factor in loan history
        uint256 completedLoans = 0;
        for (uint256 i = 0; i < memberLoans[_member].length; i++) {
            if (loanRequests[memberLoans[_member][i]].status == LoanStatus.COMPLETED) {
                completedLoans++;
            }
        }
        baseScore += (completedLoans * 50);
        
        // Factor in DAO participation
        if (memberProfiles[_member].votesParticipated > 50) {
            baseScore += 100;
        }
        
        // Cap at 1000
        if (baseScore > 1000) {
            baseScore = 1000;
        }
        
        memberCreditScore[_member] = baseScore;
        
        emit CreditScoreUpdated(_member, baseScore);
    }
    
    /**
     * @dev Calculate skill match percentage
     */
    function _calculateSkillMatch(address _member, string[] memory _requiredSkills) internal view returns (uint256) {
        if (_requiredSkills.length == 0) return 100;
        
        uint256 matchCount = 0;
        for (uint256 i = 0; i < _requiredSkills.length; i++) {
            if (skillVerifications[_member][_requiredSkills[i]] > 0) {
                matchCount++;
            }
        }
        
        return (matchCount * 100) / _requiredSkills.length;
    }
    
    /**
     * @dev Calculate square root (for quadratic voting)
     */
    function sqrt(uint256 x) internal pure returns (uint256) {
        if (x == 0) return 0;
        uint256 z = (x + 1) / 2;
        uint256 y = x;
        while (z < y) {
            y = z;
            z = (x / z + z) / 2;
        }
        return y;
    }
    
    /**
     * @dev Update DAO metrics
     */
    function updateDAOMetrics() external onlyModerator {
        daoMetrics.totalValueLocked = address(this).balance;
        daoMetrics.memberRetentionRate = _calculateRetentionRate();
        daoMetrics.votingParticipationRate = _calculateParticipationRate();
        daoMetrics.proposalSuccessRate = _calculateSuccessRate();
        daoMetrics.lastUpdated = block.timestamp;
        
        emit DAOMetricsUpdated(block.timestamp);
    }
    
    /**
     * @dev Helper functions for metrics calculation
     */
    function _calculateRetentionRate() internal view returns (uint256) {
        // Simplified retention calculation
        uint256 activeMembers = 0;
        // In a real implementation, iterate through members and check activity
        return (activeMembers * 100) / memberCount;
    }
    
    function _calculateParticipationRate() internal view returns (uint256) {
        // Simplified participation calculation
        if (proposalCount == 0) return 0;
        uint256 totalVotes = 0;
        // In a real implementation, sum up all votes across proposals
        return (totalVotes * 100) / (proposalCount * memberCount);
    }
    
    function _calculateSuccessRate() internal view returns (uint256) {
        // Simplified success rate calculation
        if (proposalCount == 0) return 0;
        uint256 successfulProposals = 0;
        // In a real implementation, count executed proposals
        return (successfulProposals * 100) / proposalCount;
    }
    
    /**
     * @dev Get member's complete profile information
     */
    function getMemberFullProfile(address _member) external view returns (
        string memory name,
        uint256 reputation,
        uint256 votingPower,
        uint256 creditScore,
        uint256 learningCredits,
        bool isInfluencer,
        uint256[] memory nftIds
    ) {
        MemberProfile storage profile = memberProfiles[_member];
        return (
            profile.name,
            memberReputation[_member],
            votingPower[_member],
            memberCreditScore[_member],
            memberLearningCredits[_member],
            isInfluencer[_member],
            memberNFTs[_member]
        );
    }
    
    /**
     * @dev Emergency pause function
     */
    function emergencyPause() external onlyAdmin {
        // Implementation would pause critical functions
        // This is a placeholder for emergency controls
    }
    
    /**
     * @dev Upgrade governance parameters
     */
    function upgradeGovernanceParams(
        uint256
