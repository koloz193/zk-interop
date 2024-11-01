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

3. **How to use it (set greeting example)**:

- Greeter Address: `0xeA6878F05DC5DcDd176962FdFE433111E87F0C72`
- InteropCenter Address: `0x7122bb051DE72eAD9CE1F6374BEaCBc38E81fdb1`

  
   ```bash
   cast call -r http://localhost:8013 0xeA6878F05DC5DcDd176962FdFE433111E87F0C72 "greeting()(string)"
   -> ""

   cast send -r http://localhost:8012 0x7122bb051DE72eAD9CE1F6374BEaCBc38E81fdb1 "requestInteropMinimal(uint256, address, bytes, uint256, uint256, uint256)" 501 0xeA6878F05DC5DcDd176962FdFE433111E87F0C72 0xa41368620000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000568656c6c6f000000000000000000000000000000000000000000000000000000 0 10000000 1000000000  --private-key 0x7becc4a46e0c3b512d380ca73a4c868f790d1055a7698f38fb3ca2b2ac97efbb

   cast call -r http://localhost:8013 0xeA6878F05DC5DcDd176962FdFE433111E87F0C72 "greeting()(string)"
   -> "hello"
   ```

For examples on how to use it, see this [guide](https://github.com/koloz193/slingshot?tab=readme-ov-file#examples-how-to-trigger).
