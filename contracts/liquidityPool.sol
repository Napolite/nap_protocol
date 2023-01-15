
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
    
    mapping(address => uint) deposits;

    event Transact(address caller, uint amount,string transtype, string message);

    function offerLPT(address to, uint amount){
        ERC20(0x76A6527426762F2879cDF91E1e0cb7eDe180292F).transferFrom(address(this), to, amount)

        emit Transact(to, amount, "offerLPT", "Transferred Provider tokens")
    }

    function deposit(address token, uint amount) public{
        require(ERC20(token).transferFrom(msg.sender, address(this), amount), "Cannot process this transfer");
        deposits[msg.sender] += amount;
        emit Transact(msg.sender, amount,"deposit", "Deposit completed");
    }


    function withdrawal(address token, uint amount) public{
        ERC20(token).transfer(msg.sender, amount);

        emit Transact(msg.sender, amount,"withdrawal", "Withdrawal Completed");
    }

    function exchange(address from, address to, uint amount) public{
        uint tokenBalance = ERC20(to).balanceOf(address(this));
        
        require(from != to, "Cannot perfrom this action on same tokens");
        require(tokenBalance >amount, "We don't have enough for this swap");

        deposit(from, amount);
        withdrawal(to, amount);

        emit Transact(msg.sender, amount,"swap", "Swap completed");
    }


}