// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {FundFundMe, WithdrawFundMe} from "../../script/Interactions.s.sol";


contract InteractionsTest is Test {
    FundMe fundMe;
    address USER = makeAddr("user"); //Makes an address and assigns it to USER
    uint256 expectedPriceFeedVersion = 4;
    uint256 expectedMinimumValue = 5 * 10 ** 18;
    uint256 SEND_VALUE = 0.1 ether;
    uint256 STARTING_BALANCE = 10 ether;

    function setUp() external {
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(USER, STARTING_BALANCE);
    }

    function testUserCanFundInteractions() public {
        //Fund Arrange
        FundFundMe fundFundMe = new FundFundMe();
        //Fund Act
        vm.prank(USER);
        fundFundMe.fundFundMe(address(fundMe)); //fund
        //Fund Assert
        address funder = fundMe.getFunder(0);
        assertEq(funder, USER); //check USER is registered as a funder

        //Withdraw Arrange
        WithdrawFundMe withdrawFundMe = new WithdrawFundMe();
        //Withdraw Act
        vm.prank(msg.sender);
        withdrawFundMe.withdrawFundMe(address(fundMe)); //withdraw
        //Withdraw Assert
        assertEq(address(fundMe).balance, 0); //check funds were withdrawn
    }
}