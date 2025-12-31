

# Comprehensive Guide: Building a High-Availability Web Infrastructure

This document provides a complete, step-by-step guide for setting up a redundant, load-balanced web server environment using VirtualBox, Vagrant, Nginx, HAProxy, and Keepalived. It covers everything from initial software installation to configuring an active-active load balancer setup.

---

## Part 1: Core Infrastructure Setup

### What is VirtualBox?

VirtualBox is a free and open-source hosted hypervisor for x86 virtualization, developed by Oracle. A hypervisor allows you to run multiple operating systems (known as "guest" operating systems) on a single physical machine (the "host" operating system).

*   **Use Cases:** Development environments, testing software on different operating systems, running legacy applications, and learning about system administration.
*   **Pros:**
    *   **Free and Open Source:** No licensing costs.
    *   **Cross-Platform:** Runs on Windows, macOS, Linux, and Solaris.
    *   **Good for Development:** Excellent for creating isolated development and testing environments on a local machine.
*   **Cons:**
    *   **Type 2 Hypervisor:** As a "hosted" hypervisor, it runs on top of a conventional OS. This introduces some performance overhead compared to Type 1 ("bare-metal") hypervisors like VMware ESXi or KVM.
    *   **Not for Production:** Generally not recommended for large-scale production workloads, which are better suited for enterprise-grade hypervisors.

### 1.1. Installing VirtualBox 7.2

**Objective:** Install the virtualization software that will host our virtual machines.

**Commands:**

```bash
# Add the Oracle GPG key to trust the repository
wget -O- https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --yes --output /usr/share/keyrings/oracle-virtualbox-2016.gpg --dearmor

# Add the VirtualBox repository to your system's sources
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian jammy contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list

# Update package lists and install VirtualBox
sudo apt-get update
sudo apt-get install -y virtualbox-7.2

# Install build dependencies (if needed) and configure kernel modules
sudo apt-get install -y gcc-12
sudo /sbin/vboxconfig

# Verify the installation
vboxmanage --version
```

**Explanation:** These commands set up the official VirtualBox repository, which ensures we install a trusted and up-to-date version. The `vboxconfig` command is crucial for building the kernel modules that allow VirtualBox to run correctly.

### What is Vagrant?

Vagrant is a tool for building and managing virtual machine environments in a single workflow. It acts as a wrapper around virtualization software like VirtualBox, allowing you to define your infrastructure as code in a file called a `Vagrantfile`.

*   **Use Cases:** Creating portable, reproducible development environments; automating the setup of complex multi-machine environments; DevOps and infrastructure-as-code practices.
*   **Pros:**
    *   **Reproducibility:** Ensures that every developer on a team has the exact same environment, eliminating "it works on my machine" problems.
    *   **Automation:** Automates the entire process of creating, provisioning, and networking virtual machines.
    *   **Portability:** The `Vagrantfile` can be shared, allowing anyone to spin up the same environment with a single `vagrant up` command.
*   **Cons:**
    *   **Dependency:** It is not a standalone solution; it requires a virtualization provider (like VirtualBox) to be installed.
    *   **Local Focus:** Primarily designed for managing local development environments, not for managing production cloud infrastructure (for which tools like Terraform are better suited).

### 1.2. Installing Vagrant

**Objective:** Install the tool used to automate the creation and management of our virtual machines.

**Commands:**

```bash
# Add the HashiCorp GPG key
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

# Add the HashiCorp repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

# Update package lists and install Vagrant
sudo apt-get update
sudo apt-get install -y vagrant

# Verify the installation
vagrant --version
```

**Explanation:** Similar to the VirtualBox setup, these commands add the official HashiCorp repository to install Vagrant securely. Vagrant reads a `Vagrantfile` to define and provision the infrastructure as code.

---

## Part 2: Web Server Configuration

**Objective:** Set up two identical web servers that will serve our application content.

**Commands:**

