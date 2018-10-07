var Proxy = artifacts.require("Proxy");
var Logic2 = artifacts.require("Logic2");

module.exports = async function(deployer) {
    let logicInstance;

    await Promise.all([
      deployer.deploy(Logic2)
    ]);
  
    instances = await Promise.all([
      Proxy.deployed(),
      Logic2.deployed()
    ])
  
    proxyInstance = instances[0];
    logicInstance = instances[1];
  
    results = await Promise.all([
      proxyInstance.updateLogicAddress(logicInstance.address),
    ]);
};