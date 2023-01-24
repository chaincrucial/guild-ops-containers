#!/bin/bash

# HYDRA CFG
curl -sS -o /opt/cardano/cnode/files/mainnet-topology.json https://raw.githubusercontent.com/input-output-hk/cardano-world/master/docs/environments/mainnet/topology.json
curl -sS -o /opt/cardano/cnode/files/mainnet-byron-genesis.json https://raw.githubusercontent.com/input-output-hk/cardano-world/master/docs/environments/mainnet/byron-genesis.json
curl -sS -o /opt/cardano/cnode/files/mainnet-shelley-genesis.json https://raw.githubusercontent.com/input-output-hk/cardano-world/master/docs/environments/mainnet/shelley-genesis.json
curl -sS -o /opt/cardano/cnode/files/mainnet-alonzo-genesis.json https://raw.githubusercontent.com/input-output-hk/cardano-world/master/docs/environments/mainnet/alonzo-genesis.json
curl -sS -o /opt/cardano/cnode/files/config-mainnet.json https://raw.githubusercontent.com/cardano-community/guild-operators/master/files/config-mainnet.json
