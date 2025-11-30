# Packet Tracer Commands and Network Administration Guide

## Overview

This guide covers essential commands and tools available in Cisco Packet Tracer for network configuration, troubleshooting, and administration. Focus is on end devices (PCs and Notebooks) and the built-in tools for network testing and diagnostics.

## End Device Commands (PC/Notebook)

### Command Prompt Access
- **Location**: Desktop → Command Prompt
- **Alternative**: Click on PC/Notebook → Desktop Tab → Command Prompt

### Basic Network Configuration Commands

#### IP Configuration
```bash
# Display current IP configuration
ipconfig

# Display detailed IP configuration
ipconfig /all

# Release current IP address (DHCP)
ipconfig /release

# Renew IP address from DHCP server
ipconfig /renew

# Flush DNS resolver cache
ipconfig /flushdns

# Display DNS resolver cache
ipconfig /displaydns
```

#### Static IP Configuration
```bash
# Configure static IP address
# Go to Desktop → IP Configuration
# Or use GUI: Click PC → Desktop Tab → IP Configuration

# Manual IP Settings:
# IP Address: 192.168.1.10
# Subnet Mask: 255.255.255.0
# Default Gateway: 192.168.1.1
# DNS Server: 8.8.8.8
```

### Network Connectivity Testing

#### Ping Commands
```bash
# Basic ping test
ping 192.168.1.1

# Ping with specific packet count
ping -n 4 192.168.1.1

# Continuous ping (stop with Ctrl+C)
ping -t 192.168.1.1

# Ping with specific packet size
ping -l 1024 192.168.1.1

# Ping localhost (loopback test)
ping 127.0.0.1

# Ping by hostname
ping www.google.com
```

#### Advanced Ping Options
```bash
# Ping with timeout specification
ping -w 5000 192.168.1.1

# Don't fragment packets
ping -f 192.168.1.1

# Record route (up to 9 hops)
ping -r 9 192.168.1.1
```

### ARP (Address Resolution Protocol) Commands

#### Basic ARP Operations
```bash
# Display ARP table
arp -a

# Display ARP entries for specific interface
arp -a -N 192.168.1.10

# Add static ARP entry
arp -s 192.168.1.1 00-50-56-C0-00-01

# Delete ARP entry
arp -d 192.168.1.1

# Delete all ARP entries
arp -d *
```

### Traceroute Commands
```bash
# Trace route to destination
tracert 192.168.1.1

# Trace route with maximum hops
tracert -h 15 192.168.1.1

# Trace route without resolving hostnames
tracert -d 192.168.1.1
```

### DNS Commands
```bash
# DNS lookup
nslookup www.google.com

# Reverse DNS lookup
nslookup 8.8.8.8

# Query specific DNS server
nslookup www.google.com 8.8.8.8
```

### Network Statistics
```bash
# Display network statistics
netstat

# Display all connections and listening ports
netstat -a

# Display numerical addresses instead of resolving hosts
netstat -n

# Display routing table
netstat -r

# Display interface statistics
netstat -e
```

## Packet Tracer Built-in Tools

### 1. Simple PDU Tool
- **Purpose**: Test basic connectivity
- **Usage**: 
  - Select Simple PDU from toolbar
  - Click source device, then destination
  - Observe packet flow animation

### 2. Complex PDU Tool
- **Purpose**: Create custom packets for testing
- **Configuration Options**:
  - Protocol selection (ICMP, TCP, UDP)
  - Source/Destination ports
  - Packet details

### 3. Simulation Mode
- **Access**: Bottom right panel → Simulation
- **Features**:
  - Step-by-step packet analysis
  - Protocol inspection
  - Timing control
  - Event filtering

### 4. Realtime Mode
- **Purpose**: Normal network operation
- **Usage**: Networks operate at normal speed
- **Testing**: Real-time connectivity testing

## Network Testing Scenarios

### Basic Connectivity Test
```bash
# Step 1: Verify local configuration
ipconfig

# Step 2: Test loopback
ping 127.0.0.1

# Step 3: Test default gateway
ping 192.168.1.1

# Step 4: Test remote host
ping 8.8.8.8

# Step 5: Test DNS resolution
ping www.google.com
```

### DHCP Troubleshooting
```bash
# Check current IP (should show DHCP assigned)
ipconfig

# If no IP assigned, try renewal
ipconfig /release
ipconfig /renew

# Verify DHCP server communication
# Check if IP is in correct range
# Verify gateway and DNS settings
```

