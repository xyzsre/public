

#!/bin/bash

# Simplified Kubernetes Installation Verification Script
# This script verifies Kubernetes installation with SUCCESS/FAILED output only
# Author: Generated from successful Vagrant installation verification
# Usage: bash simple-verification.sh

set -e  # Exit on any error
set -u  # Exit on undefined variables

echo "Kubernetes Installation Verification"
echo "===================================="

# Function to check success or failure
check_status() {
    local test_name="$1"
    local command="$2"
    
    if eval "$command" >/dev/null 2>&1; then
        echo "$test_name: SUCCESS"
        return 0
    else
        echo "$test_name: FAILED"
        return 1
    fi
}

# 1. Check kubectl version
echo "1. Kubernetes Tools:"
check_status "kubectl" "kubectl version --client"
check_status "kubeadm" "kubeadm version"
echo ""

# 2. Check container runtime
echo "2. Container Runtime:"
check_status "containerd installed" "dpkg -l | grep containerd"
check_status "containerd running" "systemctl is-active containerd"
check_status "containerd enabled" "systemctl is-enabled containerd"
echo ""

# 3. Check kubelet service
echo "3. Kubelet Service:"
check_status "kubelet installed" "dpkg -l | grep kubelet"
check_status "kubelet enabled" "systemctl is-enabled kubelet"
echo ""

# 4. Check kernel modules
echo "4. Kernel Modules:"
check_status "overlay module loaded" "lsmod | grep overlay"
check_status "br_netfilter module loaded" "lsmod | grep br_netfilter"
check_status "kernel modules configured" "test -f /etc/modules-load.d/k8s.conf"
echo ""

# 5. Check network configuration
echo "5. Network Configuration:"
check_status "ip_forward enabled" "sysctl -n net.ipv4.ip_forward | grep 1"
check_status "bridge iptables enabled" "sysctl -n net.bridge.bridge-nf-call-iptables | grep 1"
check_status "bridge ip6tables enabled" "sysctl -n net.bridge.bridge-nf-call-ip6tables | grep 1"
check_status "sysctl configured" "test -f /etc/sysctl.d/k8s.conf"
echo ""

# 6. Check swap status
echo "6. Swap Configuration:"
check_status "swap disabled" "! swapon --show | grep -q ."
check_status "swap in fstab disabled" "! grep -q '^[^#].*swap' /etc/fstab"
echo ""

# 7. Check containerd configuration
echo "7. Containerd Configuration:"
check_status "containerd config exists" "test -f /etc/containerd/config.toml"
check_status "systemd cgroup enabled" "grep -q 'SystemdCgroup = true' /etc/containerd/config.toml"
echo ""

# 8. Check Kubernetes repository
echo "8. Kubernetes Repository:"
check_status "k8s repo configured" "test -f /etc/apt/sources.list.d/kubernetes.list"
check_status "k8s gpg key exists" "test -f /etc/apt/keyrings/kubernetes-apt-keyring.gpg"
echo ""

# 9. Check package holds
echo "9. Package Holds:"
check_status "kubectl held" "apt-mark showhold | grep -q kubectl"
check_status "kubeadm held" "apt-mark showhold | grep -q kubeadm"
check_status "kubelet held" "apt-mark showhold | grep -q kubelet"
echo ""

# 10. Check CNI plugins
echo "10. CNI Configuration:"
check_status "kubernetes-cni installed" "dpkg -l | grep kubernetes-cni"
check_status "cri-tools installed" "dpkg -l | grep cri-tools"
echo ""

# 11. Check system resources
echo "11. System Resources:"
check_status "sufficient memory" "[ $(free -m | awk 'NR==2{print $2}') -gt 1500 ]"
check_status "sufficient disk space" "[ $(df / | tail -1 | awk '{print $4}') -gt 1000000 ]"
echo ""

echo "===================================="
echo "Verification Complete!"
echo ""
echo "Expected status:"
echo "- kubelet: FAILED (inactive) - This is normal before cluster init"
echo "- All other checks should show SUCCESS"
