FROM rockylinux/rockylinux:8

ENV PATH=/root/.cabal/bin:/root/.ghcup/bin:/root/.local/bin:/root/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin

RUN /bin/bash -c "dnf -y update &&\
    dnf -y install epel-release &&\
    dnf -y clean all &&\
    mkdir -pv /root/tmp /root/.{cabal,ghcup}/bin &&\
    cd /root/tmp &&\
    curl -sS -o guild-deploy.sh https://raw.githubusercontent.com/cardano-community/guild-operators/master/scripts/cnode-helper-scripts/guild-deploy.sh &&\
    chmod 755 guild-deploy.sh && export SUDO='N' ; export UPDATE_CHECK='N' ; ./guild-deploy.sh -s l"
