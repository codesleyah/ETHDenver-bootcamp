// SPDX-License-Identifier: None

pragma solidity 0.8.17;


contract BootcampContract {

    uint256 number;
    address deployer;

    constructor (){
        deployer = msg.sender;
    }


    function store(uint256 num) public {
        number = num;
    }

    function returnAdress() external view returns(address){
        address theAddress;
        if(msg.sender == deployer){
            theAddress =  0x000000000000000000000000000000000000dEaD;
        } else{
            theAddress = deployer;
        }

        return theAddress;
    }

    function retrieve() public view returns (uint256){
        return number;
    }
}
