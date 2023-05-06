FROM chaincrucial/guild-ops-base:test-stage1

ENV PATH=/root/.cabal/bin:/root/.ghcup/bin:/root/.local/bin:/root/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin
RUN rm -rf ./cardano-node ;\
    git clone https://github.com/CardanoSolutions/cardano-node.git &&\
    pwd ; ls -l

WORKDIR /cardano-node
RUN curl -o cardano-node-latest-tag.txt https://raw.githubusercontent.com/chaincrucial/guild-ops-containers/development/containers/guild-ops-base/cardano-node-latest-tag.txt &&\
    CNODE_VERSION="1.35.7+cip-0094" &&\
    echo "Checking out Cardano node: tags/${CNODE_VERSION}" \
    git fetch --tags --all &&\
    git pull &&\
    git checkout "tags/${CNODE_VERSION}" &&\
    git status &&\
    curl -o cabal.project.local https://raw.githubusercontent.com/cardano-community/guild-operators/alpha/files/cabal.project.local &&\
    /opt/cardano/cnode/scripts/cabal-build-all.sh -l &&\
    cabal install cardano-ping &&\
    /root/.cabal/bin/cardano-cli version ; /root/.cabal/bin/cardano-node version
