FROM rockylinux/rockylinux:8
ARG COMMIT
ARG BRANCH
ARG CNODE_HOME=/opt/cardano/cnode

ENV \
  LANG=C.UTF-8 \
  USER=root \
  PATH=$CNODE_HOME/scripts:/root/.cabal/bin:/root/.ghcup/bin:$PATH \
  BRANCH=$BRANCH \
  COMMIT=$COMMIT

WORKDIR /

RUN dnf -y install epel-release-8 &&\
    dnf -y --allowerasing install python3 coreutils pkgconf-pkg-config libffi-devel gmp-devel openssl-devel ncurses-libs ncurses-compat-libs systemd systemd-devel zlib-devel make gcc-c++ git gnupg libtool autoconf srm iproute bc traceroute diffutils &&\
    dnf clean all &&\
    mkdir -pv /root/.cabal/bin /root/.ghcup/bin &&\
    curl -sS -o guild-deploy.sh "https://raw.githubusercontent.com/chaincrucial/guild-ops-containers/${BRANCH}/scripts/cnode-helper-scripts/guild-deploy.sh" &&\
    chmod 755 guild-deploy.sh &&\
    export SUDO='N' &&\
    export UPDATE_CHECK='N' &&\
    ./guild-deploy.sh -b "${BRANCH}"