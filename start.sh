#!/bin/bash

set -e

cd /data
echo "preparing /data with modpack"
cp -vrf /tmp/minecraft/* .
echo "eula=true" > eula.txt

if [[ ! -z "${RCON_PASSWORD}" ]] && ! grep -q rcon.password server.properties 2>/dev/null; then
    echo "enabling RCON, since RCON_PASSWORD is set and not present in server.properties"
    echo "rcon.password=${RCON_PASSWORD}" >> server.properties
    sed -i -e 's/enable-rcon=false/enable-rcon=true/' server.properties
fi

echo "starting minecraft"
java $JVM_OPTS -jar forge-*.jar nogui