#!/bin/bash

# Setup Key
cd ~/.ssh
ssh-keygen -q -N "" -f ./id_rsa

# Copy Key To Servers
echo "vagrant" > password.txt
#ssh-keyscan 192.168.100.100 >> ~/.ssh/known_hosts
#ssh-keyscan 192.168.100.101 >> ~/.ssh/known_hosts
#ssh-keyscan 192.168.100.102 >> ~/.ssh/known_hosts
ssh-keyscan admin >> ~/.ssh/known_hosts
ssh-keyscan mon >> ~/.ssh/known_hosts
ssh-keyscan osd1 >> ~/.ssh/known_hosts
ssh-keyscan osd2 >> ~/.ssh/known_hosts

echo "Copying Key to Servers"
sshpass -f ./password.txt ssh-copy-id vagrant@admin
sshpass -f ./password.txt ssh-copy-id vagrant@mon
sshpass -f ./password.txt ssh-copy-id vagrant@osd1
sshpass -f ./password.txt ssh-copy-id vagrant@osd2

