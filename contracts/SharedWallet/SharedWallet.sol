// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/76fca3aec8e6ce2caf1c9c9a2c8396fe0882591a/contracts/access/Ownable.sol";

contract SharedWallet is Ownable {
    uint freeBalance;
    function getFreeBalance() public view returns(uint) {
        return freeBalance;
    }

    mapping(address => uint) allowance;
    function getUserAllowance(address _user) public view returns(uint) {
        return allowance[_user];
    }

    function fundWallet() public onlyOwner payable {
        freeBalance += msg.value;
    }

    receive () external payable {
        fundWallet();
    }

    function addAllowance(address _user, uint _amount) public onlyOwner {
        require(freeBalance >= _amount, "Insufficient free balance");
        freeBalance -= _amount;
        allowance[_user] += _amount;
    }

    function removeAllowance(address _user, uint _amount) public onlyOwner {
        require(allowance[_user] >= _amount, "Insufficient allowance to remove");
        allowance[_user] -= _amount;
        freeBalance += _amount;
    }

    function withdraw(address payable _to, uint _amount) public {
        require(_amount <= allowance[msg.sender], "Insufficient allowance");
        allowance[msg.sender] -= _amount;
        _to.transfer(_amount);
    }
}