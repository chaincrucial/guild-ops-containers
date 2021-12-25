FROM chaincrucial/guild-ops-base:stage1

ENV PATH=/root/.cabal/bin:/root/.ghcup/bin:/root/.local/bin:/root/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin
RUN if [ -d /root/git ] ; then cd /root/git ; else mkdir /root/git  ; fi
WORKDIR /root/git
RUN rm -rf ./cardano-node ;\
    git clone https://github.com/input-output-hk/cardano-node &&\
    pwd ; ls -l ;\
    curl -o cardano-node-latest.txt https://raw.githubusercontent.com/chaincrucial/guild-ops-containers/master/containers/guild-ops-base/cardano-node-latest.txt &&\
    CNODE_VERSION=$(cat cardano-node-latest.txt) &&\
    echo "Checking out Cardano node: ${CNODE_VERSION}" \
WORKDIR /root/git/cardano-node
RUN git fetch --tags --all &&\
    git pull &&\
    git checkout "${CNODE_VERSION}" &&\
    git status &&\
    curl -o cabal.project.local https://raw.githubusercontent.com/cardano-community/guild-operators/master/files/cabal.project.local &&\
    . /root/.bashrc &&\
    /opt/cardano/cnode/scripts/cabal-build-all.sh -l &&\
    cabal install cardano-ping &&\
    /root/.cabal/bin/cardano-cli version ; /root/.cabal/bin/cardano-node version
