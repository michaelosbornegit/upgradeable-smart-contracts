var Proxy = artifacts.require("Proxy");
var Logic1 = artifacts.require("Logic1");

module.exports = async function(deployer) {
    let proxyInstance, logicInstance;

    await Promise.all([
      deployer.deploy(Proxy),
      deployer.deploy(Logic1)
    ]);
  
    instances = await Promise.all([
      Proxy.deployed(),
      Logic1.deployed()
    ])
  
    proxyInstance = instances[0];
    logicInstance = instances[1];
  
    results = await Promise.all([
      proxyInstance.updateLogicAddress(logicInstance.address),
    ]);
};