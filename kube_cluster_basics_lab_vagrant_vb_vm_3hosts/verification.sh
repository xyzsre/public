
#!/bin/bash

# Kubernetes Installation Verification Script
# This script verifies that all Kubernetes components are properly installed and configured
# Author: Generated from successful Vagrant installation verification
# Usage: bash verification.sh

set -e  # Exit on any error
set -u  # Exit on undefined variables

echo "Starting Kubernetes installation verification..."
echo "=============================================="

# Verify Kubernetes package versions
# This checks that kubectl, kubeadm, and kubelet are installed and shows their versions
echo "1. Checking Kubernetes package versions..."
echo "kubectl version:"
kubectl version --client
echo ""
echo "kubeadm version:"
kubeadm version
echo ""

# Verify container runtime status
# containerd must be running for Kubernetes to work properly
echo "2. Checking containerd service status..."
sudo systemctl status containerd --no-pager -l
echo ""

# Verify kubelet service status
# kubelet should be enabled but inactive until cluster initialization
echo "3. Checking kubelet service status..."
sudo systemctl status kubelet --no-pager -l
echo ""

# Verify installed packages
# This confirms all required Kubernetes packages are installed
echo "4. Verifying installed packages..."
echo "Installed Kubernetes and container runtime packages:"
sudo apt list --installed | grep -E '(containerd|kubelet|kubeadm|kubectl|cri-tools|kubernetes-cni)' | awk -F'/' '{print $1}'
echo ""

# Verify kernel modules are loaded
# overlay and br_netfilter are required for Kubernetes networking and storage
echo "5. Checking loaded kernel modules..."
echo "Loaded kernel modules:"
lsmod | grep -E '(overlay|br_netfilter)'
echo ""

# Verify kernel modules configuration persistence
# These modules should be configured to load on boot
echo "6. Checking kernel modules configuration..."
if [ -f /etc/modules-load.d/k8s.conf ]; then
    echo "Kernel modules configuration (/etc/modules-load.d/k8s.conf):"
    cat /etc/modules-load.d/k8s.conf
else
    echo "WARNING: /etc/modules-load.d/k8s.conf not found"
fi
echo ""

# Verify sysctl networking parameters
# These settings are required for Kubernetes networking
echo "7. Checking sysctl networking parameters..."
echo "Current sysctl values for Kubernetes networking:"
sysctl net.bridge.bridge-nf-call-iptables net.bridge.bridge-nf-call-ip6tables net.ipv4.ip_forward
echo ""

# Verify sysctl configuration persistence
# These settings should persist across reboots
echo "8. Checking sysctl configuration files..."
if [ -f /etc/sysctl.d/k8s.conf ]; then
    echo "Sysctl configuration (/etc/sysctl.d/k8s.conf):"
    cat /etc/sysctl.d/k8s.conf
else
    echo "WARNING: /etc/sysctl.d/k8s.conf not found"
fi
echo ""

# Verify swap is disabled
# Kubernetes requires swap to be disabled for proper memory management
echo "9. Checking swap status..."
echo "Memory and swap usage:"
free -h
echo ""

# Verify swap is permanently disabled in fstab
# This prevents swap from being re-enabled on reboot
echo "10. Checking fstab swap configuration..."
echo "Swap entries in /etc/fstab (should be commented out):"
grep -E "(swap)" /etc/fstab || echo "No swap entries found (good)"
echo ""

# Verify containerd configuration
# containerd must be configured to use systemd cgroup driver
echo "11. Checking containerd configuration..."
if [ -f /etc/containerd/config.toml ]; then
    echo "containerd systemd cgroup configuration:"
    grep "SystemdCgroup" /etc/containerd/config.toml
else
    echo "WARNING: /etc/containerd/config.toml not found"
fi
echo ""

# Verify Kubernetes repository configuration
# This ensures we can receive Kubernetes package updates
echo "12. Checking Kubernetes repository configuration..."
if [ -f /etc/apt/sources.list.d/kubernetes.list ]; then
    echo "Kubernetes repository configuration:"
    cat /etc/apt/sources.list.d/kubernetes.list
else
    echo "WARNING: /etc/apt/sources.list.d/kubernetes.list not found"
fi
echo ""

# Verify Kubernetes GPG key
# This ensures package authenticity
echo "13. Checking Kubernetes GPG key..."
if [ -f /etc/apt/keyrings/kubernetes-apt-keyring.gpg ]; then
    echo "Kubernetes GPG key found:"
    ls -la /etc/apt/keyrings/kubernetes-apt-keyring.gpg
else
    echo "WARNING: Kubernetes GPG key not found"
fi
echo ""

# Verify package holds
# Kubernetes packages should be held to prevent automatic updates
echo "14. Checking Kubernetes package holds..."
echo "Package holds (Kubernetes packages should be held):"
apt-mark showhold | grep -E '(kubelet|kubeadm|kubectl)' || echo "No package holds found"
echo ""

# Verify network interfaces
# Kubernetes nodes need proper network configuration
echo "15. Checking network interfaces..."
echo "Network interfaces:"
ip addr show
echo ""

# Verify iptables rules
# Kubernetes uses iptables for networking and service proxying
echo "16. Checking iptables rules..."
echo "Current iptables rules:"
sudo iptables -L -n -v | head -20
echo ""

# Verify system resources
# Kubernetes nodes should meet minimum resource requirements
echo "17. Checking system resources..."
echo "CPU and memory info:"
lscpu | grep -E "(Model name|CPU\(s\)|Thread)"
echo ""
echo "Memory info:"
free -h
echo ""

# Verify disk space
# Kubernetes nodes need sufficient disk space for containers and images
echo "18. Checking disk space..."
echo "Disk usage:"
df -h
echo ""

# Final summary
echo "=============================================="
echo "Kubernetes Installation Verification Complete!"
echo ""
echo "If all checks passed, the node is ready for:"
echo "- Cluster initialization: sudo kubeadm init"
echo "- Joining existing cluster: kubeadm join <control-plane-ip>:<port> --token <token> --discovery-token-ca-cert-hash <hash>"
echo ""
echo "Expected status:"
echo "- containerd: Active (running)"
echo "- kubelet: Inactive (dead) - This is normal before cluster init"
echo "- Swap: 0B (disabled)"
echo "- Kernel modules: overlay and br_netfilter loaded"
echo "- Network settings: IP forwarding and bridge filtering enabled"
