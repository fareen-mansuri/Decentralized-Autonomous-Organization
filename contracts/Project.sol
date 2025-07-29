 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

/**
 * @title Ultra Enhanced DAO - Next-Generation Decentralized Autonomous Organization
 * @dev A comprehensive smart contract with cutting-edge DAO features and advanced governance
 */
contract UltraEnhancedDAO is ERC721, ReentrancyGuard, AccessControl, Pausable {
    
    using Counters for Counters.Counter;
    using ECDSA for bytes32;
    
    // ============ ROLE DEFINITIONS ============
    
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
    bytes32 public constant VALIDATOR_ROLE = keccak256("VALIDATOR_ROLE");
    bytes32 public constant ORACLE_ROLE = keccak256("ORACLE_ROLE");
    bytes32 public constant BRIDGE_OPERATOR_ROLE = keccak256("BRIDGE_OPERATOR_ROLE");
    bytes32 public constant TREASURY_MANAGER_ROLE = keccak256("TREASURY_MANAGER_ROLE");
    bytes32 public constant QUANTUM_ADMIN_ROLE = keccak256("QUANTUM_ADMIN_ROLE");
    bytes32 public constant ESG_AUDITOR_ROLE = keccak256("ESG_AUDITOR_ROLE");
    bytes32 public constant ML_OPERATOR_ROLE = keccak256("ML_OPERATOR_ROLE");
    bytes32 public constant PREDICTION_ORACLE_ROLE = keccak256("PREDICTION_ORACLE_ROLE");
    bytes32 public constant SUSTAINABILITY_OFFICER_ROLE = keccak256("SUSTAINABILITY_OFFICER_ROLE");
    bytes32 public constant COMMUNITY_MODERATOR_ROLE = keccak256("COMMUNITY_MODERATOR_ROLE");
    bytes32 public constant EMERGENCY_COORDINATOR_ROLE = keccak256("EMERGENCY_COORDINATOR_ROLE");
    bytes32 public constant SECURITY_AUDITOR_ROLE = keccak256("SECURITY_AUDITOR_ROLE");
    
    // ============ NEW ADVANCED STRUCTS ============
    
    // Emergency Response & Crisis Management System
    struct EmergencyResponseSystem {
        uint256 systemId;
        mapping(uint256 => EmergencyProposal) emergencyProposals;
        mapping(address => bool) emergencyCoordinators;
        mapping(string => uint256) crisisThresholds; // Threshold for different crisis types
        mapping(uint256 => CrisisLevel) proposalCrisisLevel;
        uint256 emergencyVotingPeriod; // Shortened voting period for emergencies
        uint256 emergencyQuorum; // Reduced quorum for emergency decisions
        mapping(address => uint256) emergencyVotingPower; // Enhanced voting power during emergencies
        bool systemLockdown; // Complete system lockdown capability
        mapping(bytes32 => bool) emergencyProtocols; // Pre-approved emergency protocols
        uint256 lastEmergencyActivation; // Timestamp of last emergency
        mapping(address => uint256) emergencyResponseRating; // Coordinator performance rating
        uint256 maxEmergencyDuration; // Maximum duration for emergency state
        mapping(uint256 => address[]) emergencyResponseTeam; // Dedicated response team per emergency
        bool enableAutoEmergencyDetection; // AI-powered emergency detection
        mapping(string => uint256) riskMetrics; // Real-time risk metrics monitoring
        uint256 emergencyFundAllocation; // Emergency fund allocation percentage
    }
    
    struct EmergencyProposal {
        uint256 id;
        string crisisType; // Type of crisis (Security, Financial, Governance, etc.)
        CrisisLevel severity;
        address coordinator;
        uint256 activationTime;
        uint256 resolution_deadline;
        bool resolved;
        string actionPlan; // IPFS hash of action plan
        mapping(address => bool) coordinatorApproval;
        uint256 emergencyBudget;
        address[] affectedSystems; // Systems affected by the emergency
    }
    
    enum CrisisLevel {
        Low,        // 0 - Minor issues
        Moderate,   // 1 - Moderate impact
        High,       // 2 - Significant impact
        Critical,   // 3 - System-wide impact
        Catastrophic // 4 - Existential threat
    }
    
    // Advanced AI-Powered Proposal Analysis
    struct AIProposalAnalyzer {
        uint256 analyzerId;
        mapping(uint256 => ProposalAnalysis) proposalAnalyses;
        mapping(string => uint256) analysisModels; // Different AI models for analysis
        mapping(uint256 => uint256) complexityScore; // Proposal complexity (0-100)
        mapping(uint256 => uint256) implementationDifficulty; // Implementation difficulty (0-100)
        mapping(uint256 => string[]) requiredSkills; // Skills needed for implementation
        mapping(uint256 => uint256) estimatedCost; // AI-estimated implementation cost
        mapping(uint256 => uint256) successProbability; // Probability of success (0-100)
        mapping(uint256 => string[]) potentialRisks; // AI-identified potential risks
        mapping(uint256 => string[]) benefitAnalysis; // AI-analyzed potential benefits
        mapping(uint256 => uint256) stakeholderImpact; // Impact on different stakeholders
        bool enablePredictiveModeling; // Enable predictive outcome modeling
        mapping(uint256 => bytes32) analysisReports; // IPFS hash of detailed analysis
        uint256 modelAccuracy; // Overall model accuracy percentage
        mapping(string => uint256) modelWeights; // Weights for different analysis models
        mapping(uint256 => bool) humanReviewRequired; // Flag for human review requirement
        uint256 confidenceThreshold; // Minimum confidence for automated decisions
    }
    
    struct ProposalAnalysis {
        uint256 proposalId;
        uint256 overallScore; // Overall viability score (0-100)
        uint256 technicalFeasibility;
        uint256 economicViability;
        uint256 socialImpact;
        uint256 environmentalImpact;
        uint256 riskScore;
        string[] recommendations; // AI recommendations
        uint256 analysisTimestamp;
        bool analysisComplete;
    }
    
    // Dynamic NFT Membership System with Utilities
    struct NFTMembershipSystem {
        uint256 systemId;
        mapping(uint256 => MembershipNFT) membershipNFTs;
        mapping(address => uint256[]) memberTokens; // Multiple NFTs per member
        mapping(uint256 => NFTTier) tokenTiers; // NFT tier system
        mapping(NFTTier => uint256) tierBenefits; // Benefits per tier
        mapping(uint256 => uint256) nftVotingPower; // Voting power per NFT
        mapping(uint256 => uint256) nftStakingRewards; // Staking rewards per NFT
        mapping(uint256 => bytes32) nftMetadata; // Dynamic metadata IPFS hash
        mapping(uint256 => uint256) nftExperience; // Experience points per NFT
        mapping(uint256 => Achievement[]) nftAchievements; // Achievements per NFT
        mapping(uint256 => uint256) nftCreationTime; // NFT creation timestamp
        mapping(uint256 => bool) nftTransferable; // Transferability per NFT
        uint256 maxNFTsPerMember; // Maximum NFTs per member
        mapping(NFTTier => uint256) tierUpgradeRequirements; // Requirements for tier upgrade
        mapping(uint256 => string[]) nftUtilities; // Utilities enabled by NFT
        bool enableDynamicUpgrades; // Enable automatic tier upgrades
        mapping(uint256 => uint256) nftLastActivity; // Last activity timestamp per NFT
        uint256 activityDecayPeriod; // Period after which NFT benefits decay
    }
    
    struct MembershipNFT {
        uint256 tokenId;
        address owner;
        NFTTier tier;
        uint256 votingPower;
        uint256 reputationScore;
        uint256 stakingRewards;
        string[] specialRoles;
        bool isActive;
        uint256 experiencePoints;
        mapping(string => bool) unlockedFeatures;
    }
    
    enum NFTTier {
        Bronze,     // 0
        Silver,     // 1
        Gold,       // 2
        Platinum,   // 3
        Diamond,    // 4
        Legendary   // 5
    }
    
    struct Achievement {
        string name;
        string description;
        uint256 timestamp;
        uint256 rewardValue;
        bool claimed;
    }
    
    // Advanced Cross-Chain Bridge & Interoperability
    struct CrossChainBridge {
        uint256 bridgeId;
        mapping(uint256 => bool) supportedChains; // Supported chain IDs
        mapping(uint256 => address) chainContracts; // DAO contracts on other chains
        mapping(bytes32 => CrossChainMessage) pendingMessages;
        mapping(bytes32 => bool) processedMessages; // Prevent replay attacks
        mapping(address => bool) authorizedRelayers; // Cross-chain message relayers
        mapping(uint256 => uint256) chainVotingWeights; // Voting weight per chain
        mapping(bytes32 => uint256) messageTimeouts; // Message timeout periods
        mapping(uint256 => mapping(address => uint256)) chainMemberTokens; // Member tokens per chain
        uint256 bridgeFee; // Fee for cross-chain operations
        mapping(uint256 => bool) chainSyncEnabled; // Sync enabled per chain
        mapping(bytes32 => address[]) messageValidators; // Validators per message
        uint256 requiredValidations; // Required validations per message
        mapping(bytes32 => mapping(address => bool)) validatorSignatures;
        bool emergencyBridgeHalt; // Emergency bridge halt capability
        mapping(uint256 => uint256) chainLatency; // Expected latency per chain
        mapping(bytes32 => uint256) messageRetries; // Retry count per message
        uint256 maxRetries; // Maximum retry attempts
    }
    
    struct CrossChainMessage {
        bytes32 messageId;
        uint256 sourceChain;
        uint256 targetChain;
        bytes payload;
        address sender;
        uint256 timestamp;
        uint256 nonce;
        bool executed;
        uint256 validationCount;
    }
    
    // Sophisticated Treasury Diversification Engine
    struct TreasuryDiversificationEngine {
        uint256 engineId;
        mapping(address => AssetAllocation) assetAllocations;
        mapping(string => InvestmentStrategy) strategies;
        mapping(address => uint256) riskRatings; // Risk rating per asset (0-100)
        mapping(string => uint256) strategyPerformance; // Historical performance per strategy
        uint256 totalPortfolioValue; // Total portfolio value in USD
        mapping(address => uint256) assetPrices; // Current asset prices
        mapping(string => uint256) allocationLimits; // Maximum allocation per asset type
        bool enableAutoRebalancing; // Automatic portfolio rebalancing
        uint256 rebalanceFrequency; // Rebalancing frequency in seconds
        mapping(address => bool) approvedAssets; // Whitelist of approved assets
        mapping(string => address[]) strategyAssets; // Assets in each strategy
        uint256 emergencyLiquidityRatio; // Minimum liquidity ratio
        mapping(address => uint256) yieldRates; // Current yield rates per asset
        mapping(string => uint256) strategyRiskLimits; // Risk limits per strategy
        bool enableYieldFarming; // Enable DeFi yield farming
        mapping(address => address) lpTokens; // LP tokens for yield farming
        uint256 impermanentLossThreshold; // Maximum acceptable IL
        mapping(bytes32 => uint256) hedgingPositions; // Hedging positions
    }
    
    struct AssetAllocation {
        address asset;
        uint256 targetAllocation; // Target allocation percentage
        uint256 currentAllocation; // Current allocation percentage
        uint256 minAllocation; // Minimum allocation percentage
        uint256 maxAllocation; // Maximum allocation percentage
        uint256 lastRebalance; // Last rebalancing timestamp
        string assetType; // Asset type (Crypto, Stablecoin, Yield, etc.)
    }
    
    struct InvestmentStrategy {
        string name;
        string description;
        uint256 riskLevel; // 0-100
        uint256 expectedReturn; // Expected annual return percentage
        address[] requiredAssets;
        uint256 minInvestment; // Minimum investment amount
        bool active;
        uint256 totalInvested;
        uint256 currentValue;
    }
    
    // Advanced Member Reputation & Skill System
    struct AdvancedReputationSystem {
        uint256 systemId;
        mapping(address => MemberProfile) memberProfiles;
        mapping(string => SkillCategory) skillCategories;
        mapping(address => mapping(string => SkillRating)) memberSkills;
        mapping(address => address[]) endorsements; // Member endorsements
        mapping(address => mapping(address => mapping(string => uint256))) skillEndorsements;
        mapping(address => uint256) overallReputation; // Overall reputation score
        mapping(address => uint256) contributionValue; // Quantified contribution value
        mapping(string => uint256) skillDemand; // Current demand for skills
        mapping(address => string[]) completedProjects; // Completed projects per member
        mapping(string => address[]) projectContributors; // Contributors per project
        mapping(address => uint256) projectSuccessRate; // Success rate per member
        uint256 reputationDecayRate; // Reputation decay over time
        mapping(address => uint256) lastReputationUpdate;
        mapping(address => Badge[]) memberBadges; // Achievement badges
        mapping(string => BadgeRequirements) badgeRequirements;
        bool enablePeerReview; // Enable peer review system
        mapping(bytes32 => PeerReview) peerReviews; // Peer review records
        uint256 reviewIncentive; // Incentive for providing reviews
    }
    
    struct MemberProfile {
        address memberAddress;
        string publicProfile; // IPFS hash of public profile
        uint256 joinDate;
        uint256 totalContributions;
        uint256 successfulProposals;
        uint256 votingAccuracy; // How often member votes align with outcomes
        string[] specializations;
        uint256 mentorshipRating;
        bool availableForMentorship;
        uint256 responseTime; // Average response time to DAO activities
    }
    
    struct SkillCategory {
        string name;
        string description;
        uint256 weight; // Weight in overall reputation calculation
        string[] subSkills;
        uint256 certificationRequirement; // Required certifications
        address[] verifiers; // Authorized skill verifiers
    }
    
    struct SkillRating {
        uint256 score; // 0-100
        uint256 endorsementCount;
        uint256 lastUpdate;
        bool certified;
        address[] certifiers;
        string[] evidence; // IPFS hashes of skill evidence
    }
    
    struct Badge {
        string name;
        string description;
        uint256 earnedDate;
        uint256 value; // Badge value/rarity
        string imageHash; // IPFS hash of badge image
        bool transferable;
    }
    
    struct BadgeRequirements {
        string badgeName;
        uint256 requiredReputation;
        string[] requiredSkills;
        uint256[] skillThresholds;
        uint256 requiredContributions;
        bool renewable; // Whether badge needs to be renewed
        uint256 validityPeriod;
    }
    
    struct PeerReview {
        bytes32 reviewId;
        address reviewer;
        address reviewee;
        string category; // Skill category being reviewed
        uint256 rating; // 0-100
        string feedback; // IPFS hash of detailed feedback
        uint256 timestamp;
        bool verified;
        uint256 helpfulnessRating; // How helpful the review was
    }
    
    // Real-Time Governance Analytics & Insights
    struct GovernanceInsights {
        uint256 insightId;
        mapping(uint256 => ProposalMetrics) proposalMetrics;
        mapping(address => ParticipationAnalytics) memberAnalytics;
        mapping(string => uint256) topicTrends; // Trending topics in governance
        mapping(uint256 => uint256) decisionSpeed; // Time from proposal to decision
        mapping(address => uint256) influenceNetwork; // Member influence network
        mapping(uint256 => uint256) controversyIndex; // Proposal controversy level
        uint256 governanceHealthScore; // Overall governance health (0-100)
        mapping(uint256 => string[]) discussionKeywords; // Keywords from discussions
        mapping(address => uint256) consistencyScore; // Voting consistency per member
        mapping(uint256 => uint256) implementationSuccess; // Implementation success rate
        mapping(string => uint256) expertiseUtilization; // How well expertise is utilized
        uint256 communityEngagement; // Overall community engagement level
        mapping(uint256 => uint256) proposalComplexity; // Complexity analysis
        mapping(address => string[]) preferredTopics; // Member topic preferences
        mapping(uint256 => uint256) executionEfficiency; // Execution efficiency per proposal
        bool enablePredictiveAnalytics; // Enable outcome prediction
        mapping(uint256 => uint256) predictedSuccess; // AI-predicted success probability
    }
    
    struct ProposalMetrics {
        uint256 proposalId;
        uint256 discussionVolume; // Amount of discussion generated
        uint256 expertInvolvement; // Level of expert involvement
        uint256 communitySupport; // Community support level
        uint256 implementationRisk; // Risk assessment for implementation
        uint256 stakeholderAlignment; // Stakeholder alignment level
        string[] keyDebatePoints; // Main points of debate
        uint256 consensusLevel; // Level of consensus reached
    }
    
    struct ParticipationAnalytics {
        address member;
        uint256 proposalsVoted; // Number of proposals voted on
        uint256 proposalsCreated; // Number of proposals created
        uint256 discussionParticipation; // Level of discussion participation
        uint256 expertiseContribution; // Contribution in area of expertise
        uint256 mentorshipActivity; // Mentorship activity level
        uint256 responseLatency; // Average response time to proposals
        string[] activeTopics; // Topics member is most active in
        uint256 influenceScore; // Member's influence on outcomes
    }
    
    // ============ EXISTING ENHANCED STRUCTS ============
    
    // Enhanced Core Proposal Structure
    struct Proposal {
        uint256 id;
        string title;
        string description;
        address proposer;
        uint256 votesFor;
        uint256 votesAgainst;
        uint256 startTime;
        uint256 endTime;
        bool executed;
        bool exists;
        bytes32 ipfsHash;
        uint256 requiredQuorum;
        mapping(address => bool) hasVoted;
        mapping(address => uint256) voteWeight;
        ProposalType proposalType;
        ProposalCategory category;
        uint256 executionDeadline;
        bool urgent;
        uint256 budgetRequested;
        address[] requiredApprovers; // Specific approvers needed
        mapping(address => bool) approverVotes;
        uint256 implementationTimeframe;
        string[] deliverables; // Expected deliverables
        mapping(string => bool) deliverablesCompleted;
    }
    
    enum ProposalType {
        Governance,
        Treasury,
        Technical,
        Social,
        Environmental,
        Emergency,
        Constitutional,
        Investment,
        Partnership,
        Research
    }
    
    enum ProposalCategory {
        Low,      // Minor changes
        Medium,   // Moderate impact
        High,     // Significant impact
        Critical  // System-wide changes
    }
    
    // Enhanced Member Structure
    struct Member {
        address memberAddress;
        uint256 joinDate;
        uint256 votingPower;
        uint256 reputationScore;
        bool isActive;
        string[] expertiseAreas;
        uint256 contributionScore;
        uint256 lastActiveTime;
        MemberTier tier;
        uint256 stakedTokens;
        bool isValidator;
        uint256 mentorshipScore;
        uint256[] ownedNFTs; // NFT token IDs owned
        mapping(string => uint256) skillLevels; // Skill levels per category
        uint256 totalEarned; // Total tokens earned from contributions
        string profileHash; // IPFS hash of member profile
        bool publicProfile; // Whether profile is public
    }
    
    enum MemberTier {
        Newcomer,   // 0
        Bronze,     // 1
        Silver,     // 2
        Gold,       // 3
        Platinum,   // 4
        Diamond,    // 5
        Elite       // 6
    }
    
    // ============ STATE VARIABLES ============
    
    // Core mappings
    mapping(uint256 => Proposal) public proposals;
    mapping(address => Member) public members;
    mapping(address => bool) public isMember;
    
    // Advanced system mappings
    mapping(uint256 => EmergencyResponseSystem) public emergencySystem;
    mapping(uint256 => AIProposalAnalyzer) public aiAnalyzers;
    mapping(uint256 => NFTMembershipSystem) public nftSystems;
    mapping(uint256 => CrossChainBridge) public crossChainBridges;
    mapping(uint256 => TreasuryDiversificationEngine) public treasuryEngines;
    mapping(uint256 => AdvancedReputationSystem) public reputationSystems;
    mapping(uint256 => GovernanceInsights) public governanceInsights;
    
    // System counters
    Counters.Counter public proposalCount;
    Counters.Counter public memberCount;
    Counters.Counter public emergencySystemCount;
    Counters.Counter public aiAnalyzerCount;
    Counters.Counter public nftSystemCount;
    Counters.Counter public bridgeCount;
    Counters.Counter public treasuryEngineCount;
    Counters.Counter public reputationSystemCount;
    Counters.Counter public insightSystemCount;
    
    // Configuration
    struct DAOConfig {
        uint256 minProposalThreshold;
        uint256 votingPeriod;
        uint256 quorumThreshold;
        uint256 passingThreshold;
        uint256 membershipFee;
        uint256 proposalFee;
        address treasuryAddress;
        uint256 stakingRewardRate;
        uint256 minStakingAmount;
        bool enableTierSystem;
        bool enableEmergencySystem;
        bool enableAIAnalysis;
        bool enableNFTMembership;
        bool enableCrossChain;
        bool enableAdvancedReputation;
        uint256 maxProposalsPerMember; // Max proposals per member per period
        uint256 proposalCooldown; // Cooldown between proposals
        bool enableGovernanceInsights;
        uint256 emergencyActivationThreshold; // Threshold for emergency activation
    }
    
    DAOConfig public daoConfig;
    
    // Additional state variables
    mapping(address => uint256) public lastProposalTime; // Proposal cooldown tracking
    mapping(address => uint256) public proposalsThisPeriod; // Proposal count per period
    uint256 public currentPeriodStart; // Current governance period start
    uint256 public governancePeriodDuration; // Duration of governance periods
    bool public emergencyMode; // Global emergency mode flag
    uint256 public lastEmergencyActivation; // Last emergency activation timestamp
    
    // ============ EVENTS ============
    
    // Core events
    event ProposalCreated(uint256 indexed proposalId, address indexed proposer, string title, ProposalType proposalType);
    event VoteCast(uint256 indexed proposalId, address indexed voter, bool support, uint256 weight);
    event ProposalExecuted(uint256 indexed proposalId, bool success);
    event MemberJoined(address indexed member, uint256 tokenId);
    
    // Advanced system events
    event EmergencyActivated(uint256 indexed systemId, CrisisLevel level, address coordinator);
    event EmergencyResolved(uint256 indexed emergencyId, bool successful);
    event AIAnalysisCompleted(uint256 indexed proposalId, uint256 overallScore, uint256 riskScore);
    event NFTMembershipUpgraded(uint256 indexed tokenId, NFTTier newTier);
    event CrossChainMessageSent(bytes32 indexed messageId, uint256 sourceChain, uint256 targetChain);
    event CrossChainMessageReceived(bytes32 indexed messageId, uint256 sourceChain);
    event TreasuryRebalanced(uint256 indexed engineId, uint256 newTotalValue);
    event ReputationUpdated(address indexed member, uint256 newReputation, string category);
    event SkillEndorsed(address indexed member, address indexed endorser, string skill);
    event BadgeEarned(address indexed member, string badgeName);
    event PeerReviewSubmitted(bytes32 indexed reviewId, address reviewer, address reviewee);
    event GovernanceInsightGenerated(uint256 indexed insightId, string insightType, uint256 value);
    event MemberTierUpdated(address indexed member, MemberTier newTier);
    event EmergencyFundUsed(uint256 amount, string reason);
    
    // ============ MODIFIERS ============
    
    modifier onlyMember() {
        require(isMember[msg.sender], "Not a DAO member");
        _;
    }
    
    modifier onlyActiveMember() {
        require(isMember[msg.sender] && members[msg.sender].isActive, "Not an active member");
        _;
    }
    
    modifier proposalExists(uint256 _proposalId) {
        require(_proposalId < proposalCount.current(), "Proposal does not exist");
        _;
    }
    
    modifier votingActive(uint256 _proposalId) {
        require(
            block.timestamp >= proposals[_proposalId].startTime &&
            block.timestamp <= proposals[_proposalId].endTime,
            "Voting period not active"
        );
        _;
    }
    
    modifier onlyTier(MemberTier _minTier) {
        require(uint256(members[msg.sender].tier) >= uint256(_minTier), "Insufficient member tier");
        _;
    }
    
    modifier whenNotEmergency() {
        require(!emergencyMode, "Emergency mode active");
        _;
    }
    
    modifier onlyEmergencyCoordinator() {
        require(hasRole(EMERGENCY_COORDINATOR_ROLE, msg.sender), "Not an emergency coordinator");
        _;
    }
    
    modifier proposalRateLimit() {
        require(
            block.timestamp >= lastProposalTime[msg.sender] + daoConfig.proposalCooldown,
            "Proposal cooldown not met"
        );
        require(
            proposalsThisPeriod[msg.sender] < daoConfig.maxProposalsPerMember,
            "Max proposals per period exceeded"
        );
        _;
    }
    
    // ============ CONSTRUCTOR ============
    
    constructor(
        string memory _name,
        string memory _symbol,
        address _treasuryAddress
    ) ERC721(_name, _symbol) {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(ADMIN_ROLE, msg.sender);
        _grantRole(EMERGENCY_COORDINATOR_ROLE, msg.sender);
        
        daoConfig = DAOConfig({
            minProposalThreshold: 1000 * 10**18,
            votingPeriod: 7 days,
            quorumThreshold: 10,
            passingThreshold: 51,
            membershipFee: 0.1 ether,
            proposalFee: 0.01 ether,
            treasuryAddress: _treasuryAddress,
            stakingRewardRate: 5,
            minStakingAmount: 100 * 10**18,
            enableTierSystem: true,
            enableEmergencySystem: true,
            enableAIAnalysis: true,
            enableNFTMembership: true,
            enableCrossChain: false,
            enableAdvancedReputation: true,
            maxProposalsPerMember: 5,
            proposalCooldown: 1 days,
            enableGovernanceInsights: true,
            emergencyActivationThreshold: 3
        });
        
        governancePeriodDuration = 30 days;
        currentPeriodStart = block.timestamp;
        
        _initializeDefaultSystems();
    }
    
    // ============ CORE MEMBERSHIP FUNCTIONS ============
    
    function joinDAO() external payable nonReentrant whenNotPaused {
        require(msg.value >= daoConfig.membershipFee, "Insufficient membership fee");
        require(!isMember[msg.sender], "Already a member");
        
        uint256 tokenId = memberCount.current();
        memberCount.increment();
        _safeMint(msg.sender, tokenId);
        
        members[msg.sender] = Member({
            memberAddress: msg.sender,
            joinDate: block.timestamp,
            votingPower: 1,
            reputationScore: 100,
            isActive: true,
            expertiseAreas: new string[](0),
            contributionScore: 0,
            lastActiveTime: block.timestamp,
            tier: MemberTier.Newcomer,
            stakedTokens: 0,
            isValidator: false,
            mentorshipScore: 0,
            ownedNFTs: new uint256[](0),
            totalEarned: 0,
            profileHash: "",
            publicProfile: false
        });
        
        isMember[msg.sender] = true;
        
        // Mint NFT membership if enabled
        if (daoConfig.enableNFTMembership && nftSystemCount.current() > 0) {
            _mintMembershipNFT(msg.sender, NFTTier.Bronze);
        }
        
        payable(daoConfig.treasuryAddress).transfer(msg.value);
        emit MemberJoined(msg.sender, tokenId);
    }
    
    function createProposal(
        string memory _title,
        string memory _description,
        bytes32 _ipfsHash,
        ProposalType _proposalType,
        ProposalCategory _category,
        uint256 _budgetRequested,
    
     
