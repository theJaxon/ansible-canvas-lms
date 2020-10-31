#!/bin/bash
ansible_cfg=/home/vagrant/ansible.cfg 
ansible_inventory=/home/vagrant/inventory

echo "[TASK 1] populate /etc/hosts"
cat >> /etc/hosts << EOF
192.168.100.200 db
192.168.100.201 app
EOF

echo "[TASK 2] Install ansible"
yum install -y epel-release && yum install -y ansible vim

echo "[TASK 3] SSH Keys setup"
su - vagrant << "EOF"
mkdir -v /home/vagrant/.ssh 
cd /home/vagrant/.ssh 
ssh-keygen -N "" -f id_rsa # Generate public and private key pairs (id_rsa, id_rsa.pub)
# Copy SSH Keys
sshpass -p "vagrant" ssh-copy-id -o StrictHostKeyChecking=no -i id_rsa.pub vagrant@db
sshpass -p "vagrant" ssh-copy-id -o StrictHostKeyChecking=no -i id_rsa.pub vagrant@app
EOF

echo "[TASK 4] Add inventory file"
if [ ! -f "$ansible_inventory" ]; then 
touch "$ansible_inventory"
cat >> "$ansible_inventory" << EOF
[all]
db 
app
EOF
else 
echo "inventory file already exists on $ansible_inventory"
fi 

echo "[TASK 5] Add ansible.cfg file"
if [ ! -f "$ansible_cfg" ]; then 
touch "$ansible_cfg"
cat >> "$ansible_cfg" << EOF 
[defaults]
remote_user = vagrant 
inventory = inventory
ask_pass = False 

[privilege_escalation]
become = True 
become_user = root 
become_method = sudo 
become_ask_pass = False
EOF
else 
echo "ansible.cfg already exists on $ansible_cfg"
fi