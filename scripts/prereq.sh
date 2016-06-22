#!/bin/bash

# Update repos
zypper refresh

# Install Boost Lib requirement
zypper -n install libboost_system1_54_0 libboost_thread1_54_0

# Grab Librados and Librbd
cd /tmp
wget http://ftp5.gwdg.de/pub/opensuse/repositories/filesystems:/ceph/openSUSE_13.2/x86_64/librados2-0.94.2+git.1438416244.bf16c3a-1.4.x86_64.rpm
wget http://ftp5.gwdg.de/pub/opensuse/repositories/filesystems:/ceph/openSUSE_13.2/x86_64/librbd1-0.94.2+git.1438416244.bf16c3a-1.4.x86_64.rpm

# Install
rpm -U ./librados2-0.94.2+git.1438416244.bf16c3a-1.4.x86_64.rpm
rpm -U ./librbd1-0.94.2+git.1438416244.bf16c3a-1.4.x86_64.rpm
