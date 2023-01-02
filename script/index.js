async function main() {
  const napToken = await ethers.getContractFactory("../token");

  // Start deployment, returning a promise that resolves to a contract object
  const Napolite = await napToken.deploy("Hello World!");
  console.log("Contract deployed to address:", Napolite.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
