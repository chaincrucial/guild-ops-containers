FROM localhost/chaincrucial/guild-ops-base:latest


# HYDRA CFG 
ADD https://hydra.iohk.io/build/3670619/download/1/mainnet-topology.json /opt/cardano/cnode/files/ 
ADD https://hydra.iohk.io/build/3670619/download/1/mainnet-shelley-genesis.json /opt/cardano/cnode/files/ 
ADD https://hydra.iohk.io/build/3670619/download/1/mainnet-byron-genesis.json /opt/cardano/cnode/files/ 
ADD https://raw.githubusercontent.com/cardano-community/guild-operators/master/files/config-mainnet.json /opt/cardano/cnode/files/ 
 
# HYDRA TESTNET CFG 
ADD https://hydra.iohk.io/job/Cardano/iohk-nix/cardano-deployment/latest-finished/download/1/testnet-byron-genesis.json /opt/cardano/cnode/files/ 
ADD https://hydra.iohk.io/job/Cardano/iohk-nix/cardano-deployment/latest-finished/download/1/testnet-shelley-genesis.json /opt/cardano/cnode/files/ 
ADD https://raw.githubusercontent.com/cardano-community/guild-operators/master/files/config-combinator.json /opt/cardano/cnode/files/ 
 
# HYDRA ALLEGRA TESTNET CFG 
ADD https://hydra.iohk.io/job/Cardano/iohk-nix/cardano-deployment/latest-finished/download/1/allegra-byron-genesis.json /opt/cardano/cnode/files/ 
ADD https://hydra.iohk.io/job/Cardano/iohk-nix/cardano-deployment/latest-finished/download/1/allegra-shelley-genesis.json /opt/cardano/cnode/files/ 
ADD https://raw.githubusercontent.com/cardano-community/guild-operators/master/files/config-allegra.json /opt/cardano/cnode/files/ 
 
# HYDRA LAUNCHPAD TESTNET CFG 
ADD https://hydra.iohk.io/job/Cardano/iohk-nix/cardano-deployment/latest-finished/download/1/launchpad-byron-genesis.json /opt/cardano/cnode/files/ 
ADD https://hydra.iohk.io/job/Cardano/iohk-nix/cardano-deployment/latest-finished/download/1/launchpad-shelley-genesis.json /opt/cardano/cnode/files/ 
ADD https://raw.githubusercontent.com/cardano-community/guild-operators/master/files/config-launchpad.json /opt/cardano/cnode/files/ 
 
# ENTRY SCRIPT 
ADD https://raw.githubusercontent.com/TrevorBenson/cardano-node/entrypoint-leverage-cnode.sh/entrypoint.sh /opt/cardano/cnode/scripts/docker-entrypoint.sh 

ENTRYPOINT ["/opt/cardano/cnode/scripts/docker-entrypoint.sh"]
RUN ["chmod", "+x", "/opt/cardano/cnode/scripts/docker-entrypoint.sh"]
