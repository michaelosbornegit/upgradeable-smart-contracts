pragma solidity ^0.4.24;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Proxy.sol";
import "../contracts/Logic1.sol";

contract TestLogic1TestEnv {

    Proxy proxy;
    Logic1 logic1;

    // Create and deploy a new instance of Proxy and Logic1 before each test.
    function beforeEach() public {
        proxy = new Proxy();
        logic1 = new Logic1();
        proxy.updateLogicAddress(address(logic1));
    }

    function testRedeem() public {
        proxy.redeem(20);
        Assert.equal(40, proxy.balanceOf(msg.sender), "Single redeem call failed");
        
        proxy.redeem(30);
        proxy.redeem(1);
        Assert.equal(102, proxy.balanceOf(msg.sender), "Multiple redeem calls failed");
    }
}