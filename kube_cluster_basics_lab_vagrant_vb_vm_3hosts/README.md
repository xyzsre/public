

# Kubernetes Practical Lab Course

## Overview
This hands-on lab course provides a practical introduction to Kubernetes using a 3-VM setup with one master node and two worker nodes. You'll learn core Kubernetes concepts, deploy applications, and explore ecosystem tools like Helm and Rancher.

## Lab Environment
- **3 Virtual Machines**: 1 Master + 2 Worker Nodes
- **Base OS**: Ubuntu 22.04 (Jammy Jellyfish)
- **Container Runtime**: containerd
- **Kubernetes Version**: Latest stable
- **Network Plugin**: Calico

## What is Kubernetes?

Kubernetes (often abbreviated as K8s) is an open-source container orchestration platform that automates the deployment, scaling, and management of containerized applications. Originally developed by Google, it's now maintained by the Cloud Native Computing Foundation (CNCF).

### Key Benefits
- **Automated Rollouts and Rollbacks**: Gradually deploy changes with health monitoring
- **Self-Healing**: Restart failed containers, replace and reschedule containers when nodes die
- **Horizontal Scaling**: Scale applications up and down based on CPU usage or custom metrics
- **Service Discovery and Load Balancing**: Automatically expose containers to the internet or other containers
- **Storage Orchestration**: Automatically mount storage systems of your choice
- **Batch Execution**: Manage batch and CI workloads, replacing failed containers

## Kubernetes Architecture

### Master Node (Control Plane)
The control plane makes global decisions about the cluster and detects and responds to cluster events.

#### Master Components:
- **kube-apiserver**: Front-end of the control plane, validates and configures data for API objects
- **etcd**: Consistent and highly-available key-value store used as Kubernetes' backing store
- **kube-scheduler**: Assigns nodes to newly created pods
- **kube-controller-manager**: Runs controller processes (node controller, replication controller, etc.)
- **cloud-controller-manager**: Embeds cloud-specific control logic

### Worker Nodes
Worker nodes run the actual applications in containers.

#### Worker Components:
- **kubelet**: Agent that runs on each node, ensures containers are running in a Pod
- **kube-proxy**: Network proxy that maintains network rules on nodes
- **container runtime**: Software responsible for running containers (containerd, Docker, etc.)

## Lab Exercises

### 1. Cluster Setup and Verification
```bash
# Check cluster status
kubectl get nodes
kubectl get pods --all-namespaces

# Verify cluster functionality
kubectl run test-pod --image=nginx --port=80
kubectl expose pod test-pod --type=NodePort --port=80
```

### 2. Basic Kubernetes Objects
- **Pods**: Smallest deployable units in Kubernetes
- **Services**: Abstract way to expose an application running on a set of Pods
- **Deployments**: Provides declarative updates for Pods and ReplicaSets
- **ConfigMaps & Secrets**: Configuration management

### 3. Application Deployments

#### Nginx Web Server
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80
```

#### PHP Application
Deploy a simple PHP application with persistent storage and database connectivity.

#### WordPress Deployment
Deploy WordPress with MySQL database using Kubernetes manifests, including:
- Persistent volumes for data storage
- ConfigMaps for configuration
- Services for network exposure
- Secrets for sensitive data

## What is Helm?

Helm is the package manager for Kubernetes. It helps you manage Kubernetes applications through Helm charts, which are packages of pre-configured Kubernetes resources.

### Helm Use Cases
- **Package Management**: Install and manage applications as versioned packages
- **Application Sharing**: Distribute applications through public and private chart repositories
- **Configuration Management**: Manage application configurations through values files
- **Lifecycle Management**: Install, upgrade, rollback, and delete applications

### Helm Components
- **Chart**: A package containing Kubernetes resource definitions
- **Release**: A specific instance of a chart running in the cluster
- **Repository**: A collection of charts available for installation

### Helm Advantages
- **Reusability**: Use existing charts for common applications
- **Version Control**: Track changes to application configurations
- **Dependency Management**: Handle complex application dependencies
- **Rollback Capabilities**: Quickly revert to previous versions

### Helm Examples
```bash
# Add a repository
helm repo add stable https://charts.helm.sh/stable

# Install an application
helm install my-nginx stable/nginx

# Upgrade a release
helm upgrade my-nginx stable/nginx --set image.tag=1.21

# Rollback to previous version
helm rollback my-nginx 1
```

## What is Rancher?

Rancher is an open-source container management platform that provides a complete solution for managing Kubernetes clusters.

### Rancher Use Cases
- **Multi-Cluster Management**: Manage multiple Kubernetes clusters from a single interface
- **Cluster Provisioning**: Deploy and configure Kubernetes clusters on any infrastructure
- **Security and Compliance**: Implement security policies and compliance standards
- **Application Catalog**: Deploy applications through a user-friendly interface
- **Monitoring and Logging**: Built-in monitoring and log aggregation

### Rancher Advantages
- **Simplified Management**: User-friendly web interface for cluster operations
- **Multi-Cloud Support**: Works with any cloud provider or on-premises infrastructure
- **Security Features**: Role-based access control, pod security policies
- **Integrated Tools**: Built-in monitoring, logging, and alerting
- **Extensibility**: Plugin architecture for custom functionality

### Rancher Features
- **Cluster Dashboard**: Centralized view of all clusters and their status
- **Workload Management**: Deploy and manage applications through the UI
- **Resource Monitoring**: Real-time metrics and performance data
- **User Management**: Authentication and authorization integration
- **Backup and Restore**: Cluster backup and disaster recovery

## Lab Prerequisites

### System Requirements
- **RAM**: Minimum 8GB (16GB recommended)
- **CPU**: 4+ cores
- **Storage**: 50GB free space
- **Network**: Internet connection for downloading images

### Software Requirements
- **Virtualization**: VirtualBox or VMware
- **Vagrant**: Latest version
- **kubectl**: Kubernetes command-line tool
- **Git**: For cloning repositories


## Troubleshooting

### Common Issues
1. **Nodes Not Ready**: Check containerd service status
2. **Pods Pending**: Verify resource availability and network plugin
3. **Service Not Accessible**: Check firewall rules and port configuration

### Debug Commands
```bash
# Check node status
kubectl describe node <node-name>

# Check pod logs
kubectl logs <pod-name>

# Check events
kubectl get events --sort-by=.metadata.creationTimestamp
```

## Next Steps

After completing this lab, you can explore:
- **Advanced Networking**: Service Mesh, Ingress Controllers
- **Monitoring**: Prometheus, Grafana integration
- **CI/CD**: GitOps with ArgoCD or Flux
- **Security**: Pod Security Policies, Network Policies
- **Storage**: Persistent volumes, storage classes

## Additional Resources

- [Kubernetes Official Documentation](https://kubernetes.io/docs/)
- [Helm Documentation](https://helm.sh/docs/)
- [Rancher Documentation](https://rancher.com/docs/)
- [Kubernetes GitHub](https://github.com/kubernetes/kubernetes)


URLs/Refs::

https://kubernetes.io/

https://kubernetes.io/docs/home/

https://kubernetes.io/docs/tutorials/

https://helm.sh/

https://helm.sh/docs/intro/install/

https://helm.sh/docs/

https://www.rancher.com/

https://www.rancher.com/products/rancher-desktop

https://rancher.com/docs/

https://www.rancher.com/quick-start

https://rancherdesktop.io/

https://www.vmware.com/products/desktop-hypervisor/workstation-and-fusion

https://www.virtualbox.org/

https://developer.hashicorp.com/vagrant

