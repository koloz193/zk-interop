// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {IAccessControl} from "openzeppelin-contracts/access/IAccessControl.sol";

bytes32 constant MINTER_ROLE = bytes32(uint256(keccak256("MINTER_ROLE")) - 1);

interface INFT is IAccessControl {
    function mint(address _receiver) external;
    function supportsInterface(bytes4 _interfaceId) external view returns (bool);
}
