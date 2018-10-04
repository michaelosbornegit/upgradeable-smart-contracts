pragma solidity ^0.4.24;

import "./Logic1.sol";

/**
 * @title Logic2
 * @dev A logic contract which is meant to be called by a proxy contract, do some calculations
 *      (logic), then return a value. This logic contract changes the redeem method to return
 *      a new value.
 */
contract Logic2 is Logic1 {

    /**
     * @dev Call the parents constructor with theProxyAddress.
     */
    constructor(address theProxyAddress) Logic1(theProxyAddress) public {}

    /**
     * @dev This function takes in a value, and converts it to another value 
     *      (the amount of tokens to be awarded based on the parameter) and then
     *      passes this value back to the proxy contract for token minting.
     * @param theAmount The value to redeem.
     */
    function redeem(uint theAmount) public onlyProxy() {

        // The key difference is we are multiplying theAmount by 10 now.
        uint tokensToAward = theAmount * 10;


        // Call the proxy contract to update the users amount.
        proxyContract.redeemTokens(tokensToAward);
    }
}