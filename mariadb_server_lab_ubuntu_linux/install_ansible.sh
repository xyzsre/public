#!/bin/bash

# Install MariaDB and MySQL client using Ansible on localhost

# Ensure Ansible is installed (if not already)
if ! command -v ansible-playbook &> /dev/null; then
    echo "Ansible is not installed. Installing Ansible..."
    sudo apt update
    sudo apt install -y ansible
fi

# To PING::
ansible -i inventory.ini all -m ping
ansible -i inventory_sample.ini all -m ping
ansible -i inventory_sample.ini server1 -m ping
ansible all -m ping
ansible server1 -m ping

# Run the Ansible playbook
ansible-playbook -i inventory.ini install_db.yml

# ansible-playbook install_db.yml
# ansible-playbook install_phpmyadmin.yml
