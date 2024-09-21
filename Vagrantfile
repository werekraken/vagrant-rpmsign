Vagrant.configure("2") do |config|
  config.vm.box = "rockylinux/9"
  config.vm.provider "virtualbox" do |v|
    v.cpus = 1
    v.memory = 512
  end
  config.vbguest.auto_update = false
  config.vm.synced_folder ".", "/vagrant", type: "rsync"
  config.vm.provision "shell", path: "provisioners/privileged.sh"
  config.vm.provision "shell", path: "provisioners/unprivileged.sh", privileged: false
end
