pragma solidity ^0.4.24;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Proxy.sol";
import "../contracts/Logic2.sol";

contract TestLogic2RealWorld {

    // Key Difference, we are using the deployed contracts address, not creating a new instance of the contract.
    Proxy proxy = Proxy(DeployedAddresses.Proxy());

    // This line is unnecessary but included to show that Logic2 is deployed
    Logic2 logic2 = Logic2(DeployedAddresses.Logic2());

    function testRedeem() public {
        proxy.redeem(20);
        Assert.equal(200, proxy.balanceOf(msg.sender), "Single redeem call failed");
        
        proxy.redeem(30);
        proxy.redeem(1);
        Assert.equal(510, proxy.balanceOf(msg.sender), "Multiple redeem calls failed");
    }
}