#!/bin/bash

# ALl Ceph Nodes Setup
cd /tmp
wget -q -O- 'https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc' | sudo apt-key add -
echo deb http://ceph.com/debian-dumpling/ $(lsb_release -sc) main | sudo tee /etc/apt/sources.list.d/ceph.list
apt-get update
apt-get install ceph-deploy -y
apt-get install sshpass ntp openssh-server -y  

echo "192.168.100.99   admin" >> /etc/hosts
echo "192.168.100.100  mon" >> /etc/hosts
echo "192.168.100.101  osd1" >> /etc/hosts
echo "192.168.100.102  osd2" >> /etc/hosts
