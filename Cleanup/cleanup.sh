#!/bin/bash
# Just a simple script to clean up and make life a little easier :D
# I  use this on client machines to ensure that if it is not decommissioned after the penetration test that evidence is minimal.

# Delete bash history
echo "" > /root/.bash_history
echo "" > ~/.bash_history

# Delete Metasploit l00ts
echo "" > /root/.msf4/history
rm -r /root/.msf4/loot/*
rm -r /root/.msf4/logs/*

echo "" > ~/.msf4/history
rm -r ~/.msf4/loot/*
rm -r ~/.msf4/logs/*

# Delete John files
rm -r /root/.john/*
rm -r ~/.john/*

# Delete Hashcat dfiles
rm -r /root/.hashcat/*.potfile
rm -r /root/.hashcat/sessions
rm -r ~/.hashcat/*.potfile
rm -r ~/.hashcat/sessions

# Miscellanious cleanups 
rm -r /opt/tools
rm -rf /root/tools
rm -r /tmp/tmp
rm -rf /opt/nessus
rm -rf /root/evidence
