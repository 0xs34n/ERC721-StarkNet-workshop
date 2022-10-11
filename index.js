import fs from "fs";
import { defaultProvider, shortString, stark, json } from "starknet";
import { stringToFeltArray } from "./util.js";

const WALLET_ADDRESS =
  "0x024d881b63aea2b9e034b3cc5632838e868bc3919bdec216fa4379b7f8a25310";

const baseTokenURI = stringToFeltArray(
  "https://raw.githubusercontent.com/0xs34n/ERC721-StarkNet-workshop/main/metadata/"
);

const compiledERC721 = json.parse(
  fs.readFileSync("./artifacts/ERC721.json").toString("ascii")
);

const ERC721Response = await defaultProvider.deployContract({
  contract: compiledERC721,
  constructorCalldata: stark.compileCalldata({
    name: shortString.encodeShortString("Pokemon"),
    symbol: shortString.encodeShortString("PKMN"),
    owner: WALLET_ADDRESS,
    token_uri: baseTokenURI,
  }),
});

console.log(
  `Check the status of the NFT contract deployment transaction: https://testnet.starkscan.co/tx/${ERC721Response.transaction_hash}`
);

console.log(
  `Once the deployment transaction is done, go to https://testnet.starkscan.co/contract/${ERC721Response.contract_address} and to the "Write Contract" tab to mint your NFT!`
);

console.log(
  `Go to the "mint" function and enter your wallet address ${WALLET_ADDRESS} in the "to" input and the token ID (1, 2, 3...9) in the "tokenId" input`
);

console.log(
  `Once the mint transaction is done, go to https://testnet.aspect.co/collection/${ERC721Response.contract_address} to see your NFT!`
);
