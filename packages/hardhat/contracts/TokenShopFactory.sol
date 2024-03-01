// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./TokenShop.sol";

library TokenData {
    struct Token {
        string  name;
        string  symbol;
        string description;
        uint256 maxTokens;
        uint256 initialPrice; //in 10**18 USD
        uint256 price; //in 10**18 USD
        uint256 dueDate; //UTC Unix Timestamp
        uint256 expectedROI; //in 10**18
        uint256 earlyWithdrawPenalty; //in 10**18 USD
        uint256 pctCashReserve; //in 10**18
        string  imageURL;
        uint256 profitPct; //in 10**18
        uint256 minOwnedTokens;
        address[] beneficiaries;
    }
}

contract TokenFactory is IERC20, Ownable {
    TokenShop[] private tokens;

    constructor(
        address _trust
    ) Ownable(_trust) {
        
    }

    function createToken(
        string  name,
        string  symbol,
        string description,
        uint256 maxTokens,
        uint256 initialPrice, //in 10**18 USD
        uint256 price, //in 10**18 USD
        uint256 dueDate, //UTC Unix Timestamp
        uint256 expectedROI, //in 10**18
        uint256 earlyWithdrawPenalty, //in 10**18 USD
        uint256 pctCashReserve, //in 10**18
        string  imageURL,
        uint256 profitPct, //in 10**18
    ) {
        TokenShop token = TokenShop(
            name,
            symbol,
            description,
            maxTokens,
            initialPrice,
            price,
            dueDate,
            expectedROI,
            earlyWithdrawPenalty,
            pctCashReserve,
            imageURL,
            owner(),
            profitPct,
        );

        tokens.push(token);
    }

    function getTokens() public view returns (TokenShop[] memory) {
        return tokens;
    }
}