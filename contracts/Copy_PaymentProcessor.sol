// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract PaymentProcessor {
    uint public balance;
    mapping(address => Balance) balanceReceived;

    struct Payment {
        uint amount;
        uint timestamp;
    }

    struct Balance {
        uint totalBalance;
        uint numPayments;
        mapping(uint => Payment) payments;
    }

    function sendMoney() public payable {
        balance += msg.value;
        Payment memory payment = Payment(msg.value, block.timestamp);
        balanceReceived[msg.sender].totalBalance += msg.value;
        balanceReceived[msg.sender].payments[balanceReceived[msg.sender].numPayments] = payment;
        balanceReceived[msg.sender].numPayments += 1;
        
    }
    function withdrawAllMoney() public payable {
        uint balanceToSend = balanceReceived[msg.sender].totalBalance;
        balance -= balanceToSend;
        balanceReceived[msg.sender].totalBalance = 0;
        payable(msg.sender).transfer(balanceToSend);
    }
}