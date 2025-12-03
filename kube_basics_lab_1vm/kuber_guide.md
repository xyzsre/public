

# Kubernetes Installation Guide - Ubuntu 22 and 24
# Kubernetes Basics
# KCNA Basics - Practical LAB
# Fundamentals >> Network / System / DevOps / SRE / Cloud / Platform Engineers
# Kubernetes >> How to ??! 
# Test and try it >> VMware / Virtual-Box / Vagrant / AWS / GCP / Azure / Digital-Ocean / Upcloud / Linode / Vultr / ...


---

## 📋 **Table of Contents**
- [Introduction to Kubernetes](#introduction-to-kubernetes)
- [Kubernetes Components Overview](#kubernetes-components-overview-kcna-topics)
- [System Preparation](#system-preparation)
- [Container Runtime Setup](#container-runtime-setup)
- [Kubernetes Installation](#kubernetes-installation)
- [System Configuration](#system-configuration-for-kubernetes)
- [Cluster Initialization](#cluster-initialization)
- [Networking Setup](#networking-setup-with-calico)
- [Final Verification](#final-verification)
- [Troubleshooting Guide](#troubleshooting-guide-issues-found-fixed)

---

## 🚀 **Introduction to Kubernetes**

### What is Kubernetes?

**Kubernetes** (often abbreviated as **K8s**) is an open-source container orchestration platform designed to automate the deployment, scaling, and management of containerized applications. Originally developed by Google and now maintained by the Cloud Native Computing Foundation (CNCF), Kubernetes provides a framework for running distributed systems resiliently.

At its core, Kubernetes is a **container orchestrator** that manages:
- **Container deployment** - Automatically places containers based on resource requirements
- **Scaling** - Horizontally scales applications up or down based on demand
- **Load balancing** - Distributes traffic across multiple instances
- **Self-healing** - Restarts failed containers, replaces unhealthy instances
- **Service discovery** - Enables communication between different parts of applications
- **Storage orchestration** - Automatically mounts storage systems of your choice

### Why is Kubernetes Important?

#### 🔄 **The Container Revolution**
Before Kubernetes, managing containerized applications at scale was extremely challenging. Teams had to manually:
- Deploy containers across multiple servers
- Handle networking between containers
- Manage storage volumes
- Monitor application health
- Scale applications manually
- Handle failures and recovery

Kubernetes solves these problems by providing:
- **Declarative configuration** - You describe what you want, Kubernetes makes it happen
- **Automated operations** - No more manual intervention for routine tasks
- **Resource optimization** - Better utilization of infrastructure resources
- **Faster deployment cycles** - Applications can be deployed in minutes, not days
- **Improved reliability** - Built-in health checks and self-healing capabilities

#### 📊 **Industry Adoption**
- **Market Leader**: Used by 91% of Fortune 500 companies (CNCF Survey 2023)
- **Cloud Native Standard**: De facto standard for cloud-native applications
- **Ecosystem**: Largest open-source community with 3000+ contributors
- **Multi-Cloud**: Works across all major cloud providers and on-premises

### Key Use Cases

#### 1. **Microservices Architecture**
- Deploy and manage complex applications composed of dozens of microservices
- Automatic service discovery and load balancing between services
- Independent scaling of different components

#### 2. **CI/CD Pipelines**
- Automated deployment of applications from development to production
- Blue-green deployments and canary releases
- Rollback capabilities for failed deployments

#### 3. **Hybrid and Multi-Cloud Deployments**
- Run applications across multiple cloud providers or on-premises
- Avoid vendor lock-in with consistent deployment experience
- Disaster recovery and high availability across regions

#### 4. **Machine Learning and AI Workloads**
- Distributed training of ML models across multiple nodes
- GPU resource management and scheduling
- Model serving with automatic scaling

#### 5. **Database and Stateful Applications**
- Run databases, message queues, and other stateful applications
- Persistent storage management
- Backup and recovery automation

### Main Components

#### 🎛️ **Control Plane Components**
- **API Server**: Central management point, accepts and processes requests
- **etcd**: Distributed key-value store for cluster state and configuration
- **Scheduler**: Assigns pods to worker nodes based on resource requirements
- **Controller Manager**: Runs controllers that regulate cluster state
- **Cloud Controller Manager**: Integrates with cloud provider APIs

#### 🖥️ **Node Components**
- **Kubelet**: Agent running on each node, manages containers
- **Kube-Proxy**: Network proxy that maintains network rules on nodes
- **Container Runtime**: Software responsible for running containers (Docker, containerd, CRI-O)

#### 📦 **Objects and Resources**
- **Pods**: Smallest deployable units, contain one or more containers
- **Deployments**: Manage replica sets and provide declarative updates
- **Services**: Provide stable network endpoints for pods
- **ConfigMaps/Secrets**: Store configuration data and sensitive information
- **PersistentVolumes**: Abstract storage resources
- **Namespaces**: Virtual clusters within a physical cluster

### VM Recommendations

#### 💻 **1 VM Setup (Development/Learning)**
**Best for**: Learning Kubernetes, development environments, proof-of-concepts

**Pros:**
- Minimal resource requirements (2-4 CPU cores, 4-8 GB RAM)
- Quick setup and experimentation
- Cost-effective for learning

**Cons:**
- No high availability
- Single point of failure
- Limited scalability testing
- Cannot test multi-node scenarios

**Use Cases:**
- Learning Kubernetes concepts
- Local development
- CI/CD testing
- Personal projects

#### 🖥️ **3 VM Setup (Production Small/Medium)**
**Best for**: Small production applications, development teams, staging environments

**Configuration:**
- 1 Control Plane Node
- 2 Worker Nodes
- Load balancer (optional, can use kube-proxy)

**Pros:**
- Basic high availability for control plane
- Can test multi-node scenarios
- Production-like environment
- Room for application scaling

**Cons:**
- Control plane not fully HA (needs 3+ nodes for etcd quorum)
- Still vulnerable to zone failures

**Use Cases:**
- Small production applications
- Development teams
- Staging environments
- Testing multi-node features

#### 🗄️ **5+ VM Setup (Production Enterprise)**
**Best for**: Large-scale production, mission-critical applications, enterprise environments

**Recommended Configuration:**
- 3 Control Plane Nodes (for etcd quorum and HA)
- 2+ Worker Nodes (scale based on workload)
- External load balancer (HAProxy, NGINX, or cloud load balancer)
- Dedicated etcd cluster (optional, can run on control plane)

**Pros:**
- Full high availability
- Can survive node failures
- Enterprise-grade reliability
- Advanced features testing
- Production-ready security

**Cons:**
- Higher resource requirements
- More complex management
- Increased operational overhead

**Use Cases:**
- Large-scale production applications
- Mission-critical systems
- Enterprise environments
- High-traffic applications
- Multi-tenant platforms

### Hardware Requirements

#### Minimum Requirements (1 VM):
- CPU: 2 cores
- RAM: 4 GB
- Storage: 20 GB
- Network: 1 Gbps

#### Recommended Production (3+ VMs):
- CPU: 4+ cores per node
- RAM: 8-16 GB per node
- Storage: 50+ GB per node (SSD preferred)
- Network: 10 Gbps between nodes

### Getting Started

This guide demonstrates setting up a **single-node Kubernetes cluster** perfect for learning and development. The concepts and commands learned here apply directly to multi-node production clusters.

---

This guide documents the exact steps performed to install and configure a single-node Kubernetes cluster on Ubuntu 24.04.3 LTS using kubeadm, containerd, and Calico networking. Each section includes explanations of why each step was necessary before showing the commands executed.


## System Preparation

### 1. Configure Sudo Access
**Why:** Kubernetes installation requires running many commands as root/administrator. We need passwordless sudo access to avoid being prompted for passwords during the automated installation process.

**Created script file:** `setup_sudo.sh`
```bash
#!/bin/bash
# Script to configure passwordless sudo for current user

echo "Configuring passwordless sudo for $(whoami) user..."
echo "$(whoami) ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$(whoami)
sudo chmod 0440 /etc/sudoers.d/$(whoami)
echo "Passwordless sudo configured successfully!"
```

**Commands executed:**
```bash
chmod +x setup_sudo.sh  # Make script executable
sudo ./setup_sudo.sh    # Run script with sudo to configure passwordless access
sudo whoami             # Verify sudo works without password prompt
```


### 2. Update System Packages
**Why:** Ensures all system packages are up-to-date before installing new software. This prevents compatibility issues and provides the latest security patches.

```bash
sudo apt update && sudo apt upgrade -y
```

### 3. Install Prerequisites
**Why:** These tools are required for downloading, verifying, and managing packages during the Kubernetes installation process. Conntrack is specifically needed for Kubernetes networking.

```bash
sudo apt install -y curl apt-transport-https ca-certificates gnupg lsb-release conntrack
```

## Container Runtime Setup

### Install containerd
**Why:** Kubernetes requires a container runtime to run containers. Containerd is the recommended runtime that provides the Container Runtime Interface (CRI) that Kubernetes uses.

```bash
sudo apt install -y containerd
```

### Configure containerd
**Why:** Containerd needs to be configured with systemd cgroup driver to properly manage container resources and integrate with Kubernetes' resource management.

```bash
# Create default configuration
sudo mkdir -p /etc/containerd
sudo containerd config default | sudo tee /etc/containerd/config.toml
cat /etc/containerd/config.toml

# Enable systemd cgroup driver (required for Kubernetes)
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml
cat /etc/containerd/config.toml | grep SystemdCgroup

# Restart and enable containerd to apply configuration
sudo systemctl restart containerd
sudo systemctl enable containerd
sudo systemctl status containerd --no-pager
```

## Kubernetes Installation

### Add Kubernetes Repository
**Why:** We need to add the official Kubernetes repository to access the latest stable versions of Kubernetes components. This provides secure package management through apt.

```bash
# Download and install the GPG key for package verification
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# Add the Kubernetes repository to apt sources
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
```

### Install Kubernetes Components
**Why:** Install the three core Kubernetes components: kubelet (node agent), kubeadm (cluster bootstrap tool), and kubectl (command-line client).

```bash
sudo apt update  # Update package lists to include new repository
sudo apt install -y kubelet kubeadm kubectl  # Install all three Kubernetes components
```

## System Configuration for Kubernetes

### Disable Swap
**Why:** Kubernetes requires swap to be disabled because it can cause performance issues and unpredictable behavior with container scheduling and resource management.

```bash
# Disable swap temporarily for current session
sudo swapoff -a

# Disable swap permanently by commenting it out in fstab
cat /etc/fstab
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
```

### Load Required Kernel Modules
**Why:** These kernel modules are required for container networking and overlay filesystems that Kubernetes uses for pod networking and container storage.

```bash
sudo modprobe overlay    # Required for overlay filesystem used by containerd
sudo modprobe br_netfilter  # Required for bridge network filtering
```

### Configure Kernel Modules to Load on Boot
**Why:** Ensures the required kernel modules are automatically loaded every time the system boots, so Kubernetes works after reboots.

```bash
echo -e "overlay\nbr_netfilter" | sudo tee /etc/modules-load.d/k8s.conf
cat /etc/modules-load.d/k8s.conf
```

### Configure Sysctl Parameters
**Why:** These network parameters enable proper routing and bridging for Kubernetes pod networking and allow packets to flow between containers and the outside world.

```bash
# Configure network parameters for Kubernetes networking
echo -e "net.bridge.bridge-nf-call-iptables = 1\nnet.bridge.bridge-nf-call-ip6tables = 1\nnet.ipv4.ip_forward = 1" | sudo tee /etc/sysctl.d/k8s.conf

cat /etc/sysctl.d/k8s.conf

# Apply the sysctl configuration changes
sudo sysctl --system

```

### Start and Enable kubelet
**Why:** Kubelet is the primary node agent that runs on each node and manages containers. It needs to be running for the node to join the cluster.

```bash
sudo systemctl enable kubelet  # Enable kubelet to start on boot
sudo systemctl start kubelet   # Start kubelet service
sudo systemctl status kubelet --no-pager
```

## Cluster Initialization

### Initialize Control Plane
**Why:** This command creates the Kubernetes control plane, generates all necessary certificates, sets up the API server, controller manager, scheduler, and etcd database. The pod network CIDR specifies the IP range for pod networking.

```bash
sudo kubeadm init --pod-network-cidr=192.168.0.0/16
```

**What this command did:**
- Created Kubernetes control plane components (API server, controller manager, scheduler)
- Generated all necessary TLS certificates
- Set up etcd database for cluster state storage
- Created kubeconfig files for cluster access
- Displayed the kubeadm join command for adding worker nodes

### Configure kubectl Access
**Why:** Kubectl needs a configuration file (kubeconfig) to authenticate with the Kubernetes API server. We copy the admin configuration and set proper permissions.


```bash
mkdir -p $HOME/.kube  # Create directory for kubeconfig files
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config  # Copy admin kubeconfig
sudo chown $(id -u):$(id -g) $HOME/.kube/config  # Set ownership to current user
```

**Verification:**
```bash
sudo systemctl status kubelet --no-pager
kubectl cluster-info    # Check if API server is accessible
kubectl get nodes       # List cluster nodes (showed as NotReady until networking installed)
```

### Remove Control Plane Taint (Single-Node Clusters)
**Why:** In single-node Kubernetes clusters, the control-plane node has a taint that prevents regular user pods from scheduling. For testing and development purposes, you may want to remove this taint.

**Note:** This step is optional but recommended for single-node clusters where you want to run user workloads on the control plane node.

```bash
kubectl taint nodes <node-name> node-role.kubernetes.io/control-plane:NoSchedule-
```

**Example:**
```bash
hostname
kubectl taint nodes devops node-role.kubernetes.io/control-plane:NoSchedule-
kubectl taint nodes host1 node-role.kubernetes.io/control-plane:NoSchedule-
```

## Networking Setup with Calico

### Install Calico Operator
**Why:** Calico is a networking and network security solution for containers and Kubernetes. The operator manages the lifecycle of Calico components in the cluster.

```bash
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.29.1/manifests/tigera-operator.yaml
```

### Install Calico Custom Resources
**Why:** These custom resources define the Calico installation configuration, including the pod network CIDR and other networking settings.

```bash
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.29.1/manifests/custom-resources.yaml
```

### Wait for Networking to Deploy
**Why:** Calico components take time to download images and configure networking. We wait to ensure all networking pods are running before proceeding.

```bash
sleep 180  # Wait 3 minutes for Calico to fully deploy and configure
kubectl get nodes  # Check if node status changed to Ready
```

## Final Verification

### Check Cluster Status
**Why:** Verify that all components are working correctly and the cluster is fully operational.

```bash
kubectl cluster-info    # Verify control plane is accessible
kubectl get nodes       # Check node readiness status
kubectl get pods -A     # Verify all system pods are running
```

**Final cluster state achieved:**
- **Kubernetes control plane**: Running at ...
- **CoreDNS**: Running (provides DNS resolution for services)
- **Node '??'**: Ready with control-plane role
- **Calico networking**: Operational (enables pod-to-pod communication)


## Kubernetes Components Overview (KCNA Topics)

This section covers the core Kubernetes components for beginners, explaining what each component does and how to test them with kubectl commands.


## Kubernetes Components Explained (KCNA Topics)

Now that our cluster is running, let's explore and test each Kubernetes component. This section covers the core components you'll need to understand for KCNA certification, organized by topic areas.

### Control Plane Components

#### API Server
**What it does:** The API Server is the front-end for the Kubernetes control plane. It exposes the Kubernetes API, validates requests, and acts as the gateway to the cluster.

**Test Commands:**
```bash
# Check API server endpoint and overall cluster status
kubectl cluster-info

# Get Kubernetes version information for client and server
kubectl version
```

#### etcd
**What it does:** etcd is a distributed key-value store that Kubernetes uses to store all cluster data. It's the single source of truth for the cluster state.

**Test Commands:**
```bash
# Check if etcd pod is running in the kube-system namespace
kubectl get pods -n kube-system | grep etcd

# Get detailed information about the etcd pod configuration and status
kubectl describe pod etcd-host1 -n kube-system
```

#### Scheduler
**What it does:** The Scheduler assigns pods to nodes based on resource requirements, constraints, and policies.

**Test Commands:**
```bash
# Check if the scheduler pod is running in the kube-system namespace
kubectl get pods -n kube-system | grep scheduler

# Get detailed information about the scheduler pod configuration and status
kubectl describe pod kube-scheduler-host1 -n kube-system
```

#### Controller Manager
**What it does:** Runs controller processes that regulate the state of the cluster (like replication controllers, endpoints controllers, etc.).

**Test Commands:**
```bash
# Check if the controller manager pod is running in the kube-system namespace
kubectl get pods -n kube-system | grep controller-manager

# Get detailed information about the controller manager pod configuration and status
kubectl describe pod kube-controller-manager-host1 -n kube-system
```

### Node Components

#### kubelet
**What it does:** The kubelet is the primary node agent that runs on each node. It ensures containers are running in pods and manages node resources.

**Test Commands:**
```bash
# Check the status of the kubelet systemd service
sudo systemctl status kubelet --no-pager

# Get detailed information about cluster nodes including their status, version, and runtime
kubectl get nodes -o wide
```

#### kube-proxy
**What it does:** kube-proxy maintains network rules on nodes to allow network communication to pods from network sessions inside/outside the cluster.

**Test Commands:**
```bash
# Check if kube-proxy pod is running in the kube-system namespace
kubectl get pods -n kube-system | grep kube-proxy

# Get detailed information about the kube-proxy pod configuration and status
kubectl describe pod kube-proxy-sntwn -n kube-system
```

#### Container Runtime (containerd)
**What it does:** The container runtime runs containers. In our setup, containerd provides the CRI (Container Runtime Interface) for Kubernetes.

**Test Commands:**
```bash
# Check the status of the containerd systemd service
sudo systemctl status containerd --no-pager

# Get the version of containerd to verify it's properly installed
sudo containerd --version
```

### Add-ons and Services

#### CoreDNS
**What it does:** CoreDNS provides DNS-based service discovery for Kubernetes services and pods.

**Test Commands:**
```bash
# Check if CoreDNS pods are running in the kube-system namespace
kubectl get pods -n kube-system | grep coredns

# Get details about the CoreDNS service configuration and endpoints
kubectl get service kube-dns -n kube-system
```

#### Calico (Networking)
**What it does:** Calico provides networking and network policy for Kubernetes clusters.

**Test Commands:**
```bash
# Check the status of all Calico-related pods in the calico-system namespace
kubectl get pods -n calico-system

# Check the status of the Calico operator in the tigera-operator namespace
kubectl get pods -n tigera-operator
```

### Basic Kubernetes Resources

#### Pods
**What it does:** Pods are the smallest deployable units in Kubernetes. A pod encapsulates one or more containers, storage resources, and network identity.

**Basic Pod Operations:**
```bash
# List all pods across all namespaces
kubectl get pods -A

# Create a simple pod (basic-pod.yaml)
kubectl apply -f basic-pod.yaml

kubectl get pods

# Get detailed information about a pod
kubectl describe pod basic-pod

# View pod logs (shows the pod is running successfully)
kubectl logs basic-pod

# Check pod status
kubectl get pods

# Execute commands inside a running pod
kubectl exec basic-pod -- echo "Hello from inside the pod"
kubectl exec basic-pod -- pwd
kubectl exec basic-pod -- ls -anp
kubectl exec basic-pod -- ip addr
kubectl exec basic-pod -- ip route
kubectl exec basic-pod -- ping -c 3 google.com


# Delete a pod
kubectl delete pod basic-pod
```

### Multi-Container Pods
**What it does:** A pod can contain multiple containers that share the same network namespace, volumes, and lifecycle. Common patterns include sidecar containers for logging, monitoring, or service mesh proxies.

**Test Commands:**
```bash
# Create a simple multi-container pod (simple-multi-pod.yaml)
kubectl apply -f simple-multi-pod.yaml

# Check pod status (shows 2/2 containers running)
kubectl get pods

# View logs from specific containers
kubectl logs simple-multi-pod -c main
kubectl logs simple-multi-pod -c sidecar

# Get detailed pod information showing both containers
kubectl describe pod simple-multi-pod
kubectl describe pod simple-multi-pod | grep Normal


# Clean up multi-container pod
kubectl delete pod simple-multi-pod
```

### Init Containers
**What it does:** Init containers run before the main application containers start. They're useful for setup tasks like database migrations, downloading dependencies, or waiting for services to be ready.

**Test Commands:**
```bash
# Create a pod with init container (simple-init-pod.yaml)
kubectl apply -f simple-init-pod.yaml

# Check pod status - shows PodInitializing while init runs, then Running
kubectl get pods

# View init container logs (runs first)
kubectl logs simple-init-pod -c init-wait

# View main container logs (runs after init completes)
kubectl logs simple-init-pod -c main

# Get detailed pod information showing init container status
kubectl describe pod simple-init-pod

# Clean up init container pod
kubectl delete pod simple-init-pod
```


### Environment Variables
**What it does:** Environment variables pass configuration data to containers without hardcoding values in the application code.

**Test Commands:**
```bash
# Create a pod with environment variables
kubectl run env-pod --image=busybox --restart=Never --env=APP_NAME=myapp --env=APP_VERSION=1.0 -- sh -c 'echo "App: $APP_NAME, Version: $APP_VERSION" && sleep 60'

# Check environment variables in running pod
kubectl exec env-pod -- env | grep APP_
kubectl exec env-pod -- env

# Clean up environment pod
kubectl delete pod env-pod
```

### DNS Resolution and Service Discovery
**What it does:** Kubernetes provides built-in DNS service discovery. Every service gets a DNS name, and pods can resolve service names to IP addresses.

**Test Commands:**
```bash
# Create test pods
kubectl run dns-test-1 --image=busybox --restart=Never -- sleep 300
kubectl run dns-test-2 --image=busybox --restart=Never -- sleep 300

kubectl get pods
kubectl get pods -o wide

# Test DNS resolution of the kubernetes service
kubectl exec dns-test-1 -- nslookup kubernetes.default.svc.cluster.local
kubectl exec dns-test-1 -- nslookup google.com



# Clean up test pods
kubectl delete pod dns-test-1 dns-test-2
```

### Pod-to-Pod Communication
**What it does:** Pods in the same cluster can communicate directly using their IP addresses through the cluster network provided by CNI (Container Network Interface).

**Test Commands:**
```bash
# Create test pods
kubectl run comm-test-1 --image=busybox --restart=Never -- sleep 300
kubectl run comm-test-2 --image=busybox --restart=Never -- sleep 300

# Get pod IP addresses
kubectl get pods -o wide

# Test direct pod-to-pod communication
POD_IP=$(kubectl get pod comm-test-2 -o jsonpath='{.status.podIP}')
kubectl exec comm-test-1 -- ping -c 3 $POD_IP

# Clean up test pods
kubectl delete pod comm-test-1 comm-test-2
```

### CPU and Memory Resource Management
**What it does:** Kubernetes allows setting resource requests (minimum guaranteed resources) and limits (maximum allowed resources) for CPU and memory to ensure proper resource allocation.

**Test Commands:**
```bash
# Create a pod with CPU and memory resource limits (resource-limits-pod.yaml)
kubectl apply -f resource-limits-pod.yaml

# Check pod resource allocation
kubectl describe pod resource-limits-pod | grep -A 5 "Requests:"
kubectl describe pod resource-limits-pod

# View node resource capacity
kubectl describe node host1
kubectl describe node host1 | grep -A 5 "Capacity:"

# Clean up pod
kubectl delete pod resource-limits-pod
```

### EmptyDir Volumes
**What it does:** EmptyDir volumes provide temporary storage that exists for the lifetime of a pod. Data is lost when the pod is deleted, but shared between containers in the same pod.

**Test Commands:**
```bash
# Create a pod with EmptyDir volume (emptydir-pod.yaml)
kubectl apply -f emptydir-pod.yaml

# Check the logs to see volume usage
kubectl logs emptydir-pod

# Verify data persistence during pod lifetime
kubectl exec emptydir-pod -- cat /tmp/data/file.txt

# Clean up pod
kubectl delete pod emptydir-pod
```

### Labels and Label-Based Operations
**What it does:** Labels are key-value pairs attached to Kubernetes objects. They are used for organization, selection, and grouping of resources.

**Test Commands:**
```bash
# Create a pod with labels
kubectl run labeled-pod --image=busybox --restart=Never --labels=app=myapp,env=test -- sleep 300

# Show labels on all pods
kubectl get pods --show-labels

# Filter pods by label
kubectl get pods -l app=myapp
kubectl get pods -l env=test

# Add a label to an existing pod
kubectl label pod labeled-pod team=devops

# Filter by multiple labels
kubectl get pods -l app=myapp,team=devops

# Clean up pod
kubectl delete pod labeled-pod
```

### Service Types
**What it does:** Kubernetes provides different service types for exposing applications: ClusterIP (internal), NodePort (external on node ports), and LoadBalancer (external load balancer).

**Test Commands:**
```bash
# Create a pod to expose
kubectl run web-pod --image=nginx --labels=app=web

kubectl get pods
kubectl describe pod web-pod | grep kubelet

# Expose as ClusterIP service (default)
kubectl expose pod web-pod --port=80 --type=ClusterIP --name=clusterip-service

# Expose as NodePort service
kubectl expose pod web-pod --port=80 --type=NodePort --name=nodeport-service

# Expose as LoadBalancer service (shows concept, may not get external IP)
kubectl expose pod web-pod --port=80 --type=LoadBalancer --name=loadbalancer-service

# List all services
kubectl get services

# Get detailed service information
kubectl describe service nodeport-service

# Clean up resources
kubectl delete pod web-pod
kubectl delete service clusterip-service nodeport-service loadbalancer-service
```

### Storage Classes
**What it does:** Storage Classes define different types of storage available in the cluster and determine how Persistent Volumes are dynamically provisioned.

**Test Commands:**
```bash
# View available storage classes
kubectl get storageclass

# Create a custom storage class for local storage (storage-class.yaml)
kubectl apply -f storage-class.yaml

# Check storage class creation
kubectl get storageclass

# Clean up storage class
kubectl delete storageclass local-storage
```

### CoreDNS Configuration
**What it does:** CoreDNS is the DNS server for Kubernetes clusters, providing service discovery and name resolution for pods and services.

**Test Commands:**
```bash
# View CoreDNS configuration
kubectl get configmap coredns -n kube-system -o yaml

# Check CoreDNS service details
kubectl get service kube-dns -n kube-system

# View CoreDNS pod logs
kubectl logs -n kube-system deployment/coredns

# Check CoreDNS metrics endpoint (if available)
kubectl port-forward -n kube-system svc/kube-dns 9153:9153 &
# Then access http://localhost:9153/metrics
```

### DNS Troubleshooting
**What it does:** DNS issues can prevent service discovery and pod-to-pod communication. Understanding DNS troubleshooting is crucial for KCNA.

**Test Commands:**
```bash
# Test internal DNS resolution
kubectl run dns-test --image=busybox --restart=Never --rm -it -- nslookup kubernetes.default.svc.cluster.local

# Test external DNS resolution
kubectl run dns-external --image=busybox --restart=Never --rm -it -- nslookup google.com

# Check DNS service configuration
kubectl get service kube-dns -n kube-system -o yaml

# Debug DNS from within a pod
kubectl run debug-pod --image=busybox --restart=Never --rm -it -- sh
# Inside pod: nslookup kubernetes.default.svc.cluster.local
# Inside pod: cat /etc/resolv.conf
```

### Pod-to-Pod Network Connectivity
**What it does:** Kubernetes networking ensures pods can communicate with each other across the cluster through the Container Network Interface (CNI).

**Test Commands:**
```bash
# Create test pods for network testing
kubectl run net-test-1 --image=busybox --restart=Never -- sleep 300
kubectl run net-test-2 --image=busybox --restart=Never -- sleep 300

# Check pod IP addresses
kubectl get pods -o wide

# Test direct pod-to-pod connectivity
POD_IP=$(kubectl get pod net-test-2 -o jsonpath='{.status.podIP}')
kubectl exec net-test-1 -- ping -c 3 $POD_IP

# Test network connectivity to external services
kubectl exec net-test-1 -- wget -q -O - http://httpbin.org/ip

# Clean up test pods
kubectl delete pod net-test-1 net-test-2
```

### Health Checks and Monitoring
**What it does:** Kubernetes provides built-in health checking through liveness and readiness probes, along with resource monitoring capabilities.

**Test Commands:**
```bash
# Create a pod with comprehensive monitoring (monitoring-pod.yaml)
kubectl apply -f monitoring-pod.yaml

# Check pod status and health
kubectl get pods
kubectl describe pod monitoring-pod

# View health check events
kubectl describe pod monitoring-pod | grep -A 10 Events

# Monitor container logs
kubectl logs monitoring-pod -c nginx --tail=5
kubectl logs monitoring-pod -c sidecar --tail=5

# Clean up monitoring pod
kubectl delete pod monitoring-pod
```

### Using ConfigMaps and Secrets
**What it does:** ConfigMaps store non-sensitive configuration data, Secrets store sensitive data like passwords. Both can be consumed by pods as environment variables or mounted volumes.

**Test Commands:**
```bash
# Create a ConfigMap with configuration data
kubectl create configmap demo-config --from-literal=app.setting=production --from-literal=database.host=localhost

# Create a Secret with sensitive data
kubectl create secret generic demo-secret --from-literal=username=admin --from-literal=password=secret123

# Create a pod that uses ConfigMap and Secret (config-secret-pod.yaml)
kubectl apply -f config-secret-pod.yaml

# Check pod environment variables
kubectl exec config-secret-pod -- env
kubectl exec config-secret-pod -- env | grep -E "(CONFIG|SECRET)"

# Check mounted volumes
kubectl exec config-secret-pod -- ls -la /etc/config/
kubectl exec config-secret-pod -- ls -la /etc/secret/

# Clean up resources
kubectl delete pod config-secret-pod
kubectl delete configmap demo-config
kubectl delete secret demo-secret
```

#### Services
**What it does:** Services provide stable network endpoints for pods and enable load balancing.

**Test Commands:**
```bash
# List all services
kubectl get services -A

# Create a pod
kubectl delete pod test-pod
kubectl run test-pod --image=nginx

# Create a service for our test pod
kubectl expose pod test-pod --port=80 --type=ClusterIP

# Check service details
kubectl describe service test-pod

# Test service connectivity (if pod exists)
kubectl run test-client --image=busybox --restart=Never --rm -it -- wget -O- http://test-pod:80
```

#### ConfigMaps
**What it does:** ConfigMaps store non-sensitive configuration data that can be consumed by pods.

**Test Commands:**
```bash
# Create a ConfigMap with key-value data to test configuration storage
kubectl create configmap test-config --from-literal=app.name=myapp --from-literal=app.version=1.0

# List all ConfigMaps in the current namespace
kubectl get configmaps

# Get detailed information about a specific ConfigMap including its data
kubectl describe configmap test-config

# Clean up by deleting the test ConfigMap
kubectl delete configmap test-config
```

#### Secrets
**What it does:** Secrets store sensitive data like passwords, tokens, and keys.

**Test Commands:**
```bash
# Create a Secret with sensitive data to test secure storage
kubectl create secret generic test-secret --from-literal=username=admin --from-literal=password=secret123

# List all Secrets in the current namespace
kubectl get secrets

# Get detailed information about a Secret (values are base64 encoded and hidden for security)
kubectl describe secret test-secret

# View the actual Secret data (use with caution as it exposes sensitive information)
kubectl get secret test-secret -o yaml

# Clean up by deleting the test Secret
kubectl delete secret test-secret
```

### Namespaces
**What it does:** Namespaces provide a way to divide cluster resources between multiple users or projects.

**Test Commands:**
```bash
# List all namespaces in the cluster to see available isolation boundaries
kubectl get namespaces

# Get detailed information about a specific namespace
kubectl describe namespace default

# Create a new namespace to test resource isolation
kubectl create namespace test-ns

# Switch kubectl context to work with the new namespace
kubectl config set-context --current --namespace=test-ns

# List all resources in the specific namespace to verify isolation
kubectl get all -n test-ns

# Switch back to the default namespace
kubectl config set-context --current --namespace=default

# Clean up by deleting the test namespace
kubectl delete namespace test-ns
```

### Annotations
**What it does:** Annotations are key-value pairs attached to objects for metadata that doesn't affect object behavior. Unlike labels, annotations can contain more complex data and are not used for selection.

**Test Commands:**
```bash
# Create a pod with annotations
kubectl run annotated-pod --image=busybox --restart=Never \
  --annotations=description="Test pod with annotations",created-by="kubectl",version="1.0" \
  -- sleep 300

# View pod with annotations
kubectl describe pod annotated-pod | grep -A 5 Annotations

# Add annotation to existing pod
kubectl annotate pod annotated-pod maintainer="devops-team"

# Clean up pod
kubectl delete pod annotated-pod
```

### Pod Priority and Priority Classes
**What it does:** Pod priority determines scheduling order when resources are limited. Higher priority pods are scheduled first, and lower priority pods may be preempted (evicted) to make room.

**Test Commands:**
```bash
# View existing priority classes
kubectl get priorityclasses

# Create a custom priority class
kubectl create priorityclass high-priority --value=1000000 --description="High priority pods"

# Create a pod with priority class (priority-pod.yaml)
kubectl apply -f priority-pod.yaml

# Check pod priority
kubectl describe pod priority-pod | grep -A 2 Priority

# Clean up resources
kubectl delete pod priority-pod
kubectl delete priorityclass high-priority
```

### Pod Disruption Budgets (PDB)
**What it does:** Pod Disruption Budgets ensure that a minimum number of pods remain available during voluntary disruptions like cluster upgrades or maintenance.

**Test Commands:**
```bash
# Create a deployment for testing PDB
kubectl create deployment nginx-deploy --image=nginx --replicas=3
kubectl get pods | grep nginx-deploy

# Create a Pod Disruption Budget
kubectl create pdb nginx-pdb --selector=app=nginx-deploy --min-available=2

# View PDB status
kubectl get pdb
kubectl describe pdb nginx-pdb

# Clean up resources
kubectl delete pdb nginx-pdb
kubectl delete deployment nginx-deploy
kubectl uncordon devops  # If node was cordoned
```

### Node Operations (Cordon/Uncordon)
**What it does:** Cordoning marks a node as unschedulable, preventing new pods from being scheduled on it while allowing existing pods to continue running.

**Test Commands:**
```bash
# Check current node status
kubectl get nodes

# Cordon a node (mark as unschedulable)
kubectl cordon host1

# Verify node status changed
kubectl get nodes

# Uncordon the node (allow scheduling again)
kubectl uncordon host1

# Check final node status
kubectl get nodes
```

### Advanced Network Policies
**What it does:** Network policies provide fine-grained control over pod-to-pod communication, allowing or denying traffic based on labels, namespaces, and IP ranges.

**Test Commands:**
```bash
# Create pods with different labels for testing
kubectl run frontend --image=nginx --labels=app=frontend
kubectl run backend --image=nginx --labels=app=backend

# Create an advanced network policy with ingress and egress rules (network-policy-web.yaml)
kubectl apply -f network-policy-web.yaml

# View network policies
kubectl get networkpolicies
kubectl describe networkpolicy allow-web-traffic

# Clean up resources
kubectl delete pod frontend backend
kubectl delete networkpolicy allow-web-traffic
```

### Custom Resource Definitions (CRDs)
**What it does:** CRDs allow you to extend the Kubernetes API by defining custom resources. This enables creating your own resource types beyond the built-in ones.

**Test Commands:**
```bash
# Create a Custom Resource Definition (crd-myapp.yaml)
kubectl apply -f crd-myapp.yaml

# Verify CRD is registered
kubectl get crd

# Create a custom resource using the CRD (myapp-sample.yaml)
kubectl apply -f myapp-sample.yaml

# View the custom resource
kubectl get myapps
kubectl describe myapp sample-app

# Clean up CRD (this also deletes the custom resources)
kubectl delete crd myapps.example.com
```

### Job Parallelism and Completions
**What it does:** Jobs can run multiple pods in parallel and specify completion requirements. This is useful for batch processing and parallel task execution.

**Test Commands:**
```bash
# Create a job with parallelism and completions (parallel-job.yaml)
kubectl apply -f parallel-job.yaml

# Monitor job progress
kubectl get jobs
kubectl describe job parallel-job

# View pods created by the job
kubectl get pods -l job-name=parallel-job

# Check job completion status
kubectl get jobs parallel-job -o jsonpath='{.status}'

# Clean up job
kubectl delete job parallel-job
```

### Cluster Events and Logging
**What it does:** Kubernetes events provide a timeline of what happened in the cluster, while logs show detailed output from containers and system components.

**Test Commands:**
```bash
# View recent cluster events
kubectl get events --sort-by='.metadata.creationTimestamp' | tail -10

# View events for a specific resource
kubectl get events --field-selector involvedObject.name=my-pod

# View system component logs
kubectl logs kube-apiserver-devops -n kube-system --tail=5
kubectl logs kube-controller-manager-devops -n kube-system --tail=5
kubectl logs kube-scheduler-devops -n kube-system --tail=5

# View pod logs from all containers
kubectl logs my-pod --all-containers

# Follow logs in real-time
kubectl logs -f my-pod
```

### kubectl Configuration Management
**What it does:** kubectl config commands manage cluster connections, contexts, and user authentication settings.

**Test Commands:**
```bash
# View current kubectl configuration
kubectl config view

# Show current context
kubectl config current-context

# List available clusters
kubectl config get-clusters

# List available contexts
kubectl config get-contexts

# Switch to a different namespace (changes context)
kubectl config set-context --current --namespace=kube-system
kubectl config set-context --current --namespace=default
```

### kubectl File Operations
**What it does:** kubectl cp allows copying files between your local machine and running pods.

**Test Commands:**
```bash
# Copy a file from local machine to pod
echo "Hello from local" > /tmp/local-file.txt
kubectl cp /tmp/local-file.txt my-pod:/tmp/pod-file.txt

# Copy a file from pod to local machine
kubectl cp my-pod:/tmp/pod-file.txt /tmp/copied-from-pod.txt
cat /tmp/copied-from-pod.txt

# Copy directories
kubectl cp /tmp/local-dir my-pod:/tmp/
kubectl cp my-pod:/tmp/pod-dir /tmp/copied-dir
```

### kubectl Authorization Checks
**What it does:** kubectl auth commands check what actions you can perform with your current credentials.

**Test Commands:**
```bash
# Check if you can perform specific actions
kubectl auth can-i get pods
kubectl auth can-i create deployments
kubectl auth can-i delete nodes

# Check permissions for a specific user or service account
kubectl auth can-i get pods --as=system:serviceaccount:default:default

# Reconcile RBAC permissions
kubectl auth reconcile -f rbac-policy.yaml
```

### kubectl API Proxy and Port Forwarding
**What it does:** kubectl proxy creates a local proxy to the Kubernetes API server, while port-forwarding allows access to pod services locally.

**Test Commands:**
```bash
# Start API proxy on local port (run in background)
kubectl proxy --port=8080 &
# Access API through proxy: curl http://localhost:8080/api/v1/pods

# Port forward to access pod service locally
kubectl port-forward my-pod 8080:80
# Now access pod service at http://localhost:8080

# Port forward to a service
kubectl port-forward svc/my-service 8080:80

# Stop background processes
pkill -f "kubectl proxy"
pkill -f "kubectl port-forward"
```

### Advanced kubectl Operations
**What it does:** Various advanced kubectl commands for cluster management and debugging.

**Test Commands:**
```bash
# Get raw API responses
kubectl get pods -o json
kubectl get nodes -o yaml

# Use JSONPath for specific field extraction
kubectl get pods -o jsonpath='{.items[*].metadata.name}'
kubectl get nodes -o jsonpath='{.items[*].status.capacity.cpu}'

# Use custom columns for output formatting
kubectl get pods -o custom-columns=NAME:.metadata.name,STATUS:.status.phase,NODE:.spec.nodeName

# Dry-run commands to see what would be created
kubectl run test-pod --image=nginx --dry-run=client -o yaml
kubectl create deployment test-deploy --image=nginx --dry-run=client -o yaml

# Edit resources directly (opens editor)
kubectl edit pod my-pod
kubectl edit deployment my-deployment

# Scale resources
kubectl scale deployment my-deployment --replicas=5

# Set image for existing deployment
kubectl set image deployment/my-deployment nginx=nginx:1.21

# Rollback deployment
kubectl rollout undo deployment/my-deployment
```

### Common Pod States and Issues
**What it does:** Understanding pod states helps diagnose common deployment issues. Pods can be Pending (waiting for resources), ContainerCreating (pulling images), Running, or in error states.

**Test Commands:**
```bash
# Check all pod statuses
kubectl get pods -A

# Get detailed pod information for troubleshooting
kubectl describe pod <pod-name>

# View pod logs for application errors
kubectl logs <pod-name>

# Check pod events for recent issues
kubectl get events --field-selector involvedObject.name=<pod-name>

# Debug pod network connectivity
kubectl exec <pod-name> -- ping 8.8.8.8

# Check pod resource usage
kubectl top pods
```

## Troubleshooting Guide - Issues Found & Fixed

During testing, we encountered and resolved several common Kubernetes issues. Here's a comprehensive guide to troubleshooting with real examples and solutions.

### Issue 1: Swap Not Disabled (Cluster Won't Start)
**Problem:** `kubelet.service` fails with "running with swap on is not supported"
**Solution:** Disable swap permanently

**Commands:**
```bash
# Check if swap is enabled
cat /proc/swaps

# Disable swap temporarily
sudo swapoff -a

# Disable swap permanently by commenting in fstab
sudo sed -i '/swap/d' /etc/fstab

# Restart kubelet
sudo systemctl restart kubelet
```

### Issue 2: Pods Stuck in Pending (Control Plane Taint)
**Problem:** All user pods show as "Pending" with scheduling failure
**Solution:** Remove control plane taint to allow pod scheduling

**Commands:**
```bash
# Check node taints
kubectl describe node <node-name> | grep Taints

# Remove control plane taint
kubectl taint nodes <node-name> node-role.kubernetes.io/control-plane:NoSchedule-

# Verify pods can now schedule
kubectl get pods
```

### Issue 3: kubectl top Commands Fail (Metrics Server Not Installed)
**Problem:** `kubectl top nodes` and `kubectl top pods` return "Metrics API not available"
**Solution:** Install metrics-server

**Commands:**
```bash
# Install metrics-server
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

# Wait for metrics-server to start
kubectl get pods -n kube-system | grep metrics-server

# Test kubectl top commands
kubectl top nodes
kubectl top pods
```

### Issue 4: LoadBalancer Services Show <pending> External-IP
**Problem:** LoadBalancer services show EXTERNAL-IP as <pending>
**Solution:** This is expected in bare-metal/on-premises setups without cloud provider

**Commands:**
```bash
# Check service status
kubectl get services

# Access via NodePort (automatically assigned)
kubectl get service <lb-service-name> -o yaml | grep nodePort

# Test access via NodePort
curl http://<node-ip>:<nodePort>
```

### Issue 5: External DNS Resolution Fails
**Problem:** External DNS queries timeout from pods
**Solution:** This is normal in isolated cluster environments

**Commands:**
```bash
# Test internal DNS (should work)
kubectl exec <pod-name> -- nslookup kubernetes.default.svc.cluster.local

# Test external DNS (may timeout)
kubectl exec <pod-name> -- nslookup google.com

# Check DNS configuration
kubectl exec <pod-name> -- cat /etc/resolv.conf
```

### Issue 6: Pod Scheduling Failures
**Problem:** Pods fail to schedule with various reasons
**Solution:** Check resource availability and constraints

**Commands:**
```bash
# Check node capacity and allocatable resources
kubectl describe node <node-name> | grep -A 10 "Capacity:"

# Check pod scheduling events
kubectl describe pod <pod-name> | grep -A 10 Events

# Check if nodes have sufficient resources
kubectl get nodes -o custom-columns=NAME:.metadata.name,CPU:.status.capacity.cpu,MEMORY:.status.capacity.memory

# Check for taints preventing scheduling
kubectl get nodes -o custom-columns=NAME:.metadata.name,TAINTS:.spec.taints
```

### Issue 7: Service Connectivity Issues
**Problem:** Pods can't reach services or external endpoints
**Solution:** Check service configuration and network policies

**Commands:**
```bash
# Check service details
kubectl get services
kubectl describe service <service-name>

# Test service DNS resolution
kubectl exec <pod-name> -- nslookup <service-name>.<namespace>.svc.cluster.local

# Check service endpoints
kubectl get endpoints

# Test direct service access
kubectl exec <pod-name> -- curl <service-cluster-ip>:<port>
```

### Issue 8: RBAC Permission Errors
**Problem:** Operations fail with "forbidden" or "unauthorized" errors
**Solution:** Check RBAC roles and bindings

**Commands:**
```bash
# Check current user permissions
kubectl auth can-i get pods
kubectl auth can-i create deployments

# List current roles and bindings
kubectl get roles,rolebindings -A

# Check cluster roles
kubectl get clusterroles,clusterrolebindings
```

### Issue 9: Persistent Volume Binding Issues
**Problem:** PVCs stuck in Pending state, not binding to PVs
**Solution:** Check storage classes and volume matching

**Commands:**
```bash
# Check PV and PVC status
kubectl get pv,pvc

# Check storage classes
kubectl get storageclass

# Verify PV and PVC match requirements
kubectl describe pv <pv-name>
kubectl describe pvc <pvc-name>

# Check volume binding mode
kubectl get storageclass -o yaml
```

### General Troubleshooting Workflow
**Step-by-step approach to diagnose Kubernetes issues:**

```bash
# 1. Check cluster status
kubectl cluster-info
kubectl get componentstatuses

# 2. Check node status
kubectl get nodes
kubectl describe node <node-name>

# 3. Check pod status
kubectl get pods -A
kubectl get pods -A | grep -v Running

# 4. Check recent events
kubectl get events --sort-by='.metadata.creationTimestamp' | tail -20

# 5. Describe problematic resources
kubectl describe pod <pod-name>
kubectl describe service <service-name>
kubectl describe deployment <deployment-name>

# 6. Check logs
kubectl logs <pod-name> -f
kubectl logs -n kube-system <system-pod-name>

# 7. Test network connectivity
kubectl exec <pod-name> -- ping <target-ip>
kubectl exec <pod-name> -- nslookup <service-name>

# 8. Check resource usage
kubectl top nodes
kubectl top pods -A

# 9. Verify RBAC permissions
kubectl auth can-i <verb> <resource>

# 10. Check storage
kubectl get pv,pvc
kubectl describe pvc <pvc-name>
```

### Basic Troubleshooting
**What it does:** Kubernetes provides various commands to diagnose and troubleshoot cluster and application issues.

**Test Commands:**
```bash
# Check overall cluster health and component status
kubectl cluster-info
kubectl get componentstatuses

# View cluster events (recent issues and status changes)
kubectl get events --sort-by='.metadata.creationTimestamp' | tail -10

# Get detailed pod information for troubleshooting
kubectl describe pod <pod-name>

# Check pod logs for application errors
kubectl logs <pod-name> -f

# Check resource usage and limits
kubectl top pods
kubectl top nodes

# Debug network connectivity
kubectl exec <pod-name> -- ping <target-ip>
kubectl exec <pod-name> -- nslookup kubernetes.default.svc.cluster.local

# Check service endpoints
kubectl get endpoints
kubectl describe service <service-name>

# View node status and capacity
kubectl describe node <node-name>
```

## Additional KCNA Topics

### Deployments
**What it does:** Deployments manage the lifecycle of pods and provide declarative updates, scaling, and rollbacks for applications.

**Test Commands:**
```bash
# Create a deployment with 3 replicas
kubectl create deployment nginx-deploy --image=nginx --replicas=3

# Check deployment status
kubectl get deployments

# View detailed deployment information
kubectl describe deployment nginx-deploy

# List pods created by the deployment
kubectl get pods -l app=nginx-deploy

# Clean up the deployment
kubectl delete deployment nginx-deploy
```

### Services
**What it does:** Services provide stable network endpoints for pods and enable load balancing across pod replicas.

**Test Commands:**
```bash
# Create a ClusterIP service (internal cluster access only)
kubectl expose deployment nginx-deploy --port=80 --type=ClusterIP --name=nginx-service

# Create a NodePort service (exposes on all nodes)
kubectl expose deployment nginx-deploy --port=80 --type=NodePort --name=nginx-nodeport

# List all services
kubectl get services

# Get detailed service information
kubectl describe service nginx-service

# Test service connectivity (if pods are running)
kubectl run test-client --image=busybox --restart=Never --rm -it -- wget -O- http://nginx-service:80

# Clean up services
kubectl delete service nginx-service nginx-nodeport
```

### Jobs and CronJobs
**What it does:** Jobs create pods that run to completion, while CronJobs schedule Jobs to run at specified times.

**Test Commands:**
```bash
# Create a Job that runs once and completes
kubectl create job test-job --image=busybox -- echo "Hello from Kubernetes Job"

# Create a CronJob that runs every 5 minutes
kubectl create cronjob test-cronjob --image=busybox --schedule="*/5 * * * *" -- echo "Hello from CronJob"

# Check Job status
kubectl get jobs

# Check CronJob status
kubectl get cronjobs

# Check pods created by jobs
kubectl get pods -l job-name=test-job

# Clean up Jobs and CronJobs
kubectl delete job test-job
kubectl delete cronjob test-cronjob
```

### RBAC (Role-Based Access Control)
**What it does:** RBAC controls who can access what resources and operations in the cluster through roles and bindings.

**Test Commands:**
```bash
# Create a service account
kubectl create serviceaccount test-sa

# Create a Role with specific permissions
kubectl create role pod-reader --verb=get,list,watch --resource=pods --resource-name=test-pod

# Create a RoleBinding to bind the role to the service account
kubectl create rolebinding pod-reader-binding --role=pod-reader --serviceaccount=default:test-sa

# List RBAC resources
kubectl get serviceaccounts
kubectl get roles
kubectl get rolebindings

# Describe role details
kubectl describe role pod-reader

# Clean up RBAC resources
kubectl delete serviceaccount test-sa
kubectl delete role pod-reader
kubectl delete rolebinding pod-reader-binding
```

### Network Policies
**What it does:** Network policies define how pods communicate with each other and with external endpoints.

**Test Commands:**
```bash
# List existing network policies in the cluster
kubectl get networkpolicies

# Create a network policy using YAML specification (network-policy-nginx.yaml)
kubectl apply -f network-policy-nginx.yaml

# Verify network policy was created
kubectl get networkpolicies

# Get detailed information about the network policy
kubectl describe networkpolicy allow-nginx

# Remove the network policy
kubectl delete networkpolicy allow-nginx
```

### Resource Management
**What it does:** Kubernetes allows setting resource requests and limits for CPU and memory on pods and containers.

**Test Commands:**
```bash
# Check node resource capacity and allocation
kubectl describe node devops | grep -A 10 Allocatable

# View cluster resource usage summary
kubectl get nodes -o custom-columns=NAME:.metadata.name,CPU:.status.capacity.cpu,MEMORY:.status.capacity.memory
```

### Labels and Selectors
**What it does:** Labels are key-value pairs attached to objects, and selectors are used to filter and select objects based on labels.

**Test Commands:**
```bash
# Show labels on existing pods
kubectl get pods --show-labels

# Filter pods using label selectors
kubectl get pods -l app=nginx-deploy

# List all deployments and their labels
kubectl get deployments --show-labels
```

### Kubernetes API and Objects
**What it does:** The Kubernetes API allows programmatic access to cluster resources, and objects are the persistent entities in the Kubernetes cluster.

**Test Commands:**
```bash
# Get API server information and endpoints
kubectl cluster-info

# List all available API resources in the cluster
kubectl api-resources

# Show available API versions
kubectl api-versions

# Get documentation for a resource type
kubectl explain pod
kubectl explain deployment
```

## Advanced KCNA Topics

### Persistent Volumes and Persistent Volume Claims
**What it does:** Persistent Volumes (PV) provide storage resources, and Persistent Volume Claims (PVC) request storage from PVs for use by pods.

**Test Commands:**
```bash
# Create a namespace for storage testing
kubectl create namespace storage-demo
kubectl config set-context --current --namespace=storage-demo

# Create a PersistentVolume using hostPath storage (pv-demo.yaml)
kubectl apply -f pv-demo.yaml

# Create a PersistentVolumeClaim that binds to the PV (pvc-demo.yaml)
kubectl apply -f pvc-demo.yaml

# Check PV and PVC status
kubectl get pv
kubectl get pvc

# Create a pod that uses the PVC (storage-pod.yaml)
kubectl apply -f storage-pod.yaml

# Verify pod is using persistent storage
kubectl exec storage-pod -- ls -la /data/

# Clean up storage resources
kubectl delete pod storage-pod
kubectl delete pvc demo-pvc
kubectl delete pv demo-pv
kubectl config set-context --current --namespace=default
kubectl delete namespace storage-demo
```

### Ingress
**What it does:** Ingress manages external access to services in a cluster, typically HTTP, and provides load balancing, SSL termination, and name-based virtual hosting.

**Test Commands:**
```bash
# Create an Ingress resource (requires ingress controller for full functionality) (ingress-demo.yaml)
kubectl apply -f ingress-demo.yaml

# Check ingress status
kubectl get ingress
kubectl describe ingress demo-ingress

# Clean up ingress
kubectl delete ingress demo-ingress
```

### DaemonSets
**What it does:** DaemonSets ensure that all (or some) nodes run a copy of a pod, useful for running system daemons or monitoring agents on every node.

**Test Commands:**
```bash
# Create a DaemonSet that runs on all nodes (daemonset-demo.yaml)
kubectl apply -f daemonset-demo.yaml

# Check DaemonSet and pods
kubectl get daemonsets
kubectl get pods -l app=demo-daemon

# Clean up DaemonSet
kubectl delete daemonset demo-daemonset
```

### StatefulSets
**What it does:** StatefulSets manage stateful applications that require stable network identities, persistent storage, and ordered deployment/scaling.

**Test Commands:**
```bash
# Create a StatefulSet with ordered pod creation (statefulset-demo.yaml)
kubectl apply -f statefulset-demo.yaml

# Check StatefulSet and pods (pods have ordered names like demo-statefulset-0, demo-statefulset-1)
kubectl get statefulsets
kubectl get pods -l app=demo-stateful

# Clean up StatefulSet
kubectl delete statefulset demo-statefulset
```

### Taints and Tolerations
**What it does:** Taints prevent pods from scheduling on nodes unless the pods have matching tolerations, allowing control over pod placement.

**Test Commands:**
```bash
# Add a taint to a node to prevent regular pods from scheduling
kubectl taint nodes devops demo-taint=demo:NoSchedule

# Check node taints
kubectl describe node devops | grep Taints

# Create a pod with tolerations that can schedule on tainted nodes (tolerant-pod.yaml)
kubectl apply -f tolerant-pod.yaml

# Check if pod schedules successfully
kubectl get pods

# Remove the taint
kubectl taint nodes devops demo-taint-

# Clean up pod
kubectl delete pod tolerant-pod
```

### Resource Quotas and LimitRanges
**What it does:** Resource Quotas limit resource usage per namespace, while LimitRanges set default resource limits for containers in a namespace.

**Test Commands:**
```bash
# Create a namespace for resource testing
kubectl create namespace resource-demo
kubectl config set-context --current --namespace=resource-demo

# Create a ResourceQuota for the namespace (resource-quota.yaml)
kubectl apply -f resource-quota.yaml

# Create a LimitRange for default container limits (limit-range.yaml)
kubectl apply -f limit-range.yaml

# Check resource quota and limit range
kubectl get resourcequotas
kubectl get limitranges
kubectl describe resourcequota demo-quota
kubectl describe limitrange demo-limits

# Clean up resources
kubectl delete resourcequota demo-quota
kubectl delete limitrange demo-limits
kubectl config set-context --current --namespace=default
kubectl delete namespace resource-demo
```

### Security Contexts
**What it does:** Security contexts define privilege and access control settings for pods and containers, enhancing security by controlling user access and capabilities.

**Test Commands:**
```bash
# Create a pod with security contexts (security-pod.yaml)
kubectl apply -f security-pod.yaml

# Check pod security context
kubectl describe pod security-pod

# Check running pod user (should show uid=1000)
kubectl exec security-pod -- id

# Clean up pod
kubectl delete pod security-pod
```

**KCNA Topics Covered:**
- ✅ **Installation & Setup** - Complete cluster deployment with Calico networking
- ✅ **Core Concepts** - Pods, multi-container pods, services, ConfigMaps, Secrets, Namespaces, Annotations
- ✅ **Workloads** - Deployments (tested), DaemonSets, StatefulSets, Jobs (tested), CronJobs with parallelism
- ✅ **Networking** - Services (ClusterIP, NodePort, LoadBalancer), DNS resolution, pod-to-pod communication
- ✅ **Storage** - ConfigMaps/Secrets as volumes (PVs/PVCs available but not tested)
- ✅ **Security** - RBAC (tested), Service Accounts, Pod Security
- ✅ **Scheduling** - Node cordon/uncordon, Labels/Selectors, Priority Classes, PDBs
- ✅ **API Extension** - Custom Resource Definitions available
- ✅ **Operations** - Node operations, Events, kubectl configuration management
- ✅ **kubectl Mastery** - Config management, auth checks, advanced commands (dry-run, JSONPath, custom columns)
- ✅ **Troubleshooting** - Comprehensive guide with working solutions


