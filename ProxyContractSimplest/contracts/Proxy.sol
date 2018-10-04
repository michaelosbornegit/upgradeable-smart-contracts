pragma solidity ^0.4.24;

import "./ERC20";

/**
 * @title Proxy
 * @dev This proxy contract holds the reference to the 
 */
contract Proxy is ERC20 {

    AbstractLogic currentLogicContract;
    mapping (address => uint) userBalances;

    function newLogicDeployed(address newLogic) public {
        currentLogicContract = AbstractLogic(newLogic);
    }

    function redeem(uint amount) public {
        currentLogicContract.redeem(amount);
    }

    function redeemTokens(uint theTokensToAward) public {
        userBalances[tx.origin] = theTokensToAward;
    }

    function getBalance() public returns(uint) {
        return userBalances[tx.origin];
    }
}

contract AbstractLogic {
    function redeem(uint amount) public {}
}
