

# VirtualBox & Vagrant Commands Reference

## Table of Contents
1. [VirtualBox CLI Commands](#virtualbox-cli-commands)
2. [Vagrant Commands](#vagrant-commands)
3. [Network Management](#network-management)
4. [Storage & Disk Operations](#storage--disk-operations)
5. [Snapshot Management](#snapshot-management)
6. [Export & Import](#export--import)
7. [Monitoring & Debugging](#monitoring--debugging)
8. [Guest Additions & Extensions](#guest-additions--extensions)
9. [Performance & Optimization](#performance--optimization)
10. [Security & Maintenance](#security--maintenance)

---

## VirtualBox CLI Commands

### VM Management
```bash
# List all virtual machines
VBoxManage list vms

# List running virtual machines
VBoxManage list runningvms

# Show detailed VM information
VBoxManage showvminfo "VM Name"

# Start a virtual machine
VBoxManage startvm "VM Name" --type headless
VBoxManage startvm "VM Name" --type gui

# Stop a virtual machine gracefully
VBoxManage controlvm "VM Name" acpipowerbutton

# Force shutdown a VM
VBoxManage controlvm "VM Name" poweroff

# Pause/resume a VM
VBoxManage controlvm "VM Name" pause
VBoxManage controlvm "VM Name" resume

# Reset a VM
VBoxManage controlvm "VM Name" reset

# Save VM state
VBoxManage controlvm "VM Name" savestate
```

### VM Configuration
```bash
# Create a new virtual machine
VBoxManage createvm --name "NewVM" --register

# Modify VM memory (in MB)
VBoxManage modifyvm "VM Name" --memory 2048

# Modify CPU count
VBoxManage modifyvm "VM Name" --cpus 2

# Enable/disable virtualization extensions
VBoxManage modifyvm "VM Name" --hwvirtex on
VBoxManage modifyvm "VM Name" --nestedpaging on

# Set boot order
VBoxManage modifyvm "VM Name" --boot1 disk --boot2 dvd --boot3 none --boot4 none

# Enable/disable audio
VBoxManage modifyvm "VM Name" --audio alsa
VBoxManage modifyvm "VM Name" --audio none

# Configure graphics memory
VBoxManage modifyvm "VM Name" --vram 128

# Enable 3D acceleration
VBoxManage modifyvm "VM Name" --accelerate3d on
```

### Network Configuration
```bash
# List available networks
VBoxManage list hostonlyifs
VBoxManage list natnetworks

# Add NAT network interface
VBoxManage modifyvm "VM Name" --nic1 nat

# Add bridged network interface
VBoxManage modifyvm "VM Name" --nic1 bridged --bridgeadapter1 eth0

# Add host-only network interface
VBoxManage modifyvm "VM Name" --nic1 hostonly --hostonlyadapter1 vboxnet0

# Forward NAT port
VBoxManage modifyvm "VM Name" --natpf1 "guestssh,tcp,,2222,,22"

# Configure NAT network
VBoxManage natnetwork add --netname natnet1 --network "192.168.15.0/24" --enable
```

---

## Vagrant Commands

### Basic Workflow
```bash
# Initialize new Vagrant environment
vagrant init ubuntu/bionic64

# Start and provision VM
vagrant up

# SSH into VM
vagrant ssh

# Halt VM (save state)
vagrant halt

# Suspend VM (save to disk)
vagrant suspend

# Resume suspended VM
vagrant resume

# Reload VM with configuration changes
vagrant reload

# Destroy VM and resources
vagrant destroy

# Check Vagrant status
vagrant status
```

### Box Management
```bash
# Add a box
vagrant box add ubuntu/bionic64

# List installed boxes
vagrant box list

# Remove a box
vagrant box remove ubuntu/bionic64

# Update boxes
vagrant box update

# Package current VM into box
vagrant package

# Repackage box
vagrant repackage
```

### Provisioning
```bash
# Run provisioners manually
vagrant provision

# Run specific provisioner
vagrant provision --provision-with shell

# Clean up provisioning
vagrant provision --clean
```

### Multi-Machine Environments
```bash
# Start specific VM in multi-machine setup
vagrant up web

# SSH into specific VM
vagrant ssh web

# Halt specific VM
vagrant halt web

# Status of all VMs
vagrant status
```

### Plugin Management
```bash
# Install plugin
vagrant plugin install vagrant-hostsupdater

# List installed plugins
vagrant plugin list

# Uninstall plugin
vagrant plugin uninstall vagrant-hostsupdater

# Update plugin
vagrant plugin update vagrant-hostsupdater
```

### Sharing & Collaboration
```bash
# Share environment via Vagrant Share
vagrant share

# Share with HTTP disabled
vagrant share --disable-http

# Share with SSH enabled
vagrant share --ssh

# Connect to shared environment
vagrant connect --ssh <share-name>
```

---

## Network Management

### VirtualBox Network Commands
```bash
# Create host-only network
VBoxManage hostonlyif create

# Configure host-only network
VBoxManage hostonlyif ipconfig vboxnet0 --ip 192.168.56.1 --netmask 255.255.255.0

# Create NAT network
VBoxManage natnetwork add --netname "mynetwork" --network "192.168.100.0/24" --dhcp on

# Start NAT network
VBoxManage natnetwork start --netname "mynetwork"

# Port forwarding for NAT
VBoxManage modifyvm "VM Name" --natpf1 "http,tcp,,8080,,80"
VBoxManage modifyvm "VM Name" --natpf1 "ssh,tcp,,2222,,22"
```

### Vagrant Network Configuration
```bash
# Forwarded port in Vagrantfile
config.vm.network "forwarded_port", guest: 80, host: 8080

# Private network with static IP
config.vm.network "private_network", ip: "192.168.33.10"

# Private network with DHCP
config.vm.network "private_network", type: "dhcp"

# Public network (bridged)
config.vm.network "public_network"

# Multiple network interfaces
config.vm.network "private_network", ip: "192.168.33.10"
config.vm.network "forwarded_port", guest: 22, host: 2222, id: "ssh"
```

---

## Storage & Disk Operations

### VirtualBox Storage Commands
```bash
# Create new virtual disk
VBoxManage createhd --filename "/path/to/disk.vdi" --size 10000 --format VDI

# Attach storage controller
VBoxManage storagectl "VM Name" --name "SATA Controller" --add sata

# Attach disk to controller
VBoxManage storageattach "VM Name" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "/path/to/disk.vdi"

# Create and attach in one command
VBoxManage createhd --filename "disk.vdi" --size 20000 --format VDI
VBoxManage storageattach "VM Name" --storagectl "SATA Controller" --port 1 --device 0 --type hdd --medium "disk.vdi"

# Resize existing disk
VBoxManage modifyhd "disk.vdi" --resize 30000

# Compact dynamic disk
VBoxManage modifyhd "disk.vdi" --compact

# Convert disk formats
VBoxManage clonehd "source.vdi" "target.vmdk" --format VMDK
VBoxManage clonehd "source.vdi" "target.vhd" --format VHD

# List storage controllers
VBoxManage showvminfo "VM Name" | grep "Storage Controller"
```

### Vagrant Storage Configuration
```bash
# Synced folder configuration
config.vm.synced_folder "host/path", "/guest/path"

# NFS synced folder (Linux/Mac hosts)
config.vm.synced_folder "host/path", "/guest/path", type: "nfs"

# SMB synced folder (Windows hosts)
config.vm.synced_folder "host/path", "/guest/path", type: "smb"

# Disable default synced folder
config.vm.synced_folder ".", "/vagrant", disabled: true

# Mount additional disk
config.vm.provider "virtualbox" do |vb|
  vb.customize ["storageattach", :id, "--storagectl", "SATA Controller", "--port", "1", "--device", "0", "--type", "hdd", "--medium", "disk.vdi"]
end
```

---

## Snapshot Management

### VirtualBox Snapshot Commands
```bash
# Take snapshot
VBoxManage snapshot "VM Name" take "Snapshot Name" --description "Snapshot description"

# List snapshots
VBoxManage snapshot "VM Name" list

# Show snapshot details
VBoxManage snapshot "VM Name" showvminfo "Snapshot Name"

# Restore snapshot
VBoxManage snapshot "VM Name" restore "Snapshot Name"

# Delete snapshot
VBoxManage snapshot "VM Name" delete "Snapshot Name"

# Restore current snapshot
VBoxManage snapshot "VM Name" restorecurrent

# Take snapshot with live state
VBoxManage snapshot "VM Name" take "Snapshot Name" --live
```

### Vagrant Snapshot Integration
```bash
# Use VirtualBox snapshots with Vagrant
VBoxManage snapshot "default" take "before-update" --description "Before system update"

# Restore snapshot and reload Vagrant
VBoxManage snapshot "default" restore "before-update"
vagrant reload
```

---

## Export & Import

### Export Operations
```bash
# Export VM as OVA
VBoxManage export "VM Name" --output "VM-Name.ova"

# Export with specific options
VBoxManage export "VM Name" --output "VM-Name.ova" --vsys 0 --product "My Product" --vendor "My Company"

# Export only specific disk
VBoxManage export "VM Name" --output "VM-Name.ovf" --manifest

# List export options
VBoxManage export --help
```

### Import Operations
```bash
# Import OVA file
VBoxManage import "VM-Name.ova"

# Import with specific settings
VBoxManage import "VM-Name.ova" --vsys 0 --memory 2048 --cpus 2

# Import with new name
VBoxManage import "VM-Name.ova" --vsys 0 --vmname "New VM Name"

# List import options
VBoxManage import --help
```

---

## Monitoring & Debugging

### VirtualBox Monitoring
```bash
# Show VM statistics
VBoxManage showvminfo "VM Name" --statistics

# Monitor VM in real-time
VBoxManage showvminfo "VM Name" --statistics | while read line; do echo "$(date): $line"; sleep 5; done

# Check VM logs
tail -f "/path/to/VirtualBox VMs/VM Name/Logs/VBox.log"

# List host information
VBoxManage list hostinfo

# Check system requirements
VBoxManage list systemproperties
```

### Vagrant Debugging
```bash
# Verbose output
vagrant up --debug

# Enable detailed logging
VAGRANT_LOG=debug vagrant up

# Check Vagrant version
vagrant --version

# Validate Vagrantfile
vagrant validate

# Show global status
vagrant global-status

# Clean up global status
vagrant global-status --prune
```

### Network Debugging
```bash
# Check VM network configuration
VBoxManage showvminfo "VM Name" | grep -i "nic"

# Test network connectivity from host
ping 192.168.56.101

# Check port forwarding
VBoxManage showvminfo "VM Name" | grep -i "forwarding"

# Monitor network traffic
VBoxManage controlvm "VM Name" nictrace1 on
VBoxManage controlvm "VM Name" nictrace1 off
```

---

## Guest Additions & Extensions

### Guest Additions Commands
```bash
# Mount Guest Additions ISO
VBoxManage storageattach "VM Name" --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium "/usr/share/virtualbox/VBoxGuestAdditions.iso"

# Check Guest Additions version
VBoxManage guestproperty get "VM Name" "/VirtualBox/GuestAdd/Version"

# Update Guest Additions
VBoxManage guestcontrol "VM Name" run --exe "/path/to/VBoxLinuxAdditions.run" --username vagrant --password vagrant

# Verify Guest Additions installation
VBoxManage guestproperty enumerate "VM Name" | grep -i "guestadd"
```

### Extension Pack Management
```bash
# Install Extension Pack
VBoxManage extpack install "Oracle_VM_VirtualBox_Extension_Pack.vbox-extpack"

# List installed extension packs
VBoxManage list extpacks

# Uninstall Extension Pack
VBoxManage extpack uninstall "Oracle VM VirtualBox Extension Pack"

# Update Extension Pack
VBoxManage extpack uninstall "Oracle VM VirtualBox Extension Pack"
VBoxManage extpack install "Oracle_VM_VirtualBox_Extension_Pack.vbox-extpack"
```

---

## Performance & Optimization

### VirtualBox Performance Commands
```bash
# Enable I/O APIC for better performance
VBoxManage modifyvm "VM Name" --ioapic on

# Enable nested virtualization
VBoxManage modifyvm "VM Name" --nested-hw-virt on

# Set paravirtualization provider
VBoxManage modifyvm "VM Name" --paravirtprovider kvm

# Configure chipset
VBoxManage modifyvm "VM Name" --chipset piix3

# Enable large page support
VBoxManage modifyvm "VM Name" --largepages on

# Set VRAM size
VBoxManage modifyvm "VM Name" --vram 256

# Configure mouse integration
VBoxManage modifyvm "VM Name" --mouse ps2
VBoxManage modifyvm "VM Name" --mouse usb
```

### Vagrant Performance Optimization
```bash
# Configure VM resources in Vagrantfile
config.vm.provider "virtualbox" do |vb|
  vb.memory = "4096"
  vb.cpus = 4
  vb.customize ["modifyvm", :id, "--ioapic", "on"]
  vb.customize ["modifyvm", :id, "--nestedpaging", "on"]
end

# Enable paravirtualized provider
config.vm.provider "virtualbox" do |vb|
  vb.customize ["modifyvm", :id, "--paravirtprovider", "kvm"]
end

# Optimize synced folder performance
config.vm.synced_folder ".", "/vagrant", type: "virtualbox", mount_options: ["uid=1000", "gid=1000"]
```

---

## Security & Maintenance

### Security Commands
```bash
# Enable VRDP with encryption
VBoxManage modifyvm "VM Name" --vrde on
VBoxManage modifyvm "VM Name" --vrdeauthtype external
VBoxManage modifyvm "VM Name" --vrdeencryptchannels on

# Configure disk encryption
VBoxManage encryptvm "VM Name" --newpassword "password"

# Set guest property filters
VBoxManage setextradata "VM Name" "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root" "1"

# Configure USB filters for security
VBoxManage usbfilter add 0 --target "VM Name" --name "Allowed Device" --vendorid 0x1234 --productid 0x5678
```

### Maintenance Commands
```bash
# Clean up VirtualBox registry
VBoxManage registervm "/path/to/VM/VMName.vbox"

# Unregister VM (keep files)
VBoxManage unregistervm "VM Name"

# Unregister and delete VM
VBoxManage unregistervm "VM Name" --delete

# Compact all disks in directory
for disk in *.vdi; do VBoxManage modifyhd "$disk" --compact; done

# Check for orphaned disks
VBoxManage list hdds | grep "State:.*orphan"

# Clean up media registry
VBoxManage closemedium disk "disk.vdi" --delete
```

---

## Quick Reference Cheat Sheet

### Essential VirtualBox Commands
```bash
# Quick VM status check
VBoxManage list runningvms

# Quick VM start/stop
VBoxManage startvm "VM Name" --type headless
VBoxManage controlvm "VM Name" poweroff

# Quick snapshot
VBoxManage snapshot "VM Name" take "backup-$(date +%Y%m%d)"
```

### Essential Vagrant Commands
```bash
# Daily workflow
vagrant up && vagrant ssh
vagrant halt
vagrant destroy

# Box management
vagrant box list
vagrant box update

# Multi-machine
vagrant status
vagrant up web database
```

---

*This command reference covers the most commonly used VirtualBox and Vagrant commands for home lab virtualization. For complete documentation, refer to the official VirtualBox and Vagrant manuals.*
