pragma solidity ^0.4.24;

import "./Logic1.sol";

/**
 * @title Logic2
 * @dev 
 */
contract Logic2 is Logic1 {

    // Call the parents constructor.
    constructor(address theProxyAddress) Logic1(theProxyAddress) public {}

    function redeem(uint theAmount) public {

        // Any conversion math or gathering data from oracles that
        // effects the conversion rate or amount to tokens goes here...
        uint tokensToAward = theAmount * 10;


        // Call the proxy contract to update the users amount.
        proxyContract.redeemTokens(tokensToAward);
    }
}