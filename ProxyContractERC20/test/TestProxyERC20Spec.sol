pragma solidity ^0.4.24;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Proxy.sol";

contract TestProxyERC20Spec {

    Proxy proxy = Proxy(DeployedAddresses.Proxy());

    function testBalanceOf() public {
        proxy.redeem(20);
        Assert.equal(40, proxy.balanceOf(msg.sender), "Single redeem call failed");
        
        proxy.redeem(30);
        proxy.redeem(1);
        Assert.equal(102, proxy.balanceOf(msg.sender), "Multiple redeem calls failed");
    }
}