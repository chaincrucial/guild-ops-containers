FROM centos:centos8.3.2011

ENV \
LANG=C.UTF-8 \
ENV=/etc/profile \
USER=root

WORKDIR /

RUN dnf -y install epel-release &&\
    mkdir -pv /root/.{cabal,ghcup}/bin &&\
    curl -sS -o prereqs.sh https://raw.githubusercontent.com/cardano-community/guild-operators/master/scripts/cnode-helper-scripts/prereqs.sh &&\
    chmod 755 prereqs.sh &&\
    export SUDO='N' &&\
    export UPDATE_CHECK='N' &&\
    ./prereqs.sh -w -c
