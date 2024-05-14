// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DeployFundMe is Script {
    function run() external returns (FundMe) {
        //Before startBroadcast -> Not a "real" transaction
        HelperConfig helperConfig = new HelperConfig();
        address ethUsdPriceFeed = helperConfig.activeNetworkConfig();

        // After startBroadcast -> Real transaction
        vm.startBroadcast();
        FundMe fundMe = new FundMe(ethUsdPriceFeed); // 0x8A753747A1Fa494EC906cE90E9f37563A8AF630e
        vm.stopBroadcast();
        return fundMe;
    }
}