### VLAN Testing
```bash
# Test connectivity within same VLAN
ping [same_vlan_device_ip]

# Test connectivity across VLANs (should fail without routing)
ping [different_vlan_device_ip]

# Verify VLAN membership through switch configuration
```

### Routing Verification
```bash
# Check routing table
netstat -r

# Trace path to destination
tracert [destination_ip]

# Test multiple network segments
ping [network1_device]
ping [network2_device]
ping [network3_device]
```

## Important Testing Considerations

### 1. Layer 1 (Physical) Testing
- **Check Cable Connections**: Green lights indicate good connections
- **Port Status**: Verify ports are up on switches/routers
- **Cable Types**: Straight-through vs. crossover cables

### 2. Layer 2 (Data Link) Testing
- **Switch Port Configuration**: Access vs. trunk ports
- **VLAN Configuration**: Correct VLAN assignments
- **MAC Address Table**: Check switch learning

### 3. Layer 3 (Network) Testing
- **IP Configuration**: Correct subnet assignments
- **Routing Tables**: Proper route entries
- **Default Gateway**: Correct gateway configuration

### 4. Layer 4+ (Transport/Application) Testing
- **Port Accessibility**: TCP/UDP port testing
- **Service Availability**: Web, FTP, DNS services
- **Firewall Rules**: Access control verification

## Advanced Troubleshooting Techniques

### 1. Systematic Approach
```bash
# Start from bottom layer and work up
# 1. Physical connectivity
# 2. Data link (switching)
# 3. Network (routing)
# 4. Transport (ports)
# 5. Application (services)
```

### 2. Isolation Testing
```bash
# Test segment by segment
# Isolate problem to specific network section
# Use divide and conquer approach
```

### 3. Baseline Comparison
```bash
# Compare working vs. non-working configurations
# Document known good configurations
# Use configuration backups
```

## Common Network Administration Tasks

### 1. IP Address Management
- Plan IP addressing schemes
- Document subnet allocations
- Monitor IP address usage
- Implement DHCP reservations

### 2. Network Monitoring
```bash
# Regular connectivity tests
ping -t [critical_servers]

# Monitor ARP tables
arp -a

# Check network statistics
netstat -e
```

### 3. Performance Testing
```bash
# Large ping tests
ping -l 1472 [destination]

# Continuous monitoring
ping -t [destination]

# Multiple destination testing
# Test from multiple sources
```

### 4. Security Testing
```bash
# Verify network segmentation
# Test VLAN isolation
# Confirm access control lists
# Validate firewall rules
```

## Best Practices for Packet Tracer Testing

### 1. Documentation
- Document network topology
- Record IP addressing schemes
- Note configuration changes
- Maintain testing logs

### 2. Standardization
- Use consistent naming conventions
- Standardize IP addressing
- Create configuration templates
- Establish testing procedures

### 3. Simulation Usage
- Use Simulation mode for learning
- Step through protocols
- Analyze packet headers
- Understand timing

### 4. Real-world Preparation
- Test realistic scenarios
- Include failure conditions
- Practice troubleshooting
- Validate redundancy

## Packet Tracer Specific Tips

### 1. Device Limitations
- Not all IOS commands available
- Some features simplified
- Performance differences from real hardware
- Limited protocol support in some cases

### 2. Simulation Accuracy
- Timing may not be realistic
- Some protocols simplified
- Error conditions may be limited
- Convergence times may differ

### 3. Testing Environment
- Save configurations frequently
- Use meaningful device names
- Organize topology logically
- Test incrementally

## Troubleshooting Common Issues

### 1. Connectivity Problems
```bash
# Check each layer systematically
# 1. Cable connections (green lights)
# 2. IP configuration (ipconfig)
# 3. Gateway reachability (ping gateway)
# 4. DNS resolution (nslookup)
```

### 2. DHCP Issues
```bash
# Verify DHCP server configuration
# Check DHCP pool settings
# Ensure DHCP is enabled on interfaces
# Test DHCP renewal process
```

### 3. VLAN Problems
```bash
# Verify VLAN assignments
# Check trunk configurations
# Test inter-VLAN routing
# Validate VLAN database
```

### 4. Routing Issues
```bash
# Check routing tables (netstat -r)
# Verify route advertisements
# Test routing protocols
# Confirm next-hop reachability
```

---

**Note**: This guide covers commands and tools available in Cisco Packet Tracer. Some commands may have limited functionality compared to real network devices. Always refer to the latest Packet Tracer documentation for specific version capabilities.

**Remember**: Practice these commands and scenarios regularly to build strong network troubleshooting skills that transfer to real-world network administration.