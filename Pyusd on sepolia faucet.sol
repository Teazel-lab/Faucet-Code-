// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
    event Transfer(address indexed from, address indexed to, uint256 value);
}

contract Faucet {
    address payable public owner;
    IERC20 public token;
    uint256 public withdrawalAmount = 1 * (10 ** 6);  // PYUSD uses 6 decimals
    uint256 public locktime = 1 minutes;

    event Withdrawal(address indexed to, uint256 amount);
    event Deposit(address indexed from, uint256 amount);

    mapping(address => uint256) public nextAccessTime;

    constructor(address tokenAddress) payable {
        token = IERC20(tokenAddress);
        owner = payable(msg.sender);
    }

    function requestTokens() public {
        require(token.balanceOf(address(this)) >= withdrawalAmount, "Contract has no tokens");
        require(msg.sender != address(0), "Invalid address");
        require(block.timestamp >= nextAccessTime[msg.sender], "Please wait before next request");

        nextAccessTime[msg.sender] = block.timestamp + locktime;
        require(token.transfer(msg.sender, withdrawalAmount), "Token transfer failed");
    }

    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    function getBalance() external view returns (uint256) {
        return token.balanceOf(address(this));
    }

    function setWithdrawalAmount(uint256 amount) public onlyOwner {
        withdrawalAmount = amount * (10 ** 6);  // PYUSD uses 6 decimals
    }

    function setLockTime(uint256 minutesAmount) public onlyOwner {
        locktime = minutesAmount * 1 minutes;
    }

    function withdrawTokens() external onlyOwner {
        uint256 balance = token.balanceOf(address(this));
        emit Withdrawal(msg.sender, balance);
        require(token.transfer(msg.sender, balance), "Withdraw failed");
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }
}
