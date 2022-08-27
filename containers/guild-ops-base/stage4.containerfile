FROM chaincrucial/guild-ops-base:stage3 AS base-stage3

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

COPY --from=base-stage3 /opt/cardano /opt/cardano
COPY --from=base-stage3 /root/tmp /root/tmp
COPY --from=base-stage3 /root/.cabal/bin/* /root/.cabal/bin/
COPY --from=base-stage3 /root/.cargo/bin/* /root/.cargo/bin/
COPY --from=base-stage3 /root/bin/cardano-hw-cli/cardano-hw-cli /root/.cabal/bin/

COPY --from=base-stage3 /usr/include/secp256k* /usr/include/
COPY --from=base-stage3 /usr/lib64/libsecp256k* /usr/lib64/
COPY --from=base-stage3 /usr/lib64/pkgconfig/libsecp256k* /usr/lib64/pkgconfig/

RUN /bin/bash -c "dnf -y install epel-release &&\
    dnf -y update &&\
    dnf -y install python3 \
        bc jq vim tmux wget \
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
