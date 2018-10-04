pragma solidity ^0.4.24;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Proxy.sol";
import "../contracts/Logic1.sol";

contract TestLogic1RealWorld {

    // Key Difference, we are using the deployed contracts address, not creating a new instance of the contract.
    Proxy proxy = Proxy(DeployedAddresses.Proxy());

    // This line is unnecessary but included to show that Logic1 is deployed
    Logic1 logic1 = Logic1(DeployedAddresses.Logic1());

    function testRedeem() public {
        proxy.redeem(20);
        Assert.equal(40, proxy.balanceOf(msg.sender), "Single redeem call failed");
        
        proxy.redeem(30);
        proxy.redeem(1);
        Assert.equal(102, proxy.balanceOf(msg.sender), "Multiple redeem calls failed");
    }
}