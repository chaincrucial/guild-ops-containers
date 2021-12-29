FROM chaincrucial/guild-ops-base:stage3

ENV PATH=/root/.cabal/bin:/root/.ghcup/bin:/root/.local/bin:/root/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin
WORKDIR /root/tmp
RUN chmod 755 prereqs.sh && export SUDO='N' ; export UPDATE_CHECK='N' ; ./prereqs.sh -l -w &&\
    ls -l /root/bin/cardano-hw-cli/
