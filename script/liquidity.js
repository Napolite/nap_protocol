async function main() {
  const liquidity = await ethers.getContractFactory("liquidityPool");

  // Start deployment, returning a promise that resolves to a contract object
  const liquidityPool = await liquidity.deploy();
  console.log("Contract deployed to address:", liquidityPool.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
