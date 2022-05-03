#!/bin/bash
# simple bash script to check free disk space on a Linux box

disk=$(df / | grep / | awk '{ print $5}' | sed 's/%//g')
host=$(hostname)
max=90
email=			# enter your email address here

if [ “$disk" -gt “$max" ]; then
    mail -s 'Disk Space Alert’ $email << EOF
Your root partition on $host is about to be full!
Used: $disk%
EOF
fi
