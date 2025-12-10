

#!/bin/bash

# Setup Kubernetes Control Plane with Calico CNI and Metrics
echo "=== SETTING UP KUBERNETES CONTROL PLANE ==="

# 1. Install missing conntrack package
echo "1. Installing conntrack package..."
sudo apt install -y conntrack

# 2. Initialize Kubernetes cluster
echo "2. Initializing Kubernetes cluster..."
sudo kubeadm init --pod-network-cidr=192.168.0.0/16 --apiserver-advertise-address=192.168.56.10

# 3. Setup kubectl for vagrant user
echo "3. Setting up kubectl configuration..."
# To start using your cluster, you need to run the following as a regular user:
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Alternatively, if you are the root user, you can run:
# export KUBECONFIG=/etc/kubernetes/admin.conf

# 4. Install Calico CNI
echo "4. Installing Calico CNI..."
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.28.1/manifests/calico.yaml --validate=false

# 5. Wait for Calico pods to be ready
echo "5. Waiting for Calico pods to be ready..."
kubectl wait --for condition=ready pod -l k8s-app=calico-node -n kube-system --timeout=300s

# 6. Install Metrics Server
echo "6. Installing Metrics Server..."
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml --validate=false

# 7. Wait for Metrics Server to be ready
echo "7. Waiting for Metrics Server to be ready..."
kubectl wait --for condition=ready pod -l k8s-app=metrics-server -n kube-system --timeout=300s

# 8. Remove control-plane taint to allow pods on master
echo "8. Removing control-plane taint..."
kubectl taint nodes --all node-role.kubernetes.io/control-plane-

# 9. Verify cluster status
echo "9. Verifying cluster status..."
kubectl get nodes
kubectl get pods -n kube-system

# 10. Get join command for worker nodes
echo "10. Generating join command for worker nodes..."
kubeadm token create --print-join-command

echo "=== CONTROL PLANE SETUP COMPLETE ==="
