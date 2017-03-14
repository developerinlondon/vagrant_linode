# -*- mode: ruby -*-
# # vi: set ft=ruby :
Vagrant.require_version ">= 1.6.0"
VAGRANTFILE_API_VERSION = "2"

require 'yaml'

servergroups = YAML.load_file(File.join(File.dirname(__FILE__), 'servers.yml'))

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  servergroups.each do |servergroup, servers|
    servers.each do |servername, serverconfig|
      secrets = YAML.load_file(File.join(File.dirname(__FILE__),"configs/#{servergroup}/#{servername}/secrets.yml"))

      config.vm.define "#{servername}.#{servergroup}"

      config.vm.provider :linode do |provider, override|
        override.ssh.private_key_path = serverconfig['private_key_path']
        override.vm.box = 'linode/ubuntu1404'

        provider.api_key = secrets['api_key']
        provider.distribution = serverconfig['distribution']
        provider.datacenter = serverconfig['datacenter']
        provider.plan = serverconfig['plan']
        provider.label = servername
        provider.group = servergroup
      end

      serverconfig['synced_folders'].each do |synced_folder|
        config.vm.synced_folder synced_folder['src'], synced_folder['dest']
      end
      config.vm.hostname = "#{servername}.#{servergroup}"
      config.vm.provision "fix_hostname", type: :shell, inline: "sed -i -e 's/127.0.0.1\slocalhost$/127.0.0.1 localhost #{servername}.#{servergroup} #{servername}/g' /etc/hosts"

      config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'" # needed for ubuntu 16.04 LTS
      config.vm.provision "initialize", type: :shell, path: "configs/#{servergroup}/#{servername}/userdata.sh"
     
      config.vm.provision :salt do |salt|
        salt.minion_config = "configs/#{servergroup}/#{servername}/minion.conf"
        salt.run_highstate = serverconfig['salt_run_highstate']
        salt.masterless = serverconfig['salt_masterless']
        salt.install_master = serverconfig['salt_install_master']
        salt.log_level = serverconfig['salt_log_level']
        salt.verbose = serverconfig['salt_verbose']
        salt.colorize = serverconfig['salt_colorize']
      end
    end
  end
end