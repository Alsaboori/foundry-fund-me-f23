//SPDX-License-Identifier: MIT

// Fund Script
// Withdraw Script

pragma solidity ^0.8.18;

import {Script, console} from "../lib/forge-std/src/Script.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";
import {DeployFundMe} from "./DeployFundMe.s.sol";


contract FundFundMe is Script {
    uint256 SEND_VALUE = 0.1 ether;

    function run() external {

        address mostRecentlyDeployed = DevOpsTools.getMostRecentDeployment(
            "FundMe",
            block.chainid
        );

        vm.startBroadcast();
        fundFundMe(mostRecentlyDeployed);
        vm.stopBroadcast();
    }

    function fundFundMe(address mostRecentlyDeployed) public payable {
        vm.prank(msg.sender);
        FundMe(payable(mostRecentlyDeployed)).fund{value: SEND_VALUE}();
        console.log("Funded FundMe with %s", SEND_VALUE);
    }
}

contract WithdrawFundMe is Script {
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.getMostRecentDeployment(
            "FundMe",
            block.chainid
        );
        vm.startBroadcast();
        withdrawFundMe(mostRecentlyDeployed);
        vm.stopBroadcast();
    }

    function withdrawFundMe(address mostRecentlyDeployed) public {
        vm.prank(msg.sender);
        FundMe(payable(mostRecentlyDeployed)).withdraw();
        console.log("Withdrew funds");
    }
}

