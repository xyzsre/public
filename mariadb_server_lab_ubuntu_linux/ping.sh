export ANSIBLE_CONFIG=/home/devops/Desktop/LAB/mana_mariadb/ansible.cfg
ansible -m ping all
ansible -i inventory.ini -m ping all


