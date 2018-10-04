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
As you can see from inspecting `contracts/Logic1.sol` and `contracts/Proxy.sol` all we are doing right now is taking a number in Proxy's `redeem` function, handing it off to Logic1's `redeem` which is multiplying that number by 2, then Logic1 hands it off to Proxy's `redeemTokens` to actually award that calculated amount. 

***But why does Logic1 call `redeemTokens` of Proxy instead of just returning a value in its `redeem`?***

Because getting access to the return value of another contracts function is [difficult and scary](https://medium.com/@blockchain101/calling-the-function-of-another-contract-in-solidity-f9edfa921f4c) (scroll down until you see assembly code 😨)

We got 2 successes, from `test/TestLogic1RealWorld` and `test/TestLogic1TestEnv`. ***Why are there two test files for one contract?*** We will get more into that later, but the key difference is how we are creating instances of each


## unfinished
