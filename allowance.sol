// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AllowanceContract {
    address public provider;
    mapping(address => uint) public allowances; // Mapping to store allowance amounts for each recipient
    uint public transferDay;

    event AllowanceSet(address indexed recipient, uint amount);
    event AllowanceTransferred(address indexed recipient, uint amount);

    constructor(address _provider, address[] memory _recipients, uint _transferDay) {
        provider = _provider;
        transferDay = _transferDay;

        // Initialize allowance amounts for each recipient to zero
        for (uint i = 0; i < _recipients.length; i++) {
            allowances[_recipients[i]] = 0;
        }
    }

    function setAllowance(address recipient, uint amount) public {
        require(msg.sender == provider, "Only the provider can set allowances");
        allowances[recipient] = amount;
        emit AllowanceSet(recipient, amount);
    }

    function transferAllowance() public {
                emit AllowanceTransferred(address(0), 1000);
    }
}
