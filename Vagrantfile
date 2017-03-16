# -*- mode: ruby -*-
# # vi: set ft=ruby :
Vagrant.require_version ">= 1.6.0"
VAGRANTFILE_API_VERSION = "2"

require 'yaml'
require 'pp'
#require 'colorize'

servergroups = YAML.load_file(File.join(File.dirname(__FILE__), 'servers.yml'))

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  servergroups.each do |servergroup, servers|
    servers.each do |servername, serverconfig|
      secrets = YAML.load_file(File.join(File.dirname(__FILE__),"configs/#{servergroup}/#{servername}/secrets.yml"))

      config.vm.define "#{servername}.#{servergroup}"

      config.vm.provider :linode do |provider, override|

        override.ssh.private_key_path = serverconfig['private_key_path']
        override.vm.box               = 'linode/ubuntu1404'

        provider.api_key      = secrets['api_key']
        provider.datacenter   = serverconfig['datacenter']
        provider.plan         = serverconfig['plan']
        provider.label        = "#{servername.gsub(/\./,'_')}_#{servergroup.gsub(/\./,'_')}"
        provider.group        = servergroup
        provider.distribution = serverconfig['distribution'] unless serverconfig['distribution'].nil?
        provider.image        = serverconfig['image'] unless serverconfig['image'].nil?
        provider.imageid      = serverconfig['imageid']
      end

      # mount any synced folders
      unless serverconfig['synced_folders'].nil?
        serverconfig['synced_folders'].each do |synced_folder|
          config.vm.synced_folder synced_folder['src'], synced_folder['dest'], disabled: synced_folder['disabled']
        end
      end

      # copy salt files
      config.vm.provision "file", source: "configs/#{servergroup}/#{servername}/salt/master", destination: "/etc/salt/master" if File.exist? "configs/#{servergroup}/#{servername}/salt/master"
      config.vm.provision "file", source: "configs/#{servergroup}/#{servername}/salt/minion", destination: "/etc/salt/minion" if File.exist? "configs/#{servergroup}/#{servername}/salt/minion"
      config.vm.provision "file", source: "configs/#{servergroup}/#{servername}/salt/minion_id", destination: "/etc/salt/minion_id" if File.exist? "configs/#{servergroup}/#{servername}/salt/minion_id"

      config.vm.hostname = "#{servername}.#{servergroup}"

      config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'" # needed for ubuntu 16.04 LTS
      config.vm.provision "initialize", type: :shell, path: "configs/#{servergroup}/#{servername}/userdata.sh"

    end
  end
end
