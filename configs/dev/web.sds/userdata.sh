#!/usr/bin/env bash
HOSTNAME=$(cat /etc/hostname)

# fix hosts entry to have the new hostname
sed -i -e "s/127.0.0.1\slocalhost$/127.0.0.1 localhost $HOSTNAME/g" /etc/hosts

# the following are needed for gitfs
apt install python-pip -y
pip install --upgrade pip
pip install pyyaml
# installing pygit2 + HTTPS support
apt install libssl-dev -y
apt install cmake -y
wget https://github.com/libgit2/libgit2/archive/v0.24.0.tar.gz
tar xzf v0.24.0.tar.gz
cd libgit2-0.24.0/
cmake .
make
make install
ldconfig
pip install cffi
pip install pygit2
cd ../

# install necessary packages
apt-get install -y salt-api salt-cloud salt-master  salt-minion salt-ssh salt-syndic
