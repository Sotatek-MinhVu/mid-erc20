require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");
require("@nomiclabs/hardhat-web3");

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.4",
  networks: {
    rinkeby: {
      url: "https://rinkeby.infura.io/v3/d1ee068e5aef46ff84294439e998de0f", //Infura url with projectId
      accounts: ["b1886389358803a0f1e2ad81cf62fdf35a08792cb0a265212b5f829b33e87153"] // add the account that will deploy the contract (private key)
    }
  },
  etherscan: {
    apiKey: "M86AEY96HV5YU3WFR6ECF9FDFDSXS8WF4A"
  }
};
