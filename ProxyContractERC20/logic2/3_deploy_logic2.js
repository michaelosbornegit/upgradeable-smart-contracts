var Proxy = artifacts.require("Proxy");
var Logic2 = artifacts.require("Logic2");

module.exports = function(deployer) {
    deployer.deploy(Logic2, Proxy.address);
};