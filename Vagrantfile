# -*- mode: ruby -*-
# vi: set ft=ruby :

myBox     = "bento/ubuntu-16.04"
myRam     = 1024
myCpu     = 1
managerIP = "192.168.99.10"
workerIP  = "192.168.99.20"
script    = "provision.sh"

Vagrant.configure("2") do |config|

    config.vm.box = myBox

    config.vm.provider "virtualbox" do |vb|
        vb.memory = myRam
        vb.cpus = myCpu
        vb.customize [ "guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 10000 ]
    end

    config.vm.provision "shell", path: script, privileged: true

    (1..3).each do |number|
        # Managers
        config.vm.define "m#{number}", autostart: false do |node|
          node.vm.provider "virtualbox" do |vb|
              vb.name = "m#{number}"
          end
            node.vm.network "private_network", ip: managerIP+"#{number}"
            node.vm.hostname = "m#{number}"
        end

        # Workers
        config.vm.define "w#{number}", autostart: false do |node|
          node.vm.provider "virtualbox" do |vb|
              vb.name = "m#{number}"
          end
            node.vm.network "private_network", ip: workerIP+"#{number}"
            node.vm.hostname = "w#{number}"
        end
    end

end
