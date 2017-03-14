#!/usr/bin/env bash
HOSTNAME=$(cat /etc/hostname)

# fix hosts entry to have the new hostname
sed -i -e "s/127.0.0.1\slocalhost$/127.0.0.1 localhost $HOSTNAME/g" /etc/hosts

# install necessary packages
apt-get install -y salt-api salt-cloud salt-master  salt-minion salt-ssh salt-syndic
