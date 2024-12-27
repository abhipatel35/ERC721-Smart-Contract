# ERC-721 Token Smart Contract

This repository contains an ERC-721 compliant smart contract developed in Solidity for creating and managing non-fungible tokens (NFTs) on the Ethereum blockchain.

## Features
- Implements ERC-721 standards for unique, non-fungible token management.
- Allows token minting, transferring, and approvals.
- Integrated safe transfer checks using `IERC721Receiver`.

## Contract Details
- **Contract Name:** `ERC721_Abhi_Patel`
- **Compiler Version:** Solidity `^0.8.9`
- **License:** MIT

## Functions
- **Mint Tokens:** Allows the contract owner to mint tokens and assign URIs.
- **Transfer Tokens:** Transfer ownership of tokens securely.
- **Approve and Set Approval:** Manage token approvals for third parties.
- **Safe Transfer Checks:** Ensures compatibility with `IERC721Receiver`.

## Technologies Used
- **Solidity** for smart contract development.
- **Ethereum** blockchain.
- Compatible with **Remix IDE** for testing and deployment.

## Getting Started
1. Clone the repository:
   ```bash
   git clone https://github.com/abhipatel35/ERC721-Token-Smart-Contract.git

2. Open the ERC721_Abhi_Patel.sol file in Remix IDE.
3. Compile the contract with Solidity ^0.8.9.
4. Deploy to a test network (e.g., using MetaMask and Remix).

## Steps to Upload:
1. Create a new repository on GitHub.
2. Clone the repository to your local machine:
   ```bash
    git clone https://github.com/abhipatel35/ERC721-Token-Smart-Contract.git
3. Add the files (ERC721_Abhi_Patel.sol, README.md, and LICENSE) to the repository folder.
4. Push the files to GitHub:
   ```bash
    git add .
    git commit -m "Initial commit: Added ERC721 Smart Contract"
    git push origin main
