// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract RWF_Trust is ERC20, ERC20Permit, AccessControl {
    constructor(address defaultAdmin)
        ERC20("RWF_Trust", "RWT")
        ERC20Permit("RWF_Trust")
    {
        _mint(msg.sender, 500000 * 10 ** decimals());
        _grantRole(DEFAULT_ADMIN_ROLE, defaultAdmin);
    }
    
    uint256 private price;

    function setPrice(uint256 newPrice) public external {
        price = newPrice;
    }

    function getPrice() public external view returns (uint256) {
        return price;
    }
}
