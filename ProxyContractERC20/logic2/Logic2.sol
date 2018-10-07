pragma solidity ^0.4.24;

import "./Logic1.sol";

/**
 * @title Logic2
 * @dev A logic contract which is meant to be called by a proxy contract, do some calculations, then return a value. 
 *      Specifically, this logic contract changes the redeem method to return a new value.
 */
contract Logic2 is Logic1 {

    /**
     * @dev This function takes in a value, and converts it to another value 
     *      (the amount of tokens to be awarded based on the parameter) and then
     *      passes this value back to the proxy contract for token minting.
     * @param theAmount The value to redeem.
     */
    function redeem(uint theAmount) pure public returns (uint256) {

        // The key difference is we are multiplying theAmount by 10 now
        // instead of 2.
        return theAmount * 10;
    }
}