// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.7.0 <0.9.0;

contract VolcanoCoin {

    uint256 totalSuply = 10000;
    address owner;
    event supplyUpdated(uint256 newValue);
    event _transfere(uint256 _amount, address _receipient);
    mapping (address => uint256) balances;
    struct Payment{
        uint256 transferAmount;
        address receipientAddress;
    }
    mapping(address => Payment[]) payments;

    constructor(){
        owner = msg.sender;
        balances[owner] = totalSuply;
    }

    function retrieveSupply() public view returns(uint256) {
        return totalSuply;
    }

    function increaseSupply() public onlyOwner{
        totalSuply += 1000;
        emit supplyUpdated(totalSuply);
    }

    modifier onlyOwner {
        if(msg.sender == owner){
            _;
        }
    }

    function getBalance(address user) public view returns(uint256){
        return balances[user];
    }

    function transfere(uint256 amount, address receipient) public {
        if(balances[msg.sender] >= amount){
            balances[msg.sender] = balances[msg.sender] - amount;
            balances[receipient] = amount;
            emit _transfere(amount, receipient);
        }
    }
}
