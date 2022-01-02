FROM rockylinux/rockylinux:8

ARG CNODE_HOME=/opt/cardano/cnode

ENV \
  LANG=C.UTF-8 \
  USER=root \
  PATH=$CNODE_HOME/scripts:/root/.cabal/bin:/root/.ghcup/bin:$PATH \
  BRANCH="${BRANCH}"

WORKDIR /

RUN dnf -y install epel-release-8 && dnf clean all &&\
    echo "Working from PR Branch: ${BRANCH}" &&\
    export BRANCH=alpha &&\
    echo "REMOVE FORCED ALPHA BRANCH ONCE THE PR TO TEST IS ON GUILD_OPERATORS" &&\
    mkdir -pv /root/.cabal/bin /root/.ghcup/bin &&\
    curl -sS -o prereqs.sh "https://raw.githubusercontent.com/cardano-community/guild-operators/${BRANCH}/scripts/cnode-helper-scripts/prereqs.sh" &&\
    chmod 755 prereqs.sh &&\
    export SUDO='N' &&\
    export UPDATE_CHECK='N' &&\
    echo "Working from PR Branch: ${BRANCH}" &&\
    ./prereqs.sh -l -b "${BRANCH}"
