FROM chaincrucial/guild-ops-base:stage4

# ENTRY SCRIPT
ADD https://raw.githubusercontent.com/TrevorBenson/cardano-node/entrypoint-leverage-cnode.sh/cncli-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
RUN ["chmod", "+x", "/docker-entrypoint.sh"]
