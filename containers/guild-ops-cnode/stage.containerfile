FROM chaincrucial/guild-ops-base:stage4

ADD https://raw.githubusercontent.com/chaincrucial/guild-ops-containers/main/containers/guild-ops-cnode/healthcheck.sh /healthcheck.sh

ADD https://raw.githubusercontent.com/chaincrucial/guild-ops-containers/main/containers/guild-ops-cnode/entrypoint.sh /entrypoint.sh

RUN ["chmod", "+x", "/entrypoint.sh", "/healthcheck.sh"]

ENTRYPOINT ["/entrypoint.sh"]
