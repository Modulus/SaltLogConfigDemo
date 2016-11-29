# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define :master do |master_config|
    master_config.vm.box = "ubuntu/trusty64"
    master_config.vm.host_name = 'master'
    master_config.vm.network "private_network", ip: "192.168.78.20" #, :bridge => "eth1"
    master_config.vm.synced_folder "salt/", "/srv/salt"

    master_config.vm.provider "virtualbox" do |v|
      v.memory = 1024
      v.cpus = 2
    end
  #  master_config.landrush.enabled = true


    master_config.vm.provision :salt do |salt|
      salt.master_config = "vagrant_config/master"
      salt.master_key = "vagrant_config/keys/master_minion.pem"
      salt.master_pub = "vagrant_config/keys/master_minion.pub"
      salt.minion_key = "vagrant_config/keys/master_minion.pem"
      salt.minion_pub = "vagrant_config/keys/master_minion.pub"
      salt.seed_master = {
                          "master" => "vagrant_config/keys/master_minion.pub"
                         }

      salt.install_type = "stable"
      salt.install_master = true
      salt.no_minion = false
      salt.minion_config = "vagrant_config/master_minion"
      salt.verbose = true
      salt.colorize = true
      salt.bootstrap_options = "-P -c /tmp"
    end
  end

end
