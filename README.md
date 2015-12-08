Weblogic Green Restart Scripts
==============================

* Scripts to stop/start/restart admin server, managed server, and node manager without configuration.
* The domain file system can be place in a SAN/NAS shared by multiple servers.
* Admin server, managed server, node manager can be Virutual IP, or DNS pointing to a virtual IP.

## Features:
  *  1. Green - save time to customize scripts.
  *  2. Automate print list of servers can be stop/start.

## Preparation:
  *  Get all files and place your DOMAIN HOME directory. And make sure Admin Server is up and running.
  *  Run ./runWLST.sh createWLkey_VIP.py and enter Admin user/password/url to generate user config file,
  *  key and managed server information.

## You are ready to go -
  *  start-admin:  Bourne shell script to start Weblogic Admin server running on the current host.
  *  stop-admin:   Bourne shell script to stop Weblogic Admin server running on the current host.
  *  restart-admin:Bourne shell script to restart Weblogic Admin server running on the current host.
  *  start-ms:     Bourne shell script to start Weblogic managed server running on the current host.
  *  stop-ms:      Bourne shell script to stop Weblogic managed server running on the current host.
  *  start-nm:     Bourne shell script to start Node Manager running on the current host.
  *  stop-nm:      Bourne shell script to start Node Manager running on the current host.
  *  tail-out:     Bourne shell script to tail a JVM file of a server running on the current host.
  *  vi-out:       Bourne shell script to vi a JVM log file of a server running on the current host.
  *  tail-log:     Bourne shell script to tail a Weblogic log file of a server running on the current host.
  *  vi-log:       Bourne shell script to vi a Weblogic log file of a server running on the current host.
  *  createWLkey_VIP.py: Jython script to connect admin server to set config file and key and get server IP and NM infor.
  *  runWLST.ksh:  WLST launcher
  *  setNodeName.sh: Bourne shell script to detect which server can be start/stop on the current host.
