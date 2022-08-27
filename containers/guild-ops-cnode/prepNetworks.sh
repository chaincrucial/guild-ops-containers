#!/bin/bash

# HYDRA CFG
curl -sS -o /opt/cardano/cnode/files/mainnet-topology.json   https://hydra.iohk.io/build/7578887/download/1/mainnet-topology.json
curl -sS -o /opt/cardano/cnode/files/mainnet-byron-genesis.json https://hydra.iohk.io/build/7578887/download/1/mainnet-byron-genesis.json
curl -sS -o /opt/cardano/cnode/files/mainnet-shelley-genesis.json https://hydra.iohk.io/build/7578887/download/1/mainnet-shelley-genesis.json
curl -sS -o /opt/cardano/cnode/files/mainnet-alonzo-genesis.json https://hydra.iohk.io/build/7578887/download/1/mainnet-alonzo-genesis.json
curl -sS -o /opt/cardano/cnode/files/config-mainnet.json https://raw.githubusercontent.com/cardano-community/guild-operators/master/files/config-mainnet.json

# HYDRA TESTNET CFG 
curl -sS -o /opt/cardano/cnode/files/testnet-byron-genesis.json https://hydra.iohk.io/build/7578887/download/1/testnet-byron-genesis.json
curl -sS -o /opt/cardano/cnode/files/testnet-shelley-genesis.json https://hydra.iohk.io/build/7578887/download/1/testnet-shelley-genesis.json
curl -sS -o /opt/cardano/cnode/files/testnet-alonzo-genesis.json https://hydra.iohk.io/build/7578887/download/1/testnet-alonzo-genesis.json
curl -sS -o /opt/cardano/cnode/files/config-testnet.json https://raw.githubusercontent.com/cardano-community/guild-operators/master/files/config-testnet.json
 
# HYDRA PREVIEW NETWORK CFG
curl -sS -o /opt/cardano/cnode/files/preview-byron-genesis.json https://book.world.dev.cardano.org/environments/preview/byron-genesis.json
curl -sS -o /opt/cardano/cnode/files/preview-shelley-genesis.json https://book.world.dev.cardano.org/environments/preview/shelley-genesis.json
curl -sS -o /opt/cardano/cnode/files/preview-alonzo-genesis.json https://book.world.dev.cardano.org/environments/preview/alonzo-genesis.json
curl -sS -o /opt/cardano/cnode/files/config-preview.json https://raw.githubusercontent.com/cardano-community/guild-operators/master/files/config-preview.json

# HYDRA PREPROD NETWORK CFG
curl -sS -o /opt/cardano/cnode/files/preprod-byron-genesis.json https://book.world.dev.cardano.org/environments/preprod/byron-genesis.json
curl -sS -o /opt/cardano/cnode/files/preprod-shelley-genesis.json https://book.world.dev.cardano.org/environments/preprod/shelley-genesis.json
curl -sS -o /opt/cardano/cnode/files/preprod-alonzo-genesis.json https://book.world.dev.cardano.org/environments/preprod/alonzo-genesis.json
curl -sS -o /opt/cardano/cnode/files/config-preprod.json https://raw.githubusercontent.com/cardano-community/guild-operators/master/files/config-preprod.json
