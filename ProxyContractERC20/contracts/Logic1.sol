pragma solidity ^0.4.24;

/**
 * @title Logic1
 * @dev A logic contract which is meant to be called by a proxy contract, do some calculations
 *      (logic), then return a value.
 */
contract Logic1 {

    /**
     * @dev Intended to be used by proxy contracts, returns a value calculated by
     *      theAmount
     * @param theAmount The value to redeem.
     */
    function redeem(uint256 theAmount) pure public returns (uint256) {
        // Any conversion math or gathering data from oracles that
        // effects the conversion rate or amount to tokens goes here...
        
        return theAmount * 2;
    }
}
