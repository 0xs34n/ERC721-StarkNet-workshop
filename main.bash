#!/bin/bash

echo "Compiling Cairo Contracts"

# nile compile

echo "Deploy NFT Contract on StarkNet"

base_token_uri=$(node baseTokenUri.helper.js)

echo "Base Token URI: $base_token_uri"

nile deploy ERC721 "Pokemon" "PKMN" "0x024d881b63aea2b9e034b3cc5632838e868bc3919bdec216fa4379b7f8a25310" $base_token_uri
