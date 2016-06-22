#!/bin/bash

cd ~
mkdir cluster
cd cluster
ceph-deploy new mon
echo "osd pool default size = 2" >> ceph.conf

ceph-deploy install admin mon osd1 osd2
ceph-deploy mon create-initial  

ssh osd1 "sudo mkdir /var/local/osd0"
ssh osd2 "sudo mkdir /var/local/osd1"

ceph-deploy osd prepare osd1:/var/local/osd0 osd2:/var/local/osd1
ceph-deploy osd activate osd1:/var/local/osd0 osd2:/var/local/osd1

ceph-deploy admin admin mon osd1 osd2

sudo chmod +r /etc/ceph/ceph.client.admin.keyring  
ssh admin "sudo chmod +r /etc/ceph/ceph.client.admin.keyring"
ssh osd1 "sudo chmod +r /etc/ceph/ceph.client.admin.keyring"
ssh osd2 "sudo chmod +r /etc/ceph/ceph.client.admin.keyring"
ssh mon "sudo chmod +r /etc/ceph/ceph.client.admin.keyring"

echo "Ceph Deployed and Running!"
