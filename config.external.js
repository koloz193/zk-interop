window["##runtimeConfig"] = {
  appEnvironment: "test",
  environmentConfig: {
    networks: [
      {
        apiUrl: "http://localhost:3020",
        bridgeUrl: "",
        hostnames: ["localhost"],
        icon: "/images/icons/zksync-arrows.svg",
        l2ChainId: 500,
        l2NetworkName: "Era Test Node 1",
        maintenance: false,
        name: "era-test-node-1",
        published: true,
        rpcUrl: "http://localhost:8012",
        baseTokenAddress: "0x000000000000000000000000000000000000800A",
      },
      {
        apiUrl: "http://localhost:3021",
        bridgeUrl: "",
        hostnames: ["localhost"],
        icon: "/images/icons/zksync-arrows.svg",
        l2ChainId: 501,
        l2NetworkName: "Era Test Node 2",
        maintenance: false,
        name: "era-test-node-2",
        published: true,
        rpcUrl: "http://localhost:8013",
        baseTokenAddress: "0x000000000000000000000000000000000000800A",
      },
    ],
  },
};
