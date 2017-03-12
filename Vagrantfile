# -*- mode: ruby -*-
# # vi: set ft=ruby :
Vagrant.require_version ">= 1.6.0"
VAGRANTFILE_API_VERSION = "2"

require 'yaml'

servers = YAML.load_file(File.join(File.dirname(__FILE__), 'servers.yml'))

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  servers.each do |servername, serverconfig|

    secrets = YAML.load_file(File.join(File.dirname(__FILE__),"configs/#{servername}/secrets.yml"))

    config.vm.define servername

    config.vm.provider :linode do |provider, override|
      override.ssh.private_key_path = serverconfig['private_key_path']
      override.vm.box = 'linode/ubuntu1404'

      provider.api_key = secrets['api_key']
      provider.distribution = serverconfig['distribution']
      provider.datacenter = serverconfig['datacenter']
      provider.plan = serverconfig['plan']
      provider.label = servername
      provider.group = serverconfig['group']
    end

    serverconfig['synced_folders'].each do |synced_folder|
      config.vm.synced_folder synced_folder['src'], synced_folder['dest']
    end
    config.vm.hostname = servername

    config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'" # needed for ubuntu 16.04 LTS

    config.vm.provision "initialize", type: :shell, path: "configs/#{servername}/userdata.sh"
   
    config.vm.provision :salt do |salt|
      salt.minion_config = "configs/#{servername}/minion.conf"
      salt.run_highstate = serverconfig['salt_run_highstate']
    end

  end
end