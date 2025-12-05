# macOS Requirements Installation

This guide covers installing Homebrew (brew), VirtualBox, and Vagrant on macOS.

## Install Homebrew

1. Open Terminal.
2. Run the following command to install Homebrew:
   ```
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```
3. Follow the on-screen instructions to complete the installation.
4. Ensure Homebrew is in your PATH by running:
   ```
   echo >> /Users/devops/.zprofile
   echo 'eval "$(/usr/local/bin/brew shellenv)"' >> /Users/devops/.zprofile
   eval "$(/usr/local/bin/brew shellenv)"
   ```

## Install VirtualBox and Vagrant

1. In Terminal, run:
   ```
   brew install --cask virtualbox vagrant
   ```
2. Follow any prompts during installation.

## Check Installations

- **Homebrew version**: `brew --version`
- **VirtualBox version**: `VBoxManage --version`
- **Vagrant version**: `vagrant --version`

