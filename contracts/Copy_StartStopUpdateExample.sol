// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract StartStopUpdateExample {
    address public owner;
    bool public isPaused;
    constructor() {
        owner = msg.sender;
    }
    function sendMoney() public payable {
        require(!isPaused, "contract is paused");
    }
    function withdrawAllMoney(address payable _to) public {
        require(!isPaused, "contract is paused");
        require(msg.sender == owner, "not owner");
        _to.transfer(address(this).balance);
    }
    function pauseContract() public {
        require(msg.sender == owner, "not owner");
        isPaused = true;
    }
    function resumeContract() public {
        require(msg.sender == owner, "not owner");
        isPaused = false;
    }

}