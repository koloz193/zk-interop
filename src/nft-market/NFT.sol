// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {ERC721Enumerable, ERC721} from "openzeppelin-contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import {AccessControl} from "openzeppelin-contracts/access/AccessControl.sol";
import {INFT, MINTER_ROLE} from "./INFT.sol";


contract NFT is INFT, ERC721Enumerable, AccessControl {
    uint256 private _tokenCounter;

    constructor(
        string memory _name, 
        string memory _symbol,
        address _admin,
        address[] memory _minters
    ) ERC721(_name, _symbol) {
        _tokenCounter = 1;

        for (uint256 i = 0; i < _minters.length; i++) {
            _grantRole(MINTER_ROLE, _minters[i]);
        }

        _grantRole(DEFAULT_ADMIN_ROLE, _admin);
    }

    function mint(address _receiver) external onlyRole(MINTER_ROLE) {
        _mint(_receiver, _tokenCounter++);
    }

    function supportsInterface(bytes4 _interfaceId) public view virtual override(INFT, ERC721Enumerable, AccessControl) returns (bool) {
        return _interfaceId == type(INFT).interfaceId || 
            ERC721Enumerable.supportsInterface(_interfaceId) || 
                AccessControl.supportsInterface(_interfaceId);
    }
}
