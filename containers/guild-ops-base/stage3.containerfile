FROM chaincrucial/guild-ops-base:stage2

ENV PATH=/root/.cabal/bin:/root/.ghcup/bin:/root/.local/bin:/root/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin
RUN curl -sS -o /root/tmp/guild-deploy.sh https://raw.githubusercontent.com/cardano-community/guild-operators/master/scripts/cnode-helper-scripts/guild-deploy.sh
WORKDIR /root/tmp
RUN chmod 755 guild-deploy.sh && export SUDO='N' ; export UPDATE_CHECK='N' ; ./guild-deploy.sh -l -c -w
