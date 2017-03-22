#!/usr/bin/env bash
HOSTNAME=$(cat /etc/hostname)

# fix hosts entry to have the new hostname
sed -i -e "s/127.0.0.1\slocalhost$/127.0.0.1 localhost $HOSTNAME/g" /etc/hosts

#apt-get update -y

# the following are needed for gitfs
#apt-get install vim python-pip -y
# pip install --upgrade pip
# pip install pyyaml

# # installing pygit2 + HTTPS support
# apt-get install libssl-dev -y
# apt-get install cmake -y
# wget -q https://github.com/libgit2/libgit2/archive/v0.25.1.tar.gz
# tar xzf v0.25.1.tar.gz
# cd libgit2-0.25.1/
# cmake .
# make
# make install
# ldconfig
# pip install cffi
# pip install pygit2
# cd ../

# # install necessary packages
#apt-get install -y salt-api salt-cloud salt-master  salt-minion salt-ssh salt-syndic

# apt-get install -y salt-api salt-cloud salt-master  salt-minion salt-ssh salt-syndic

salt-key -A -y
salt-key -y -d ubuntu.members.linode.com
salt-call state.highstate
