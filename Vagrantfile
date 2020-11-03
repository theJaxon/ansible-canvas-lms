Vagrant.configure("2") do |config|
  config.vm.box_check_update = false
  config.vm.synced_folder ".", "/vagrant", type: "rsync"
  # config.vm.define "database" do |database|
  #   database.vm.box = "bento/ubuntu-18.04"
  #   database.vm.hostname = "Postgres"
  #   database.vm.network "private_network", ip: "192.168.100.200"
  #   database.vm.network "forwarded_port", guest: 5432 , host: 5432 # Postgresql port
  # end

  config.vm.define "app" do |app|
    app.vm.box = "bento/ubuntu-18.04"
    app.vm.hostname = "Canvas"
    app.vm.network "private_network", ip: "192.168.100.201"
    app.vm.network "forwarded_port", guest: 3000 , host: 3000 # canvas port
    app.vm.provider "virtualbox" do |v|
        v.memory = 8192
        v.cpus = 2
      end
  end
  
  config.vm.define "controller" do |controller|
      controller.vm.box = "bento/centos-8.2"
      controller.vm.hostname = "controller"
      controller.vm.network "private_network", ip: "192.168.100.202"
      controller.vm.provision "shell", path: "controller.sh"
    end
  end
  