# Created by Jonas Rosland, @virtualswede & Matt Cowger, @mcowger
# Many thanks to this post by James Carr: http://blog.james-carr.org/2013/03/17/dynamic-vagrant-nodes/
# Extended by cebruns for CoprHD All-In-One Vagrant Setup

########################################################
#
# Global Settings for CoprHD and Ceph
#
########################################################
network = "192.168.100"
domain = 'aio.local'

script_proxy_args = ""
# Check if we are currently behind proxy
# We will pass into build/provision scripts if set
if ENV["http_proxy"] || ENV["https_proxy"]
  if !(Vagrant.has_plugin?("vagrant-proxyconf"))
    raise StandardError, "Env Proxy set but vagrant-proxyconf not installed. Fix with: vagrant plugin install vagrant-proxyconf"
   end
   # Remove http and https from proxy setting
   temp = ENV["http_proxy"].dup
   temp.slice! "http://"
   http_proxy, http_proxy_port = temp.split(":")
   script_proxy_args = " --proxy #{http_proxy} --port #{http_proxy_port}"

   # Some proxies use http or https as secure proxy, handle both
   temp = ENV["https_proxy"].dup
   temp =~ /https*:\/\/(.*)/
   https_proxy, https_proxy_port = $1.split(":")
   script_proxy_args += " --secure_proxy #{https_proxy} --secure_port #{https_proxy_port}"
   script_proxy_args += " --secure_proxy #{https_proxy} --secure_port #{https_proxy_port}"
end

########################################################
#
# CoprHD Settings
#
########################################################
#ch_node_ip = "#{network}.11"
#ch_virtual_ip = "#{network}.10"
#ch_gw_ip = "#{network}.1"
#build = true
#ch_vagrantbox = "3.5.0.0.30_CoprHDBox"
#ch_vagrantboxurl = "https://build.coprhd.org/jenkins/userContent/DevKits/3.5.0.0.30/CoprHDDevKit.x86_64-3.5.0.0.30.box"

# Simulated Backend - set to true to get VNX/VMAX Simulated Backends
#smis_simulator = false

# All Simulators - set to true for Sanity Testing (will include smis_simulator)
#all_simulators = false

########################################################
#
# Ceph Settings
#
########################################################
admin_node_ip = "#{network}.99"
mon_node_ip   = "#{network}.100"
osd1_node_ip  = "#{network}.101"
osd2_node_ip  = "#{network}.102"

# Ubuntu 16.04 Server Base
ceph_vagrantbox = "boxcutter/ubuntu1604"
# Stupid Ubuntu Xenial box doesn't have the vagrant user!
#ceph_vagrantbox = "ubuntu/xenial64"
#ceph_vagrantboxurl = "https://atlas.hashicorp.com/boxcutter/boxes/ubuntu1604/versions/2.0.23/providers/virtualbox.box"
#ceph_vagrantbox = "bento_xenial"
#ceph_vagrantboxurl = "https://atlas.hashicorp.com/bento/boxes/ubuntu-16.04/versions/2.3.0/providers/virtualbox.box"

# Ceph Nodes - in order we want them to boot
ceph_nodes = ['mon', 'osd1', 'osd2', 'admin']

ceph_hostnames = []
ceph_nodes.each { |node_name|
  (1..1).each {|n|
    ceph_hostnames << {:hostname => "#{node_name}"}
  }
}

########################################################
#
# Launch the VMs
#
########################################################
Vagrant.configure("2") do |config|

  config.vm.box_download_insecure = true

  # If Proxy is set when provisioning, we set it permanently in each VM
  # If Proxy is not set when provisioning, we won't set it
  if Vagrant.has_plugin?("vagrant-proxyconf")
    if ENV["http_proxy"]
      config.proxy.http    = ENV["http_proxy"]
    end
    if ENV["https_proxy"]
      config.proxy.https   = ENV["https_proxy"]
    end
    if ENV["ftp_proxy"]
      config.proxy.ftp     = ENV["ftp_proxy"]
    end
    if ENV["no_proxy"]
      config.proxy.no_proxy = ENV["no_proxy"]
    end
  end

  # Enable caching to speed up package installation for second run
  # vagrant plugin install vagrant-cachier
#  if Vagrant.has_plugin?("vagrant-cachier")
#    config.cache.scope = :box
#    config.cache.synced_folder_opts = {
#        owner: "_apt",
#        group: "_apt"
#    }
#  end

