# zk-interop

## Services and Ports

This setup includes the following services:

- **era-test-node-1**  
  - **Description**: Test node for zkSync Era with `CHAIN_ID=500`.
  - **URL/Port**: `http://localhost:8012`

- **era-test-node-2**  
  - **Description**: Second test node for zkSync Era with `CHAIN_ID=501`.
  - **URL/Port**: `http://localhost:8013`

- **slingshot**  
  - **Description**: Slingshot service for interoperability.
  - **Depends On**: `era-test-node-1`, `era-test-node-2`

- **Block Explorer**  
  - **App**: `http://localhost:3010`
  - **API ETN 1**: `http://localhost:3020`
  - **Data Fetcher ETN 1**: `http://localhost:3040`
  - **API ETN 2**: `http://localhost:3021`
  - **Data Fetcher ETN 2**: `http://localhost:3041`

## How to Run

1. **Initialize Submodules**:

   ```bash
   git submodule update --init --recursive
   ```

2. **Start Services**:

   ```bash
   docker compose up -d
   ```

3. **Deploy Scripts**:

   ```bash
   cd slingshot

   forge script script/Deploy.s.sol:Deploy --rpc-url http://localhost:8012 --private-key 0x3d3cbc973389cb26f657686445bcc75662b415b656078503592ac8c1abb8810e --zksync --skip-simulation --enable-eravm-extensions --broadcast

   forge script script/Deploy.s.sol:Deploy --rpc-url http://localhost:8013 --private-key 0x3d3cbc973389cb26f657686445bcc75662b415b656078503592ac8c1abb8810e --zksync --skip-simulation --enable-eravm-extensions --broadcast
   ```

For examples on how to use it, see this [guide](https://github.com/mm-zk/slingshot?tab=readme-ov-file#examples-how-to-trigger).
