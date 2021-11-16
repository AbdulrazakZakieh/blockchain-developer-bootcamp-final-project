const Migrations = artifacts.require("DisputeableContract");

module.exports = function (deployer) {
  deployer.deploy(Migrations);
};
