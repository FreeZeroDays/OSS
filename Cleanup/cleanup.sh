#!/bin/bash
# Just a simple script to clean up and make life a little easier :D
# Author: Deviant

# Delete bash history
echo "" > /root/.bash_history
echo "" > ~/.bash_history

# Delete Metasploit l00ts
echo "" > /root/.msf4/history
rm -rf /root/.msf4/loot/*
rm -rf /root/.msf4/logs/*
rm -rf /root/.msf4/local/*

echo "" > ~/.msf4/history
rm -rf ~/.msf4/loot/*
rm -rf ~/.msf4/logs/*
rm -rf ~/.msf4/local/*

# Delete John files
rm -rf /root/.john/*
rm -rf ~/.john/*

# Delete Hashcat dfiles
rm -rf /root/.hashcat/*.potfile
rm -rf /root/.hashcat/sessions
rm -rf ~/.hashcat/*.potfile
rm -rf ~/.hashcat/sessions

# Miscellanious cleanups
rm -rf /root/tools
rm -rf ~/tools
rm -rf /tmp/*
rm -rf /opt/nessus
rm -rf /root/evidence
rm -rf ~/evidence
rm -rf /root/.cme
rm -rf ~/.cme

# Kill all active sessions so we don't leak data
tmux kill-server
pkill screen
