FROM chaincrucial/guild-ops-base:test-stage3

ENV PATH=/root/.cabal/bin:/root/.ghcup/bin:/root/.local/bin:/root/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin
WORKDIR /root/tmp
RUN . /root/.bashrc &&\
    chmod 755 prereqs.sh && export SUDO='N' ; export UPDATE_CHECK='N' ; ./prereqs.sh -l -w -b alpha &&\
    ls -l /root/bin/cardano-hw-cli/
