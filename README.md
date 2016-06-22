coprhd_plus_ceph
---------------

# Description 
Multi-VM Vagrant environment with 5 VMs defined: 1 for CoprHD and 4 for the Ceph Cluster

# Prerequisites
* vagrant
  * Nice-to-have: vagrant-cachier for caching packages - really speeds up subsequent installs
  * `vagrant plugin install vagrant-cachier`
* virtualbox

# Usage
* Modify the Vagrantfile for the Host-only network you want to create/use for all VMs
* Launch/Provision all VMs
  * `vagrant up`
* Launch only a subset of VM(s)
  * `vagrant up [VM]`
  * [VM] is one or more of: coprhd, mon, osd1, osd2, admin

# Access the VMs
* `vagrant ssh [VM]`
  * [VM] is one of coprhd, mon, osd1, osd2, admin
  * NOTE: Default ssh user is 'vagrant'.  CoprHD sets up services using storageos user.
  * You can either `su storageos` after SSH'ing into CoprHD or you can use this command:
  * `vagrant ssh coprhd -- -l storageos` with the password 'vagrant' to login to CoprHD

# CoprHD Access/Changes
* Login to the CoprHD VM:
  * `vagrant ssh coprhd -- -l storageos`  # P: vagrant
* Stop CoprHD services
  * `sudo /etc/storageos/storageos stop`
* CoprHD source code is in: /tmp/coprhd-controller/
* Checked out branch is: master
* Make changes and recompile:
  * `sudo make clobber BUILD_TYPE=oss rpm`

# Useful Ceph Commands
* Login to a Ceph VM:
* `vagrant ssh mon`
* Watch the Ceph Cluster for changes:
* `ceph -w`
* Watch volumes:
* `watch rbd ls -l`

