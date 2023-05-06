FROM ubuntu:20.04
ARG COMMIT
ARG BRANCH
ARG CNODE_HOME=/opt/cardano/cnode

ENV \
  DEBIAN_FRONTEND=noninteractive \
  LANG=C.UTF-8 \
  USER=root \
  PATH=$CNODE_HOME/scripts:/root/.cabal/bin:/root/.ghcup/bin:$PATH \
  BRANCH=$BRANCH \
  COMMIT=$COMMIT

WORKDIR /

RUN set -x && apt-get -y update && apt-get -y --no-install-recommends install curl git ca-certificates gnupg apt-utils udev &&\
    rm -rf /var/lib/apt/lists/* &&\
    mkdir -pv /root/.cabal/bin /root/.ghcup/bin &&\
    curl --silent --show-error --insecure --output guild-deploy.sh "https://raw.githubusercontent.com/chaincrucial/guild-ops-containers/${BRANCH}/scripts/cnode-helper-scripts/guild-deploy.sh" &&\
    chmod 0755 guild-deploy.sh &&\
    export SUDO='N' &&\
    export UPDATE_CHECK='N' &&\
    ./guild-deploy.sh -s l -b "${BRANCH}"