# zk-interop

## How to Run
```
docker compose up -d

cd slingshot

forge script script/Deploy.s.sol:Deploy --rpc-url http://localhost:8012 --private-key 0x3d3cbc973389cb26f657686445bcc75662b415b656078503592ac8c1abb8810e --zksync  --skip-simulation  --enable-eravm-extensions --broadcast && forge script script/Deploy.s.sol:Deploy --rpc-url http://localhost:8013 --private-key 0x3d3cbc973389cb26f657686445bcc75662b415b656078503592ac8c1abb8810e --zksync  --skip-simulation  --enable-eravm-extensions --broadcast
```

For examples on how to use it see this [guide](https://github.com/mm-zk/slingshot?tab=readme-ov-file#examples-how-to-trigger)
