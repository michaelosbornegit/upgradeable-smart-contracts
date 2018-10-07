pragma solidity ^0.4.24;

import "./openzeppelin-solidity/ERC20.sol";

/**
 * @title Proxy
 * @dev This proxy contract delegates work to a logic contract which can be updated at
 *      any time. This contract also has ERC20 functionality through extending OpenZeppelin's
 *      popular ERC20 contract.
 *
 *      NOTE: This contract exclusively uses tx.origin instead of msg.sender to work with
 *            Truffles testing and deployment environment. These should be changed to
 *            msg.sender for production.
 */
contract Proxy is ERC20 {

    LogicInterface internal currentLogicContract;
    address internal deployer;

    /**
     * @dev Restricts functions to the deployer of the contract.
     */
    modifier onlyDeployer() {
        require(tx.origin == deployer, "This function is restricted to the deployer of the contract.");
        _;
    }

    constructor() public {
        deployer = tx.origin;
    }

    /**
     * @dev Updates this contracts logic contract reference to a new logic contract.
     * @param newLogicAddress The address of the new logic contract.
     */
    function updateLogicAddress(address newLogicAddress) public onlyDeployer() {
        currentLogicContract = LogicInterface(newLogicAddress);
    }

    /**
     * @dev Mints the amount of coins calculated by the logic contract to tx.origin
     * @param theAmount The theAmount (of something) to redeem.
     */
    function redeem(uint256 theAmount) public {
        _mint(tx.origin, currentLogicContract.redeem(theAmount));
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
    function redeem(uint theAmount) external returns(uint256);
}
