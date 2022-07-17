FROM rockylinux/rockylinux:8

ENV PATH=/root/.cabal/bin:/root/.ghcup/bin:/root/.local/bin:/root/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin

RUN /bin/bash -c "dnf -y update &&\
    dnf -y install epel-release &&\
    mkdir -pv /root/tmp /root/.{cabal,ghcup}/bin &&\
    cd /root/tmp &&\
    curl -sS -o prereqs.sh https://raw.githubusercontent.com/cardano-community/guild-operators/alpha/scripts/cnode-helper-scripts/prereqs.sh &&\
    chmod 755 prereqs.sh && export SUDO='N' ; export UPDATE_CHECK='N' ; ./prereqs.sh -l -b alpha"
