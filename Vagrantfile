# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|	
  config.vm.define "service_host" do |service_host|
    # Every Vagrant virtual environment requires a box to build off of.
    #service_host.vm.box = "chef/centos-6.6"
    
    service_host.vm.box = "hbcd/centos-6.6_1428414292_virtualbox"
    service_host.vm.box_url = "http://sd1pgo11lx.saksdirect.com:8081/artifactory/repo/centos/6.6/x86_64/1428414292/virtualbox/centos-6.6-x86_64-1428414292.virtualbox.box"

    # Create a private network, which allows host-only access to the machine
    # using a specific IP.
    service_host.vm.network "private_network", ip: "192.168.50.15"
    
    #product-detail-service
    service_host.vm.network "forwarded_port", guest: 9460, host: 9460
    
    #endeca-service
    service_host.vm.network "forwarded_port", guest: 9600, host: 9600
    
    #navigation-service
    service_host.vm.network "forwarded_port", guest: 9790, host: 9790
    
    #product-array-service
    service_host.vm.network "forwarded_port", guest: 9550, host: 9550
    
    #product-service
    service_host.vm.network "forwarded_port", guest: 9470, host: 9470
    
    #inventory-service
    service_host.vm.network "forwarded_port", guest: 9490, host: 9490
    
    #price-service
    service_host.vm.network "forwarded_port", guest: 9480, host: 9480
    
    #waitlist-service
    service_host.vm.network "forwarded_port", guest: 9240, host: 9240
    
    #reviews-service
    service_host.vm.network "forwarded_port", guest: 9530, host: 9530
    
    #promo-service
    service_host.vm.network "forwarded_port", guest: 9520, host: 9520
    
    #hidefromcatalog-service
    service_host.vm.network "forwarded_port", guest: 9560, host: 9560
    
    #fitpredictor-service
    service_host.vm.network "forwarded_port", guest: 9510, host: 9510
    
    #questionanswer-service
    service_host.vm.network "forwarded_port", guest: 9540, host: 9540
    
    #profile-service
    service_host.vm.network "forwarded_port", guest: 9810, host: 9810

    #private-sale-service
    service_host.vm.network "forwarded_port", guest: 9630, host: 9630
    
    # Share an additional folder to the guest VM. The first argument is
    # the path on the host to the actual folder. The second argument is
    # the path on the guest to mount the folder. And the optional third
    # argument is a set of non-required options.
    # config.vm.synced_folder "../data", "/vagrant_data"

    # Provider-specific configuration so you can fine-tune various
    # backing providers for Vagrant. These expose provider-specific options.
    # Example for VirtualBox:
    #
   service_host.vm.provider "virtualbox" do |vb|
     #   vb.gui = true
     #
     #   # Use VBoxManage to customize the VM. For example to change memory:
     vb.memory = 4096
     vb.cpus = 2
     vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
     vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
     vb.customize ["modifyvm", :id, "--nicpromisc3", "allow-all"]
   end
  
    service_host.librarian_puppet.puppetfile_dir = "puppet"
    service_host.librarian_puppet.placeholder_filename = ".gitkeep"

    # Enable provisioning with Puppet stand alone.  Puppet manifests
    # are contained in a directory path relative to this Vagrantfile.
    # You will need to create the manifests directory and a manifest in
    # the file default.pp in the manifests_path directory.
    service_host.vm.provision "puppet" do |puppet|
      puppet.manifests_path = "puppet"
      puppet.manifest_file = "site.pp"
      puppet.module_path = "puppet/modules"
    end
  end
end
