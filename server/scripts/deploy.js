

const main = async()=> {
  const contractFactory = await ethers.getContractFactory('TaskContract')
  const contract = await contractFactory.deploy();
  await contract.deployed();

  console.log("Contract address is:" , contract.address); 
//save this address since it will be use in frontend to interact with blockchain
}

const runMain = async() =>{
  try{
    await main();
    process.exit(0); //successful termination of function without errors
  }
  catch(err){
    console.log(err);
    process.exit(1); //termination of function with errors
  }
}

runMain();