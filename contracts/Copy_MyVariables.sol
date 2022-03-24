pragma solidity ^0.5.13;

contract MyVariables {
    uint256 public myUint;
    function setMyUint(uint _myUint) public {
        myUint = _myUint;
    }

    bool public myBool;
    function setMyBool(bool _myBool) public {
        myBool = _myBool;
    }

    uint8 public myUint8;
    function incrementUint8() public {
        myUint8 += 1;
    }
    function decrementUint8() public {
        myUint8 -= 1;
    }

    address public myAddress;
    function setAddress(address _addr) public {
        myAddress = _addr;
    }
    function getBalanceOfAddress() public view returns(uint) {
        return myAddress.balance;
    }

    string public myString = "hello world";
    function setMyString(string memory _s) public {
        myString = _s;
    }
}