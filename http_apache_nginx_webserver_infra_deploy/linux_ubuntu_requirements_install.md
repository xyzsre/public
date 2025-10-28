# Linux Ubuntu Requirements Installation

This guide covers installing Snap, VirtualBox, and Vagrant on Ubuntu.

## Install Snap (if not already installed)

1. Open Terminal.
2. Check if Snap is installed: `snap --version`
3. If not installed, run:
   ```
   sudo apt update
   sudo apt install snapd
   ```
4. Restart your system or log out and back in to ensure Snap is fully integrated.

## Install VirtualBox and Vagrant

1. In Terminal, run:
   ```
   sudo snap install virtualbox
   sudo snap install vagrant --classic
   ```
2. Follow any prompts during installation.

## Check Installations

- **Snap version**: `snap --version`
- **VirtualBox version**: `virtualbox --version` (or `VBoxManage --version` after starting VirtualBox)
- **Vagrant version**: `vagrant --version`
