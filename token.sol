// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.5.0;

contract token {
    address public minter;
    string public name;
    uint public totalSupply;
    uint public decimals ;
    mapping(address => uint256) public balances;
    mapping (address => address) public approval;

    event Sent(address from, address to, uint256 amount);

    constructor() {
        minter = msg.sender;
        name='Tok Token'
        mint(1000000000);
    }

    function mint(uint256 amount) private {
        require(msg.sender == minter);
        balances[minter] += amount;
        totalSupply += amount;
    }

    error InsuficientBalance(uint256 requested, uint256 available);

    function send(address receiver, uint256 amount) public {
        if (amount > balances[msg.sender]) {
            revert InsuficientBalance({
                requested: amount,
                available: balances[msg.sender]
            });
        }

        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }

    function approve()

}
