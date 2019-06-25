#!/bin/bash
sudo apt-get update && apt-get upgrade -y && apt-get autoremove && apt-get autoclean
sudo apt-get install build-essential libreadline-dev libssl-dev libpq5 libpq-dev libreadline5 libsqlite3-dev libpcap-dev git-core autoconf postgresql pgadmin3 curl zlib1g-dev libxml2-dev libxslt1-dev libyaml-dev curl zlib1g-dev gawk bison libffi-dev libgdbm-dev libncurses5-dev libtool sqlite3 libgmp-dev gnupg2 dirmngr nmap ruby-full rbenv -y
ruby -v
cd /opt/
sudo git clone https://github.com/rapid7/metasploit-framework.git
sudo chown -R `whoami` /opt/metasploit-framework
cd /opt/metasploit-framework
sudo gem install bundler
bundle install
sudo bash -c 'for MSF in $(ls msf*); do ln -s /opt/metasploit-framework/$MSF /usr/local/bin/$MSF;done'
sudo usermod -a -G postgres `whoami`
sudo su - `whoami` -c "cd /opt/metasploit-framework/; export PATH=$PATH:/usr/lib/postgresql/9.6/bin/; ./msfdb init;"
