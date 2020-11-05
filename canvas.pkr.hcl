# Vagrant build fails because i'm running out of memory
# Still didn't figure how to set RAM when using vagrant builder, Given Vagrant go template always fails for some reason.

source "vagrant" "canvas" {
  communicator = "ssh"
  box_name = "canvas-ubuntu-bionic"
  source_path = "bento/ubuntu-18.04"
  provider = "virtualbox"
  ssh_username = "vagrant"
  ssh_password = "vagrant"
  #template = "Vagrantfile.go"
}

variables {
  ansible_dir = "/etc/ansible"
}

build {
  sources = ["source.vagrant.canvas"]

  # Install ansible and place the config file 
  provisioner "shell" {
  inline = [
    # Install prerequiste software
    "sudo apt install -y aptitude python3.8 python-minimal software-properties-common",
    "sudo apt-add-repository ppa:ansible/ansible",
    "sudo apt-get update",
    "sudo apt install -y ansible"
  ]
 }

 # Run ansible-local provisioner to setup the machine 
 provisioner "ansible-local" {
    playbook_file   = "canvas.yml"
    inventory_groups = ["localhost"]
    host_vars = "host_vars"
    role_paths = ["postgres", "canvas"]
    extra_arguments = [ "--extra-vars \"ANSIBLE_CONFIG=/etc/ansible/ansible.cfg ansible_python_interpreter=/usr/bin/python3\"", "-b" ]
  }
}