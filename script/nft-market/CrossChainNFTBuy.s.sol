// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import "forge-std/console2.sol";
import {NFT} from "../../src/nft-market/NFT.sol";
import {NFTMarket} from "../../src/nft-market/NFTMarket.sol";
import {InteropCenter} from "../../slingshot/src/InteropCenter.sol";

contract CrossChainNFTBuy is Script {
    InteropCenter constant INTEROP_CENTER = InteropCenter(0x767162c75097a97Bd363B7494E6da9D01aeF8A6c);
    uint256 constant CHAIN_A_CHAIN_ID = 500;
    uint256 constant CHAIN_B_CHAIN_ID = 501;

    function setUp() public {}

    // Run this first from chain B (see foundry.toml for RPC)
    function deployContractsOnChainBAndCreateSale() public {

        vm.startBroadcast();
        NFTMarket market = new NFTMarket(msg.sender);
        
        console2.log("NFTMarket: ", address(market));

        address[] memory minters = new address[](1);
        minters[0] = address(market);
        NFT nft = new NFT("hello", "chain b", msg.sender, minters);
        console2.log("NFT: ", address(nft));

        uint256 saleId = market.createSale(
            address(nft), 
            0.1 ether
        );

        console2.log("Sale created with SaleId: ", saleId);

        vm.stopBroadcast();
    }

    // Run this second from chain A (see foundry.toml for RPC)
    function mintTokenFromChainA(address _nftMarket, uint256 _saleId, address _receiver) public {
        bytes memory mintCalldataData = abi.encodeWithSelector(
            NFTMarket.buy.selector,
            _saleId,
            _receiver
        );

        vm.startBroadcast();
        INTEROP_CENTER.requestInteropMinimalPayLocally{value: 10 ether}(
            CHAIN_B_CHAIN_ID, 
            _nftMarket, 
            mintCalldataData,  
            100000000, 
            1000000000
        );

        vm.stopBroadcast();
    }
}
