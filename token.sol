// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.5.0;

// abstract contract ERC20Basic {
//     function totalSupply() external view returns (uint);
//     function balanceOf(address who) external view returns (uint);
//     function transfer(address to, uint value) external;
//     event Transfer(address indexed from, address indexed to, uint value);
// }

// abstract contract ERC20 is ERC20Basic {
//     function allowance(address owner, address spender) external view returns (uint);
//     function transferFrom(address from, address to, uint value) external;
//     function approve(address spender, uint value) external;
//     event Approval(address indexed owner, address indexed spender, uint value);
// }

contract token {
    uint public _totalSupply;
    address public minter;
    string public name;
    uint public decimals ;
    mapping(address => uint256) public balances;
    mapping (address => mapping (address => uint)) public allowed;

    event Sent(address from, address to, uint256 amount);

    constructor() {
        minter = msg.sender;
        name='Tok Token';
        mint(1000000000);
    }

    function mint(uint256 amount) private {
        require(msg.sender == minter);
        balances[minter] += amount;
        _totalSupply += amount;
    }

    error InsuficientBalance(uint256 requested, uint256 available);

    function transfer(address receiver, uint256 amount) public {
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

    function totalSupply() public view returns(uint){
        return _totalSupply;
    }

    function balanceOf(address who) public view returns(uint){
        return balances[who];
    }




    // function approve()

}
