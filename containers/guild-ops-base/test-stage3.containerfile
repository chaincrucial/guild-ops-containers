FROM chaincrucial/guild-ops-base:test-stage2

ENV PATH=/root/.cabal/bin:/root/.ghcup/bin:/root/.local/bin:/root/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin
RUN curl -sS -o /root/tmp/guild-deploy.sh https://raw.githubusercontent.com/cardano-community/guild-operators/alpha/scripts/cnode-helper-scripts/guild-deploy.sh
WORKDIR /root/tmp
RUN chmod 755 guild-deploy.sh && export SUDO='N' ; export UPDATE_CHECK='N' ; ./guild-deploy.sh -s l -c -w -b alpha
