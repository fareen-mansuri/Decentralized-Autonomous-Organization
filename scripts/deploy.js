const hre = require("hardhat");

async function main() {
  console.log("Starting DAO deployment on Core Testnet 2...");
  
  // Get the deployer account
  const [deployer] = await hre.ethers.getSigners();
  
  console.log("Deploying contracts with the account:", deployer.address);
  console.log("Account balance:", hre.ethers.formatEther(await hre.ethers.provider.getBalance(deployer.address)));
  
  // Deploy the DAO contract
  console.log("\nDeploying DAO contract...");
  const DAO = await hre.ethers.getContractFactory("DAO");
  const dao = await DAO.deploy();
  
  await dao.waitForDeployment();
  
  const contractAddress = await dao.getAddress();
  console.log("DAO contract deployed to:", contractAddress);
  
  // Verify the deployment
  console.log("\nVerifying deployment...");
  const admin = await dao.admin();
  const memberCount = await dao.memberCount();
  const proposalCount = await dao.proposalCount();
  
  console.log("Admin address:", admin);
  console.log("Initial member count:", memberCount.toString());
  console.log("Initial proposal count:", proposalCount.toString());
  
  // Display contract interaction examples
  console.log("\n=== Contract Interaction Examples ===");
  console.log("1. Add a new member:");
  console.log(`   await dao.addMember("0x...memberAddress");`);
  
  console.log("\n2. Create a proposal:");
  console.log(`   await dao.createProposal("Proposal Title", "Proposal Description");`);
  
  console.log("\n3. Vote on a proposal:");
  console.log(`   await dao.vote(1, true); // Vote 'yes' on proposal ID 1`);
  
  console.log("\n4. Execute a proposal:");
  console.log(`   await dao.executeProposal(1);`);
  
  console.log("\n5. Get proposal details:");
  console.log(`   await dao.getProposal(1);`);
  
  // Save deployment info
  const deploymentInfo = {
    network: hre.network.name,
    contractAddress: contractAddress,
    deployerAddress: deployer.address,
    blockNumber: await hre.ethers.provider.getBlockNumber(),
    timestamp: new Date().toISOString(),
    chainId: (await hre.ethers.provider.getNetwork()).chainId
  };
  
  console.log("\n=== Deployment Summary ===");
  console.log("Network:", deploymentInfo.network);
  console.log("Contract Address:", deploymentInfo.contractAddress);
  console.log("Deployer Address:", deploymentInfo.deployerAddress);
  console.log("Block Number:", deploymentInfo.blockNumber);
  console.log("Chain ID:", deploymentInfo.chainId);
  console.log("Timestamp:", deploymentInfo.timestamp);
  
  // Save to file
  const fs = require('fs');
  const path = require('path');
  
  const deploymentsDir = path.join(__dirname, '../deployments');
  if (!fs.existsSync(deploymentsDir)) {
    fs.mkdirSync(deploymentsDir, { recursive: true });
  }
  
  fs.writeFileSync(
    path.join(deploymentsDir, `${hre.network.name}_deployment.json`),
    JSON.stringify(deploymentInfo, null, 2)
  );
  
  console.log(`\nDeployment info saved to deployments/${hre.network.name}_deployment.json`);
  
  // Verify contract on block explorer (if supported)
  if (hre.network.name !== "hardhat" && hre.network.name !== "localhost") {
    console.log("\nWaiting for block confirmations...");
    await dao.deploymentTransaction().wait(6);
    
    console.log("Verifying contract on block explorer...");
    try {
      await hre.run("verify:verify", {
        address: contractAddress,
        constructorArguments: [],
      });
      console.log("Contract verified successfully!");
    } catch (error) {
      console.log("Contract verification failed:", error.message);
    }
  }
  
  console.log("\n🎉 DAO deployment completed successfully!");
  console.log("You can now interact with your DAO at:", contractAddress);
}

// Handle errors
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error("Deployment failed:", error);
    process.exit(1);
  });
