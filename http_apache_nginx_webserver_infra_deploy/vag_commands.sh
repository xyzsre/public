vagrant --version
vagrant box list
vagrant status
vagrant up
vagrant ssh vm1
vagrant ssh vm2
vagrant destroy --force
vagrant box remove generic/ubuntu2204
vagrant box list
vagrant box add generic/ubuntu2204
vagrant box list
vagrant ssh vm1 -c 'ls -anp /home/vagrant/'
vagrant ssh vm1 -c 'sudo cat /etc/resolv.conf'
