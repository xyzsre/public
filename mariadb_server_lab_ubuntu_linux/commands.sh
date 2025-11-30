#!/bin/bash

# MariaDB Installation and Management Commands for Ubuntu/Debian-based VM
# Note: Run these commands with sudo if not root. Assumes apt package manager.

echo "Updating package list..."
sudo apt update

echo "Installing MariaDB server and MySQL client..."
sudo apt install -y mariadb-server mariadb-client

echo "Checking MariaDB service status..."
sudo systemctl status mariadb --no-pager

echo "Enabling MariaDB service to start on boot..."
sudo systemctl enable mariadb

echo "Starting MariaDB service..."
sudo systemctl start mariadb

echo "Verifying MariaDB service is running..."
sudo systemctl is-active mariadb

# Removal commands (uncomment to use)
# echo "Stopping MariaDB service..."
# sudo systemctl stop mariadb

# echo "Disabling MariaDB service..."
# sudo systemctl disable mariadb

# echo "Removing MariaDB packages..."
# sudo apt remove --purge -y mariadb-server mariadb-client
# sudo apt remove -y mariadb-server mariadb-client -q

# echo "Removing dependencies no longer needed..."
# sudo apt autoremove -y

# echo "Removing MariaDB data and configuration (optional, use with caution)..."
# sudo rm -rf /var/lib/mysql
# sudo rm -rf /etc/mysql

echo "Installation and service management complete."
