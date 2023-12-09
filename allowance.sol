// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract AllowanceContract {
    address public provider;
    mapping(address => uint) public allowances;
    uint public transferDay;
    uint public startTime;
    uint public endTime;
    string public transferMessage;
    address[] public recipients;
    uint256 contractBalance=0;
    event AllowanceSet(address indexed recipient, uint amount, uint startTime, uint endTime);
    event AllowanceTransferred(address indexed recipient, uint amount, string message);
    event RecipientRemoved(address indexed recipient);
    event TransferMessage(string message);

    constructor(address _provider, address[] memory _recipients, uint _transferDay, uint _startTime, uint _endTime) payable {
        provider = _provider;
        transferDay = _transferDay;
        startTime = _startTime;
        endTime = _endTime;
        recipients = _recipients;

        for (uint i = 0; i < _recipients.length; i++) {
            allowances[_recipients[i]] = 0;
        }
        contractBalance+=msg.value;
    }

    function deposit() public payable {
        contractBalance+=msg.value;
    }


    function setAllowances(address[] memory _recipients, uint[] memory amounts) public {
        require(msg.sender == provider, "Only the provider can set allowances");
        require(_recipients.length == amounts.length, "Arrays length mismatch");

        for (uint i = 0; i < _recipients.length; i++) {
            allowances[_recipients[i]] = amounts[i];
        }

        emit AllowanceSet(_recipients[_recipients.length - 1], amounts[amounts.length - 1], startTime, endTime);
    }

    function transferAllowance(address receiver, uint256 amount) public {
        require(block.timestamp >= startTime && block.timestamp <= endTime, "Allowance transfer not allowed at this time");

        for (uint i = 0; i < recipients.length; i++) {
            address recipient = recipients[i];
            uint allowed_amount = allowances[recipient];
            require(amount<=allowed_amount,"amount greater than allowed amount");
            allowances[recipient]-=amount;
            payable(receiver).transfer(amount);
            emit AllowanceTransferred(recipient, amount, transferMessage);
        }
    }

    function removeRecipient(address recipient) public {
        require(msg.sender == provider, "Only the provider can remove recipients");
        delete allowances[recipient];
        emit RecipientRemoved(recipient);
    }

    function setTransferMessage(string memory message) public {
        require(msg.sender == provider, "Only the provider can set transfer messages");
        transferMessage = message;
        emit TransferMessage(message);
    }
}