```bash
# Start the entire environment defined in the Vagrantfile
vagrant up

# Install Nginx on both web servers
vagrant ssh Web1 -c "sudo apt-get update && sudo apt-get install -y nginx"
vagrant ssh Web2 -c "sudo apt-get update && sudo apt-get install -y nginx"

# Start and enable the Nginx service on both
vagrant ssh Web1 -c "sudo systemctl start nginx && sudo systemctl enable nginx"
vagrant ssh Web2 -c "sudo systemctl start nginx && sudo systemctl enable nginx"

# Customize the welcome page for each server to identify them
vagrant ssh Web1 -c "echo '<h1>Welcome to Server 1</h1>' | sudo tee /var/www/html/index.html"
vagrant ssh Web2 -c "echo '<h1>Welcome to Server 2</h1>' | sudo tee /var/www/html/index.html"

# Verify that both servers are responding with their custom pages
curl 192.168.56.12
curl 192.168.56.13
```

**Explanation:** We provision two Ubuntu VMs, install the Nginx web server on each, and customize their homepages. This customization is critical for verifying that our load balancing is working correctly later on.

---

## Part 3: Load Balancer Setup with HAProxy

### What is HAProxy?

HAProxy (High Availability Proxy) is a free, open-source, and incredibly fast and reliable reverse proxy offering high availability, load balancing, and proxying for TCP and HTTP-based applications.

*   **Use Cases:** Distributing web traffic across multiple servers, ensuring high availability and reliability of web services, SSL termination, and providing a single point of access to a cluster of servers.
*   **Pros:**
    *   **Performance:** It is extremely lightweight and one of the fastest software load balancers available.
    *   **Reliability:** It is battle-tested and known for its stability in high-traffic production environments.
    *   **Advanced Health Checks:** Offers sophisticated health-checking mechanisms to automatically detect and remove failed servers from the pool.
*   **Cons:**
    *   **Complexity:** The configuration file can be complex for advanced scenarios.
    *   **Limited Scope:** It is primarily a load balancer and reverse proxy, lacking the broader feature set of a full web server like Nginx (though it excels at its core function).

**Objective:** Set up two load balancers to distribute incoming traffic between the two web servers.

### 3.1. HAProxy Installation

**Commands:**

```bash
# Install HAProxy on both load balancer VMs
vagrant ssh LB1 -c "sudo apt-get update && sudo apt-get install -y haproxy"
vagrant ssh LB2 -c "sudo apt-get update && sudo apt-get install -y haproxy"

# Start and enable the HAProxy service on both
vagrant ssh LB1 -c "sudo systemctl start haproxy && sudo systemctl enable haproxy"
vagrant ssh LB2 -c "sudo systemctl start haproxy && sudo systemctl enable haproxy"
```

### 3.2. HAProxy Configuration for Load Balancing

**Objective:** Configure HAProxy to perform health checks and distribute traffic in a round-robin fashion.

**`haproxy.cfg` Content:**

```
global
    log /dev/log    local0
    daemon

defaults
    log     global
    mode    http
    option  httplog
    timeout connect 5000
    timeout client  50000
    timeout server  50000

frontend http_front
    bind *:80
    default_backend http_back

backend http_back
    balance roundrobin
    server web1 192.168.56.12:80 check
    server web2 192.168.56.13:80 check
```

**Commands:**

```bash
# Copy the configuration to both load balancers and restart the service
vagrant ssh LB1 -c "sudo cp /vagrant/haproxy.cfg /etc/haproxy/haproxy.cfg && sudo systemctl restart haproxy"
vagrant ssh LB2 -c "sudo cp /vagrant/haproxy.cfg /etc/haproxy/haproxy.cfg && sudo systemctl restart haproxy"
```

**Explanation:** The `check` parameter in the `backend` section tells HAProxy to actively monitor the health of the web servers. If a server fails a health check, HAProxy will automatically stop sending traffic to it.

---

## Part 4: High Availability with Keepalived

### What is Keepalived?

Keepalived is a routing software written in C. Its main goal is to provide simple and robust facilities for load balancing and high availability. It operates by using the Virtual Router Redundancy Protocol (VRRP), which allows for a "floating" virtual IP (VIP) to be shared between two or more servers.

*   **Use Cases:** Creating a high-availability pair for load balancers, firewalls, or other critical network services. It ensures that if the primary server fails, the backup server automatically takes over its IP address and continues to provide service.
*   **Pros:**
    *   **Reliable Failover:** Implements the industry-standard VRRP protocol for fast and reliable automatic failover.
    *   **Lightweight:** It has a small footprint and consumes minimal system resources.
    *   **Integrated Health Checks:** Can monitor services (like HAProxy) and trigger a failover if the service itself fails, not just the machine.
