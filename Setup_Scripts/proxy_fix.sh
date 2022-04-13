#!/bin/bash

# Quick and dirty bash script to fix some proxy issues for SOCKS during penetration test setup
# Script will ensure that the host can SSH into itself, start up SOCKS on a localhost and then forward that to the jumpbox
# SOCKS can then be accessed with a little bit of reverse tunnel magic

# Set the SOCKS and IP variables
ip="127.0.0.1"
socks="1080"

# Brief check to see if we can SSH into ourselves (I should add more checks here in the future)
if [[ $(cat /root/.ssh/authorized_keys|grep -f /root/.ssh/id_rsa.pub) ]]; then
    echo "Public key already exists in .ssh/authorized_keys"
else
    cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
    echo "Public key doesn't exist in .ssh/authorized_keys... Adding now"
fi

echo "Proceeding with starting SOCKS ✅"

# Start SOCKS
ssh -o StrictHostKeyChecking=no -Nf -D $ip:$socks localhost
ssh -o StrictHostKeyChecking=no -fnNR $socks:$ip:$socks clientrs@$ip

# Check if 1080/tcp is now open
if [[ $(ss -antp | grep 1080) ]]; then
    echo "Proxy is Alive ✅"
else
    echo "Proxy ain't Alive ❌"
fi
