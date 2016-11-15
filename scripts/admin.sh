#!/bin/bash

# All Ceph Nodes Setup
cd /tmp
# Grab the key
#wget -q -O- 'https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc' | sudo apt-key add -
wget -q -O- 'https://download.ceph.com/keys/release.asc' | sudo apt-key add -
# Set the release to Jewel 
#echo deb http://ceph.com/debian-jewel/ $(lsb_release -sc) main | sudo tee /etc/apt/sources.list.d/ceph.list
echo deb https://download.ceph.com/debian-jewel/ $(lsb_release -sc) main | sudo tee /etc/apt/sources.list.d/ceph.list

apt-get update
apt-get install ceph-deploy -y
apt-get install sshpass ntp openssh-server -y  

echo "192.168.100.99   admin" >> /etc/hosts
echo "192.168.100.100  mon" >> /etc/hosts
echo "192.168.100.101  osd1" >> /etc/hosts
echo "192.168.100.102  osd2" >> /etc/hosts
