# -*- mode: ruby -*-
# # vi: set ft=ruby :
Vagrant.require_version ">= 1.6.0"
VAGRANTFILE_API_VERSION = "2"

require 'yaml'
require 'pp'

#require 'colorize'

# install dependant plugins
%w( vagrant-linode vagrant-hosts vagrant-share vagrant-scaleway ).each do |plugin|
    exec "vagrant plugin install #{plugin};vagrant #{ARGV.join(" ")}" unless Vagrant.has_plugin? plugin || ARGV[0] == 'plugin'
end

servergroups = YAML.load_file(File.join(File.dirname(__FILE__), 'servers.yml'))
host_port = 2222
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  servergroups.each do |servergroup, servers|
    servers.each do |servername, serverconfig|
      secrets = YAML.load_file(File.join(File.dirname(__FILE__),"configs/#{servergroup}/#{servername}/secrets.yml")) if File.exist? "configs/#{servergroup}/#{servername}/secrets.yml"
      vm_name = "#{servername}.#{servergroup}"
      config.vm.define vm_name do |server|
        host_port = host_port + 1
        server.vm.network :forwarded_port, guest: 22, host: host_port, id: 'ssh'
        if serverconfig['provider'] == 'linode' then
          server.vm.provider :linode do |provider, override|
            override.ssh.private_key_path = serverconfig['private_key_path']
            override.vm.box               = 'linode/ubuntu1404'

            provider.api_key      = secrets['api_key']
            provider.datacenter   = serverconfig['datacenter']
            provider.plan         = serverconfig['plan']
            provider.label        = "#{servername.gsub(/\./,'_')}_#{servergroup.gsub(/\./,'_')}"
            provider.group        = servergroup
            provider.distribution = serverconfig['distribution'] unless serverconfig['distribution'].nil?
            provider.image        = serverconfig['image'] unless serverconfig['image'].nil?
            provider.imageid      = serverconfig['imageid'] unless serverconfig['imageid'].nil?
          end
          server.vm.hostname = "#{servername}.#{servergroup}"
        elsif serverconfig['provider'] == 'scaleway' then
          server.vm.provider :scaleway do |provider, override|
            override.ssh.private_key_path = serverconfig['private_key_path']

            provider.name            = "#{servername}.#{servergroup}"
            provider.region          = serverconfig['region']
            provider.tags            = serverconfig['tags']
            provider.commercial_type = serverconfig['commercial_type']
            provider.organization    = secrets['organization']
            provider.token           = secrets['token']
            provider.image           = serverconfig['image']
          end
          server.vm.hostname = "#{servername}.#{servergroup}"
        elsif serverconfig['provider'] == 'virtualbox' then
          server.vm.provider :virtualbox do |provider, override|
            override.vm.box          = serverconfig['box']
            override.ssh.insert_key  = false
            override.vm.define :jenkins do |jenkins|
            end
            provider.name            = "#{servername}.#{servergroup}"
            provider.memory = serverconfig['memory']
            provider.cpus = serverconfig['cpus']
            unless serverconfig['vboxmanage'].nil?
              serverconfig['vboxmanage'].each do |customize|
                provider.customize [customize['name'], :id, customize['setting'], customize['value']]
              end
            end
          end
        else
          exit 'Please pass a provider'
        end

        # mount any synced folders
        unless serverconfig['synced_folders'].nil?
          serverconfig['synced_folders'].each do |synced_folder|
            server.vm.synced_folder synced_folder['src'], synced_folder['dest'], disabled: synced_folder['disabled']
          end
        end

        # copy files
        unless serverconfig['files'].nil?
          serverconfig['files'].each do |file|
            server.vm.provision "file", source: "configs/#{servergroup}/#{servername}/#{file['src']}", destination: "#{file['dest']}" if File.exist? "configs/#{servergroup}/#{servername}/#{file['src']}"
          end
        end

        # run the scripts
        server.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'" # needed for ubuntu 16.04 LTS
        unless serverconfig['scripts'].nil?
          serverconfig['scripts'].each do |script|
            server.vm.provision script['name'], type: :shell, path: "configs/#{servergroup}/#{servername}/#{script['src']}"
          end
        end

      end
    end
  end
end
