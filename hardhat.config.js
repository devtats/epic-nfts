require("@nomiclabs/hardhat-waffle");
module.exports = {
  solidity: "0.8.4",
  networks: {
    rinkeby: {
      url: 'https://eth-rinkeby.alchemyapi.io/v2/IEM4yl7VbfWpapcs-6zs0SAj7AKw40Gb',
      accounts: ['86daf3331ae777de6efbc179bf0cd3965626d97a2d4f20836cd817b33dae30ed']
    }
  }
};
