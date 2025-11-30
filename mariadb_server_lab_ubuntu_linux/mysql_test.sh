#!/bin/bash

# MySQL/MariaDB Test and Configuration Script
# This script tests MySQL connection, checks databases and version,
# and configures a test user for remote access on localhost.

echo "=== MySQL/MariaDB Test and Configuration Script ==="
echo ""

# Test 1: Check MySQL version
echo "1. Checking MySQL/MariaDB version..."
sudo mysql -u root -e "SELECT VERSION();"
echo ""

# Test 2: Show available databases
echo "2. Listing all databases..."
sudo mysql -u root -e "SHOW DATABASES;"
echo ""

# Test 3: Login to MySQL (interactive)
echo "3. Logging into MySQL as root (enter password when prompted)..."
echo "   Type 'exit' to quit the MySQL prompt."
sudo mysql -u root
echo ""

# Configuration: Create test user with remote access
echo "4. Creating test user 'testuser' with password 'testuser' for remote access..."
sudo mysql -u root -e "
CREATE USER IF NOT EXISTS 'testuser'@'localhost' IDENTIFIED BY 'testuser';
CREATE USER IF NOT EXISTS 'testuser1'@'%' IDENTIFIED BY 'testuser1';
GRANT ALL PRIVILEGES ON *.* TO 'testuser'@'localhost';
GRANT ALL PRIVILEGES ON *.* TO 'testuser1'@'%';
FLUSH PRIVILEGES;
"
echo "   User 'testuser' created with full privileges."
echo "   Can connect from localhost and any remote host."
echo ""

# Test 4: Test login with new user
echo "5. Testing login with 'testuser' (password: testuser)..."
mysql -u testuser -ptestuser -e "SELECT USER(), VERSION();"
echo ""

# Additional info
echo "=== Configuration Notes ==="
echo "- To connect with MySQL Workbench:"
echo "  - Host: 127.0.0.1"
echo "  - Port: 3306"
echo "  - Username: testuser"
echo "  - Password: testuser"
echo "- For security, consider restricting privileges or using SSH tunneling for remote access."
echo "- Run 'sudo mysql_secure_installation' to secure the root account if not done yet."
echo ""

echo "Script completed!"

