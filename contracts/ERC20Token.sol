// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title SkutiiToken - A simple ERC-20 token created by skutii
/// @notice This is a practice contract for learning purposes
contract SkutiiToken {
    // skutii: Variables to store token details
    string public name = "SkutiiToken";
    string public symbol = "SKT";
    uint8 public decimals = 18;
    uint256 public totalSupply;

    // skutii: Mapping to track each address balance
    mapping(address => uint256) public balanceOf;

    // skutii: Mapping to track allowances (who can spend on your behalf)
    mapping(address => mapping(address => uint256)) public allowance;

    // skutii: Events (help track transfers on blockchain explorers)
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /// @notice Constructor that mints initial supply to the deployer
    /// @param _initialSupply The amount of tokens to mint
    constructor(uint256 _initialSupply) {
        totalSupply = _initialSupply * (10 ** uint256(decimals));
        balanceOf[msg.sender] = totalSupply;

        // skutii: Emit a transfer from address(0) to show minting
        emit Transfer(address(0), msg.sender, totalSupply);
    }

    /// @notice Transfer tokens from sender to another address
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value, "Not enough balance");
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        emit Transfer(msg.sender, _to, _value); // skutii: Log transfer event
        return true;
    }

    /// @notice Approve someone to spend tokens on your behalf
    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value); // skutii: Log approval event
        return true;
    }

    /// @notice Transfer tokens from one account to another (with approval)
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(balanceOf[_from] >= _value, "Not enough balance");
        require(allowance[_from][msg.sender] >= _value, "Allowance too low");

        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -= _value;

        emit Transfer(_from, _to, _value); // skutii: Log transfer event
        return true;
    }
}
