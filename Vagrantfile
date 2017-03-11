Vagrant.configure('2') do |config|

  config.vm.provider :linode do |provider, override|
    override.ssh.private_key_path = '~/.ssh/id_rsa'
    override.vm.box = 'linode/ubuntu1404'

    provider.api_key = '93fLktcDjou7wcCTXjXJnIJxmHWDorJtwMREnKKFwJeqqIaLuvBeYBwQ1988Dy4B'
    provider.distribution = 'Ubuntu 16.04 LTS'
    provider.datacenter = 'frankfurt'
    provider.plan = 'Linode 1024'
    # provider.planid = <int>
    # provider.paymentterm = <*1*,12,24>
    # provider.datacenterid = <int>
    # provider.image = <string>
    # provider.imageid = <int>
    # provider.kernel = <string>
    # provider.kernelid = <int>
    # provider.private_networking = <boolean>
    # provider.stackscript = <string> # Not Supported Yet
    # provider.stackscriptid = <int> # Not Supported Yet
    # provider.distributionid = <int>
  end
end