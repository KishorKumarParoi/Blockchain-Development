import { ContractFactory, JsonRpcProvider, Wallet } from "ethers";
import { readFileSync } from "fs";

async function main() {
    let provider = new JsonRpcProvider("HTTP://127.0.0.1:7545");
    let wallet = new Wallet("0x7d93bdb32deaa87de3c360ee327f887ce455c3a9579fe432b87236483d656902", provider);
    const abi = readFileSync("./SimpleStorage_sol_SimpleStorage.abi", "utf8");
    const binary = readFileSync("./SimpleStorage_sol_SimpleStorage.bin", "utf8");
    const contractFactory = new ContractFactory(abi, binary, wallet);
    console.log("Deploying, please wait...");
    const contract = await contractFactory.deploy({ gasLimit: 1000000 });
    console.log(contract);

    const transactionReceipt = await contract.deploymentTransaction.wait(1);
    console.log('Here is the deployment transaction (transaction response) : ');
    console.log(contract.deploymentTransaction);

    console.log("Here is the transaction receipt");
    console.log(transactionReceipt);
}

main();