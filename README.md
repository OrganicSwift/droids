This is a [Next.js](https://nextjs.org) project bootstrapped with [`create-onchain`](https://www.npmjs.com/package/create-onchain).

## Getting Started

First, install dependencies:

```bash
npm install
```

Next, run the development server:

```bash
npm run dev
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

## Smart Contracts

The project includes a robust ERC721 Smart Contract for "Droids" in the `contracts` directory.
It is built with Foundry and OpenZeppelin.

**Deployed Contract (Base Sepolia):** `0xBd66a5BA947AC0C25443d6a876a4cb6db2ca1aBb`

### Setup Contracts

1. Install Foundry (if not already installed): https://book.getfoundry.sh/
2. Navigate to `contracts` directory:
   ```bash
   cd contracts
   ```
3. Build contracts:
   ```bash
   forge build
   ```
4. Run tests:
   ```bash
   forge test
   ```

### Deployment

To deploy to Base Sepolia (or Mainnet), ensure your `.env` contains `PRIVATE_KEY` (with `0x` prefix) and run the deployment script:

```bash
cd contracts
forge script script/DeployDroids.s.sol --rpc-url https://sepolia.base.org --broadcast
```

## Learn More

To learn more about OnchainKit, see our [documentation](https://docs.base.org/onchainkit).
To learn more about Next.js, see the [Next.js documentation](https://nextjs.org/docs).
