/*
 * NB: since truffle-hdwallet-provider 0.0.5 you must wrap HDWallet providers in a 
 * function when declaring them. Failure to do so will cause commands to hang. ex:
 * ```
 * mainnet: {
 *     provider: function() { 
 *       return new HDWalletProvider(mnemonic, 'https://mainnet.infura.io/<infura-key>') 
 *     },
 *     network_id: '1',
 *     gas: 4500000,
 *     gasPrice: 10000000000,
 *   },
 */

var HDWalletProvider = require("truffle-hdwallet-provider"); // 在这里我们需要通过 js 调用以太坊钱包，通过 npm install truffle-hdwallet-provider 安装这个库
var infura_apikey = "q7e6gTMRPm7mtLpod***"; // infura 为你提供的 apikey 请与你申请到的 key 保持一致，此处仅为示例
var mnemonic = "loan wasp endless couch melt develop cabbage sock deny tackle fringe history"; // 你以太坊钱包的 mnemonic ，可以从 Metamask 当中导出，mnemonic 可以获取你钱包的所有访问权限，请妥善保存，在开发中切勿提交到 git
//以上助记词对应着的钱包地址和私钥：
//0xD134dd2a3c16Fb12885cd6FDc8a03D4bbe5d7031
//6D7BA1846D5BEE5138418701138998CDC7D8B4D3386D432D2351449541334***

module.exports = {
  networks: {
    "development": {
      host: "127.0.0.1",
      port: 7545,
      network_id: "default"
    },

    "mainnet": {
      provider: function() {
        return new HDWalletProvider(mnemonic, "https://mainnet.infura.io/" + infura_apikey)
      },
      network_id: "1",
      gas: 4712388,
      gasPrice: 100000000000
    }

    //2 Morden

    "ropsten": {
      provider: function() {
        return new HDWalletProvider(mnemonic, "https://ropsten.infura.io/" + infura_apikey)
      },
      network_id: "3",
      gas: 4712388,
      gasPrice: 100000000000
    },

    "rinkeby": {
      provider: function() {
        return new HDWalletProvider(mnemonic, "https://rinkeby.infura.io/" + infura_apikey)
      },
      network_id: "4",
      gas: 4712388,
      gasPrice: 100000000000
    },

    "kovan": {
      provider: function() {
        return new HDWalletProvider(mnemonic, "https://kovan.infura.io/" + infura_apikey)
      },
      network_id: "42",
      gas: 4712388,
      gasPrice: 100000000000
    },     

  }

};
