#!/bin/bash

# Troubleshooting script for common package management issues on Ubuntu/Debian
# Run with sudo if needed, or as root.

echo "Checking for running apt or dpkg processes..."
# One-liner to kill any running apt or dpkg processes: sudo ps aux | grep -E "(apt|dpkg)" | grep -v grep | awk '{print $2}' | sudo xargs kill -9
sudo ps aux | grep -E "(apt|dpkg)" | grep -v grep | awk '{print $2}' | sudo xargs kill -9 && echo "Killed running apt/dpkg processes." || echo "No running apt/dpkg processes found."

echo "Fixing interrupted dpkg processes..."
# sudo dpkg --configure -a: Completes any pending package installations or configurations
# that were interrupted. This is essential if apt was stopped mid-operation.
sudo dpkg --configure -a

echo "Fixing broken dependencies..."
# sudo apt install -f: Attempts to fix broken dependencies by installing missing packages.
sudo apt install -f

echo "Updating package lists and fixing missing packages..."
# sudo apt update --fix-missing: Updates package lists and downloads missing packages.
sudo apt update --fix-missing

echo "Cleaning up package cache..."
# sudo apt clean: Removes downloaded package files from cache to free space.
sudo apt clean

echo "Autoremoving unused packages..."
# sudo apt autoremove: Removes packages that were installed as dependencies but are no longer needed.
sudo apt autoremove

echo "Troubleshooting complete. Try your original command again."
