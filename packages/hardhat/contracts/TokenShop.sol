// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract RWF_Trust is ERC20, ERC20Permit, AccessControl {

    uint256 private maxTokens;
    uint256 private initialPrice; //in 10**18 USD
    uint256 private price; //in 10**18 USD
    uint256 private dueDate; //UTC Unix Timestamp
    uint256 private expectedROI; //in 10**18
    uint256 private earlyWithdrawPenalty; //in 10**18 USD
    uint256 private pctCashReserve; //in 10**18
    string  private imageURL;
    address private trust;
    uint256 private profitPct; //in 10**18
    uint256 private minOwnedTokens = 20;

    constructor(
        string  memory _name,
        string  memory _symbol,
        uint256 _maxTokens,
        uint256 _price,
        uint32  _dueDate,
        uint256 _expectedROI,
        uint256 _earlyWithdrawPenalty,
        uint256 _pctCashReserve,
        string  memory _imageURL,
        address _trust,
        uint256 _profitPct
    )
        ERC20(_name, _symbol)
        ERC20Permit(_name)
    {
        //FIXME: check invariants
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        maxTokens = _maxTokens;
        initialPrice = _price;
        setPrice(_price);
        dueDate = _dueDate;
        expectedROI = _expectedROI;
        earlyWithdrawPenalty = _earlyWithdrawPenalty;
        pctCashReserve = _pctCashReserve;
        imageURL = _imageURL;
        trust = _trust;
        profitPct = _profitPct;
    } //end of constructor

    function decimals() public view override pure returns (uint8) {
        return 0;
    }

    function setPrice(uint256 newPrice) public {
        price = newPrice;
        //FIXME: add ownership check, only the Trust can change it.
    }

    function getPrice() public view returns (uint256) {
        return price;
    }

    function getDueDate() public view returns (uint32) {
        return dueDate;
    }

    function ethExchangeValue() private pure returns (uint256) {
        //FIXME: should ask an oracle the current price in USD of one ETH:
        return 333531 * 10**16; //2024-02-29.
    }

    function buy() public payable {
        uint256 tokenAmount = msg.value * ethExchangeValue() / (price * 10**18);
        require(tokenAmount > 0, "Insufficient ETH amount to buy a single token");
        require(tokenAmount + balanceOf(msg.sender) >= minOwnedTokens,
            "Insufficient ETH amount to buy the minimum amount of tokens");
        uint256 remainingTokens = maxTokens - totalSupply();
        require(tokenAmount <= remainingTokens, "Insufficient tokens available, send less ETH");

        _mint(msg.sender, tokenAmount);

        uint256 excessAmount = msg.value - (tokenAmount * price / ethExchangeValue()) * 10**18;
        if (excessAmount > 0) {
            payable(msg.sender).transfer(excessAmount);
        }
        //FIXME: should send to the trust or they will just withraw from time to time?
    }

    function sell(uint256 tokenAmount) public {
        require(tokenAmount > 0, "Invalid token amount");
        require(balanceOf(msg.sender) >= tokenAmount, "Insufficient tokens in your balance");

        uint256 penalty = 0;
        if (block.timestamp < dueDate) {
            penalty = tokenAmount * price * earlyWithdrawPenalty / (100**18 * 1**18);
        }
        uint256 profit = (price - initialPrice) * tokenAmount;
        uint256 platformProfit = profit * profitPct / (100**18 * 1**18);
        uint256 amountUSD = tokenAmount * price - penalty - platformProfit;
        uint256 ethAmount =  amountUSD * 1 ** 18 / ethExchangeValue();
        require(ethAmount > 0, "There's nothing left for you my friend, better luck next time");
        _burn(msg.sender, tokenAmount);
        payable(msg.sender).transfer(ethAmount);
    }
}
