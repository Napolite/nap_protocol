
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.5.0;

interface ERC20 {
    function totalSupply() external view returns (uint);
    function balanceOf(address who) external view returns (uint);
    function transfer(address to, uint value) external;
    event Transfer(address indexed from, address indexed to, uint value);
    function allowance(address owner, address spender) external returns (uint);
    function transferFrom(address from, address to, uint value) external;
    function approve(address spender, uint value) external;
    event Approval(address indexed owner, address indexed spender, uint value);
}

interface Ownable{
    function  owner() external view returns (address);
    function transferOwnership(address sender) external;
}


contract token is ERC20 {
    uint public _totalSupply;
    address public minter;
    address public contractOwner;
    string public name;
    string public symbol;
    uint public decimals ;
    mapping(address => uint256) public balances;
    mapping (address => mapping (address => uint)) public allowed;


    constructor() {
        minter = msg.sender;
        name='Tok Token';
        mint(1000000000);
    }


    function mint(uint256 amount) private {
        require(msg.sender == minter);
        balances[owner] += amount;
        _totalSupply += amount;
    }

    error InsuficientBalance(uint256 requested, uint256 available);

    function transfer(address receiver, uint256 amount) public override{
        if (amount > balances[msg.sender]) {
            revert InsuficientBalance({
                requested: amount,
                available: balances[msg.sender]
            });
        }

        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Transfer(msg.sender, receiver, amount);
    }

    function transferFrom(address from, address to, uint amount) public override{
        uint allowanceAmount = allowed[from][msg.sender];
         if (allowanceAmount < amount || amount > balances[from]) {
            revert InsuficientBalance({
                requested: amount,
                available: balances[from]
            });
        }
        balances[from] -= amount;
        balances[to] += amount;
        emit Transfer(from, to, amount);
    }

    function totalSupply() public view override returns(uint){
        return _totalSupply;
    }

    function balanceOf(address who) public view override returns(uint){
        return balances[who];
    }

    function approve(address spender, uint amount) public override{
        require(amount != 0);
        allowed[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
    }

    function allowance(address owner, address spender) public view override returns(uint256) {
        return allowed[owner][spender];
    }

}
