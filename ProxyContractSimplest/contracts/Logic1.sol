pragma solidity ^0.4.24;

/**
 * @title Logic1
 * @dev 
 */
contract Logic1 {

    AbstractProxy public proxyContract;

    constructor(address theProxyAddress) public {
        proxyContract = AbstractProxy(theProxyAddress);
        proxyContract.newLogicDeployed(address(this));
    }

    function redeem(uint theAmount) public {

        // Any conversion math or gathering data from oracles that
        // effects the conversion rate or amount to tokens goes here...
        uint tokensToAward = theAmount * 2;


        // Call the proxy contract to update the users amount.
        proxyContract.redeemTokens(tokensToAward);
    }
}

contract AbstractProxy {
    function newLogicDeployed(address theLogicAddress) public {}
    function redeemTokens(uint theTokensToAward) public {}
}