*   **Cons:**
    *   **Active/Passive by Default:** The standard VRRP setup results in an active/passive cluster, meaning the backup server is idle. Achieving an active/active setup requires a more complex configuration with multiple instances, as we demonstrated.
    *   **Network-Level Only:** It only manages IP addresses and does not provide any application-level load balancing itself; it is designed to be paired with a service like HAProxy.

### 4.1. Active/Passive Setup

**Objective:** Create a single floating virtual IP (VIP) that fails over from a `MASTER` load balancer to a `BACKUP` if the master goes down.

*   **Pros:** Simple to configure and provides fast, automatic failover.
*   **Cons:** The backup server is idle and unused during normal operation, representing wasted resources.

**Commands & Configuration:**

```bash
# Install Keepalived on both load balancers
vagrant ssh LB1 -c "sudo apt-get update && sudo apt-get install -y keepalived"
vagrant ssh LB2 -c "sudo apt-get update && sudo apt-get install -y keepalived"

# --- Configuration for LB1 (MASTER) --- #
# vrrp_instance VI_1 {
#     state MASTER
#     interface enp0s8
#     virtual_router_id 51
#     priority 101
#     ...
#     virtual_ipaddress { 192.168.56.100 }
# }

# --- Configuration for LB2 (BACKUP) --- #
# vrrp_instance VI_1 {
#     state BACKUP
#     interface enp0s8
#     virtual_router_id 51
#     priority 100
#     ...
#     virtual_ipaddress { 192.168.56.100 }
# }

# Apply new configurations to both LBs and restart keepalived
vagrant ssh LB1 -c "sudo cp /vagrant/keepalived_master.conf /etc/keepalived/keepalived.conf && sudo systemctl restart keepalived"
vagrant ssh LB2 -c "sudo cp /vagrant/keepalived_backup.conf /etc/keepalived/keepalived.conf && sudo systemctl restart keepalived"

sudo systemctl status keepalived

# --- Kernel Tuning for VIP (on BOTH LBs) --- #
# This allows HAProxy to bind to an IP that isn't physically on the machine
# and fixes ARP issues.
sudo sysctl -w net.ipv4.ip_nonlocal_bind=1
sudo sysctl -w net.ipv4.conf.all.arp_ignore=1
sudo sysctl -w net.ipv4.conf.all.arp_announce=2

# Make settings persistent (on BOTH LBs)
echo 'net.ipv4.ip_nonlocal_bind=1' | sudo tee -a /etc/sysctl.conf
echo 'net.ipv4.conf.all.arp_ignore=1' | sudo tee -a /etc/sysctl.conf
echo 'net.ipv4.conf.all.arp_announce=2' | sudo tee -a /etc/sysctl.conf

# Apply configurations and restart services
# (Copy keepalived.conf files and restart keepalived on both LBs)
vagrant ssh LB1 -c "sudo systemctl restart keepalived"
vagrant ssh LB2 -c "sudo systemctl restart keepalived"

vagrant ssh LB1 -c "ss -tupln"
vagrant ssh LB2 -c "ss -tupln"

vagrant ssh LB1 -c "ip addr"
vagrant ssh LB2 -c "ip addr"

vagrant ssh LB1 -c "ip addr | grep 56.100"
vagrant ssh LB2 -c "ip addr | grep 56.100"

for i in {1..4}; do curl 192.168.56.100; done
for i in {1..100}; do curl 192.168.56.100; sleep 1; done
for i in {1..4}; do curl http://www.domain.local; done


```

### 4.2. Active/Active Setup

**Objective:** Make both load balancers active simultaneously by assigning a separate virtual IP to each, with the other server acting as its backup. This maximizes resource utilization.

*   **Pros:** Utilizes all available resources. Doubles the capacity of the load-balancing tier.
*   **Cons:** Slightly more complex to configure and manage.

**Commands & Configuration:**

