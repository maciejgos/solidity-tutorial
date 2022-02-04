// SPDX-License-Identifier: MIT

pragma solidity 0.8.11;

contract Wallet {
    address public owner;
    mapping (address => uint) private allowance;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(owner == msg.sender, "You are not the owner.");
        _;
    }

    modifier minimumAmount(uint _amount) {
        require(_amount <= allowance[msg.sender], "You don't have sufficient funds.");
        _;
    }

    function addAllowance(address _employee, uint _amount) public onlyOwner {
        allowance[_employee] = _amount;
    }

    function withdrawMoney(address payable _to, uint _amount) public minimumAmount(_amount) {
        reduceAllowance(msg.sender, _amount);
        _to.transfer(_amount);
    }

    function reduceAllowance(address _employee, uint _amount) private {
        allowance[_employee] -= _amount;
    }
}