#!/bin/bash

. ~/.bashrc > /dev/null 2>&1
. /opt/cardano/cnode/scripts/env

if [ -n "$1" ]; then
  NETWORK=$1
fi

customize () {
  find /opt/cardano/cnode/files -name "*config*.json" -print0 | xargs -0 sed -i 's/127.0.0.1/0.0.0.0/g' > /dev/null 2>&1 
  grep -i ENABLE_CHATTR /opt/cardano/cnode/scripts/cntools.sh >/dev/null \
    && sed -i.orig 's/ENABLE_CHATTR=true/ENABLE_CHATTR=false/g' /opt/cardano/cnode/scripts/cntools.sh > /dev/null 2>&1
  grep -i ENABLE_DIALOG /opt/cardano/cnode/scripts/cntools.sh >/dev/null \
    && sed -i.bak 's/ENABLE_DIALOG=true/ENABLE_DIALOG=false/' /opt/cardano/cnode/scripts/cntools.sh > /dev/null 2>&1
  find /opt/cardano/cnode/files -name "*config*.json" -print0 | xargs -0 sed -i 's/\"hasEKG\": 12788,/\"hasEKG\": [\n    \"0.0.0.0\",\n    12788\n],/g' > /dev/null 2>&1
  return 0
}

echo "NETWORK: $NETWORK";

[[ -z "${CNODE_HOME}" ]] && export CNODE_HOME=/opt/cardano/cnode 
[[ -z "${CNODE_PORT}" ]] && export CNODE_PORT=6000
export UPDATE_CHECK='N'

echo "NODE: $HOSTNAME";
cardano-node --version;

if [[ -n "${NETWORK}" ]] ; then 
  ln -sf "${CNODE_HOME}/files/${NETWORK}-byron-genesis.json" "${CNODE_HOME}/files/byron-genesis.json" \
  && ln -sf "${CNODE_HOME}/files/${NETWORK}-shelley-genesis.json" "${CNODE_HOME}/files/shelley-genesis.json" \
  && ln -sf "${CNODE_HOME}/files/${NETWORK}-alonzo-genesis.json" "${CNODE_HOME}/files/alonzo-genesis.json" \
  && jq '.hasEKG = ["0.0.0.0", 12788] | .hasPrometheus = ["0.0.0.0", 12798] | .TraceMempool = false' "${CNODE_HOME}/files/config-${NETWORK}.json" > "${CNODE_HOME}/files/config.json" \
  && customize \
  && exec "${CNODE_HOME}/scripts/cnode.sh"
else
  echo "Please set a NETWORK environment variable to one of: [preview|preprod|testnet|mainnet]"
  echo "To modify topology.json map a container volume of this file to ${CNODE_HOME}/files/topology.json for a read/write -v /my/files/topology.json:${CNODE_HOME}/files/topology.json:rw otherwise set rw to ro if you want it read only inside the container."
  echo "To enable a POOL pass in POOL_NAME environment variable"
fi
