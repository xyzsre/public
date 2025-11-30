#!/bin/bash

# Script to check MariaDB status, installation, processes, and directories

echo "Checking MariaDB service status (no pager)..."
sudo systemctl status mariadb --no-pager

echo -e "\nChecking if MariaDB service is active..."
sudo systemctl is-active mariadb

echo -e "\nChecking if MariaDB is installed via apt..."
apt list --installed | grep mariadb

echo -e "\nFinding MariaDB processes with ps aux..."
ps aux | grep mariadb | grep -v grep

echo -e "\nMariaDB data directory contents (/var/lib/mysql):"
ls -la /var/lib/mysql

echo -e "\nMariaDB config directory contents (/etc/mysql):"
ls -la /etc/mysql

echo -e "\nCheck complete."
