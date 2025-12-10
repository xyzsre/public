
# Windows Requirements Installation

This guide covers installing Chocolatey (choco), VirtualBox, and Vagrant on Windows.

## Install Chocolatey

1. Open PowerShell as Administrator.
2. Run the following command to install Chocolatey:
   ```
   Set-ExecutionPolicy Bypass -Scope Process -Force; `
   [System.Net.ServicePointManager]::SecurityProtocol = `
   [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; `
   iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
   ```
3. Close and reopen PowerShell to ensure Chocolatey is available.

## Install VirtualBox and Vagrant

1. In PowerShell (as Administrator), run:
   ```
   choco install virtualbox vagrant
   ```
2. Follow any prompts during installation.

## Check Installations

- **Chocolatey version**: `choco --version`
- **VirtualBox version**: `VBoxManage --version`
- **Vagrant version**: `vagrant --version`

