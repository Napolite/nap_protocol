
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.5.0;

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

interface Ownable{
    function  Owner() external view returns (address);
    function transferOwnership(address sender) external;
}


contract token is ERC20, Ownable {
    uint public _totalSupply;
    address public contractOwner;
    string public _name;
    string public _symbol;
    uint public decimals ;
    mapping(address => uint256) public balances;
    mapping (address => mapping (address => uint)) public allowed;


    constructor() {
        contractOwner = msg.sender;
        _name="Napolite";
        _symbol = "Nap";
        mint(1000000000);
    }


    function mint(uint256 amount) private {
        require(msg.sender == contractOwner);
        balances[contractOwner] += amount;
        _totalSupply += amount;
    }

    function name() public view override returns(string memory){
        return _name;
    }

    function symbol() public view override returns(string memory){
        return _symbol;
    }

    error InsuficientBalance(uint256 requested, uint256 available);


    function transfer(address receiver, uint256 amount) public override{
        require(msg.sender != receiver, "you cannot transfer tokens to same address");
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
        require(from != to, "you cannot transfer tokens to same address");
        require(allowanceAmount < amount, "Contract not allowed to spend amount");
         if (amount > balances[from]) {
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
        allowed[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
    }

    function allowance(address owner, address spender) public view override returns(uint256) {
        return allowed[owner][spender];
    }

    function Owner() public view override returns (address){
        return contractOwner;
    }

    function transferOwnership(address newOwner) public override{
        require(msg.sender == contractOwner, "you are not the owner of this contract");
        contractOwner = newOwner;
    }

}