```bash
# --- Configuration for LB1 (MASTER for .100, BACKUP for .200) --- #
# vrrp_instance VI_1 { state MASTER; priority 101; virtual_ipaddress { 192.168.56.100 } }
# vrrp_instance VI_2 { state BACKUP; priority 100; virtual_ipaddress { 192.168.56.200 } }

# --- Configuration for LB2 (BACKUP for .100, MASTER for .200) --- #
# vrrp_instance VI_1 { state BACKUP; priority 100; virtual_ipaddress { 192.168.56.100 } }
# vrrp_instance VI_2 { state MASTER; priority 101; virtual_ipaddress { 192.168.56.200 } }

# Apply new configurations to both LBs and restart keepalived
vagrant ssh LB1 -c "sudo cp /vagrant/keepalived.lb1.conf /etc/keepalived/keepalived.conf && sudo systemctl restart keepalived"
vagrant ssh LB2 -c "sudo cp /vagrant/keepalived.lb2.conf /etc/keepalived/keepalived.conf && sudo systemctl restart keepalived"

vagrant ssh LB1 -c "sudo systemctl status keepalived --no-pager"
vagrant ssh LB2 -c "sudo systemctl status keepalived --no-pager"

ping -c2 192.168.56.100
ping -c2 192.168.56.200

arp
ip neighbor
ip neighbor | grep -E "56.100|56.200"


vagrant ssh LB1 -c "ss -tupln | grep :80"
vagrant ssh LB2 -c "ss -tupln | grep :80"

vagrant ssh LB1 -c "ip addr"
vagrant ssh LB2 -c "ip addr"

vagrant ssh LB1 -c "ip addr | grep -E '56.100|56.200'"
vagrant ssh LB2 -c "ip addr | grep -E '56.100|56.200'"

for i in {1..4}; do curl 192.168.56.100; done
for i in {1..4}; do curl 192.168.56.200; done

for i in {1..100}; do curl 192.168.56.100; sleep 1; done
for i in {1..100}; do curl 192.168.56.200; sleep 1; done

for i in {1..4}; do curl http://test1.domain.local; done
for i in {1..4}; do curl http://test2.domain.local; done

for i in {1..1000}; do curl http://test2.domain.local; sleep 1; done


```

---

## Part 5: Testing the Final Setup

### 5.1. Testing Web Server Failover

**Objective:** Verify that HAProxy health checks correctly remove a failed web server from the load-balancing pool.

```bash
# Shut down one web server
vagrant halt Web1

# All traffic should now go to the remaining healthy server
for i in {1..4}; do curl 192.168.56.100; done

# Bring the server back online
vagrant up Web1

# Traffic should now be balanced between both servers again
for i in {1..4}; do curl 192.168.56.100; done
```

### 5.2. Testing Load Balancer Failover

**Objective:** Verify that Keepalived correctly fails over the virtual IP(s) when a load balancer goes down.

```bash
# Shut down the primary load balancer for the .100 VIP
vagrant halt LB1

# Check that LB2 has acquired the .100 VIP
vagrant ssh LB2 -c "ip addr show enp0s8"

# Verify that traffic is still being served through the VIP
for i in {1..4}; do curl 192.168.56.100; done

# Bring the primary load balancer back online
vagrant up LB1

# Check that LB1 has reclaimed the .100 VIP
vagrant ssh LB1 -c "ip addr show enp0s8"
```

---

## Resources

### Official Documentation
- [VirtualBox Manual](https://www.virtualbox.org/manual/)
- [Vagrant Documentation](https://www.vagrantup.com/docs/)
- [VirtualBox Forums](https://forums.virtualbox.org/)
- [Vagrant Community](https://www.vagrantup.com/docs/community)

### Tutorials and Guides
- [VirtualBox User Guide](https://www.virtualbox.org/wiki/UserDocumentation)
- [Vagrant Getting Started](https://www.vagrantup.com/intro/getting-started/)
- [Home Lab Setup Guides](https://github.com/topics/home-lab)


URLs/Refs::

https://www.vmware.com/products/desktop-hypervisor/workstation-and-fusion

https://www.virtualbox.org/

https://developer.hashicorp.com/vagrant

https://ubuntu.com/download/desktop

https://ubuntu.com/download/server

https://developer.hashicorp.com/vagrant/docs/boxes

https://portal.cloud.hashicorp.com/vagrant/discover

https://aws.amazon.com/free/

https://azure.microsoft.com/en-us/pricing/purchase-options/azure-account

https://cloud.google.com/free

https://www.digitalocean.com/landing/do-for-higher-education

https://upcloud.com/docs/getting-started/free-trial/


