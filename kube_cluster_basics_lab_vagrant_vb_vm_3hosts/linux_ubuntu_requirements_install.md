

# Linux Ubuntu Requirements Installation


****************************************
(Ubuntu 22 & 24):: VirtualBox + Vagrant Installation >>>>


ls -anp /etc/apt/sources.list.d/

ls -anp /usr/share/keyrings/

# Add Oracle VirtualBox GPG key
sudo wget -q -O- https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --dearmor --yes -o /usr/share/keyrings/oracle-virtualbox-2016.gpg

# Add VirtualBox repository
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list

# Remove old repository file if exists
sudo rm -f /etc/apt/sources.list.d/archive_uri-https_download_virtualbox_org_virtualbox_debian-jammy.list

# Add HashiCorp GPG key for Vagrant
sudo wget -q -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

# Add HashiCorp repository
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

ls -anp /etc/apt/sources.list.d/

ls -anp /usr/share/keyrings/


# Update package lists
sudo apt update


# Install VirtualBox 7.2
sudo apt install -y virtualbox-7.2


# Install Vagrant
sudo apt install -y vagrant


# Check VirtualBox version
VBoxManage --version

virtualbox --help


# Check Vagrant version
vagrant --version



# Tshoot

sudo apt update && sudo apt install gcc-12

sudo /sbin/vboxconfig

VBoxManage --version


****************************************
## Vagrant Commands >>>>

vagrant help

vagrant global-status

vagrant init

vagrant status

vagrant up

vagrant ssh vm1

vagrant destroy vm1

vagrant destroy --force

