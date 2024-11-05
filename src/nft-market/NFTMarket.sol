// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Ownable} from "openzeppelin-contracts/access/Ownable.sol";
import {INFT, MINTER_ROLE} from "./INFT.sol";

contract NFTMarket is Ownable {
    // 0xc3169b4b
    error DoesntSupportInterface(bytes4 _interfaceId);

    // 0x52eea11a
    error DoesntHaveRole(bytes32 _role, address _operator);

    // 0x061f81f1
    error SaleDoesNotExist(uint256 _saleId);

    // 0x8c905368
    error NotEnoughFunds(uint256 _expected, uint256 _actual);

    // 0xfe8a94f4
    error FailedToSendEth();

    event SaleCreated(address indexed _nft, uint256 _price, uint256 _saleId);

    event SaleCancelled(address indexed _nft, uint256 _saleId);

    event NFTBought(address indexed _nft, address indexed _buyer);

    uint256 public saleCounter;

    struct NFTSale {
        INFT nft;
        uint256 price;
    }

    mapping(uint256 => NFTSale) public sales;
    
    constructor(address _owner) Ownable(_owner) {
        saleCounter = 0;
    }

    function createSale(
        address _nftContract,
        uint256 _price
    ) external onlyOwner returns (uint256) {
        INFT nft = INFT(_nftContract);

        if (!nft.supportsInterface(type(INFT).interfaceId)) {
            revert DoesntSupportInterface(type(INFT).interfaceId);
        }

        if (!nft.hasRole(MINTER_ROLE, address(this))) {
            revert DoesntHaveRole(MINTER_ROLE, address(this));
        }

        sales[saleCounter++] = NFTSale(
            nft,
            _price
        );

        emit SaleCreated(_nftContract, _price, saleCounter - 1);

        return saleCounter - 1;
    }

    function cancelSale(uint256 _saleId) external onlyOwner {
        if (!saleExists(_saleId)) {
            revert SaleDoesNotExist(_saleId);
        }

        NFTSale memory nftSale = sales[_saleId];

        delete sales[_saleId];

        emit SaleCancelled(address(nftSale.nft), _saleId);
    }

    function buy(uint256 _saleId, address _receiver) external payable {
        if (!saleExists(_saleId)) {
            revert SaleDoesNotExist(_saleId);
        }

        NFTSale memory nftSale = sales[_saleId];

        if (msg.value != nftSale.price) {
            revert NotEnoughFunds(nftSale.price, msg.value);
        }

        nftSale.nft.mint(_receiver);

        (bool sent, ) = owner().call{value: msg.value}("");

        if (!sent) {
            revert FailedToSendEth();
        }

        emit NFTBought(address(nftSale.nft), _receiver);
    }

    
    function saleExists(uint256 _salesId) public view returns (bool) {
        return address(sales[_salesId].nft) != address(0);
    }
}
