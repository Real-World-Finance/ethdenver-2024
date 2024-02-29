// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract RWF_Trust is ERC20, ERC20Permit, AccessControl {

    uint256 private maxTokens;
    uint32  private price;
    uint32  private dueDate;
    uint16  private expectedROI; 
    uint8   private earlyWithdrawPenalty;
    uint8   private pctCashReserve;
    string  private imageURL;
    address private trust;
    uint32  private profitBase;
    uint8   private profitPct;

    constructor(
        string  _name,
        string  _symbol,
        uint256 _maxTokens,
        uint256 _price,
        uint32  _dueDate,
        uint16  _expectedROI,
        uint8   _earlyWithdrawPenalty,
        uint8   _pctCashReserve,
        string  _imageURL,
        address _trust,
        uint32  _profitBase,
        uint8   _profitPct
    )
        ERC20(_name, _symbol)
        ERC20Permit(_name)
    {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        maxTokens = _maxTokens;
        setPrice(_price);
        dueDate = _dueDate;
        expectedROI = _expectedROI;
        earlyWithdrawPenalty = _earlyWithdrawPenalty;
        pctCashReserve = _pctCashReserve;
        imageURL = _imageURL;
        trust = _trust;
        profitBase = _profitBase;
        profitPct = _profitPct;
    } //end of constructor

    function decimals() public view returns (uint8) {
        return 0;
    }

    function setPrice(uint32 newPrice) public external {
        price = newPrice;
        //FIXME: add ownership check, only the Trust can change it.
    }

    function getPrice() public external view returns (uint32) {
        return price;
    }

    function getDueDate() public external view returns (uint32) {
        return dueDate;
    }

    function buy() public external payable {
        //FIXME: get USD ETH value then calculate tokens amount.
        //FIXME: do require(); to not exceed maxTokens.
        //_mint(msg.sender, _totalSupply * 10 ** decimals());
    }
}
