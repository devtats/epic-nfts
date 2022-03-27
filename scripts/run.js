// MyEpicNFT.sol のテストスクリプト

const main = async () => {
    // コントラクトがコンパイルします
    // コントラクトを扱うために必要なファイルが `artifacts` ディレクトリの直下に生成されます。
    const nftContractFactory = await hre.ethers.getContractFactory('MyEpicNFT');
    // Hardhat がローカルの Ethereum ネットワークを作成します。
    const nftContract = await nftContractFactory.deploy();
    // コントラクトが Mint され、ローカルのブロックチェーンにデプロイされるまで待ちます。
    await nftContract.deployed();
    console.log("Contract deployed to:", nftContract.address);

    // call function to Mint a NFT
    let txn = await nftContract.makeAnEpicNFT();
    await txn.wait();

    // call function to Mint a NFT
    txn = await nftContract.makeAnEpicNFT();
    await txn.wait();
  };
  // エラー処理を行っています。
  const runMain = async () => {
    try {
      await main();
      process.exit(0);
    } catch (error) {
      console.log(error);
      process.exit(1);
    } 
  };
  
  runMain();