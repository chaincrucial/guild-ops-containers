FROM debian:stable

ENV \
  CNODE_HOME=/opt/cardano/cnode \
  DEBIAN_FRONTEND=noninteractive \
  LANG=C.UTF-8 \
  ENV=/etc/profile \
  USER=root \
  PATH=$CNODE_HOME/scripts:/root/.cabal/bin:/root/.ghcup/bin:$PATH

WORKDIR /

RUN set -x && apt-get -y update && apt-get -y --no-install-recommends install curl=7.74.0-1.3+deb11u1 &&\
    rm -rf /var/lib/apt/lists/* &&\
    mkdir -pv /root/.cabal/bin /root/.ghcup/bin &&\
    curl -sS -o prereqs.sh https://raw.githubusercontent.com/cardano-community/guild-operators/master/scripts/cnode-helper-scripts/prereqs.sh &&\
    chmod 0755 prereqs.sh &&\
    export SUDO='N' &&\
    export UPDATE_CHECK='N' &&\
    ./prereqs.sh -c -w
