# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 1.6.2"

BOX_NAME = "CentOS-7-x86_64-Minimal"

Vagrant.configure("2") do |config|

  config.vm.provider :libvirt do |libvirt|
    libvirt.connect_via_ssh = false
    libvirt.username = "root"
    libvirt.storage_pool_name = "vagrant"
    libvirt.driver = "kvm"
    libvirt.machine_type = "pc"
    libvirt.management_network_name = "default"
    libvirt.management_network_address = "192.168.122.0/24"
  end

  config.vm.define :vm1 do |vm1|
    vm1.vm.box = BOX_NAME
    vm1.vm.box_url = "./packer/vagrant-boxes/CentOS-7-x86_64-Minimal.box"
    vm1.vm.box_check_update = true
    vm1.vm.hostname = "el7-rails"
    vm1.vm.network :forwarded_port, guest: 80, host: 8180
    vm1.vm.network :private_network, 
      :ip => "192.168.121.100",
      :libvirt__network_name => "vagrant-libvirt"
    vm1.vm.provider :libvirt do |domain|
      domain.memory = 8192
      domain.cpus = 2
      domain.video_type = "vga"
      domain.nested = true
    end
  end
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"
end
