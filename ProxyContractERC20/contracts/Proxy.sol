pragma solidity ^0.4.24;

import "./openzeppelin-solidity/ERC20.sol";

/**
 * @title Proxy
 * @dev This proxy contract delegates work to a logic contract which can be updated at
 *      any time and complies with ERC20 token guidelines.
 */
contract Proxy is ERC20 {

    LogicInterface internal currentLogicContract;
    address internal deployer;

    modifier onlyLogic() {
        require(msg.sender == address(currentLogicContract), "Only the currently deployed logic contract can call this function");
        _;
    }

    // This modifier makes sure only the deployer of the proxy contract
    // can perform certain operations.
    modifier onlyDeployer() {
        require(tx.origin == deployer, "Only the account that deployed the proxy can call this function");
        _;
    }

    constructor() public {
        deployer = tx.origin;
    }

    /**
     * @dev This function is called by the logic contract and updates this
     *      contracts reference to the currently deployed logic contract.
     *      Whenever the logic contract is updated, this function must be called.
     * @param theLogicAddress The address of the new logic contract.
     */
    function newLogicDeployed(address theLogicAddress) public onlyDeployer() {
        currentLogicContract = LogicInterface(theLogicAddress);
    }

    /**
     * @dev This is the money function. We delegate the work of figuring out how much
     *      tokens the theAmount parameter is worth to the logic contract. For example,
     *      theAmount could be how many hours you worked/volunteered (which you then
     *      get awarded tokens for).
     * @param theAmount The theAmount (of something) to redeem.
     */
    function redeem(uint256 theAmount) public {
        currentLogicContract.redeem(theAmount);
    }

    /**
     * @dev This function is called by the logic contract. Mints the amount of tokens
     *      the logic contract calculated to the original caller.
     * @param theTokensToAward The amount to mint to the original caller.
     */
    function redeemTokens(uint256 theTokensToAward) public onlyLogic() {
        // tx.origin must be used here because msg.sender gets mutated when contracts
        // are called from contracts. We need to award the account that called redeem
        // in the first place.
        _mint(tx.origin, theTokensToAward);
    }
}

/**
 * @title LogicInterface
 * @dev This interface is so this proxy contract knows the functions it can call on 
 *      the logic contract. This proxy contract can then hold a reference to the 
 *      actual deployed logic contract and call methods on it with only the logic 
 *      contract's address.
 *
 *      NOTE: Newer versions of logic contracts must always have this function.
 */
contract LogicInterface {
    function redeem(uint theAmount) external;
}
