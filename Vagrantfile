# Fend off compatibility issues arising from differing Vagrant versions
Vagrant.require_version '>= 2.2.4'

# Keep in mind compatibilty when associating Xcode versions to a macOS release
# https://en.wikipedia.org/wiki/Xcode#Version_comparison_table
# TODO: Add MAC, IP Address options here; nil default (Auto, DHCP, respectively)
boxes = [
  {
    index: 1,
    name: '10136-17G66',
    compat_xcodes:
      ['9.4.1', '10.0', '10.1']
  },
  {
    index: 2,
    name: '1014-18A384a',
    compat_xcodes:
      ['9.4.1', '10.0', '10.1']
  },
  {
    index: 3,
    name: '10142-18C54',
    compat_xcodes:
      ['9.4.1', '10.0', '10.1']
  },
  {
    index: 4,
    name: '10143-18D109',
    compat_xcodes:
      ['9.4.1', '10.0', '10.1', '10.2']
  },
  {
    index: 5,
    name: '10144-18E194e',
    compat_xcodes:
      ['9.4.1', '10.0', '10.1', '10.2']
  },
  {
    index: 6,
    name: '10144-18E226',
    compat_xcodes:
      ['9.4.1', '10.0', '10.1', '10.2']
  }, # rubocop:disable Style/TrailingCommaInArrayLiteral
]

def ssh_port_gen(box_index)
  2200 + box_index.to_i
end

boxes.each do |macinbox|
  Vagrant.configure(2) do |config|
    # Name of the Vagrant machine (as it appears in `vagrant status`)
    config.vm.define "macos-#{macinbox[:name]}"

    # Name of Vagrant box that the machine should be brought up against
    config.vm.box = "macos-#{macinbox[:name]}"

    # Name for the machine's HostName, LocalHostName, and ComputerName
    config.vm.hostname = "macos-#{macinbox[:name]}"

    # Specified MAC address for the given machine
    # config.vm.base_mac = #{macinbox['mac_address']}

    # Specified IP address for the default NAT interface
    # config.vm.base_address = #{macinbox['ip_address']}

    # Network settings for the given machine
    # See: https://www.vagrantup.com/docs/networking/
    # config.vm.network "private_network", ip: "192.168.50.4"

    # Defined protocol by which Vagrant should connect to guest machines
    # (Default: SSH; alt. WinRM)
    # config.vm.communicator = "ssh"

    # Dynamic vm:host ssh port assignment (avoid concurrent testing conflicts)
    config.vm.forward_port 22, ssh_port_gen(macinbox['index']), auto: true

    # File-based provisioning tasks
    # TODO: See if file can be accessed via synced_folder instead of pushing
    config.vm.provision 'file', source: "~/.vagrant.d/provisioning/CommandLineToolsmacOSMojaveVersion10.14.pkg", destination: "$HOME/CommandLineToolsmacOSMojaveVersion10.14.pkg"

    # Shell-based provisioning tasks
    config.vm.provision 'shell', path: 'xcodeclitools_install.sh'
    config.vm.provision 'shell', path: 'homebrew_install.sh', privileged: false

    # Whether or not the machine will check for updates (upon each `vagrant up`
    # to the configured box
    config.vm.box_check_update = false

    # Volume mount for file-sharing between host and guest
    config.vm.synced_folder '.', '/vagrant', disabled: true

    # Provider-specific configurations
    config.vm.provider 'virtualbox' do |v|
      # Specify whether to enable a GUI for the machine being provisioned
      v.gui = true

      # Name of machine as it appears in VirtualBox
      v.name = "macos-#{macinbox[:name]}"
    end
  end
end
