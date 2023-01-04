// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.5.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/utils/SafeERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

interface ERC20 {
    function name() external view returns(string memory);
    function symbol() external view returns(string memory);
    function totalSupply() external view returns (uint);
    function balanceOf(address who) external view returns (uint);
    function transfer(address to, uint value) external;
    event Transfer(address indexed from, address indexed to, uint value);
    function allowance(address owner, address spender) external returns (uint);
    function transferFrom(address from, address to, uint value) external;
    function approve(address spender, uint value) external;
    event Approval(address indexed owner, address indexed spender, uint value);
}

contract Pool {
    using SafeERC20 for ERC20;
    using SafeMath for uint;

    event Deposit(string message);

    function deposit(address token, uint amount) public{
        ERC20(token).transferFrom(msg.sender, address(this), amount);

        emit Deposit("deposit completed");
    }


    function withdrawal(address token, uint amount) public{
        ERC20(token).transfer(msg.sender, amount);

        emit Deposit("Withdrawal Completed");
    }


}