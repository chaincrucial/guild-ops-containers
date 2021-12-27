FROM ubuntu:20.04

ENV \
DEBIAN_FRONTEND=noninteractive \
LANG=C.UTF-8 \
ENV=/etc/profile \
USER=root

WORKDIR /

RUN set -x && apt-get -y update && apt-get -y --no-install-recommends install curl=7.68.0-1ubuntu2 &&\
    mkdir -pv /root/.cabal/bin /root/.ghcup/bin &&\
    curl -sS -o prereqs.sh https://raw.githubusercontent.com/cardano-community/guild-operators/master/scripts/cnode-helper-scripts/prereqs.sh &&\
    chmod 0755 prereqs.sh &&\
    export SUDO='N' &&\
    export UPDATE_CHECK='N' &&\
    ./prereqs.sh -c -w
