FROM chaincrucial/guild-ops-base:test-stage3 as base-test-stage3

FROM rockylinux/rockylinux:8

ENV \
    ENV=/etc/profile \
    LC_ALL=C.UTF-8 \
    LANG=C.UTF-8 \
    LANGUAGE=C.UTF-8 \
    CNODE_HOME=/opt/cardano/cnode \
    LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH" \
    PKG_CONFIG_PATH="/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH" \
    PATH=/root/.cabal/bin:/root/.ghcup/bin:/root/.local/bin:/root/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin

COPY --from=base-test-stage3 /opt/cardano /opt/cardano
COPY --from=base-test-stage3 /root/tmp /root/tmp
COPY --from=base-test-stage3 /root/.bashrc /root/.bashrc
COPY --from=base-test-stage3 /usr/lib64/libsecp256k* /usr/lib64/

COPY --from=base-test-stage3 /root/.cabal/bin/* /root/.cabal/bin/
COPY --from=base-test-stage3 /root/.cargo/bin/* /root/.cargo/bin/
COPY --from=base-test-stage3 /root/bin/cardano-hw-cli/cardano-hw-cli /root/.cabal/bin/

# HYDRA CFG
ADD https://hydra.iohk.io/build/7578887/download/1/mainnet-topology.json /opt/cardano/cnode/files/ 
ADD https://hydra.iohk.io/build/7578887/download/1/mainnet-byron-genesis.json /opt/cardano/cnode/files/
ADD https://hydra.iohk.io/build/7578887/download/1/mainnet-shelley-genesis.json /opt/cardano/cnode/files/
ADD https://hydra.iohk.io/build/7578887/download/1/mainnet-alonzo-genesis.json /opt/cardano/cnode/files/
ADD https://raw.githubusercontent.com/cardano-community/guild-operators/master/files/config-mainnet.json /opt/cardano/cnode/files/

# HYDRA TESTNET CFG 
ADD https://hydra.iohk.io/build/7578887/download/1/testnet-byron-genesis.json /opt/cardano/cnode/files/
ADD https://hydra.iohk.io/build/7578887/download/1/testnet-shelley-genesis.json /opt/cardano/cnode/files/
ADD https://hydra.iohk.io/build/7578887/download/1/testnet-alonzo-genesis.json /opt/cardano/cnode/files/
ADD https://raw.githubusercontent.com/cardano-community/guild-operators/master/files/config-testnet.json /opt/cardano/cnode/files/
 
# HYDRA PREVIEW NETWORK CFG
ADD https://book.world.dev.cardano.org/environments/preview/byron-genesis.json /opt/cardano/cnode/files/
ADD https://book.world.dev.cardano.org/environments/preview/shelley-genesis.json /opt/cardano/cnode/files/
ADD https://book.world.dev.cardano.org/environments/preview/alonzo-genesis.json /opt/cardano/cnode/files/
ADD https://raw.githubusercontent.com/cardano-community/guild-operators/master/files/config-preview.json /opt/cardano/cnode/files/

# HYDRA PREPROD NETWORK CFG
ADD https://book.world.dev.cardano.org/environments/preprod/byron-genesis.json /opt/cardano/cnode/files/
ADD https://book.world.dev.cardano.org/environments/preprod/shelley-genesis.json /opt/cardano/cnode/files/
ADD https://book.world.dev.cardano.org/environments/preprod/alonzo-genesis.json /opt/cardano/cnode/files/
ADD https://raw.githubusercontent.com/cardano-community/guild-operators/master/files/config-preprod.json /opt/cardano/cnode/files/config-preprod.json


RUN /bin/bash -c "dnf -y install epel-release &&\
    dnf -y update &&\
    dnf -y install python3 \
        bc jq vim tmux wget git\
        gnupg sqlite iproute \
        libtool ncurses \
        net-tools e2fsprogs \
        pkgconfig gmp-devel \
        zlib-devel \
        libffi-devel \
        tcptraceroute \
        openssl-devel \
        ncurses-libs \
        libsodium-devel \
        glibc-langpack-en \
        glibc-locale-source \
        ncurses-compat-libs \
        libsqlite3x-devel \
        procps-ng &&\
    dnf -y clean all && rm -rf /var/cache/yum/ &&\
    ln -s /root/.cabal/bin/cardano-node /usr/local/bin/ &&\
    ln -s /root/.cabal/bin/cardano-cli /usr/local/bin/ &&\
    ln -s /root/.cargo/bin/cncli /usr/local/bin/ &&\
    sed -i 's/^#CONFIG=/CONFIG=/' /opt/cardano/cnode/scripts/env &&\
    sed -i 's/^#SOCKET=/SOCKET=/' /opt/cardano/cnode/scripts/env &&\
    sed -i 's/^#TOPOLOGY=/TOPOLOGY=/' /opt/cardano/cnode/scripts/env &&\
    sed -i 's/^#LOG_DIR=/LOG_DIR=/' /opt/cardano/cnode/scripts/env &&\
    sed -i 's/^#DB_DIR=/DB_DIR=/' /opt/cardano/cnode/scripts/env &&\
    sed -i 's/^#EKG_HOST=/EKG_HOST=/' /opt/cardano/cnode/scripts/env &&\
    sed -i 's/^#EKG_PORT=/EKG_PORT=/' /opt/cardano/cnode/scripts/env &&\
    sed -i 's/^#EKG_TIMEOUT=/EKG_TIMEOUT=/' /opt/cardano/cnode/scripts/env &&\
    sed -i 's/^#CURL_TIMEOUT=/CURL_TIMEOUT=/' /opt/cardano/cnode/scripts/env &&\
    sed -i 's/^#BLOCKLOG_DIR=/BLOCKLOG_DIR=/' /opt/cardano/cnode/scripts/env &&\
    sed -i 's%^#BLOCKLOG_TZ=\"UTC\"%BLOCKLOG_TZ=\"America/Los_Angeles\"%' /opt/cardano/cnode/scripts/env"
