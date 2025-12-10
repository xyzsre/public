
#!/bin/bash

# Kubernetes Installation Script for Ubuntu/Debian Systems
# This script installs all required components for a Kubernetes node
# Author: Generated from successful Vagrant installation
# Usage: sudo bash kubernetes-install.sh

set -e  # Exit on any error
set -u  # Exit on undefined variables

echo "Starting Kubernetes installation..."

# Update package lists to ensure we have the latest package information
# This ensures we get the latest versions of all packages
echo "Updating package lists..."
sudo apt update

# Install container runtime (containerd)
# containerd is the industry-standard container runtime that Kubernetes uses
# to run containers. It's responsible for managing the complete container lifecycle.
echo "Installing containerd container runtime..."
sudo apt install -y containerd

# Create containerd configuration directory
# containerd needs a configuration directory to store its settings
echo "Creating containerd configuration directory..."
sudo mkdir -p /etc/containerd

# Generate default containerd configuration
# This creates a default configuration file that we can then customize
# for Kubernetes requirements
echo "Generating containerd default configuration..."
sudo containerd config default | sudo tee /etc/containerd/config.toml

# Configure containerd to use systemd cgroup driver
# Kubernetes works best with systemd cgroup driver for better integration
# with the host system's process management
echo "Configuring containerd to use systemd cgroup driver..."
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml

# Restart containerd service to apply new configuration
# This makes our configuration changes take effect
echo "Restarting containerd service..."
sudo systemctl restart containerd

# Enable containerd service to start automatically on boot
# This ensures containerd will be available whenever the system reboots
echo "Enabling containerd service..."
sudo systemctl enable containerd

# Load required kernel modules for Kubernetes networking
# overlay: Required for container filesystem layering (overlay filesystems)
# br_netfilter: Required for network bridge filtering in Kubernetes networking
echo "Loading required kernel modules..."
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

# Load the overlay kernel module immediately
# overlay filesystem is essential for container image layers
echo "Loading overlay kernel module..."
sudo modprobe overlay

# Load the br_netfilter kernel module immediately
# br_netfilter is needed for Kubernetes network policies and service proxying
echo "Loading br_netfilter kernel module..."
sudo modprobe br_netfilter

# Configure kernel networking parameters for Kubernetes
# These settings are required for proper Kubernetes networking functionality:
# - bridge-nf-call-iptables: Makes bridge traffic go through iptables for NetworkPolicy
# - bridge-nf-call-ip6tables: Same as above but for IPv6 traffic
# - ip_forward: Enables IP forwarding between network interfaces
echo "Configuring kernel networking parameters..."
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

# Apply all sysctl configurations system-wide
# This makes our networking changes take effect immediately
echo "Applying sysctl configurations..."
sudo sysctl --system

# Disable swap completely
# Kubernetes requires swap to be disabled for proper memory management
# and to ensure pods get the memory they're allocated
echo "Disabling swap..."
sudo swapoff -a

# Permanently disable swap in /etc/fstab
# This prevents swap from being re-enabled on system reboot
echo "Permanently disabling swap in fstab..."
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# Add Kubernetes GPG key for package verification
# This ensures we're downloading authentic Kubernetes packages
echo "Adding Kubernetes GPG key..."
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# Add Kubernetes repository to apt sources
# This allows us to install Kubernetes packages using apt
echo "Adding Kubernetes repository..."
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

# Update package lists to include Kubernetes repository
# This makes apt aware of the new Kubernetes packages
echo "Updating package lists with Kubernetes repository..."
sudo apt update

# Install Kubernetes components
# kubelet: The node agent that runs on each node and manages containers
# kubeadm: The command-line tool for bootstrapping a Kubernetes cluster
# kubectl: The command-line tool for interacting with a Kubernetes cluster
echo "Installing Kubernetes components (kubelet, kubeadm, kubectl)..."
sudo apt install -y kubelet kubeadm kubectl

# Hold Kubernetes packages to prevent automatic updates
# This prevents unexpected version upgrades that could break the cluster
# Kubernetes upgrades should be done manually and carefully
echo "Holding Kubernetes packages to prevent automatic updates..."
sudo apt-mark hold kubelet kubeadm kubectl

# Enable kubelet service to start automatically
# kubelet needs to be running for the node to participate in the cluster
echo "Enabling kubelet service..."
sudo systemctl enable kubelet

echo ""
echo "Installing conntrack package (required for kubeadm)..."
sudo apt install -y conntrack

# Verify installation by checking versions
echo "Verifying Kubernetes installation..."
echo "kubectl version:"
kubectl version --client
echo ""
echo "kubeadm version:"
kubeadm version
echo ""
echo "containerd status:"
sudo systemctl status containerd --no-pager
echo ""
echo "kubelet status (should be inactive until cluster init):"
sudo systemctl status kubelet --no-pager

echo ""
echo "Kubernetes installation completed successfully!"
echo "This node is now ready to join a Kubernetes cluster."
echo "To initialize a cluster as control plane, run: sudo kubeadm init"
echo "To join an existing cluster, get the join command from the control plane node."