########################################################
#
# Launch CoprHD
#
########################################################
#  config.vm.define "coprhd" do |coprhd|
#     coprhd.vm.box = "#{ch_vagrantbox}"
#     coprhd.vm.box_url = "#{ch_vagrantboxurl}"
#     coprhd.vm.host_name = "coprhd1"
#     coprhd.vm.network "private_network", ip: "#{ch_node_ip}"
#     coprhd.vm.base_mac = "003EDAF3880D"
#
#     # configure virtualbox provider
#     coprhd.vm.provider "virtualbox" do |v|
#         v.gui = false
#         v.name = "CoprHD_Ceph"
#         v.memory = 3000
#         v.cpus = 4
#     end
#
#     # download and compile CoprHD from sources
#     coprhd.vm.provision "shell" do |s|
#      s.path = "scripts/build.sh"
#      s.args = "--build #{build} --node_ip #{ch_node_ip} --virtual_ip #{ch_virtual_ip} --gw_ip #{ch_gw_ip} --node_count 1 --node_id vipr1"
#      s.args  += script_proxy_args
#     end
#
#      # Setup ntpdate crontab
#      coprhd.vm.provision "shell", inline: "zypper -n install cron"
#      coprhd.vm.provision "shell" do |s|
#        s.path = "scripts/crontab.sh"
#        s.privileged = false
#      end
#
#     # install CoprHD RPM
#     coprhd.vm.provision "shell" do |s|
#      s.path = "scripts/install.sh"
#      s.args   = "--virtual_ip #{ch_virtual_ip}"
#     end
#
#     # Grab CoprHD CLI Scripts and Patch Auth Module
#     coprhd.vm.provision "shell" do |s|
#      s.path = "scripts/coprhd_cli.sh"
#      s.args = "-s #{smis_simulator} -a #{all_simulators} --node_ip #{ch_node_ip}"
#     end
#
#     coprhd.vm.provision "shell" do |s|
#      s.path = "scripts/banner.sh"
#      s.args   = "--virtual_ip #{ch_virtual_ip}"
#     end
#
#     coprhd.vm.provision "shell", inline: "service network restart", run: "always"
#     coprhd.vm.provision "shell", inline: "service sshd restart", run: "always"
#    end # End of CoprHD Config
#
#########################################################
#
# Launch CEPH Cluster
#
########################################################
  ceph_hostnames.each do |node|
    config.vm.define node[:hostname] do |node_config|
      node_config.vm.box = "#{ceph_vagrantbox}" 
#      node_config.vm.box_url = "#{ceph_vagrantboxurl}"
      node_config.vm.host_name = "#{node[:hostname]}.#{domain}"
      node_config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", "1024"]
        vb.customize ["modifyvm", :id, "--name", node[:hostname]]
      end # vb

     # Setup Swap space
     node_config.vm.provision "shell" do |s|
      s.path = "scripts/swap.sh"
     end
  
    # Install admin packages/set IP, setup SSH
    if node[:hostname] == "admin"
     node_config.vm.network "private_network", ip: "#{admin_node_ip}"
     node_config.vm.provision "shell" do |s|
      s.path = "scripts/admin.sh"
     end
     # setup ssh
     node_config.vm.provision "shell" do |s|
      s.privileged = false
      s.path = "scripts/ssh_setup.sh"
     end
     # setup cluster
     node_config.vm.provision "shell" do |s|
      s.privileged = false
      s.path = "scripts/cluster.sh"
     end
    end  # End of Admin

    # MON Node
    if node[:hostname] == "mon"
     node_config.vm.network "private_network", ip: "#{mon_node_ip}"
     # install necessary packages
     node_config.vm.provision "shell" do |s|
      s.path = "scripts/ceph_setup.sh"
     end
    end  # End of Mon

    # OSD1 Node
    if node[:hostname] == "osd1"
     node_config.vm.network "private_network", ip: "#{osd1_node_ip}"
     # install necessary packages
     node_config.vm.provision "shell" do |s|
      s.path = "scripts/ceph_setup.sh"
     end
    end  # End of OSD1

    # OSD2 Node
    if node[:hostname] == "osd2"
     node_config.vm.network "private_network", ip: "#{osd2_node_ip}"
     # install necessary packages
     node_config.vm.provision "shell" do |s|
      s.path = "scripts/ceph_setup.sh"
     end
    end  # End of OSD2
    end # node_config
  end  # End of Ceph Hostnames
end # End of Vagrant Configure
