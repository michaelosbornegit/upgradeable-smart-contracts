pragma solidity ^0.4.24;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Proxy.sol";
import "../contracts/Logic1.sol";

contract TestProxyERC20 {

    // Proxy proxy = Proxy(DeployedAddresses.Proxy());

    // // This line is unnecessary but included to show that Logic1 is deployed
    // Logic1 logic1 = Logic1(DeployedAddresses.Logic1());

    Proxy proxy;
    Logic1 logic1;

    // Create and deploy a new instance of Proxy and Logic1 before each test.
    function beforeEach() public {
        proxy = new Proxy();
        logic1 = new Logic1();
        proxy.updateLogicAddress(address(logic1));
    }

    function testBalanceOf() public {
        proxy.redeem(20);
        Assert.equal(40, proxy.balanceOf(msg.sender), "Single balanceOf call failed");
        
        proxy.redeem(30);
        proxy.redeem(1);
        Assert.equal(102, proxy.balanceOf(msg.sender), "Multiple balanceOf calls failed");
    }

    function testTotalSupply() public {
        proxy.redeem(50);
        proxy.redeem(30);
        proxy.redeem(1);
        Assert.equal(162, proxy.totalSupply(), "Multiple balanceOf calls failed");
    }
}