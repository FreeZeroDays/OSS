#!/bin/bash

# Updates
apt-get update && apt-get -y upgrade
apt-get -y autoremove
echo "Kali Updated ✅"

# Start Postgres
if command -v psql &> /dev/null
then
    service postgresql start
    update-rc.d postgresql enable
    echo "PostgreSQL started and will start on boot ✅"
else
    echo "PostgreSQL could not be found; install it and rerun this sript"
fi

# Initialize msfdb
if command -v msfconsole &> /dev/null
then
    msfdb init
    echo "msfdb initialized ✅"
else
    echo "msfconsole could not be found; install it and rerun this sript"
fi
