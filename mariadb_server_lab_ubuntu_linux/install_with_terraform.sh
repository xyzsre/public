#!/bin/bash

# Script to install MariaDB and MySQL client using Terraform on localhost
# Assumes Terraform is installed. If not, install it first: sudo apt install -y terraform

echo "Initializing Terraform..."
terraform init

echo "Planning Terraform deployment..."
terraform plan

echo "Applying Terraform deployment..."
terraform apply -auto-approve

echo "Checking MariaDB service status after installation..."
sudo systemctl status mariadb --no-pager

echo "Verifying MariaDB is active..."
sudo systemctl is-active mariadb

echo "Testing MySQL client connection..."
sudo mysql -u root -e "SELECT VERSION();"

echo "Installation and testing complete."

# To remove MariaDB, uncomment and run the following:
# echo "Destroying Terraform resources (uninstalling MariaDB)..."
# terraform destroy -auto-approve
