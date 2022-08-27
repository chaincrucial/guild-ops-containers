FROM chaincrucial/guild-ops-base:test-stage2

ENV PATH=/root/.cabal/bin:/root/.ghcup/bin:/root/.local/bin:/root/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin
RUN curl -sS -o /root/tmp/prereqs.sh https://raw.githubusercontent.com/cardano-community/guild-operators/alpha/scripts/cnode-helper-scripts/prereqs.sh
WORKDIR /root/tmp
RUN chmod 755 prereqs.sh && export SUDO='N' ; export UPDATE_CHECK='N' ; ./prereqs.sh -l -c -w -b alpha

# HYDRA CFG
ADD https://hydra.iohk.io/build/7578887/download/1/mainnet-topology.json /opt/cardano/cnode/files/ 
ADD https://hydra.iohk.io/build/7578887/download/1/mainnet-byron-genesis.json /opt/cardano/cnode/files/
ADD https://hydra.iohk.io/build/7578887/download/1/mainnet-shelley-genesis.json /opt/cardano/cnode/files/
ADD https://hydra.iohk.io/build/7578887/download/1/mainnet-alonzo-genesis.json /opt/cardano/cnode/files/
ADD https://raw.githubusercontent.com/cardano-community/guild-operators/master/files/config-mainnet.json /opt/cardano/cnode/files/

# HYDRA TESTNET CFG 
ADD https://hydra.iohk.io/build/7578887/download/1/testnet-byron-genesis.json /opt/cardano/cnode/files/
ADD https://hydra.iohk.io/build/7578887/download/1/testnet-shelley-genesis.json /opt/cardano/cnode/files/
ADD https://hydra.iohk.io/build/7578887/download/1/testnet-alonzo-genesis.json /opt/cardano/cnode/files/
ADD https://raw.githubusercontent.com/cardano-community/guild-operators/master/files/config-testnet.json /opt/cardano/cnode/files/
 
# HYDRA PREVIEW NETWORK CFG
ADD https://book.world.dev.cardano.org/environments/preview/byron-genesis.json /opt/cardano/cnode/files/
ADD https://book.world.dev.cardano.org/environments/preview/shelley-genesis.json /opt/cardano/cnode/files/
ADD https://book.world.dev.cardano.org/environments/preview/alonzo-genesis.json /opt/cardano/cnode/files/
ADD https://raw.githubusercontent.com/cardano-community/guild-operators/master/files/config-preview.json /opt/cardano/cnode/files/

# HYDRA PREPROD NETWORK CFG
ADD https://book.world.dev.cardano.org/environments/preprod/byron-genesis.json /opt/cardano/cnode/files/
ADD https://book.world.dev.cardano.org/environments/preprod/shelley-genesis.json /opt/cardano/cnode/files/
ADD https://book.world.dev.cardano.org/environments/preprod/alonzo-genesis.json /opt/cardano/cnode/files/
ADD https://raw.githubusercontent.com/cardano-community/guild-operators/master/files/config-preprod.json /opt/cardano/cnode/files/
