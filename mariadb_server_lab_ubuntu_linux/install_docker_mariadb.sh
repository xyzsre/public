#!/bin/bash

# Install Docker and Docker Compose, then bring up MariaDB via Docker Compose

echo "=== Installing Docker and Docker Compose ==="

# Update package list
sudo apt update

# Install Docker
sudo apt install -y docker-compose

# Start and enable Docker
sudo systemctl start docker
sudo systemctl enable docker

# Add current user to docker group (optional, but recommended)
sudo usermod -aG docker $USER

echo "=== Bringing up MariaDB with Docker Compose ==="

# Navigate to the directory with docker-compose.yml (assuming current dir)
cd /home/devops/Desktop/TEST

# Bring up the services
sudo docker-compose up -d

echo "=== Listing Docker containers ==="

# List all containers
sudo docker ps -a

echo "=== Setup Complete ==="
echo "Connect to MariaDB at localhost:8000 with user root, password root."
echo "Note: You may need to log out and back in for docker group changes to take effect."


