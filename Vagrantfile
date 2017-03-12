# -*- mode: ruby -*-
# # vi: set ft=ruby :
Vagrant.require_version ">= 1.6.0"
VAGRANTFILE_API_VERSION = "2"

require 'yaml'

servers = YAML.load_file(File.join(File.dirname(__FILE__), 'servers.yml'))
secrets = YAML.load_file(File.join(File.dirname(__FILE__), 'secrets.yml'))

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  servers.each do |server|

    config.vm.define server["name"]

    config.vm.provider :linode do |provider, override|
      override.ssh.private_key_path = server['private_key_path']
      override.vm.box = 'linode/ubuntu1404'

      provider.api_key = secrets[server['name']]['api_key']
      provider.distribution = server['distribution']
      provider.datacenter = server['datacenter']
      provider.plan = server['plan']
      provider.label = server['label']
      provider.group = server['group']
    end

    config.vm.synced_folder server['synced_folder_src'], server['synced_folder_dest']
    config.vm.hostname = server['hostname']

    config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'" # needed for ubuntu 16.04 LTS

    config.vm.provision server['install_script'], type: :shell, inline: server['install_script_content']
   
    config.vm.provision :salt do |salt|
      salt.minion_config = server['salt_minion_config']
      salt.run_highstate = server['salt_run_highstate']
    end

  end
end