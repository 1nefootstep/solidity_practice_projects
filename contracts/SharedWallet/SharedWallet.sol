// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/76fca3aec8e6ce2caf1c9c9a2c8396fe0882591a/contracts/access/Ownable.sol";

contract SharedWallet is Ownable {
    event AllowanceChanged(address indexed _user, address indexed _currOwner, uint _oldAmount, uint _newAmount);

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
        uint newAllowance = allowance[_user] + _amount;
        emit AllowanceChanged(_user, msg.sender, allowance[_user], newAllowance);
        allowance[_user] = newAllowance;        
    }

    function removeAllowance(address _user, uint _amount) public onlyOwner {
        require(allowance[_user] >= _amount, "Insufficient allowance to remove");
        uint newAllowance = allowance[_user] - _amount;
        emit AllowanceChanged(_user, msg.sender, allowance[_user], newAllowance);
        allowance[_user] = newAllowance;
        freeBalance += _amount;
    }

    function withdraw(address payable _to, uint _amount) public {
        require(_amount <= allowance[msg.sender], "Insufficient allowance");
        uint newAllowance = allowance[msg.sender] - _amount;
        emit AllowanceChanged(msg.sender, msg.sender, allowance[msg.sender], newAllowance);
        allowance[msg.sender] = newAllowance;
        _to.transfer(_amount);    
    }

    // overwriting the renounceOwnership function
    function renounceOwnership() override public onlyOwner view {
        revert("Not allowed to renounce ownership");
    }
}