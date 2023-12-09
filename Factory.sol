// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./allowance.sol";

contract FactoryContract {
    event ContractCreated(address creator, address contractAddr);
    mapping(address => AllowanceContract) public addr_to_contract;

    function deployChildContract(
        address _provider,
        address[] memory _recipients,
        uint _transferDay,
        uint _startTime,
        uint _endTime
    ) public {
        AllowanceContract newChildContract = new AllowanceContract(
            _provider,
            _recipients,
            _transferDay,
            _startTime,
            _endTime
        );
        addr_to_contract[msg.sender] = newChildContract;
        emit ContractCreated(msg.sender, address(newChildContract));
    }
}
