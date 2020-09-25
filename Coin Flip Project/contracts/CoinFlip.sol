pragma solidity 0.5.12;

contract CoinFlip {
    
    address public owner;
    uint public balance;
    bool result;
    
    struct Bet {
        uint coinside;
        uint betvalue;
    }
    
    mapping (address => Bet) private bettings;
    


    constructor() public payable {
        balance = msg.value;
        owner = msg.sender;

    }

    function setAbet(uint myCoinSide) public payable {
        
        Bet memory newbet;
        
        newbet.coinside = myCoinSide;
        newbet.betvalue = msg.value;
        bettings[msg.sender] = newbet;
        
        balance += msg.value;

    
    }

    function getAbet() public view returns (uint myCoinSide, uint myBetValue) {
        
        return (bettings[msg.sender].coinside, bettings[msg.sender].betvalue);
    }

    function random () private view returns (uint) {
        return now % 2;
    }

    function flip () public returns(bool) {
        
        uint coin = random();
        uint toTransfer = bettings[msg.sender].betvalue;
        if (coin == bettings[msg.sender].coinside) {
            require(balance>=2*toTransfer);
            balance = balance - 2*toTransfer;
            bettings[msg.sender].betvalue = 0;
            msg.sender.transfer(2*toTransfer);
            return result = true;
        }
        else {
            
            return result = false;
        }
    
    }
    
    function showResult() public view returns (bool) {
        return result; 
    }
    
    
    
}