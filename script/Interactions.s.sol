//SPDX-License-Identifier: MIT

// Fund Script
// Withdraw Script

pragma solidity ^0.8.18;

import {Script, console} from "../lib/forge-std/src/Script.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundFundMe is Script {
    uint256 constant SEND_VALUE = 0.01 ether;
    constructor (address mostRecentDeployment) {
        vm.startBroadcast();
        FundMe(payable(mostRecentDeployment)).fund{value: SEND_VALUE}();
        vm.stopBroadcast();
        console.log("Funded FundMe  with %s", SEND_VALUE);
    }


    function run() external {
        address mostRecentDeployment = DevOpsTools.getMostRecentDeployment(
            "FundMe",
            block.chainid
        );
        FundFundMe(mostRecentDeployment);
    }
}

contract WithdrawFundMe is Script {}
