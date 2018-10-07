# Proxy/Logic contracts with ERC20 compliance


## Intro
This is the simplest version of upgradeability, the proxy contract takes all calls from the user and delegates the actual work to the logic contract. The logic contract can then be upgraded to provide new functionality or, in this case, to update a simple calculation to determine the amount of tokens to reward a user.

Lets get started!


## Truffle
These contracts were created and tested in record time using [Truffle](https://truffleframework.com/docs/truffle/overview). The [quickstart guide](https://truffleframework.com/docs/truffle/quickstart) should be all you need to get your hands dirty. This overview assumes you have at least skimmed the quickstart and have truffle installed globally:
```
npm install -g truffle
```


## Running the base
It's more fun to run it first then see what we did later, so let's do that!

It's simple, clone this repository or download this folder and from this folder run
```
truffle test
```
truffle compiles the contracts in `contracts/`, runs the migrations in `/migrations` and runs the test files in `test/` **Yay green checks are good!**


### What did we actually just do?
As you can see from inspecting `contracts/Logic1.sol` and `contracts/Proxy.sol`, all we are doing right now is taking a number in Proxy's `redeem` function, handing it off to Logic1's `redeem` and awarding the user the returned value in tokens. The logic contract is simply providing a conversion rate of amount to tokens.


When we run the tests we get 3 successes, from `test/TestLogic1RealWorld`, `test/TestLogic1TestEnv`, and `test/TestProxyERC20`. ***Why are there two test files for one contract?*** We will get more into that later, but the key difference is how we are creating the instances of each:
```solidity
// TestLogic1RealWorld.sol
// This simulates what it would actually be like in production on a real 
// blockchain. We deploy smart contracts once and are calling the deployed 
// smart contracts to test them.
Proxy proxy = Proxy(DeployedAddresses.Proxy());
Logic1 logic1 = Logic1(DeployedAddresses.Logic1());
```
```solidity
// TestLogic1TestEnv.sol
// Here we are abusing resources, deploying each contract before each and 
// every test. This would cost a lot of gas on a real network. This also ensures
// each test will run correctly, but it may lead to false positives where your code
// would actually fail in production but passes testing.
Proxy proxy;
Logic1 logic1;
function beforeEach() public {
    proxy = new Proxy();
    logic1 = new Logic1();
    proxy.updateLogicAddress(address(logic1));
}
```


# Short n Sweet (to be fleshed out later)
The `logic2` folder has everything we need to deploy a new logic contract.
Lets upgrade!

1. Copy `logic2/logic2.sol` to `contracts/`
2. Copy `logic2/TestLogic2RealWorld.sol` and `logic2/TestLogic2TestEnv.sol` to `test/`
3. Copy `logic2/3_deploy_logic2.js` to `migrations/`

Either run
```
truffle test
```
again, or
```
truffle develop
```
then inside the truffle<develop> console run
```
migrate
test
```
Four tests pass, everything is working except for the one that didn't!! **You successfully upgraded a smart contract!** (if you don't believe me take a look at the files you added to `test/` that start with `Testlogic2...`.
  
  
## But... I spy a red X
I included this to show a risk (or feature 😊) of this approach to upgradeability, and this is ***critical*** so listen up.

`TestLogic1RealWorld.sol` fails. [This is because all function calls in the EVM are virtual, which means that the most derived function is called, except when the contract name is explicitly given.](https://solidity.readthedocs.io/en/v0.4.24/contracts.html#inheritance) 

Because we are using the proxy contract for multiple logic contracts, we can't include the explicit name of the logic contract (Then we couldn't upggrade!)


### What does this really mean?
This means (***with my current implementation***) all users of the proxy contract will immediately ker-chunk into using the new logic contract and the **logic in the parents overridden function is gone forever**. This could actually be seen as a feature to automatically update everyone, but I'll let you decide.


### Well just fix it code boy!
One possible solution would be to have a store that holds all logic contract names in the proxy contract, and then you could select the logic contract name with the functionality you want and the proxy contract could include the specific contract name with the delegated function call. Still have to try this. If you try it let me know if it works!

# Thanks for upgrading!
