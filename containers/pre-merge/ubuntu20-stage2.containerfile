FROM ubuntu:20.04

ENV \
DEBIAN_FRONTEND=noninteractive \
LANG=C.UTF-8 \
ENV=/etc/profile \
USER=root

WORKDIR /

RUN set -x && apt update && apt install -y curl &&\
    mkdir -pv /root/.{cabal,ghcup}/bin &&\
    curl -sS -o prereqs.sh https://raw.githubusercontent.com/cardano-community/guild-operators/master/scripts/cnode-helper-scripts/prereqs.sh &&\
    chmod 0755 prereqs.sh &&\
    export SUDO='N' &&\
    export UPDATE_CHECK='N' &&\
    ./prereqs.sh -c -w
RUN curl -o cardano-node-latest.txt https://raw.githubusercontent.com/chaincrucial/guild-ops-containers/master/containers/guild-ops-base/cardano-node-latest.txt &&\
    CNODE_VERSION=$(cat cardano-node-latest.txt) &&\
    echo "Checking out Cardano node: ${CNODE_VERSION}" &&\
    git fetch --tags --all &&\
    git pull &&\
    git checkout "${CNODE_VERSION}" &&\
    git status &&\
    curl -o cabal.project.local https://raw.githubusercontent.com/cardano-community/guild-operators/master/files/cabal.project.local &&\
    /opt/cardano/cnode/scripts/cabal-build-all.sh -l &&\
    cabal install cardano-ping &&\
    /root/.cabal/bin/cardano-cli version ; /root/.cabal/bin/cardano-node version