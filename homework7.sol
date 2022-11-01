// SPDX-License-Identifier: UNLICENSED

pragma solidity  ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract VolcanoCoin is Ownable{

    uint  public totalSupply = 10000;
    mapping(address => uint) public balances;

    constructor(){
        balances[owner()] = totalSupply;
    }

    struct Payment{
        uint amount;
        address recipient;
    }

    mapping(address => Payment[]) payments;

    event SupplyChange(uint _totalSupply);
    event Transfer(uint _amount,address _to);

    function increaseSupply() public onlyOwner{
        totalSupply +=totalSupply;
        emit SupplyChange(totalSupply);
    }

    function transfer(uint _amount, address _to)public{
        uint  balance = balances[msg.sender];
        require(_amount <= balance,"Unsufficient balance ");
        require(_to != address(0)," Can't send to a zero address");

        balances[_to] = _amount;
        balances[msg.sender] = balance - _amount;
        recordPayment(msg.sender, _to, _amount);
        emit Transfer(_amount,_to);

    }

    function viewPayments(address user) public view returns(Payment[] memory){
        return payments[user];
    }

    function recordPayment(address sender, address receiver, uint256 amount) private {

        payments[sender].push(
            Payment({
                amount:amount,
                recipient: receiver
            })
        );
    }


    
}
