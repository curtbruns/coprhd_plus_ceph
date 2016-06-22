#!/bin/bash
# Run as Root!
if [[ $UID -ne 0 ]]; then 
   echo "Must run as root"
   exit
fi

# Stop Services
/etc/storageos/storageos stop

# Delete Database and all Data
sleep 2
rm -vrf /data/db/*
rm -vrf /data/zk/*
rm -vrf /data/geodb/*
sleep 2

# Remove CoprHD
# rpm -e storageos

echo "Not restarting the services...do what you need to do..."
echo "If you're going to build, this is the command:"
echo "make clobber BUILD_TYPE=oss rpm"
