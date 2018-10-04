var Proxy = artifacts.require("Proxy");
var Logic1 = artifacts.require("Logic1");

module.exports = function(deployer) {
    deployer.deploy(Proxy).then(function() {
        return deployer.deploy(Logic1, Proxy.address);
    });
};