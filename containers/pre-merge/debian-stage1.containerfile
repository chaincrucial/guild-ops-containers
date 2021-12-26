FROM debian:stable

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
