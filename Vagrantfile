# -*- mode: ruby -*-
# vi: set ft=ruby :

nodes = {
  'skyline-1' => {:ip => '172.16.10.10'},
  'oculus-1' => {:ip => '172.16.10.11', :memory => 1024},
  'oculus-www-1' => {:ip => '172.16.10.12'},
  'oculus-worker-1' => {:ip => '172.16.10.20'},
  'elasticsearch-a-1' => {:ip => '172.16.10.30'},
  'elasticsearch-b-1' => {:ip => '172.16.10.40'},
  'graphite-1' => {:ip => '172.16.10.50'},
}
node_defaults = {
  :domain => 'kale.local',
  :memory => 512,
}

Vagrant.configure("2") do |config|
  config.vm.box     = "puppet-precise64"
  config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-1204-x64.box"

  config.vm.provision :puppet do |puppet|
    puppet.manifest_file  = "site.pp"
    puppet.manifests_path = "manifests"
    puppet.module_path    = [ "modules", "vendor/modules" ]
    puppet.options = [
      "--verbose", "--summarize",
      "--reports", "store",
      "--hiera_config", "/vagrant/hiera.yaml",
    ]
  end

  nodes.each do |node_name, node_opts|
    config.vm.define node_name do |node|
      node_opts = node_defaults.merge(node_opts)
      fqdn = "#{node_name}.#{node_opts[:domain]}"

      node.vm.hostname = fqdn

      if node_opts[:ip]
        node.vm.network(:private_network, :ip => node_opts[:ip])
      end

      node.vm.provider :virtualbox do |vb|
        modifyvm_args = ['modifyvm', :id]
        modifyvm_args << "--name" << fqdn
        if node_opts[:memory]
          modifyvm_args << "--memory" << node_opts[:memory]
        end
        # Isolate guests from host networking.
        modifyvm_args << "--natdnsproxy1" << "on"
        modifyvm_args << "--natdnshostresolver1" << "on"
        vb.customize(modifyvm_args)
      end
    end
  end
end
