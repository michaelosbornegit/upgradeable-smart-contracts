pragma solidity ^0.4.24;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Proxy.sol";
import "../contracts/Logic2.sol";

contract TestLogic2TestEnv {

    Proxy proxy;
    Logic2 logic2;

    // Create and deploy a new instance of Proxy and Logic2 before each test.
    function beforeEach() public {
        proxy = new Proxy();
        logic2 = new Logic2();
        proxy.updateLogicAddress(address(logic2));
    }

    function testRedeem() public {
        proxy.redeem(20);
        Assert.equal(200, proxy.balanceOf(msg.sender), "Single redeem call failed");
        
        proxy.redeem(30);
        proxy.redeem(1);
        Assert.equal(510, proxy.balanceOf(msg.sender), "Multiple redeem calls failed");
    }
}