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
    }
    
    // Struct for milestones in bounties
    struct Milestone {
        string description;
        uint256 reward;
        bool completed;
        uint256 dueDate;
        address reviewer;
        bool approved;
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
        uint256 budgetAllocation;
        bool requiresMultiSig;
        uint256 riskLevel;
        address[] approvers;
        mapping(address => bool) hasApproved;
        uint256 requiredApprovals;
    }
    
    // Struct for decentralized identity and reputation system
    struct Identity {
        bytes32 identityHash;
        bool isVerified;
        address verifier;
        uint256 verificationDate;
        string[] documents; // IPFS hashes
        uint256 trustScore;
        mapping(address => bool) trustedBy;
        uint256 trustedByCount;
        bool isKYCCompleted;
        string jurisdiction;
        uint256 complianceScore;
    }
    
    // Struct for governance tokens with different classes
    struct TokenClass {
        string name;
        uint256 totalSupply;
        uint256 votingWeight;
        uint256 dividendRate;
        bool transferable;
        uint256 lockupPeriod;
        mapping(address => uint256) balances;
        mapping(address => uint256) lockupEndTime;
    }
    
    // Struct for decentralized dispute resolution
    struct Dispute {
        uint256 id;
        address plaintiff;
        address defendant;
        string description;
        uint256 stake;
        address[] arbitrators;
        mapping(address => DisputeVote) arbitratorVotes;
        uint256 votingDeadline;
        bool resolved;
        address winner;
        uint256 compensation;
        DisputeCategory category;
        string evidence; // IPFS hash
        uint256 createdAt;
    }
    
    struct DisputeVote {
        address winner;
        string reasoning;
        uint256 timestamp;
        bool hasVoted;
    }
    
    // Struct for governance research and analytics
    struct GovernanceMetrics {
        uint256 totalProposals;
        uint256 averageVotingParticipation;
        uint256 averageProposalDuration;
        uint256 memberGrowthRate;
        uint256 treasuryGrowthRate;
        uint256 activityScore;
        mapping(ProposalType => uint256) proposalSuccessRates;
        mapping(address => uint256) memberActivityScores;
        uint256 lastUpdateTimestamp;
    }
    
    // Struct for automated proposal execution
    struct AutomatedAction {
        uint256 id;
        string description;
        bytes callData;
        address targetContract;
        uint256 executeAt;
        bool executed;
        bool cancelled;
        uint256 gasLimit;
        address creator;
        bool requiresConfirmation;
        uint256 confirmationCount;
        mapping(address => bool) hasConfirmed;
    }
    
    // Struct for cross-chain governance
    struct CrossChainProposal {
        uint256 localProposalId;
        uint256[] chainIds;
        mapping(uint256 => bytes32) chainProposalHashes;
        mapping(uint256 => bool) chainExecutionStatus;
        bool isMultiChain;
        address relayerContract;
        uint256 crossChainFee;
    }
    
    // Struct for DAO partnerships and alliances
    struct Partnership {
        uint256 id;
        address partnerDAO;
        string description;
        uint256 establishedAt;
        bool isActive;
        uint256 sharedBudget;
        uint256 votingWeight;
        mapping(uint256 => bool) jointProposals;
        address[] liaisons;
        string[] collaborationAreas;
        uint256 performanceScore;
    }
    
    // New enums
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
    
    // Existing enums (keeping all previous ones)
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
    
    // Additional state variables
    mapping(address => Identity) public memberIdentities;
    mapping(uint256 => TokenClass) public tokenClasses;
    mapping(uint256 => Dispute) public disputes;
    mapping(uint256 => AutomatedAction) public automatedActions;
    mapping(uint256 => CrossChainProposal) public crossChainProposals;
    mapping(uint256 => Partnership) public partnerships;
    mapping(address => MemberRole[]) public memberRoles;
    mapping(address => mapping(string => uint256)) public memberSkillLevels;
    mapping(address => uint256) public memberMentorshipCount;
    mapping(address => address[]) public memberMentees;
    mapping(uint256 => uint256) public proposalFunding;
    mapping(address => uint256) public liquidityProvided;
    mapping(address => uint256) public liquidityRewards;
    mapping(string => uint256) public skillDemand;
    mapping(address => bool) public isAccreditedInvestor;
    mapping(address => uint256) public investmentLimit;
    mapping(uint256 => mapping(address => uint256)) public proposalStaking;
    mapping(address => uint256) public totalProposalStake;
    
    // Governance analytics
    GovernanceMetrics public governanceMetrics;
    
    // Advanced state variables
    uint256 public disputeCount;
    uint256 public automatedActionCount;
    uint256 public partnershipCount;
    uint256 public tokenClassCount;
    uint256 public crossChainProposalCount;
    uint256 public totalLiquidityPool;
    uint256 public governanceInsurancePool;
    uint256 public educationFund;
    uint256 public innovationGrants;
    uint256 public sustainabilityScore;
    uint256 public decentralizationIndex;
    
    // Oracles and external data feeds
    mapping(string => address) public dataOracles;
    mapping(string => uint256) public oracleData;
    
    // Existing state variables (keeping all previous ones)
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
    // ... [keeping all other existing mappings]
    
    uint256 public proposalCount;
    uint256 public memberCount;
    uint256 public committeeCount;
    uint256 public bountyCount;
    uint256 public treasuryProposalCount;
    // ... [keeping all other existing state variables]
    
    address public admin;
    GovernanceParams public governanceParams;
    uint256 public treasury;
    // ... [keeping all other existing variables]
    
    // New events for additional functionality
    event IdentityVerified(address indexed member, bytes32 identityHash, address indexed verifier);
    event DisputeCreated(uint256 indexed disputeId, address indexed plaintiff, address indexed defendant);
    event DisputeResolved(uint256 indexed disputeId, address indexed winner, uint256 compensation);
    event AutomatedActionScheduled(uint256 indexed actionId, uint256 executeAt);
    event AutomatedActionExecuted(uint256 indexed actionId, bool success);
    event CrossChainProposalCreated(uint256 indexed proposalId, uint256[] chainIds);
    event PartnershipEstablished(uint256 indexed partnershipId, address indexed partnerDAO);
    event SkillEndorsed(address indexed member, string skill, address indexed endorser);
    event MentorshipStarted(address indexed mentor, address indexed mentee);
    event LiquidityProvided(address indexed provider, uint256 amount, uint256 rewards);
    event ProposalFunded(uint256 indexed proposalId, address indexed funder, uint256 amount);
    event MilestoneCompleted(uint256 indexed bountyId, uint256 milestoneId, address indexed assignee);
    event TokenClassCreated(uint256 indexed classId, string name, uint256 votingWeight);
    event GovernanceMetricsUpdated(uint256 timestamp, uint256 activityScore);
    event OracleUpdated(string indexed dataType, uint256 newValue);
    event ComplianceCheckCompleted(address indexed member, bool passed);
    event RiskAssessmentCompleted(uint256 indexed proposalId, uint256 riskLevel);
    event EducationModuleCompleted(address indexed member, string module);
    event InnovationGrantAwarded(address indexed recipient, uint256 amount, string project);
    
    // Advanced modifiers
    modifier onlyArbitrator() {
        require(hasRole(msg.sender, MemberRole.ARBITRATOR), "Only arbitrators can perform this action");
        _;
    }
    
    modifier onlyMentor() {
        require(hasRole(msg.sender, MemberRole.MENTOR), "Only mentors can perform this action");
        _;
    }
    
    modifier hasKYC() {
        require(memberIdentities[msg.sender].isKYCCompleted, "KYC verification required");
        _;
    }
    
    modifier validTrustScore(uint256 _minScore) {
        require(memberIdentities[msg.sender].trustScore >= _minScore, "Insufficient trust score");
        _;
    }
    
    modifier onlyAccreditedInvestor() {
        require(isAccreditedInvestor[msg.sender], "Only accredited investors allowed");
        _;
    }
    
    modifier withinInvestmentLimit(uint256 _amount) {
        require(_amount <= investmentLimit[msg.sender], "Exceeds investment limit");
        _;
    }
    
    // Keep all existing modifiers...
    modifier onlyMember() {
        require(isMember[msg.sender], "Only members can perform this action");
        _;
    }
    
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }
    
    // ... [all other existing modifiers]
    
    // Constructor (enhanced)
    constructor() {
        admin = msg.sender;
        isMember[msg.sender] = true;
        memberSince[msg.sender] = block.timestamp;
        votingPower[msg.sender] = 100;
        memberCount = 1;
        memberReputation[msg.sender] = 500;
        membershipTiers[msg.sender] = MembershipTier.FOUNDER;
        isVerifiedMember[msg.sender] = true;
        isModerator[msg.sender] = true;
        moderatorSince[msg.sender] = block.timestamp;
        memberVoteCredits[msg.sender] = 100;
        isAccreditedInvestor[msg.sender] = true;
        investmentLimit[msg.sender] = 1000 ether;
        
        // Initialize token classes
        _createTokenClass("Governance", 1000000, 100, 0, true, 0);
        _createTokenClass("Utility", 5000000, 50, 0, true, 0);
        _createTokenClass("Premium", 100000, 200, 500, false, 365 days);
        
        // Initialize identity
        memberIdentities[msg.sender] = Identity({
            identityHash: keccak256(abi.encodePacked(msg.sender, block.timestamp)),
            isVerified: true,
            verifier: msg.sender,
            verificationDate: block.timestamp,
            documents: new string[](0),
            trustScore: 1000,
            trustedByCount: 0,
            isKYCCompleted: true,
            jurisdiction: "GLOBAL",
            complianceScore: 100
        });
        
        // Add roles to admin
        memberRoles[msg.sender].push(MemberRole.ADMIN);
        memberRoles[msg.sender].push(MemberRole.EMERGENCY_COUNCIL);
        memberRoles[msg.sender].push(MemberRole.ARBITRATOR);
        
        // Initialize governance parameters (enhanced)
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
        
        // Initialize pools
        governanceInsurancePool = 10 ether;
        educationFund = 5 ether;
        innovationGrants = 15 ether;
        sustainabilityScore = 75;
        decentralizationIndex = 80;
    }
    
    /**
     * @dev Advanced KYC and identity verification
     */
    function completeKYCVerification(
        address _member,
        bytes32 _identityHash,
        string[] memory _documents,
        string memory _jurisdiction
    ) external onlyModerator {
        require(isMember[_member], "Member does not exist");
        
        Identity storage identity = memberIdentities[_member];
        identity.identityHash = _identityHash;
        identity.isVerified = true;
        identity.verifier = msg.sender;
        identity.verificationDate = block.timestamp;
        identity.documents = _documents;
        identity.isKYCCompleted = true;
        identity.jurisdiction = _jurisdiction;
        identity.complianceScore = 85; // Initial compliance score
        identity.trustScore += 200; // Bonus for KYC completion
        
        // Unlock additional features for KYC-verified members
        memberVoteCredits[_member] += 30;
        votingPower[_member] += 20;
        
        emit IdentityVerified(_member, _identityHash, msg.sender);
        emit VotingPowerChanged(_member, votingPower[_member]);
    }
    
    /**
     * @dev Create a new token class with specific properties
     */
    function _createTokenClass(
        string memory _name,
        uint256 _totalSupply,
        uint256 _votingWeight,
        uint256 _dividendRate,
        bool _transferable,
        uint256 _lockupPeriod
    ) internal returns (uint256) {
        uint256 classId = tokenClassCount++;
        TokenClass storage tokenClass = tokenClasses[classId];
        tokenClass.name = _name;
        tokenClass.totalSupply = _totalSupply;
        tokenClass.votingWeight = _votingWeight;
        tokenClass.dividendRate = _dividendRate;
        tokenClass.transferable = _transferable;
        tokenClass.lockupPeriod = _lockupPeriod;
        
        // Give initial supply to admin
        tokenClass.balances[admin] = _totalSupply;
        if (_lockupPeriod > 0) {
            tokenClass.lockupEndTime[admin] = block.timestamp + _lockupPeriod;
        }
        
        emit TokenClassCreated(classId, _name, _votingWeight);
        return classId;
    }
    
    /**
     * @dev Create a dispute for resolution
     */
    function createDispute(
        address _defendant,
        string memory _description,
        DisputeCategory _category,
        string memory _evidence
    ) external payable onlyActiveMember {
        require(msg.value >= 0.1 ether, "Insufficient dispute stake");
        require(_defendant != msg.sender, "Cannot dispute against yourself");
        require(isMember[_defendant], "Defendant must be a member");
        
        uint256 disputeId = disputeCount++;
        Dispute storage dispute = disputes[disputeId];
        dispute.id = disputeId;
        dispute.plaintiff = msg.sender;
        dispute.defendant = _defendant;
        dispute.description = _description;
        dispute.stake = msg.value;
        dispute.category = _category;
        dispute.evidence = _evidence;
        dispute.votingDeadline = block.timestamp + 7 days;
        dispute.createdAt = block.timestamp;
        
        // Assign random arbitrators with ARBITRATOR role
        _assignArbitrators(disputeId);
        
        emit DisputeCreated(disputeId, msg.sender, _defendant);
    }
    
    /**
     * @dev Assign arbitrators to a dispute
     */
    function _assignArbitrators(uint256 _disputeId) internal {
        // Simplified arbitrator assignment - in production, use randomness
        Dispute storage dispute = disputes[_disputeId];
        
        // For now, assign admin as arbitrator
        if (hasRole(admin, MemberRole.ARBITRATOR)) {
            dispute.arbitrators.push(admin);
        }
    }
    
    /**
     * @dev Vote on a dispute resolution (arbitrators only)
     */
    function voteOnDispute(
        uint256 _disputeId,
        address _winner,
        string memory _reasoning
    ) external onlyArbitrator {
        Dispute storage dispute = disputes[_disputeId];
        require(block.timestamp <= dispute.votingDeadline, "Voting period ended");
        require(!dispute.resolved, "Dispute already resolved");
        require(_winner == dispute.plaintiff || _winner == dispute.defendant, "Invalid winner");
        
        // Check if caller is assigned arbitrator
        bool isAssignedArbitrator = false;
        for (uint256 i = 0; i < dispute.arbitrators.length; i++) {
            if (dispute.arbitrators[i] == msg.sender) {
                isAssignedArbitrator = true;
                break;
            }
        }
        require(isAssignedArbitrator, "Not assigned to this dispute");
        require(!dispute.arbitratorVotes[msg.sender].hasVoted, "Already voted");
        
        dispute.arbitratorVotes[msg.sender] = DisputeVote({
            winner: _winner,
            reasoning: _reasoning,
            timestamp: block.timestamp,
            hasVoted: true
        });
        
        // Check if we can resolve the dispute
        _tryResolveDispute(_disputeId);
    }
    
    /**
     * @dev Try to resolve dispute based on arbitrator votes
     */
    function _tryResolveDispute(uint256 _disputeId) internal {
        Dispute storage dispute = disputes[_disputeId];
        
        uint256 plaintiffVotes = 0;
        uint256 defendantVotes = 0;
        uint256 totalVotes = 0;
        
        for (uint256 i = 0; i < dispute.arbitrators.length; i++) {
            address arbitrator = dispute.arbitrators[i];
            if (dispute.arbitratorVotes[arbitrator].hasVoted) {
                totalVotes++;
                if (dispute.arbitratorVotes[arbitrator].winner == dispute.plaintiff) {
                    plaintiffVotes++;
                } else {
                    defendantVotes++;
                }
            }
        }
        
        // Resolve if majority reached or voting deadline passed
        if ((plaintiffVotes > dispute.arbitrators.length / 2) || 
            (defendantVotes > dispute.arbitrators.length / 2) ||
            (block.timestamp > dispute.votingDeadline && totalVotes > 0)) {
            
            dispute.resolved = true;
            if (plaintiffVotes > defendantVotes) {
                dispute.winner = dispute.plaintiff;
                // Transfer stake to winner
                payable(dispute.plaintiff).transfer(dispute.stake);
                // Apply penalties to defendant
                _applyDisputePenalty(dispute.defendant, dispute.category);
            } else {
                dispute.winner = dispute.defendant;
                // Penalize plaintiff for false dispute
                _applyDisputePenalty(dispute.plaintiff, dispute.category);
            }
            
            emit DisputeResolved(_disputeId, dispute.winner, dispute.stake);
        }
    }
    
    /**
     * @dev Apply penalties based on dispute resolution
     */
    function _applyDisputePenalty(address _member, DisputeCategory _category) internal {
        // Reduce reputation and trust score
        memberReputation[_member] = memberReputation[_member] > 100 ? memberReputation[_member] - 100 : 0;
        memberIdentities[_member].trustScore = memberIdentities[_member].trustScore > 200 ? 
            memberIdentities[_member].trustScore - 200 : 0;
        
        // Category-specific penalties
        if (_category == DisputeCategory.GOVERNANCE_VIOLATION) {
            votingPower[_member] = votingPower[_member] > 20 ? votingPower[_member] - 20 : 1;
            memberVoteCredits[_member] = memberVoteCredits[_member] > 10 ? memberVoteCredits[_member] - 10 : 1;
        } else if (_category == DisputeCategory.MISCONDUCT) {
            // Temporary suspension
            memberProfiles[_member].isActive = false;
            // Schedule reactivation in 30 days (would need timer mechanism)
        }
    }
    
    /**
     * @dev Schedule automated action for execution
     */
    function scheduleAutomatedAction(
        string memory _description,
        bytes memory _callData,
        address _targetContract,
        uint256 _executeAt,
        uint256 _gasLimit,
        bool _requiresConfirmation
    ) external onlyMember hasReputation(200) {
        require(_executeAt > block.timestamp, "Execution time must be in future");
        require(_gasLimit > 0, "Gas limit must be positive");
        
        uint256 actionId = automatedActionCount++;
        AutomatedAction storage action = automatedActions[actionId];
        action.id = actionId;
        action.description = _description;
        action.callData = _callData;
        action.targetContract = _targetContract;
        action.executeAt = _executeAt;
        action.gasLimit = _gasLimit;
        action.creator = msg.sender;
        action.requiresConfirmation = _requiresConfirmation;
        
        emit AutomatedActionScheduled(actionId, _executeAt);
    }
    
    /**
     * @dev Execute scheduled automated action
     */
    function executeAutomatedAction(uint256 _actionId) external {
        AutomatedAction storage action = automatedActions[_actionId];
        require(block.timestamp >= action.executeAt, "Not ready for execution");
        require(!action.executed && !action.cancelled, "Action already processed");
        
        if (action.requiresConfirmation) {
            require(action.confirmationCount >= 3, "Insufficient confirmations");
        }
        
        action.executed = true;
        
        // Execute the call with specified gas limit
        (bool success, ) = action.targetContract.call{gas: action.gasLimit}(action.callData);
        
        emit AutomatedActionExecuted(_actionId, success);
    }
    
    /**
     * @dev Confirm automated action (for actions requiring confirmation)
     */
    function confirmAutomatedAction(uint256 _actionId) external onlyVerifiedMember {
        AutomatedAction storage action = automatedActions[_actionId];
        require(action.requiresConfirmation, "Action doesn't require confirmation");
        require(!action.hasConfirmed[msg.sender], "Already confirmed");
        require(block.timestamp < action.executeAt, "Confirmation period ended");
        
        action.hasConfirmed[msg.sender] = true;
        action.confirmationCount++;
    }
    
    /**
     * @dev Provide funding for a specific proposal
     */
    function fundProposal(uint256 _proposalId) external payable proposalExists(_proposalId) {
        Proposal storage proposal = proposals[_proposalId];
        require(proposal.fundingGoal > 0, "Proposal doesn't accept funding");
        require(proposal.currentFunding < proposal.fundingGoal, "Funding goal already met");
        require(msg.value > 0, "Must send some funds");
        
        proposal.fundingContributions[msg.sender] += msg.value;
        proposal.currentFunding += msg.value;
        
        if (proposal.currentFunding >= proposal.fundingGoal) {
            proposal.isFundingGoalMet = true;
        }
        
        // Increase proposal priority based on funding
        proposal.priorityScore += msg.value / 0.01 ether; // 1 priority point per 0.01 ETH
        
        emit ProposalFunded(_proposalId, msg.sender, msg.value);
    }
    
    /**
     * @dev Start mentorship relationship
     */
    function startMentorship(address _mentee) external onlyMentor {
        require(isMember[_mentee], "Mentee must be a member");
        require(_mentee != msg.sender, "Cannot mentor yourself");
        
        memberMentees[msg.sender].push(_mentee);
        memberMentorshipCount[msg.sender]++;
        memberProfiles[msg.sender].mentorshipScore += 10;
        
        // Mentees get bonus reputation for being mentored
        memberReputation[_mentee] += 25;
        
        emit MentorshipStarted(msg.sender,
