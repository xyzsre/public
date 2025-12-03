#!/bin/bash
# Script to configure passwordless sudo for current user

echo "Configuring passwordless sudo for $(whoami) user..."
echo "$(whoami) ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$(whoami)
sudo chmod 0440 /etc/sudoers.d/$(whoami)
echo "Passwordless sudo configured successfully!"

