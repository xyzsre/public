sudo apt update -y
sudo apt install snapd -y
sudo apt install ansible-core -y
sudo snap install terraform --classic
sudo snap install code --classic

snap --version
ansible --version
terraform --version
code --version

sudo snap list
sudo snap find workbench
sudo snap install mysql-workbench-community --classic
mysql-workbench-community --version

sudo apt update && sudo apt install -y sshpass
sshpass -V

sudo apt install -y nmap
nmap --version
nmap -p 22 127.0.0.1
sudo apt install openssh-server -y
sudo systemctl status ssh --no-pager
sudo systemctl start ssh
sudo systemctl enable ssh 


sudo apt install python3 python3-pip -y
pip3 install --break-system-packages mysql-connector-python

