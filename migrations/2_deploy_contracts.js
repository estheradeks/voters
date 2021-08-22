// which contracts we'd like to interact with via the artifacts.require() method
const Election = artifacts.require("Election");

// All migrations must export a function via the module.exports syntax
module.exports = function (deployer) {
  // The function exported by each migration should accept a deployer object
  deployer.deploy(Election);
};