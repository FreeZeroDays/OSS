#!/bin/bash
# Just a simple script to clean up and make life a little easier :) 
# I  use this on client machines to ensure that if it is not decommissioned after the penetration test that evidence is minimal.
echo "" > /root/.bash_history
echo "" > ~/.bash_history

echo "" > /root/.msf4/history
rm -r /root/.msf4/loot/*
rm -r /root/.msf4/logs/*

echo "" > ~/.msf4/history
rm -r ~/.msf4/loot/*
rm -r ~/.msf4/logs/*

rm -r /root/.john/*
rm -r ~/.john/*

rm -r /root/.hashcat/*.potfile
rm -r /root/.hashcat/sessions
rm -r ~/.hashcat/*.potfile
rm -r ~/.hashcat/sessions

rm -r /opt/tools
rm -r /tmp/tmp
