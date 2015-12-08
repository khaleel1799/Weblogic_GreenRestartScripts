#!/bin/sh
# Author jchen@ca.ibm.com
DOMAIN_HOME=$(cd `dirname $0` ;pwd)

cd ${DOMAIN_HOME}

if [ "$1" = "" ]; then
    VIPFILE=${DOMAIN_HOME}/VIP_MS.txt
    if ! test -f $VIPFILE; then
        echo "$VIPFILE not found. please create this file with all VIP and name of Managed Servers"
        echo "<Virtual IP>:<port> <Name of Mananged server>" 
        exit 1
    fi
    IPS=`/sbin/ifconfig | awk -F "[: ]+" 'BEGIN {ORS=" "}{if (($3 == "addr") && ($4 != "127.0.0.1")) print $4}'`

    for I in ${IPS}; do
        grep ${I}: ${VIPFILE}
    done | cut -d" " -f2 > $$

    trap 'rm -f $$' 0 1 2 3 15

    line=`wc -l $$|cut -d" " -f1`
    if [ "$line" = "1" ]; then
        SERVER_NAME=`cat $$`
    else
        echo "Server list can be running on this server -"
        awk '{print NR": "$0}' $$
        echo "Please select a number for a managed server to start:"
        read l
        SERVER_NAME=`sed "${l}q;d" $$`
        if [ "$SERVER_NAME" = "" ] ; then
            echo "Please enter a valid number. exit"
            exit 2
        fi
    fi
    rm $$
else
    SERVER_NAME="$1"
fi

export DOMAIN_HOME
export SERVER_NAME
