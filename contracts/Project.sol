// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title Ultra Enhanced DAO - Next-Generation Decentralized Autonomous Organization
 * @dev A comprehensive smart contract with cutting-edge DAO features and advanced governance
 */
contract UltraEnhancedDAO {
    // ============ EXISTING STRUCTS (keeping all previous ones) ============
    
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
        uint256 sentimentScore;
        mapping(address => uint256) memberEngagement;
        bool requiresAudit;
        address auditor;
        bool auditPassed;
        uint256 estimatedImpact;
        string[] dependencies;
        uint256 carbonFootprint;
        bool isUrgent;
        // NEW FIELDS
        uint256 aiConfidenceScore;
        mapping(address => bool) expertEndorsements;
        uint256 riskScore;
        bool hasSmartContractRisk;
        uint256 marketImpactScore;
        mapping(string => uint256) stakeholderWeights;
        bool requiresMultiSigExecution;
        address[] requiredSigners;
        mapping(address => bool) signerApproval;
        uint256 signatureCount;
        bool isRecurringProposal;
        uint256 recurringInterval;
        uint256 maxRecurrences;
        uint256 currentRecurrence;
    }
    
    // ============ NEW ADVANCED STRUCTS ============
    
    // AI-Powered Governance Assistant
    struct AIGovernanceBot {
        uint256 id;
        string name;
        string model; // GPT-4, Claude, etc.
        address controller;
        bool isActive;
        uint256 accuracy; // Historical accuracy percentage
        mapping(uint256 => string) proposalAnalysis;
        mapping(uint256 => uint256) riskAssessments;
        mapping(uint256 => string) recommendations;
        uint256 totalAnalyses;
        uint256 correctPredictions;
        mapping(string => uint256) specializations; // governance, finance, tech, etc.
        bool canAutoVote;
        uint256 delegatedVotingPower;
        mapping(address => bool) authorizedDelegators;
    }
    
    // Dynamic NFT Membership System
    struct DynamicMembershipNFT {
        uint256 tokenId;
        address holder;
        MembershipTier tier;
        uint256 experiencePoints;
        uint256 level;
        mapping(string => uint256) achievements;
        mapping(string => bool) badges;
        uint256 powerMultiplier; // Voting power multiplier
        uint256 lastLevelUp;
        string metadataURI;
        bool isEvolvable;
        uint256 stakingRewards;
        mapping(uint256 => bool) accessRights; // Which features they can access
        uint256 socialCredits;
        mapping(address => bool) endorsements;
        uint256 mentorshipCount;
        uint256 innovationScore;
    }
    
    // Liquid Democracy System
    struct DelegationChain {
        address delegator;
        address delegate;
        uint256 votingPower;
        string[] topics; // Specific topics for delegation
        uint256 delegationTime;
        bool isActive;
        uint256 chainLength; // Prevent infinite chains
        mapping(address => bool) visited; // Prevent cycles
        bool allowsSubDelegation;
        uint256 expiryTime;
        mapping(string => uint256) topicWeights;
    }
    
    // Cross-Chain Governance Bridge
    struct CrossChainProposal {
        uint256 localProposalId;
        uint256[] remoteProposalIds;
        mapping(uint256 => address) chainContracts; // chainId => contract address
        mapping(uint256 => bool) chainVoteStatus;
        uint256 totalChains;
        uint256 approvedChains;
        uint256 requiredChainConsensus; // Percentage needed
        bool isMultiChain;
        mapping(uint256 => bytes) crossChainData;
        uint256 syncTimestamp;
        bool isExecutedOnAllChains;
    }
    
    // Advanced Reputation System
    struct ReputationMetrics {
        uint256 baseReputation;
        mapping(string => uint256) domainReputation; // tech, finance, governance, etc.
        uint256 temporalDecay; // Reputation decay rate
        uint256 lastActivity;
        mapping(address => uint256) peerEndorsements;
        uint256 contributionWeight;
        mapping(uint256 => uint256) proposalImpact; // Historical proposal impact
        uint256 consistencyScore; // How consistent their voting is
        uint256 expertiseDepth;
        mapping(string => uint256) certifiedSkills;
        uint256 leadershipScore;
        uint256 collaborationRating;
        bool isSubjectMatterExpert;
        string[] expertDomains;
        uint256 mentorshipImpact;
    }
    
    // DAO Treasury Optimization AI
    struct TreasuryAI {
        uint256 id;
        string strategy;
        uint256 riskTolerance; // 1-10 scale
        mapping(address => uint256) assetAllocations;
        uint256 totalAUM; // Assets Under Management
        uint256 expectedReturn;
        uint256 actualReturn;
        uint256 performanceScore;
        bool isActive;
        address[] approvedProtocols;
        mapping(address => uint256) protocolLimits;
        uint256 rebalanceFrequency;
        uint256 lastRebalance;
        mapping(string => uint256) marketSentiment;
        bool autoRebalanceEnabled;
        uint256 stopLossThreshold;
        uint256 maxDrawdown;
    }
    
    // Decentralized Identity Verification
    struct IdentityCredential {
        uint256 credentialId;
        address holder;
        string credentialType; // KYC, Education, Professional, etc.
        bytes credentialHash; // Hashed credential data
        address[] verifiers;
        mapping(address => bool) verifierApproval;
        uint256 issuanceDate;
        uint256 expiryDate;
        bool isRevoked;
        uint256 trustScore;
        mapping(string => string) attributes; // Name, Education, etc.
        bool isPrivate; // Zero-knowledge proof verification
        bytes32 merkleRoot; // For ZK proofs
        uint256 verificationLevel; // 1-5 scale
    }
    
    // Advanced Analytics and Insights
    struct DAOAnalytics {
        uint256 timestamp;
        uint256 memberGrowthRate;
        uint256 proposalQuality; // AI-assessed quality score
        uint256 decisionEfficiency; // Time from proposal to execution
        uint256 treasuryUtilization;
        mapping(string => uint256) activityHeatmap; // Day/hour activity patterns
        uint256 memberSatisfaction; // Survey-based score
        uint256 innovationIndex;
        mapping(address => uint256) memberContributionScores;
        uint256 diversityIndex; // Member diversity metrics
        uint256 sustainabilityScore;
        mapping(string => uint256) topicPopularity;
        uint256 governanceHealth; // Overall health score
        uint256 networkEffects; // Member interaction strength
        uint256 knowledgeCapital; // Collective expertise value
    }
    
    // Gamification and Social Features
    struct SocialGraph {
        address member;
        address[] connections;
        mapping(address => uint256) connectionStrength;
        mapping(address => string) connectionType; // mentor, peer, collaborator
        uint256 socialCapital;
        uint256 influenceRadius; // How many members they can influence
        mapping(string => uint256) socialMetrics; // likes, shares, mentions
        uint256 viralityScore; // How viral their content is
        bool isInfluencer;
        uint256 followerCount;
        mapping(address => bool) followers;
        uint256 trustNetwork; // Web of trust score
        mapping(string => uint256) contentEngagement;
    }
    
    // Real-World Asset Integration
    struct RealWorldAsset {
        uint256 assetId;
        string assetType; // Real Estate, Art, Commodities, etc.
        uint256 valuation;
        address oracle; // Price oracle
        bool isTokenized;
        uint256 tokenSupply;
        mapping(address => uint256) ownership;
        string location;
        bytes32 legalDocumentHash;
        bool isInsured;
        uint256 insuranceValue;
        address custodian;
        uint256 lastValuation;
        mapping(string => string) metadata;
        bool isLiquid; // Can be easily sold
        uint256 maintenanceCost;
        uint256 expectedReturn;
    }
    
    // Decentralized Arbitration System
    struct ArbitrationCase {
        uint256 caseId;
        address plaintiff;
        address defendant;
        string disputeType;
        string description;
        uint256 amount; // Amount in dispute
        address[] arbitrators;
        mapping(address => bool) arbitratorVotes;
        mapping(address => string) arbitratorReasons;
        uint256 votingDeadline;
        bool isResolved;
        address winner;
        uint256 settlement;
        uint256 arbitrationFee;
        mapping(address => uint256) arbitratorFees;
        string evidence; // IPFS hash
        uint256 createdAt;
        ArbitrationStatus status;
        mapping(address => bool) hasAppeared;
    }
    
    // Advanced Voting Mechanisms
    struct ConvictionVoting {
        uint256 proposalId;
        mapping(address => uint256) conviction; // Accumulated conviction
        mapping(address => uint256) lastUpdate; // Last conviction update
        uint256 totalConviction;
        uint256 convictionThreshold;
        uint256 halfLife; // Conviction decay half-life
        bool isPassing;
        uint256 passingTime;
        mapping(address => uint256) stakedTokens;
        uint256 totalStaked;
        uint256 fundingRequested;
        uint256 maxRatio; // Max funding ratio
    }
    
    // DAO Partnerships and Alliances
    struct PartnershipAgreement {
        uint256 agreementId;
        address partnerDAO;
        string partnershipType; // Strategic, Financial, Technical, etc.
        uint256 duration;
        uint256 startTime;
        mapping(string => uint256) terms; // Numerical terms
        mapping(string => string) conditions; // Text conditions
        bool isActive;
        uint256 sharedValue; // Value created together
        mapping(address => bool) approvals;
        uint256 requiredApprovals;
        string[] deliverables;
        mapping(string => bool) deliverableStatus;
        uint256 performanceScore;
        bool autoRenewal;
        uint256 exitClause;
    }
    
    // Knowledge Management System
    struct KnowledgeBase {
        uint256 articleId;
        string title;
        string content; // IPFS hash
        address author;
        string[] tags;
        uint256 views;
        uint256 rating;
        mapping(address => uint256) userRatings;
        uint256 ratingCount;
        bool isVerified;
        address[] verifiers;
        uint256 lastUpdated;
        string category;
        uint256 difficulty; // 1-5 scale
        string[] prerequisites;
        mapping(address => bool) hasRead;
        uint256 readCount;
        bool isPublic;
        uint256 bountyReward; // Reward for creating quality content
    }
    
    // ============ NEW ENUMS ============
    
    enum ArbitrationStatus {
        FILED,
        ARBITRATORS_SELECTED,
        EVIDENCE_PERIOD,
        DELIBERATION,
        DECIDED,
        APPEALED,
        FINAL
    }
    
    enum VerificationLevel {
        BASIC,
        ENHANCED,
        PREMIUM,
        INSTITUTIONAL,
        GOVERNMENT
    }
    
    enum TreasuryAction {
        INVEST,
        DIVEST,
        REBALANCE,
        HEDGE,
        STAKE,
        UNSTAKE,
        BRIDGE
    }
    
    enum ProposalComplexity {
        SIMPLE,
        MODERATE,
        COMPLEX,
        CRITICAL,
        EMERGENCY
    }
    
    // ============ NEW STATE VARIABLES ============
    
    mapping(uint256 => AIGovernanceBot) public aiGovBots;
    mapping(uint256 => DynamicMembershipNFT) public membershipNFTs;
    mapping(address => DelegationChain) public delegationChains;
    mapping(uint256 => CrossChainProposal) public crossChainProposals;
    mapping(address => ReputationMetrics) public reputationSystem;
    mapping(uint256 => TreasuryAI) public treasuryAIs;
    mapping(uint256 => IdentityCredential) public identityCredentials;
    mapping(uint256 => DAOAnalytics) public analyticsHistory;
    mapping(address => SocialGraph) public socialGraphs;
    mapping(uint256 => RealWorldAsset) public realWorldAssets;
    mapping(uint256 => ArbitrationCase) public arbitrationCases;
    mapping(uint256 => ConvictionVoting) public convictionVotes;
    mapping(uint256 => PartnershipAgreement) public partnerships;
    mapping(uint256 => KnowledgeBase) public knowledgeBase;
    
    // Enhanced mappings
    mapping(address => uint256[]) public memberCredentials;
    mapping(address => mapping(string => uint256)) public skillEndorsements;
    mapping(address => uint256) public socialCapitalScore;
    mapping(address => bool) public isVerifiedExpert;
    mapping(string => address[]) public expertsByDomain;
    mapping(uint256 => uint256[]) public proposalDependencies;
    mapping(address => uint256[]) public delegatedVotingPower;
    mapping(uint256 => mapping(uint256 => bool)) public crossChainSync;
    mapping(address => uint256) public liquidDemocracyPower;
    
    // New counters
    uint256 public aiGovBotCount;
    uint256 public credentialCount;
    uint256 public arbitrationCaseCount;
    uint256 public partnershipCount;
    uint256 public knowledgeBaseCount;
    uint256 public realWorldAssetCount;
    
    // Advanced configuration
    struct AdvancedConfig {
        uint256 aiAnalysisWeight; // How much weight AI analysis gets
        uint256 expertBoostMultiplier; // Voting power boost for experts
        uint256 delegationDepthLimit;
        uint256 crossChainConsensusThreshold;
        uint256 reputationDecayRate;
        uint256 minConvictionTime;
        uint256 arbitrationTimeout;
        uint256 knowledgeRewardPool;
        bool enableLiquidDemocracy;
        bool enableCrossChainGovernance;
        bool enableAIAssistance;
        bool enableReputationVoting;
    }
    
    AdvancedConfig public advancedConfig;
    
    // ============ NEW EVENTS ============
    
    event AIAnalysisCompleted(uint256 indexed proposalId, uint256 riskScore, string recommendation);
    event ExpertEndorsementReceived(uint256 indexed proposalId, address indexed expert, string domain);
    event DelegationCreated(address indexed delegator, address indexed delegate, string[] topics);
    event DelegationRevoked(address indexed delegator, address indexed delegate);
    event CrossChainSyncInitiated(uint256 indexed proposalId, uint256[] chainIds);
    event ReputationUpdated(address indexed member, uint256 newReputation, string domain);
    event TreasuryOptimizationExecuted(uint256 indexed strategyId, uint256 expectedReturn);
    event IdentityVerified(address indexed member, uint256 indexed credentialId, VerificationLevel level);
    event ArbitrationCaseFiled(uint256 indexed caseId, address indexed plaintiff, address indexed defendant);
    event ArbitrationDecision(uint256 indexed caseId, address indexed winner, uint256 settlement);
    event ConvictionThresholdReached(uint256 indexed proposalId, uint256 totalConviction);
    event PartnershipEstablished(uint256 indexed agreementId, address indexed partnerDAO, string partnershipType);
    event KnowledgeArticleCreated(uint256 indexed articleId, address indexed author, string title);
    event SocialGraphUpdated(address indexed member, uint256 newSocialCapital);
    event RealWorldAssetTokenized(uint256 indexed assetId, uint256 tokenSupply, uint256 valuation);
    event AIBotDeployed(uint256 indexed botId, string name, string model);
    event MembershipNFTEvolved(uint256 indexed tokenId, uint256 newLevel, uint256 experiencePoints);
    
    // ============ MODIFIERS ============
    
    modifier onlyVerifiedExpert(string memory _domain) {
        require(isVerifiedExpert[msg.sender], "Not a verified expert");
        require(reputationSystem[msg.sender].expertDomains.length > 0, "No expert domains");
        _;
    }
    
    modifier hasCredential(VerificationLevel _level) {
        bool hasValidCredential = false;
        for (uint256 i = 0; i < memberCredentials[msg.sender].length; i++) {
            uint256 credId = memberCredentials[msg.sender][i];
            if (identityCredentials[credId].verificationLevel >= uint256(_level) && 
                !identityCredentials[credId].isRevoked &&
                identityCredentials[credId].expiryDate > block.timestamp) {
                hasValidCredential = true;
                break;
            }
        }
        require(hasValidCredential, "Insufficient verification level");
        _;
    }
    
    modifier onlyArbitrator(uint256 _caseId) {
        bool isArbitrator = false;
        for (uint256 i = 0; i < arbitrationCases[_caseId].arbitrators.length; i++) {
            if (arbitrationCases[_caseId].arbitrators[i] == msg.sender) {
                isArbitrator = true;
                break;
            }
        }
        require(isArbitrator, "Not an arbitrator for this case");
        _;
    }
    
    // ============ ADVANCED FUNCTIONS ============
    
    /**
     * @dev Deploy AI Governance Bot
     */
    function deployAIGovernanceBot(
        string memory _name,
        string memory _model,
        string[] memory _specializations,
        bool _canAutoVote
    ) external onlyAdmin {
        uint256 botId = aiGovBotCount++;
        AIGovernanceBot storage bot = aiGovBots[botId];
        bot.id = botId;
        bot.name = _name;
        bot.model = _model;
        bot.controller = msg.sender;
        bot.isActive = true;
        bot.canAutoVote = _canAutoVote;
        
        for (uint256 i = 0; i < _specializations.length; i++) {
            bot.specializations[_specializations[i]] = 100; // Initial specialization score
        }
        
        emit AIBotDeployed(botId, _name, _model);
    }
    
    /**
     * @dev AI analyzes proposal and provides recommendations
     */
    function analyzeProposalWithAI(
        uint256 _proposalId,
        uint256 _botId,
        uint256 _riskScore,
        string memory _analysis,
        string memory _recommendation
    ) external {
        require(_botId < aiGovBotCount, "AI bot does not exist");
        require(aiGovBots[_botId].controller == msg.sender, "Not authorized to control this bot");
        require(proposals[_proposalId].exists, "Proposal does not exist");
        
        AIGovernanceBot storage bot = aiGovBots[_botId];
        bot.proposalAnalysis[_proposalId] = _analysis;
        bot.riskAssessments[_proposalId] = _riskScore;
        bot.recommendations[_proposalId] = _recommendation;
        bot.totalAnalyses++;
        
        // Update proposal with AI insights
        proposals[_proposalId].aiConfidenceScore = _calculateAIConfidence(_riskScore);
        proposals[_proposalId].riskScore = _riskScore;
        
        emit AIAnalysisCompleted(_proposalId, _riskScore, _recommendation);
    }
    
    /**
     * @dev Create delegation for liquid democracy
     */
    function createDelegation(
        address _delegate,
        string[] memory _topics,
        uint256 _expiryTime,
        bool _allowsSubDelegation
    ) external onlyMember {
        require(_delegate != msg.sender, "Cannot delegate to yourself");
        require(isMember[_delegate], "Delegate must be a member");
        require(_expiryTime > block.timestamp, "Expiry must be in future");
        
        DelegationChain storage delegation = delegationChains[msg.sender];
        delegation.delegator = msg.sender;
        delegation.delegate = _delegate;
        delegation.votingPower = votingPower[msg.sender];
        delegation.topics = _topics;
        delegation.delegationTime = block.timestamp;
        delegation.isActive = true;
        delegation.chainLength = 1;
        delegation.allowsSubDelegation = _allowsSubDelegation;
        delegation.expiryTime = _expiryTime;
        
        // Transfer voting power
        votingPower[msg.sender] = 0;
        liquidDemocracyPower[_delegate] += delegation.votingPower;
        
        emit DelegationCreated(msg.sender, _delegate, _topics);
    }
    
    /**
     * @dev Revoke delegation
     */
    function revokeDelegation() external onlyMember {
        DelegationChain storage delegation = delegationChains[msg.sender];
        require(delegation.isActive, "No active delegation");
        
        // Restore voting power
        liquidDemocracyPower[delegation.delegate] -= delegation.votingPower;
        votingPower[msg.sender] = delegation.votingPower;
        
        delegation.isActive = false;
        
        emit DelegationRevoked(msg.sender, delegation.delegate);
    }
    
    /**
     * @dev Start conviction voting for continuous funding
     */
    function startConvictionVoting(
        uint256 _proposalId,
        uint256 _fundingRequested,
        uint256 _convictionThreshold
    ) external onlyMember {
        require(proposals[_proposalId].exists, "Proposal does not exist");
        require(_fundingRequested <= treasury, "Insufficient treasury funds");
        
        ConvictionVoting storage cv = convictionVotes[_proposalId];
        cv.proposalId = _proposalId;
        cv.convictionThreshold = _convictionThreshold;
        cv.fundingRequested = _fundingRequested;
        cv.halfLife = 7 days; // Default half-life
        cv.maxRatio = 20; // 20% max of treasury
        
        require(_fundingRequested <= (treasury * cv.maxRatio / 100), "Exceeds max funding ratio");
    }
    
    /**
     * @dev Support proposal with conviction voting
     */
    function supportWithConviction(uint256 _proposalId, uint256 _tokens) external payable onlyMember {
        require(msg.value >= _tokens, "Insufficient tokens sent");
        
        ConvictionVoting storage cv = convictionVotes[_proposalId];
        
        // Update conviction based on time elapsed
        uint256 timeElapsed = block.timestamp - cv.lastUpdate[msg.sender];
        if (timeElapsed > 0 && cv.stakedTokens[msg.sender] > 0) {
            uint256 currentConviction = cv.conviction[msg.sender];
            // Exponential growth formula: conviction = tokens * (1 - e^(-t/halfLife))
            uint256 maxConviction = cv.stakedTokens[msg.sender];
            uint256 growth = maxConviction - (maxConviction * _exponentialDecay(timeElapsed, cv.halfLife) / 1e18);
            cv.conviction[msg.sender] = currentConviction + growth;
        }
        
        cv.stakedTokens[msg.sender] += _tokens;
        cv.totalStaked += _tokens;
        cv.lastUpdate[msg.sender] = block.timestamp;
        
        // Update total conviction
        _updateTotalConviction(_proposalId);
        
        // Check if threshold reached
        if (cv.totalConviction >= cv.convictionThreshold && !cv.isPassing) {
            cv.isPassing = true;
            cv.passingTime = block.timestamp;
            emit ConvictionThresholdReached(_proposalId, cv.totalConviction);
        }
    }
    
    /**
     * @dev Create identity credential
     */
    function createIdentityCredential(
        address _holder,
        string memory _credentialType,
        bytes memory _credentialHash,
        VerificationLevel _level,
        uint256 _expiryTime,
        mapping(string => string) memory _attributes
    ) external onlyModerator {
        uint256 credId = credentialCount++;
        IdentityCredential storage credential = identityCredentials[credId];
        credential.credentialId = credId;
        credential.holder = _holder;
        credential.credentialType = _credentialType;
        credential.credentialHash = _credentialHash;
        credential.issuanceDate = block.timestamp;
        credential.expiryDate = _expiryTime;
        credential.verificationLevel = uint256(_level);
        credential.trustScore = 100; // Initial trust score
        
        memberCredentials[_holder].push(credId);
        
        emit IdentityVerified(_holder, credId, _level);
    }
    
    /**
     * @dev File arbitration case
     */
    function fileArbitrationCase(
        address _defendant,
        string memory _disputeType,
        string memory _description,
        uint256 _amount,
        string memory _evidence
    ) external payable onlyMember {
        require(msg.value >= 0.1 ether, "Must pay arbitration fee");
        require(_defendant != msg.sender, "Cannot dispute with yourself");
        
        uint256 caseId = arbitrationCaseCount++;
        ArbitrationCase storage arbitrationCase = arbitrationCases[caseId];
        arbitrationCase.caseId = caseId;
        arbitrationCase.plaintiff = msg.sender;
        arbitrationCase.defendant = _defendant;
        arbitrationCase.disputeType = _disputeType;
        arbitrationCase.description = _description;
        arbitrationCase.amount = _amount;
        arbitrationCase.evidence = _evidence;
        arbitrationCase.arbitrationFee = msg.value;
        arbitrationCase.createdAt = block.timestamp;
        arbitrationCase.votingDeadline = block.timestamp + 14 days;
        arbitrationCase.status = ArbitrationStatus.FILED;
        
        // Select arbitrators (simplified - in practice, use more sophisticated selection)
        arbitrationCase.arbitrators = _selectArbitrators(3);
        
        emit ArbitrationCaseFiled(caseId, msg.sender, _defendant);
    }
    
    /**
     * @dev Arbitrator votes on case
     */
    function arbitratorVote(
        uint256 _caseId,
        address _winner,
        uint256 _settlement,
        string memory _reason
    ) external onlyArbitrator(_caseId) {
        ArbitrationCase storage arbitrationCase = arbitrationCases[_caseId];
        require(block.timestamp <= arbitrationCase.votingDeadline, "Voting period ended");
        require(!arbitrationCase.arbitratorVotes[msg.sender], "Already voted");
        
        arbitrationCase.arbitratorVotes[msg.sender] = true;
        arbitrationCase.arbitratorReasons[msg.sender] = _reason;
        
        // Check if majority reached
        uint256 voteCount = 0;
        for (uint256 i = 0; i < arbitrationCase.arbitrators.length; i++) {
            if (arbitrationCase.arbitratorVotes[arbitrationCase.arbitrators[i]]) {
                voteCount++;
            }
        }
        
        if (voteCount > arbitrationCase.arbitrators.length / 2) {
            arbitrationCase.isResolved = true;
            arbitrationCase.winner = _winner;
            arbitrationCase.settlement = _settlement;
            arbitrationCase.status = ArbitrationStatus.DECIDED;
            
            // Transfer settlement
            if (_settlement > 0 && _winner != address(0)) {
                payable(_winner).transfer(_settlement);
            }
            
            emit ArbitrationDecision(_caseId, _winner, _settlement);
        }
    }
    
    /**
     * @dev Create partnership agreement
     */
    function createPartnership(
        address _partnerDAO,
        string memory _partnershipType,
        uint256 _duration,
        uint256 _requiredApprovals,
        string[] memory _deliverables
    ) external onlyModerator {
        uint256 agreementId = partnershipCount++;
        PartnershipAgreement storage agreement = partnerships[agreementId];
        agreement.agreementId = agreementId;
        agreement.partnerDAO = _partnerDAO;
        agreement.partnershipType = _partnershipType;
        agreement.duration = _duration;
        agreement.startTime = block.timestamp;
        agreement.requiredApprovals = _requiredApprovals;
        agreement.deliverables = _deliverables;
        agreement.autoRenewal = false;
        
        emit PartnershipEstablished(agreementId, _partnerDAO, _partnershipType);
    }
    
    /**
     * @dev Create knowledge base article
     */
    function createKnowledgeArticle(
        string memory _title,
        string memory _contentHash,
        string[] memory _tags,
        string memory _category,
        uint256 _difficulty,
        string[] memory _prerequisites
    ) external onlyMember hasReputation(
