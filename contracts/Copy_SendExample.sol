// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract SendMoneyExample {
    uint public balanceReceived;

    function receiveMoney() public payable {
        balanceReceived += msg.value;
    }
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
    function withdraw() public {
        address payable to = payable(msg.sender);
        to.transfer(this.getBalance());
    }
    function withdrawTo(address payable _to) public {
        _to.transfer(this.getBalance());
    }
}