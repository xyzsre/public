

# MANA

# GCP High-Availability Web Server Architecture Guide

## Subtitle: Understanding Cloud Infrastructure, Load Balancing, and Automation Concepts

---

## Table of Contents
1. [What is GCP Compute Engine?](#what-is-gcp-compute-engine)
2. [What is a Load Balancer?](#what-is-a-load-balancer)
3. [Regional vs Global Load Balancers](#regional-vs-global-load-balancers)
4. [Ubuntu 22 Web Server Instances](#ubuntu-22-web-server-instances)
5. [What is GCP CLI?](#what-is-gcp-cli)
6. [What is Ansible?](#what-is-ansible)
7. [Why Use Ansible with GCP VMs?](#why-use-ansible-with-gcp-vms)
8. [Practical Load Balancer Scenarios](#practical-load-balancer-scenarios)
9. [Web Server Architecture Patterns](#web-server-architecture-patterns)

---

## What is GCP Compute Engine?

### Definition
GCP Compute Engine is Google Cloud's Infrastructure as a Service (IaaS) offering that provides virtual machines (VMs) running on Google's global infrastructure. These VMs are called "instances" and can be configured with different operating systems, memory, CPU, and storage options.

### Why Use Compute Engine?
- **Scalability**: Instantly scale up or down based on demand
- **Global Infrastructure**: Deploy in data centers worldwide
- **Pay-as-you-go**: Only pay for what you use
- **High Performance**: Access to Google's advanced hardware and network
- **Integration**: Seamless connection with other GCP services

### Advantages Over Traditional Hosting
- **No Hardware Maintenance**: Google manages physical infrastructure
- **Instant Provisioning**: Create servers in minutes, not days
- **Built-in Redundancy**: Multiple availability zones automatically
- **Advanced Networking**: High-speed, low-latency global network
- **Security**: Google's enterprise-grade security measures

### Use Cases
- Web applications and APIs
- Development and testing environments
- Big data processing
- Machine learning workloads
- Disaster recovery sites

---

## What is a Load Balancer?

### Definition
A load balancer is a traffic management system that distributes incoming network requests across multiple servers. It acts as a "traffic cop" sitting in front of your servers, routing client requests to all servers that are capable of fulfilling those requests.

### Why Use Load Balancers?
- **High Availability**: If one server fails, traffic automatically routes to healthy servers
- **Performance**: Distributes workload to prevent any single server from being overwhelmed
- **Scalability**: Easily add or remove servers without affecting users
- **Maintenance**: Perform server maintenance without downtime
- **Geographic Distribution**: Route users to the nearest server for better performance

### Types of Load Balancing Algorithms
- **Round Robin**: Distributes requests evenly across all servers
- **Least Connections**: Sends requests to the server with fewest active connections
- **IP Hash**: Routes requests based on client IP address (session persistence)
- **Geographic**: Routes based on user location

### Advantages
- **Zero Downtime**: Continuous service even during server failures
- **Better Performance**: Optimized resource utilization
- **Flexibility**: Support for different traffic patterns and requirements
- **Monitoring**: Built-in health checks and performance metrics
- **SSL Termination**: Offload SSL processing from web servers

---

## Regional vs Global Load Balancers

### Regional Load Balancers

#### What Are They?
Regional load balancers operate within a single geographic region and distribute traffic to resources (like VMs) located in that same region.

#### Characteristics
- **Single Region Scope**: Only handles traffic within one GCP region
- **Lower Latency**: Faster response times for local users
- **Lower Cost**: Generally less expensive than global load balancers
- **Simpler Setup**: Less complex configuration
- **Regional IP Address**: Uses a regional IP address

#### Use Cases
- Applications serving primarily local/regional users
- Internal applications within a specific geographic area
- Cost-sensitive deployments
- Applications with data residency requirements

#### Advantages
- **Cost Efficiency**: Lower operational costs
- **Simplicity**: Easier to configure and manage
- **Regional Compliance**: Data stays within specific regions
- **Performance**: Optimized for regional traffic patterns

### Global Load Balancers

#### What Are They?
Global load balancers can distribute traffic across multiple regions worldwide, providing a single global IP address that routes users to the nearest healthy backend.

#### Characteristics
- **Global Reach**: Can route traffic to any region globally
- **Single IP Address**: One global IP for all regions
- **Anycast Routing**: Routes users to the closest healthy backend
- **Higher Cost**: More expensive due to global infrastructure
- **Advanced Features**: CDN integration, SSL certificates, more sophisticated routing

#### Use Cases
- Global applications with worldwide user base
- Content delivery networks
- SaaS applications serving multiple continents
- High-availability global services

#### Advantages
- **Global Performance**: Users connect to nearest data center
- **Disaster Recovery**: Automatic failover between regions
- **Single Management**: One load balancer for global infrastructure
- **Advanced Routing**: URL-based routing, weighted traffic distribution
- **CDN Integration**: Built-in content delivery capabilities

---

## Ubuntu 22 Web Server Instances

### What Are They?
Ubuntu 22.04 LTS (Long Term Support) instances are virtual machines running the Ubuntu 22 operating system, specifically configured to serve web content. When used as web servers, they typically run web server software like Nginx or Apache.

### Why Ubuntu 22 for Web Servers?
- **LTS Support**: 5 years of free security updates and maintenance
- **Stability**: Proven, reliable operating system for production workloads
- **Performance**: Optimized for cloud environments
- **Security**: Built-in security features and regular updates
- **Community**: Large community support and extensive documentation
- **Package Management**: Advanced APT package system

### Instance Types for Web Servers

#### General Purpose Instances (E2 Series)
- **Best For**: Small to medium websites, development environments
- **Characteristics**: Balanced CPU and memory, cost-effective
- **Use Cases**: Blogs, small business websites, internal tools

#### Compute-Optimized Instances (C2 Series)
- **Best For**: CPU-intensive web applications
- **Characteristics**: High CPU performance, lower memory ratio
- **Use Cases**: API servers, real-time applications, data processing

#### Memory-Optimized Instances (N2 Series)
- **Best For**: Memory-intensive applications
- **Characteristics**: High memory capacity, good CPU performance
- **Use Cases**: Large databases, caching servers, in-memory applications

#### Burstable Instances (E2 Micro)
- **Best For**: Low-traffic websites, development
- **Characteristics**: Low cost with performance bursts
- **Use Cases**: Personal projects, staging environments, small blogs

### Web Server Configuration Options
- **Nginx**: High-performance, lightweight, excellent for concurrent connections
- **Apache**: Feature-rich, flexible configuration, extensive module ecosystem
- **Node.js**: JavaScript-based, good for real-time applications
- **Python/Gunicorn**: Python-based web applications
- **Docker**: Containerized applications for consistency

---

## What is GCP CLI?

### Definition
The Google Cloud Platform Command Line Interface (gcloud CLI) is a unified command-line tool for managing GCP resources and services. It provides a text-based interface to create, configure, and manage Google Cloud resources.

### Why Use GCP CLI?
- **Automation**: Script repetitive tasks and workflows
- **Consistency**: Ensure identical configurations across environments
- **Speed**: Faster than clicking through web console
- **Version Control**: Track infrastructure changes in code
- **Integration**: Works with CI/CD pipelines and DevOps tools

### Key Features
- **Resource Management**: Create, update, delete any GCP resource
- **Batch Operations**: Perform operations on multiple resources simultaneously
- **Configuration Management**: Manage project settings and permissions
- **Debugging**: Access logs and troubleshoot issues
- **Cross-Platform**: Works on Windows, macOS, and Linux

### Advantages Over Web Console
- **Reproducibility**: Commands can be saved and reused
- **Documentation**: Commands serve as documentation of infrastructure
- **Team Collaboration**: Easy to share and review configurations
- **Error Reduction**: Less prone to human error than manual clicking
- **Advanced Features**: Access to features not available in web console

### Common Use Cases
- Infrastructure provisioning
- Automated deployments
- Backup and restore operations
- Monitoring and maintenance
- Multi-environment management

---

## What is Ansible?

### Definition
Ansible is an open-source automation tool that simplifies configuration management, application deployment, and task automation. It uses YAML-based "playbooks" to define automation tasks and connects to remote systems via SSH without requiring agents.

### Why Use Ansible?
- **Agentless**: No software to install on managed systems
- **Simple**: Uses human-readable YAML format
- **Powerful**: Can orchestrate complex multi-tier applications
- **Reliable**: Idempotent operations ensure consistent results
- **Scalable**: Manages from a few to thousands of servers

### Key Concepts
- **Playbooks**: YAML files defining automation tasks
- **Modules**: Pre-built units of work (install packages, copy files, etc.)
- **Inventory**: Lists of managed systems
- **Roles**: Reusable collections of playbooks and configurations
- **Templates**: Dynamic configuration files using variables

### Advantages
- **No Learning Curve**: Simple syntax, easy to understand
- **Safe**: Idempotent operations prevent unintended changes
- **Fast**: Parallel execution across multiple systems
- **Flexible**: Works with any system that supports SSH
- **Version Control**: Infrastructure as code with Git

### Use Cases
- Server configuration and hardening
- Application deployment
- Multi-environment management
- Continuous integration/deployment
- Disaster recovery automation

---

## Why Use Ansible with GCP VMs?

### Integration Benefits
- **Unified Management**: Single tool for both cloud and configuration
- **Consistency**: Ensure all VMs have identical configurations
- **Speed**: Configure multiple VMs simultaneously
- **Documentation**: Playbooks serve as living documentation
- **Reproducibility**: Easily recreate environments

### Why Ansible for GCP Specifically?
- **SSH Access**: GCP VMs support SSH out of the box
- **Dynamic Inventory**: Ansible can automatically discover GCP instances
- **Cloud Modules**: Special modules for GCP resource management
- **Cost Efficiency**: Reduce manual configuration time
- **Scalability**: Easily manage hundreds of instances

### Practical Example: Nginx Installation

#### What Happens Without Ansible?
1. SSH into each VM manually
2. Run commands manually on each server
3. Risk of human error and inconsistent configurations
4. Time-consuming for multiple servers
5. Difficult to track changes and rollback

#### What Happens With Ansible?
1. Write one playbook defining Nginx installation
2. Run playbook against all servers simultaneously
3. Consistent configuration across all instances
4. Automatic error handling and reporting
5. Version-controlled infrastructure changes

### Advantages of This Approach
- **Time Savings**: Configure 100 servers as easily as 1
- **Consistency**: Eliminate configuration drift
- **Reliability**: Tested, proven configurations
- **Documentation**: Clear record of all changes
- **Compliance**: Enforce security and configuration standards

---

## Practical Load Balancer Scenarios

### Scenario 1: E-commerce Website

#### Situation
An online store experiences traffic spikes during holiday seasons and flash sales. The website must remain available and responsive even during peak traffic.

#### Load Balancer Solution
- **Global Load Balancer**: Route users to nearest data center
- **Auto-scaling**: Automatically add servers during traffic spikes
- **Health Checks**: Remove unhealthy servers immediately
- **Session Persistence**: Keep shopping carts consistent
- **SSL Termination**: Secure checkout process

#### Benefits
- **99.99% Uptime**: Continuous service during peak periods
- **Global Performance**: Fast loading times worldwide
- **Cost Efficiency**: Scale down during quiet periods
- **Customer Satisfaction**: No abandoned carts due to slow performance

### Scenario 2: SaaS Application

#### Situation
A software-as-a-service application serves customers across multiple continents with different usage patterns. The application must provide consistent performance and handle regional outages.

#### Load Balancer Solution
- **Multi-Region Setup**: Deploy in US, Europe, and Asia-Pacific
- **Geographic Routing**: Route users to nearest region
- **Failover Logic**: Automatic failover between regions
- **Weighted Routing**: Gradual traffic shifting during updates
- **Health Monitoring**: Proactive issue detection

#### Benefits
- **Global Reach**: Serve customers efficiently worldwide
- **Disaster Recovery**: Automatic failover during regional issues
- **Maintenance Windows**: Zero-downtime updates
- **Performance Optimization**: Reduced latency for all users

### Scenario 3: Media Streaming Platform

#### Situation
A video streaming service needs to deliver content to millions of concurrent viewers with different bandwidth capabilities and geographic locations.

#### Load Balancer Solution
- **CDN Integration**: Cache content at edge locations
- **Bandwidth Detection**: Route based on connection quality
- **Adaptive Bitrate**: Serve appropriate quality based on conditions
- **Geographic Load Balancing**: Route to nearest content servers
- **Capacity Planning**: Predictive scaling based on usage patterns

#### Benefits
- **Buffer-Free Streaming**: Optimized delivery for all users
- **Cost Optimization**: Reduce bandwidth costs through caching
- **Scalability**: Handle millions of concurrent viewers
- **Quality of Service**: Consistent experience across devices

### Scenario 4: Financial Trading Platform

#### Situation
A high-frequency trading platform requires ultra-low latency connections and absolute reliability for financial transactions.

#### Load Balancer Solution
- **Regional Load Balancer**: Minimize latency within financial centers
- **Direct Peering**: Direct connections to major exchanges
- **Health Monitoring**: Sub-second health checks
- **Traffic Engineering**: Optimize routing for latency
- **Redundancy**: Multiple paths for critical transactions

#### Benefits
- **Ultra-Low Latency**: Millisecond response times
- **High Reliability**: 99.999% uptime for trading operations
- **Regulatory Compliance**: Data residency requirements
- **Competitive Advantage**: Faster execution than competitors

---

## Web Server Architecture Patterns

### Pattern 1: Simple Load-Balanced Setup

#### Architecture
```
Internet → Load Balancer → Multiple Web Servers
```

#### Use Cases
- Small to medium websites
- Development environments
- Internal applications
- Proof of concepts

#### Advantages
- **Simple Setup**: Easy to configure and manage
- **Cost Effective**: Minimal infrastructure requirements
- **Good Performance**: Adequate for moderate traffic
- **Easy Troubleshooting**: Straightforward architecture

### Pattern 2: Multi-Tier Architecture

#### Architecture
```
Internet → Load Balancer → Web Servers → Application Servers → Database
```

#### Use Cases
- Large enterprise applications
- E-commerce platforms
- SaaS applications
- Complex web applications

#### Advantages
- **Scalability**: Each tier can scale independently
- **Security**: Layered security approach
- **Performance**: Optimized for specific workloads
- **Maintenance**: Can update individual tiers

### Pattern 3: Microservices Architecture

#### Architecture
```
Internet → API Gateway → Multiple Service Load Balancers → Individual Services
```

#### Use Cases
- Modern cloud applications
- Large development teams
- Complex business logic
- Rapid deployment requirements

#### Advantages
- **Team Independence**: Teams can work on services independently
- **Technology Diversity**: Different services can use different technologies
- **Resilience**: Failure of one service doesn't affect others
- **Scalability**: Individual services can scale based on demand

### Pattern 4: Content Delivery Architecture

#### Architecture
```
Internet → CDN → Edge Load Balancers → Origin Servers → Content Storage
```

#### Use Cases
- Media streaming
- Global websites
- Software distribution
- Static content delivery

#### Advantages
- **Global Performance**: Content delivered from nearest location
- **Bandwidth Savings**: Cached content reduces origin server load
- **Reliability**: Multiple edge locations provide redundancy
- **Scalability**: Handle massive traffic spikes

---

## Conclusion

Understanding these concepts is crucial for building modern, scalable web applications. The combination of GCP Compute Engine, load balancers, and Ansible automation provides a powerful foundation for cloud-native architectures that can handle real-world traffic patterns and requirements.

The key is choosing the right components for your specific use case while considering factors like cost, performance, scalability, and maintenance requirements. This knowledge enables you to design architectures that not only work today but can grow and adapt to future needs.




# Step by Step - LAB Guide

## 1. Upgrade
```bash
sudo apt update -y
```

## 2. Upgrade
```bash
sudo apt upgrade -y
```

## 3. Install Google Cloud CLI (gcloud) using snap
```bash
sudo snap install google-cloud-sdk --classic
```

## 4. Verify gcloud installation
```bash
gcloud version
```

## 5. Authenticate with GCP using JSON key file
```bash
gcloud auth activate-service-account --key-file=gcp-key.json
```

## 6. List GCP projects
```bash
gcloud projects list
```

## 7. List compute instances
```bash
gcloud compute instances list --project=melodic-furnace-462121-n7
```

## 8. Set current project
```bash
gcloud config set project melodic-furnace-462121-n7
```

## 9. List compute instances (without project parameter)
```bash
gcloud compute instances list
```

## 10. Check current active project
```bash
gcloud config list project
```

## 11. List all available compute machine types and save to file
```bash
gcloud compute machine-types list > gcp_compute_list.txt
```

## 12. List all available GCP regions and save to file
```bash
gcloud compute regions list > gcp_regions_list.txt
```

## 13. List all available availability zones and save to file
```bash
gcloud compute zones list > gcp_zones_list.txt
```

## 14. NOTE:: region-country mapping file
# File: gcp_regions_countries.txt

## 15. NOTE:: regions-countries-zones list
# File: gcp_complete_list.txt

## 16. List all available GCP images
```bash
gcloud compute images list > gcp_all_images_list.txt
```

## 17. Filter and format Linux distribution images
```bash
grep -E "(ubuntu|debian|centos|fedora|rocky|almalinux|opensuse|cos)" gcp_all_images_list.txt > gcp_linux_images.txt
```

## 18. Create web1 VM with Ubuntu 22.04 in France
```bash
gcloud compute instances create web1 --zone=europe-west9-b --machine-type=e2-medium --image-family=ubuntu-2204-lts --image-project=ubuntu-os-cloud --boot-disk-size=20GB
```

## 19. Create web2 VM with Ubuntu 22.04 in France
```bash
gcloud compute instances create web2 --zone=europe-west9-c --machine-type=e2-medium --image-family=ubuntu-2204-lts --image-project=ubuntu-os-cloud --boot-disk-size=20GB
```

## 20. List all compute instances
```bash
gcloud compute instances list
```

34.155.255.159  web1
34.155.93.89    web2


## 21. List storage (disks) consumed in GCP
```bash
gcloud compute disks list
```

## 22. Get detailed IP information for web1
```bash
gcloud compute instances describe web1 --zone=europe-west9-b --format="get(networkInterfaces[0].networkIP,networkInterfaces[0].accessConfigs[0].natIP)"
```

## 23. Get detailed IP information for web2
```bash
gcloud compute instances describe web2 --zone=europe-west9-c --format="get(networkInterfaces[0].networkIP,networkInterfaces[0].accessConfigs[0].natIP)"
```

## 24. Create SSH key pair (4096-bit) for GCP VM access
```bash
ssh-keygen -t rsa -b 4096 -f gcp_ssh_key -N "" -C "gcp_user"
```

## 25. Format SSH public key for GCP
```bash
echo "gcp_user:$(cat gcp_ssh_key.pub)" > gcp_ssh_key_formatted.pub
```

## 26. Assign SSH key to web1 VM
```bash
gcloud compute instances add-metadata web1 --zone=europe-west9-b --metadata=ssh-keys="$(cat gcp_ssh_key_formatted.pub)"
```

## 27. Assign SSH key to web2 VM
```bash
gcloud compute instances add-metadata web2 --zone=europe-west9-c --metadata=ssh-keys="$(cat gcp_ssh_key_formatted.pub)"
```

## 28. Verify SSH key files
```bash
ls -la gcp_ssh_key*
```

## 29. SSH to web1 and update packages
```bash

ssh -i gcp_ssh_key -o StrictHostKeyChecking=no gcp_user@web1 "hostname -I"

chmod 600 gcp_ssh_key

ssh -i gcp_ssh_key -o StrictHostKeyChecking=no gcp_user@34.155.88.60 "sudo apt update && sudo apt upgrade -y"

ssh -i gcp_ssh_key -o StrictHostKeyChecking=no gcp_user@web1 "sudo apt update && sudo apt upgrade -y"

```

## 30. SSH to web2 and update packages
```bash
ssh -i gcp_ssh_key -o StrictHostKeyChecking=no gcp_user@34.163.231.1 "sudo apt update && sudo apt upgrade -y"

ssh -i gcp_ssh_key -o StrictHostKeyChecking=no gcp_user@web2 "sudo apt update && sudo apt upgrade -y"

```

## 31. Add web1 IP to local hosts file
```bash
echo "34.155.88.60 web1" | sudo tee -a /etc/hosts
```

## 32. Add web2 IP to local hosts file
```bash
echo "34.163.231.1 web2" | sudo tee -a /etc/hosts
```

## 33. Verify hosts file entries
```bash
tail -3 /etc/hosts
```

## 34. Test connectivity to web1 using hostname
```bash
ping -c 3 web1
```

## 35. Test connectivity to web2 using hostname
```bash
ping -c 3 web2
```

## 36. SSH to web1 using hostname and update packages
```bash
ssh -i gcp_ssh_key -o StrictHostKeyChecking=no gcp_user@web1 "sudo apt update"
```

## 37. SSH to web2 using hostname and update packages
```bash
ssh -i gcp_ssh_key -o StrictHostKeyChecking=no gcp_user@web2 "sudo apt update"
```

## 38. Update local package lists
```bash
sudo apt update
```

## 39. Install software-properties-common for PPA support
```bash
sudo apt install -y software-properties-common
```

## 40. Add Ansible PPA repository
```bash
sudo add-apt-repository --yes --update ppa:ansible/ansible
```

## 41. Remove existing Ansible (to fix conflicts)
```bash
sudo apt remove -y ansible
```

## 42. Install latest Ansible from PPA
```bash
sudo apt install -y ansible
```

## 43. Verify Ansible installation and version
```bash
ansible --version
```

## 44. Install sshpass for Ansible SSH authentication
```bash
sudo apt install -y sshpass
```

## 45. Create Ansible inventory file
# File: inventory

## 46. Create Ansible configuration file
# File: ansible.cfg


## 47. Test Ansible ping on webservers group (using inventory file)
```bash
ansible webservers -m ping -i inventory
```

## 48. Test Ansible ping on webservers group (using config file)
```bash
ansible webservers -m ping
```

## 49. Execute hostname command using Ansible command module
```bash
ansible webservers -m command -a "hostname -I"
```

## 50. Execute hostname command using Ansible shell module
```bash
ansible webservers -m shell -a "hostname -I"
```

## 51. Create Ansible playbook to update and install nginx
# File: install_nginx.yml


## 52. Execute Ansible playbook on webservers
```bash
ansible-playbook install_nginx.yml
```

## NOTE:: ALIAS:: CONFIG
```bash
alias
alias w1='ssh -i gcp_ssh_key -o StrictHostKeyChecking=no gcp_user@web1 '
alias w2='ssh -i gcp_ssh_key -o StrictHostKeyChecking=no gcp_user@web2 '
alias
```


## 53. Check nginx service status on both servers
```bash
ansible webservers -m shell -a "systemctl status nginx --no-pager -l"
```

## 54. Test nginx web server response
```bash
ansible webservers -m shell -a "curl -I http://localhost"
```

## 55. Check port 80 listening status using Ansible
```bash
ansible webservers -m shell -a "ss -tulpn | grep :80"
```

## 56. Check port 80 on web1 using direct SSH
```bash
ssh -i gcp_ssh_key gcp_user@web1 "ss -tulpn | grep :80"
```

## 57. Check port 80 on web2 using direct SSH
```bash
ssh -i gcp_ssh_key gcp_user@web2 "ss -tulpn | grep :80"
```

## 58. List all GCP firewall rules
```bash
gcloud compute firewall-rules list
```

## 59. Describe SSH firewall rule details
```bash
gcloud compute firewall-rules describe default-allow-ssh
```

## 60. Describe ICMP firewall rule details
```bash
gcloud compute firewall-rules describe default-allow-icmp
```

## 61. Describe internal traffic firewall rule details
```bash
gcloud compute firewall-rules describe default-allow-internal
```

## 62. Describe RDP firewall rule details
```bash
gcloud compute firewall-rules describe default-allow-rdp
```

## 63. Install nmap port scanning tool
```bash
sudo apt install -y nmap
```

## 64. Scan web1 for port 80
```bash
nmap -p 80 web1
```

## 65. Scan web2 for port 80
```bash
nmap -p 80 web2
```

## 66. Comprehensive port scan on web1 (SSH, HTTP, HTTPS)
```bash
nmap -p 22,80,443 web1
```

## 67. Comprehensive port scan on web2 (SSH, HTTP, HTTPS)
```bash
nmap -p 22,80,443 web2
```

## 68. Install curl and wget tools
```bash
sudo apt install -y curl wget
```

## 69. Test web1 with curl (hostname)
```bash
curl web1
```

## 70. Test web1 with verbose curl
```bash
curl -v web1
```

## 71. Test web2 with curl
```bash
curl web2
```

## 72. Test web1 with wget spider mode
```bash
wget --spider web1
```

## 73. Test web2 with wget spider mode
```bash
wget --spider web2
```

## 74. Test web1 with timeout and direct IP
```bash
curl -v --connect-timeout 5 --max-time 10 web1
curl -v --connect-timeout 2 --max-time 3 web1
```

## 75. Create GCP firewall rule for HTTP and HTTPS
```bash
gcloud compute firewall-rules create allow-web-http --allow tcp:80,tcp:443 --source-ranges 0.0.0.0/0 --target-tags http-server --description "Allow HTTP and HTTPS traffic to web servers"

gcloud compute firewall-rules list
```

## 76. Add http-server tag to web1
```bash
gcloud compute instances add-tags web1 --tags http-server --zone europe-west9-b
```

## 77. Add http-server tag to web2
```bash
gcloud compute instances add-tags web2 --tags http-server --zone europe-west9-c
```

## 78. List all firewall rules to verify
```bash
gcloud compute firewall-rules list
```

## 79. Test web1 with curl after firewall rule
```bash
curl -v --connect-timeout 5 --max-time 10 web1
curl -v --connect-timeout 1 --max-time 2 web1
```

## 80. Test web2 with curl after firewall rule
```bash
curl -v --connect-timeout 5 --max-time 10 web2
curl -v --connect-timeout 1 --max-time 2 web2
```

## 81. Change nginx default HTML on web1
```bash
w1 "ls -anp /var/www/html/"

ssh -i gcp_ssh_key gcp_user@web1 "sudo tee /var/www/html/index.html > /dev/null << 'EOF'
<!DOCTYPE html>
<html>
<head>
<title>Welcome to web1!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
        text-align: center;
    }
    h1 {
        color: #2c3e50;
        font-size: 2.5em;
        margin-top: 2em;
    }
</style>
</head>
<body>
<h1>Welcome to web1!</h1>
<p>This is the custom page for web1 server.</p>
<p>Server is running nginx and accessible from the internet.</p>
</body>
</html>
EOF"

scp -i gcp_ssh_key web1.html gcp_user@web1:/var/www/html/index.html

scp -i gcp_ssh_key web1.html gcp_user@web1:/tmp/
w1 "sudo mv /tmp/web1.html /var/www/html/index.html"

```

## 82. Change nginx default HTML on web2
```bash
w2 "ls -anp /var/www/html/"

ssh -i gcp_ssh_key gcp_user@web2 "sudo tee /var/www/html/index.html > /dev/null << 'EOF'
<!DOCTYPE html>
<html>
<head>
<title>Welcome to web2!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
        text-align: center;
    }
    h1 {
        color: #27ae60;
        font-size: 2.5em;
        margin-top: 2em;
    }
</style>
</head>
<body>
<h1>Welcome to web2!</h1>
<p>This is the custom page for web2 server.</p>
<p>Server is running nginx and accessible from the internet.</p>
</body>
</html>
EOF"

scp -i gcp_ssh_key web2.html gcp_user@web2:/var/www/html/index.html

scp -i gcp_ssh_key web2.html gcp_user@web2:/tmp/
w2 "sudo mv /tmp/web2.html /var/www/html/index.html"

```

## 83. Verify web1 custom page with curl
```bash
curl web1
```

## 84. Verify web2 custom page with curl
```bash
curl web2
```

## 85. Create web1.html file locally
# File: web1.html


## 86. Create web2.html file locally
# File: web2.html


## 87. Copy web1.html to web1 server using SCP
```bash
scp -i gcp_ssh_key web1.html gcp_user@web1:/tmp/index.html
```

## 88. Move web1.html to nginx directory on web1
```bash
ssh -i gcp_ssh_key gcp_user@web1 "sudo mv /tmp/index.html /var/www/html/index.html"
```

## 89. Copy web2.html to web2 server using SCP
```bash
scp -i gcp_ssh_key web2.html gcp_user@web2:/tmp/index.html
```

## 90. Move web2.html to nginx directory on web2
```bash
ssh -i gcp_ssh_key gcp_user@web2 "sudo mv /tmp/index.html /var/www/html/index.html"
```

## 91. Verify web1 serves the copied file
```bash
curl web1
```

## 92. Verify web2 serves the copied file
```bash
curl web2
```

## 93. List local HTML files
```bash
ls -la *.html
```

## 94. Scan port 80 on web1 with nmap
```bash
nmap -p 80 web1
```

## 95. Scan port 80 on web2 with nmap
```bash
nmap -p 80 web2
```

## 96. Service detection scan on web1
```bash
nmap -p 80 -sV web1
```

## 97. Service detection scan on web2
```bash
nmap -p 80 -sV web2
```

## 98. List existing load balancers
```bash
gcloud compute forwarding-rules list
gcloud compute target-pools list
gcloud compute url-maps list
gcloud compute health-checks list
gcloud compute instance-groups list
```

## 99. Create target pool for web servers
```bash
gcloud compute target-pools create web-servers-pool --region europe-west9
```

## 100. Add web1 and web2 to target pool
```bash
gcloud compute target-pools add-instances web-servers-pool --instances-zone europe-west9-b --instances web1
gcloud compute target-pools add-instances web-servers-pool --instances-zone europe-west9-c --instances web2
```

## 101. Create forwarding rule for load balancer
```bash
gcloud compute forwarding-rules create web-lb-rule --region europe-west9 --ports 80 --target-pool web-servers-pool
```

## 102. List forwarding rules to verify load balancer
```bash
gcloud compute forwarding-rules list
```

## 103. List target pools to verify configuration
```bash
gcloud compute target-pools list
```

## 104. Describe target pool details
```bash
gcloud compute target-pools describe web-servers-pool --region europe-west9
```


## 105. Test load balancer - Request 1
```bash
curl wlb
```

## 106. Test load balancer - Request 2
```bash
curl wlb
```

## 107. Test load balancer - Request 3
```bash
curl wlb
```

## 108. Add load balancer IP to hosts file
```bash
echo "34.163.158.204 wlb" | sudo tee -a /etc/hosts
```

## 109. Verify hosts file entries
```bash
tail -3 /etc/hosts
```

## 110. Load test load balancer with 8 requests
```bash
for i in {1..8}; do echo "Request $i:"; curl -s wlb | grep -o "<h1>.*</h1>"; echo ""; done
```

## 111. List existing health checks
```bash
gcloud compute health-checks list
```

## 112. Create HTTP health check for web servers
```bash
gcloud compute http-health-checks create web-health-check --port 80 --request-path "/" --check-interval 5 --timeout 5 --unhealthy-threshold 3 --healthy-threshold 2
```

## 113. Describe health check configuration
```bash
gcloud compute http-health-checks describe web-health-check
```

## 114. Attach health check to target pool
```bash
gcloud compute target-pools add-health-checks web-servers-pool --http-health-check web-health-check --region europe-west9
```

## 115. Verify target pool with health check
```bash
gcloud compute target-pools describe web-servers-pool --region europe-west9
```

## 116. Update health check for faster response
```bash
gcloud compute http-health-checks update web-health-check --check-interval 3 --timeout 3 --unhealthy-threshold 2 --healthy-threshold 2
```

## 117. Check health status of target pool instances
```bash
gcloud compute target-pools get-health web-servers-pool --region europe-west9
```

## 118. List all health checks
```bash
gcloud compute http-health-checks list
```

## 119. Stop nginx on web2 to simulate server failure
```bash
ssh -i gcp_ssh_key gcp_user@web2 "sudo systemctl stop nginx"
```

## 120. Verify nginx stopped on web2
```bash
ssh -i gcp_ssh_key gcp_user@web2 "sudo systemctl status nginx"
```

## 121. Test load balancer with web2 down (10 requests)
```bash
for i in {1..10}; do echo "Request $i:"; curl -s --connect-timeout 5 --max-time 10 wlb | grep -o "<h1>.*</h1>" || echo "Request failed"; echo ""; done
```

## 122. Check health status after web2 failure
```bash
gcloud compute target-pools get-health web-servers-pool --region europe-west9
```

## 123. Restart nginx on web2 to restore service
```bash
ssh -i gcp_ssh_key gcp_user@web2 "sudo systemctl start nginx"
```

## 124. Verify nginx restarted on web2
```bash
ssh -i gcp_ssh_key gcp_user@web2 "sudo systemctl status nginx"
```

## 125. Verify health status after recovery
```bash
sleep 5 && gcloud compute target-pools get-health web-servers-pool --region europe-west9
```

## 126. Shutdown web1 instance
```bash
gcloud compute instances stop web1 --zone europe-west9-b
```

## 127. Shutdown web2 instance
```bash
gcloud compute instances stop web2 --zone europe-west9-b
```

## 128. Verify instances are stopped
```bash
gcloud compute instances list
```

## 129. Test load balancer with servers down
```bash
curl -s --connect-timeout 5 --max-time 10 wlb
```

## 130. Check health status with servers down
```bash
gcloud target-pools get-health web-servers-pool --region europe-west9
```

## 131. Analyze current load balancer configuration
```bash
gcloud compute forwarding-rules describe web-lb-rule --region europe-west9
```

## 132. Check for global load balancers
```bash
gcloud compute forwarding-rules list --global
```

## 133. Check available static addresses
```bash
gcloud compute addresses list
gcloud compute addresses list --global
```

## 134. Create regional static IP address
```bash
gcloud compute addresses create web-lb-ip --region europe-west9
```





## 135. Create global static IP address (for anycast)
```bash
gcloud compute addresses create web-lb-global --global
```

## 136. Verify global IP address details
```bash
gcloud compute addresses describe web-lb-global --global
gcloud compute addresses list --global

```

## 137. Create global HTTP health check
```bash
gcloud compute health-checks create http web-health-check-global --port 80 --request-path "/" --check-interval 5 --timeout 5 --unhealthy-threshold 3 --healthy-threshold 2 --global
```

## 138. Create global backend service
```bash
gcloud compute backend-services create web-lb-backend --protocol HTTP --health-checks web-health-check-global --global
```

## 139. Check region availability zones
```bash
gcloud compute regions describe europe-west9
```

## 140. Start existing web1 and web2 instances
```bash
gcloud compute instances start web1 --zone europe-west9-b
gcloud compute instances start web2 --zone europe-west9-b
```



## 141. Create web3 in europe-west1 region (Germany)
```bash
gcloud compute instances create web3 --machine-type e2-medium --zone europe-west1-b --image-family ubuntu-2204-lts --image-project ubuntu-os-cloud --tags http-server
```

## 142. Create web4 in europe-west1 region (Germany)
```bash
gcloud compute instances create web4 --machine-type e2-medium --zone europe-west1-b --image-family ubuntu-2204-lts --image-project ubuntu-os-cloud --tags http-server
```

## 143. Create unmanaged instance group for web3
```bash
gcloud compute instance-groups unmanaged create web3-group --zone europe-west1-b
```

## 144. Add web3 to instance group
```bash
gcloud compute instance-groups unmanaged add-instances web3-group --zone europe-west1-b --instances web3
```

## 145. Create unmanaged instance group for web4
```bash
gcloud compute instance-groups unmanaged create web4-group --zone europe-west1-b
```

## 146. Add web4 to instance group
```bash
gcloud compute instance-groups unmanaged add-instances web4-group --zone europe-west1-b --instances web4

gcloud compute instance-groups list

```

## Create a health check
```bash
gcloud compute health-checks create http web-hc \
  --port 80 \
  --request-path /

gcloud compute health-checks list

```


## Create the backend service
```bash
gcloud compute backend-services create web-lb-backend \
  --protocol HTTP \
  --port-name http \
  --health-checks web-hc \
  --global

gcloud compute backend-services list

```

## 147. Add web3 group to global backend service
```bash
gcloud compute backend-services add-backend web-lb-backend --instance-group web3-group --instance-group-zone europe-west1-b --global
```

## 148. Add web4 group to global backend service
```bash
gcloud compute backend-services add-backend web-lb-backend --instance-group web4-group --instance-group-zone europe-west1-b --global
```

## 149. Create URL map for global load balancer
```bash
gcloud compute url-maps create web-lb-map --default-service web-lb-backend

gcloud compute url-maps list
```

## 150. Create HTTP target proxy
```bash
gcloud compute target-http-proxies create web-lb-proxy --url-map web-lb-map

gcloud compute target-http-proxies list
```

## 151. Create global forwarding rule with anycast IP
```bash
gcloud compute forwarding-rules create web-global-lb --address web-lb-global --global --target-http-proxy web-lb-proxy --ports 80
```

## 152. Verify global load balancer configuration
```bash
gcloud compute forwarding-rules list
gcloud compute forwarding-rules list --global
```

## 153. List all running instances across regions
```bash
gcloud compute instances list
```

## 154. Test global load balancer with 12 requests
```bash
ping -c3 glb
for i in {1..12}; do echo "Request $i:"; curl -s --connect-timeout 1 --max-time 2 glb | grep -o "<h1>.*</h1>" || echo "Request failed or no content"; echo ""; done
```

## 155. Verify backend health status
```bash
gcloud compute backend-services get-health web-lb-backend --global
```

## 156. Install nginx on web3 (Germany)
```bash
gcloud compute ssh web3 --zone europe-west1-b --command "sudo apt update && sudo apt install -y nginx && sudo systemctl start nginx && sudo systemctl enable nginx"
```

## 157. Install nginx on web4 (Germany)
```bash
gcloud compute ssh web4 --zone europe-west1-b --command "sudo apt update && sudo apt install -y nginx && sudo systemctl start nginx && sudo systemctl enable nginx"
```


## 158. Create custom HTML page for web3
```bash
gcloud compute ssh web3 --zone europe-west1-b --command "sudo tee /var/www/html/index.html > /dev/null << 'EOF'
<!DOCTYPE html>
<html>
<head>
<title>Welcome to web3!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
        text-align: center;
    }
    h1 {
        color: #e74c3c;
        font-size: 2.5em;
        margin-top: 2em;
    }
</style>
</head>
<body>
<h1>Welcome to web3!</h1>
<p>This is the custom page for web3 server (Germany).</p>
<p>Server is running nginx and accessible from the internet.</p>
</body>
</html>
EOF"
```

## 159. Create custom HTML page for web4
```bash
gcloud compute ssh web4 --zone europe-west1-b --command "sudo tee /var/www/html/index.html > /dev/null << 'EOF'
<!DOCTYPE html>
<html>
<head>
<title>Welcome to web4!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
        text-align: center;
    }
    h1 {
        color: #f39c12;
        font-size: 2.5em;
        margin-top: 2em;
    }
</style>
</head>
<body>
<h1>Welcome to web4!</h1>
<p>This is the custom page for web4 server (Germany).</p>
<p>Server is running nginx and accessible from the internet.</p>
</body>
</html>
EOF"
```

## 160. Verify backend health after nginx setup
```bash
gcloud compute backend-services get-health web-lb-backend --global
```

## 161. Test global load balancer with 12 requests (final test)
```bash
for i in {1..12}; do echo "Request $i:"; curl -s --connect-timeout 1 --max-time 2 glb | grep -o "web.*" || echo "Request failed or no content"; echo ""; done
```

## 162. Extended load balancing test (20 requests)
```bash

gcloud compute ssh web3 --zone europe-west1-b --command "sudo systemctl stop nginx"

gcloud compute ssh web4 --zone europe-west1-b --command "sudo systemctl stop nginx"

for i in {1..12}; do echo "Request $i:"; curl -s --connect-timeout 1 --max-time 2 glb | grep -o "web.*" || echo "Request failed or no content"; echo ""; done

gcloud compute ssh web3 --zone europe-west1-b --command "sudo systemctl start nginx"

gcloud compute ssh web4 --zone europe-west1-b --command "sudo systemctl start nginx"


```

## 163. Check backend service configuration
```bash
gcloud compute backend-services describe web-lb-backend --global
```

## 164. Verify both backends are healthy
```bash
gcloud compute backend-services get-health web-lb-backend --global
```

## 165. Troubleshooting load balancing - Verify backend configuration
```bash
gcloud compute backend-services describe web-lb-backend --global --format="json"
```

## 166. Verify instance groups are properly configured
```bash
gcloud compute instance-groups unmanaged describe web3-group --zone europe-west1-b
gcloud compute instance-groups unmanaged describe web4-group --zone europe-west1-b
```

## 167. Verify instances in groups
```bash
gcloud compute instance-groups unmanaged list-instances web3-group --zone europe-west1-b
gcloud compute instance-groups unmanaged list-instances web4-group --zone europe-west1-b
```

## 168. Test failover by removing web3 from backend
```bash
gcloud compute backend-services remove-backend web-lb-backend --instance-group web3-group --instance-group-zone europe-west1-b --global
```

## 169. Test traffic with only web4 in backend
```bash
for i in {1..12}; do echo "Request $i:"; curl -s --connect-timeout 1 --max-time 2 glb | grep -o "web.*" || echo "Request failed or no content"; echo ""; done
```

## 170. Re-add web3 to backend service
```bash
gcloud compute backend-services add-backend web-lb-backend --instance-group web3-group --instance-group-zone europe-west1-b --global
```

## 171. Test traffic after re-adding web3
```bash
for i in {1..12}; do echo "Request $i:"; curl -s --connect-timeout 1 --max-time 2 glb | grep -o "web.*" || echo "Request failed or no content"; echo ""; done
```

## 172. Test with different HTTP headers to break persistence
```bash
for i in {1..12}; do echo "Request $i:"; curl -s --connect-timeout 1 --max-time 2 -H "Connection: close" glb | grep -o "web.*"; done

for i in {1..12}; do echo "Request $i:"; curl -s --connect-timeout 1 --max-time 2 -H "User-Agent: curl-test-$(date +%s)" glb | grep -o "web.*"; done
```

## 173. Complete cleanup of all GCP resources
```bash
# Global resources cleanup
gcloud compute forwarding-rules delete web-global-lb --global --quiet
gcloud compute target-http-proxies delete web-lb-proxy --quiet
gcloud compute url-maps delete web-lb-map --quiet
gcloud compute backend-services delete web-lb-backend --global --quiet
gcloud compute health-checks delete web-health-check-global --global --quiet

# Instance groups cleanup
gcloud compute instance-groups unmanaged delete web3-group --zone europe-west1-b --quiet
gcloud compute instance-groups unmanaged delete web4-group --zone europe-west1-b --quiet

# Regional resources cleanup
gcloud compute forwarding-rules delete web-lb-rule --region europe-west9 --quiet
gcloud compute target-pools delete web-servers-pool --region europe-west9 --quiet
gcloud compute http-health-checks delete web-health-check --quiet

# Firewall rules cleanup
gcloud compute firewall-rules delete allow-web-http --quiet

# Static IP addresses cleanup
gcloud compute addresses delete web-lb-global --global --quiet
gcloud compute addresses delete web-lb-ip --region europe-west9 --quiet

# Instances cleanup
gcloud compute instances stop web1 web2 --zone europe-west9-b --quiet
gcloud compute instances stop web3 web4 --zone europe-west1-b --quiet
```

## 174. Verify cleanup completion
```bash
gcloud compute forwarding-rules list --global
gcloud compute forwarding-rules list
gcloud compute instances list
```

## 175. Delete all compute instances
```bash
gcloud compute instances delete web1 --zone europe-west9-b --quiet
gcloud compute instances delete web2 --zone europe-west9-c --quiet
gcloud compute instances delete web3 web4 --zone europe-west1-b --quiet
```

## 176. Final verification - no instances remaining
```bash
gcloud compute instances list
```

## 177. Create GCP resource inventory script
## FILE >> gcp_inventory.sh


## 178. Make script executable
```bash
chmod +x gcp_inventory.sh
```

## 179. Test the inventory script
```bash
./gcp_inventory.sh | head -30
```


