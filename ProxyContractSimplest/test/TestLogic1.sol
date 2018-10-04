pragma solidity ^0.4.24;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Proxy.sol";
import "../contracts/Logic1.sol";
import "../contracts/Logic2.sol";

contract TestProxy {

    Proxy proxy;
    Logic1 logic1;

    function beforeEach() public {
        proxy = Proxy(DeployedAddresses.Proxy());
        logic1 = Logic1(DeployedAddresses.Logic1());
    }

    function testRedeem() public {
        proxy.redeem(20);
        Assert.equal(40, proxy.getBalance(), "Redeem did not work correctly");
    }

    function testOverwriteRedeem() public {
        proxy.redeem(20);
        proxy.redeem(30);
        Assert.equal(60, proxy.getBalance(), "Redeem did not work correctly");
    }
}