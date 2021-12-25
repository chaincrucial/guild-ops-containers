FROM chaincrucial/guild-ops-base:test-stage1

ENV PATH=/root/.cabal/bin:/root/.ghcup/bin:/root/.local/bin:/root/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin
RUN . /root/.bashrc &&\
    if [ -d /root/git ] ; then cd /root/git ; else mkdir /root/git  ; fi ;\
    cd /root/git &&\
    rm -rf ./cardano-node ;\
    git clone https://github.com/input-output-hk/cardano-node &&\
    curl -o cardano-node-latest-tag.txt https://raw.githubusercontent.com/chaincrucial/guild-ops-containers/master/containers/guild-ops-base/cardano-node-latest-tag.txt &&\
    CNODE_VERSION=$(cat cardano-node-latest-tag.txt) &&\
    echo "Checking out Cardano node: ${CNODE_VERSION}" &&\
    cd cardano-node &&\
    git fetch --tags --all &&\
    git pull &&\
    git checkout "${CNODE_VERSION}" &&\
    git status &&\
    curl -o cabal.project.local https://raw.githubusercontent.com/cardano-community/guild-operators/master/files/cabal.project.local
RUN pwd ; ls -l ;\
    . /root/.bashrc &&\
    cd /root/git/cardano-node &&\
    /opt/cardano/cnode/scripts/cabal-build-all.sh -l &&\
    /root/.cabal/bin/cardano-cli version ; /root/.cabal/bin/cardano-node version