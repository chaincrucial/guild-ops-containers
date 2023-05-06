FROM chaincrucial/guild-ops-base:stage1

ENV PATH=/root/.cabal/bin:/root/.ghcup/bin:/root/.local/bin:/root/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin
RUN rm -rf ./cardano-node ;\
    git clone https://github.com/CardanoSolutions/cardano-node.git &&\
    pwd ; ls -l

WORKDIR /cardano-node
RUN curl -o cardano-node-latest.txt https://raw.githubusercontent.com/chaincrucial/guild-ops-containers/main/containers/guild-ops-base/cardano-node-latest.txt &&\
    CNODE_VERSION="1.35.7+cip-0094" &&\
    echo "Checking out Cardano node: ${CNODE_VERSION}" \
    git fetch --tags --all &&\
    git pull &&\
    git checkout "${CNODE_VERSION}" &&\
    git status &&\
    sed -i '/      cardano-ping/d' shell.nix &&\
    curl -o cabal.project.local https://raw.githubusercontent.com/cardano-community/guild-operators/master/files/cabal.project.local &&\
    /opt/cardano/cnode/scripts/cabal-build-all.sh -l &&\
    cabal install cardano-ping &&\
    /root/.cabal/bin/cardano-cli version ; /root/.cabal/bin/cardano-node version
