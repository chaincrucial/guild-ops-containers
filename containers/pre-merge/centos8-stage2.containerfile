FROM centos:centos8.3.2011

ENV \
  CNODE_HOME=/opt/cardano/cnode \
  LANG=C.UTF-8 \
  USER=root \
  PATH=$CNODE_HOME/scripts:/root/.cabal/bin:/root/.ghcup/bin:$PATH

WORKDIR /

RUN dnf -y install epel-release-8 git-2.27.0 && dnf clean all &&\
    mkdir -pv /root/.cabal/bin /root/.ghcup/bin &&\
    curl -sS -o prereqs.sh https://raw.githubusercontent.com/cardano-community/guild-operators/master/scripts/cnode-helper-scripts/prereqs.sh &&\
    chmod 755 prereqs.sh &&\
    export SUDO='N' &&\
    export UPDATE_CHECK='N' &&\
    ./prereqs.sh

RUN git clone https://github.com/input-output-hk/cardano-node &&\
    pwd ; ls -l

WORKDIR /cardano-node

RUN curl -o cardano-node-latest.txt https://raw.githubusercontent.com/chaincrucial/guild-ops-containers/master/containers/guild-ops-base/cardano-node-latest.txt &&\
    CNODE_VERSION=$(cat cardano-node-latest.txt) &&\
    echo "Checking out Cardano node: ${CNODE_VERSION}" &&\
    git fetch --tags --all &&\
    git pull &&\
    git checkout "${CNODE_VERSION}" &&\
    git status &&\
    curl -o cabal.project.local https://raw.githubusercontent.com/cardano-community/guild-operators/master/files/cabal.project.local &&\
    /opt/cardano/cnode/scripts/cabal-build-all.sh &&\
    cabal install cardano-ping &&\
    /root/.cabal/bin/cardano-cli version ; /root/.cabal/bin/cardano-node version