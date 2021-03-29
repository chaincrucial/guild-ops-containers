FROM chaincrucial/guild-ops-base:test-stage2

ENV PATH=/root/.cabal/bin:/root/.ghcup/bin:/root/.local/bin:/root/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin
RUN curl -sS -o /root/tmp/prereqs.sh https://raw.githubusercontent.com/cardano-community/guild-operators/alpha/scripts/cnode-helper-scripts/prereqs.sh
RUN . /root/.bashrc &&\
    cd /root/tmp &&\
    chmod 755 prereqs.sh && export SUDO='N' ; export UPDATE_CHECK='N' ; ./prereqs.sh -l -c -w -b alpha &&\
    yum -y clean all &&\
    rm -rf /var/cache/yum
