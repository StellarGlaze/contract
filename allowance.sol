// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AllowanceContract {
    address public provider;
    mapping(address => uint) public allowances;
    uint public transferDay;
    uint public startTime;
    uint public endTime;
    string public transferMessage;

    event AllowanceSet(address indexed recipient, uint amount, uint startTime, uint endTime);
    event AllowanceTransferred(address indexed recipient, uint amount, string message);
    event RecipientRemoved(address indexed recipient);
    event TransferMessage(string message);

    constructor(address _provider, address[] memory _recipients, uint _transferDay, uint _startTime, uint _endTime) {
        provider = _provider;
        transferDay = _transferDay;
        startTime = _startTime;
        endTime = _endTime;

        for (uint i = 0; i < _recipients.length; i++) {
            allowances[_recipients[i]] = 0;
        }
    }

    function setAllowance(address recipient, uint amount) public {
        require(msg.sender == provider, "Only the provider can set allowances");
        allowances[recipient] = amount;
        emit AllowanceSet(recipient, amount, startTime, endTime);
    }

    function transferAllowance() public {
        // Add logic here to transfer allowance based on start and end time
        emit AllowanceTransferred(address(0), 1000, transferMessage);
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
