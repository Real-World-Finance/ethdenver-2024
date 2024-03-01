// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract RWF_Trust is ERC20, ERC20Permit, Ownable {

    uint256 private maxTokens;
    uint256 private initialPrice; //in 10**18 USD
    uint256 private price; //in 10**18 USD
    uint256 private dueDate; //UTC Unix Timestamp
    uint256 private expectedROI; //in 10**18
    uint256 private earlyWithdrawPenalty; //in 10**18 USD
    uint256 private pctCashReserve; //in 10**18
    string  private imageURL;
    uint256 private profitPct; //in 10**18
    uint256 private minOwnedTokens = 20;
    address[] private beneficiaries;

    constructor(
        string  memory _name,
        string  memory _symbol,
        uint256 _maxTokens,
        uint256 _price,
        uint256 _dueDate,
        uint256 _expectedROI,
        uint256 _earlyWithdrawPenalty,
        uint256 _pctCashReserve,
        string  memory _imageURL,
        address _trust,
        uint256 _profitPct
    )
        ERC20(_name, _symbol)
        ERC20Permit(_name)
        Ownable(_trust)
    {
        //FIXME: check invariants
        maxTokens = _maxTokens;
        initialPrice = _price;
        setPrice(_price);
        dueDate = _dueDate;
        expectedROI = _expectedROI;
        earlyWithdrawPenalty = _earlyWithdrawPenalty;
        pctCashReserve = _pctCashReserve;
        imageURL = _imageURL;
        profitPct = _profitPct;
    } //end of constructor

    function decimals() public pure override returns (uint8) {
        return 0;
    }

    function setPrice(uint256 newPrice) public onlyOwner {
        price = newPrice;
    }

    function getPrice() public view returns (uint256) {
        return price;
    }

    function getDueDate() public view returns (uint256) {
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
        require(block.timestamp < dueDate, "Fund has been terminated");

        _mint(msg.sender, tokenAmount);

        payable(owner()).transfer( (100**18 - pctCashReserve) * msg.value / (100**18 * 1**18) );

        uint256 excessAmount = msg.value - (tokenAmount * price / ethExchangeValue()) * 10**18;
        if (excessAmount > 0) {
            payable(msg.sender).transfer(excessAmount);
        }
    }

    function _sell(address seller, uint256 tokenAmount) private {
        require(tokenAmount > 0, "Invalid token amount");
        require(balanceOf(seller) >= tokenAmount, "Insufficient tokens in your balance");

        uint256 penalty = 0;
        if (block.timestamp < dueDate) {
            penalty = tokenAmount * price * earlyWithdrawPenalty / (100**18 * 1**18);
        }
        uint256 profit = (price - initialPrice) * tokenAmount;
        uint256 platformProfit = profit * profitPct / (100**18 * 1**18);
        uint256 amountUSD = tokenAmount * price - penalty - platformProfit;
        uint256 ethAmount =  amountUSD * 1 ** 18 / ethExchangeValue();
        require(ethAmount > 0, "There's nothing left for you my friend, better luck next time");
        _burn(seller, tokenAmount);
        payable(seller).transfer(ethAmount);
    }

    function sell(uint256 tokenAmount) public {
        _sell(msg.sender, tokenAmount);
    }

    function investmentExecution() public onlyOwner {
        uint256 netPaymentETH = totalSupply() * price * 1**18 / ethExchangeValue();
        uint256 totalPaymentETH = (100**18 - profitPct) * netPaymentETH / (100**18 * 1**18);
        require(address(this).balance >= totalPaymentETH,
            "Not enough funds to execute investment returns");
        
        for (uint32 i = 0; i != beneficiaries.length; i++) {
            address beneficiary = beneficiaries[i];
            if (balanceOf(beneficiary) == 0) {
                continue;
            }
            _sell(beneficiary, balanceOf(beneficiary));
        }
    }

    function _update(address from, address to, uint256 value) internal virtual override {
        bool toExisted = balanceOf(to) > 0;
        super._update(from, to, value);
        bool toExists = balanceOf(to) > 0;
        if (!toExisted && toExists) {
            beneficiaries.push(to);
        }
    }

    function withdraw(uint256 amount) public onlyOwner {
        require(address(this).balance >= amount, "Insufficient funds");
        payable(owner()).transfer(amount);
    }
}
