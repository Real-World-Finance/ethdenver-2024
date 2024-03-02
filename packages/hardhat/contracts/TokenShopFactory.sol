// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./TokenShop.sol";

library TokenData {
    struct Token {
        string  name;
        string  symbol;
        uint256 maxTokens;
        uint256 initialPrice; //in 10**18 USD
        uint256 price; //in 10**18 USD
        uint256 dueDate; //UTC Unix Timestamp
        uint256 expectedROI; //in 10**18
        uint256 earlyWithdrawPenalty; //in 10**18 USD
        uint256 pctCashReserve; //in 10**18
        string  imageUrl;
        uint256 profitPct; //in 10**18
        uint256 minOwnedTokens;
        address[] beneficiaries;
    }
}

contract TokenFactory is Ownable {
    RWF_Trust[] private tokens;

    constructor(
        address _trust
    ) Ownable(_trust) {
        
    }

    function createToken(
        string memory  name,
        string memory  symbol,
        uint256 maxTokens,
        uint256 initialPrice, //in 10**18 USD
        uint256 dueDate, //UTC Unix Timestamp
        uint256 expectedROI, //in 10**18
        uint256 earlyWithdrawPenalty, //in 10**18 USD
        uint256 pctCashReserve, //in 10**18
        string memory  imageUrl,
        uint256 profitPct //in 10**18
    ) public onlyOwner {
        RWF_Trust token = new RWF_Trust(
            name,
            symbol,
            maxTokens,
            initialPrice,
            dueDate,
            expectedROI,
            earlyWithdrawPenalty,
            pctCashReserve,
            owner(),
            imageUrl,
            profitPct
        );

        tokens.push(token);
    }

    function getTokens() public view returns (RWF_Trust[] memory) {
        return tokens;
    }
}