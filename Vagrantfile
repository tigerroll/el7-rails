# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 1.6.2"

BOX_NAME = "CentOS-7-x86_64-Minimal"

Vagrant.configure("2") do |config|

  config.vm.box = BOX_NAME
  config.vm.box_url = "./packer/vagrant-boxes/CentOS-7-x86_64-Minimal.box"
  config.vm.box_check_update = true
  config.vm.hostname = "el7-rails"
  config.vm.network :private_network, ip: "192.168.33.10" 
  config.vm.network :private_network, ip: "192.168.33.11" 
  config.vm.network :forwarded_port, guest: 80, host: 8080

  config.vm.provider :virtualbox do |vb|
     vb.gui = false
     vb.name = BOX_NAME
     vb.customize ["modifyvm", :id, "--memory", "2048"]
     vb.customize ["modifyvm", :id, "--cpus", "2"]
  end

  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"

end
