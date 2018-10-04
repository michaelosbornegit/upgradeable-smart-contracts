pragma solidity ^0.4.24;

/**
 * @title Logic1
 * @dev A logic contract which is meant to be called by a proxy contract, do some calculations
 *      (logic), then return a value.
 */
contract Logic1 {

    ProxyInterface public proxyContract;

    modifier onlyProxy() {
        require(msg.sender == address(proxyContract), "This function can only be called by the proxy");
        _;
    }

    /**
     * @dev Creates the reference to the deployed proxy contract using the ProxyInterface
     *      and the passed in proxy address. Calls a function on the proxy contract to
     *      update its reference to this contract.
     */
    constructor(address theProxyAddress) public {
        proxyContract = ProxyInterface(theProxyAddress);
        proxyContract.newLogicDeployed(address(this));
    }

    /**
     * @dev This function takes in a value, and converts it to another value 
     *      (the amount of tokens to be awarded based on the parameter) and then
     *      passes this value back to the proxy contract for token minting.
     * @param theAmount The value to redeem.
     */
    function redeem(uint256 theAmount) public onlyProxy() {

        // Any conversion math or gathering data from oracles that
        // effects the conversion rate or amount to tokens goes here...
        uint256 tokensToAward = theAmount * 2;


        // Call the proxy contract to update the users amount.
        proxyContract.redeemTokens(tokensToAward);
    }
}

/**
 * @title ProxyInterface
 * @dev This interface is so the logic contract knows the functions it can call on 
 *      the proxy contract. The Logic contract can then hold a reference to the 
 *      actual deployed proxy contract and call methods on it with only the proxy 
 *      contract's address.
 */
interface ProxyInterface {
    function newLogicDeployed(address theLogicAddress) external;
    function redeemTokens(uint256 theTokensToAward) external;
}
