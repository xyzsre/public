# Packet Tracer Multilayer Switches Guide (3550/3560)

## Overview

This guide covers multilayer switches in Cisco Packet Tracer, focusing on the Catalyst 3550 and 3560 series. These switches can operate at both Layer 2 and Layer 3, providing switching and routing capabilities in a single device. Learn about their differences, configuration examples, and advanced features.

## Available Multilayer Switches in Packet Tracer

### 1. Cisco Catalyst 3550-24
- **Ports**: 24 FastEthernet + 2 Gigabit uplinks
- **Capabilities**: Layer 2 switching + Layer 3 routing
- **Memory**: Limited compared to 3560
- **Features**: Basic Layer 3, limited routing protocols
- **Use Case**: Small to medium networks requiring basic routing

### 2. Cisco Catalyst 3560-24PS
- **Ports**: 24 FastEthernet + 2 Gigabit uplinks
- **PoE**: Power over Ethernet support
- **Capabilities**: Advanced Layer 2/3 features
- **Memory**: More memory and processing power
- **Features**: Full routing protocol support, advanced QoS
- **Use Case**: Enterprise distribution/access layer

### 3. Cisco Catalyst 3560G-24TS
- **Ports**: 24 Gigabit Ethernet + 4 SFP slots
- **Performance**: Higher throughput
- **Capabilities**: Full Layer 3 routing
- **Features**: Advanced security, QoS, and management
- **Use Case**: High-performance distribution layer

### 4. Other Multilayer Options
- **3750 Series**: Stackable multilayer switches
- **4506**: Modular chassis-based switch
- **6506**: High-end modular switch

## Comparison: 3550 vs 3560

| Feature | Catalyst 3550 | Catalyst 3560 |
|---------|---------------|----------------|
| **Layer 3 Performance** | Basic | Enhanced |
| **Routing Protocols** | RIP, EIGRP, OSPF (limited) | Full routing protocol support |
| **QoS Features** | Basic | Advanced QoS |
| **Security Features** | Standard | Enhanced security |
| **Memory** | Limited | More memory |
| **PoE Support** | No | Available on PS models |
| **Stacking** | No | No (3750 supports stacking) |
| **VLAN Support** | Up to 255 | Up to 4096 |
| **Routing Table Size** | Smaller | Larger capacity |
| **Price Point** | Lower cost | Higher cost, more features |

## Why Use Multilayer Switches?

### 1. Network Convergence
- **Single Device**: Combines switching and routing
- **Reduced Complexity**: Fewer devices to manage
- **Cost Effective**: Less expensive than separate router + switch
- **Space Saving**: Rack space optimization

### 2. Performance Benefits
- **Wire Speed**: Layer 3 switching at wire speed
- **Low Latency**: Hardware-based forwarding
- **High Throughput**: Dedicated ASICs for packet processing
- **Scalability**: Better performance as network grows

### 3. Design Flexibility
- **Collapsed Core**: Can serve as both access and distribution
- **Inter-VLAN Routing**: Route between VLANs locally
- **Redundancy**: Multiple Layer 3 paths
- **Load Balancing**: Traffic distribution across links

## Basic Multilayer Switch Configuration

### Initial Setup and Layer 3 Enabling

#### Accessing the Switch
```cisco
# Connect via console
enable
configure terminal

# Set hostname
hostname MLS1

# Enable IP routing (crucial for Layer 3 functionality)
ip routing

# Set passwords
enable secret cisco123
line console 0
password console123
login
exit

line vty 0 15
password telnet123
login
exit
```

#### Configuring SVIs (Switched Virtual Interfaces)

##### What are SVIs and Why Configure Them?
- **Definition**: Virtual interfaces for VLANs that enable Layer 3 functionality
- **Purpose**: Provide gateway for devices in VLANs
- **Benefits**: Inter-VLAN routing without external router
- **Use Cases**: Default gateways, management access, routing between subnets

```cisco
# Create VLANs first
vlan 10
name Sales
exit

vlan 20
name Marketing
exit

vlan 30
name IT
exit

vlan 99
name Management
exit

# Configure SVI for VLAN 10 (Sales)
interface vlan 10
description "Sales Gateway"
ip address 192.168.10.1 255.255.255.0
no shutdown
exit

# Configure SVI for VLAN 20 (Marketing)
interface vlan 20
description "Marketing Gateway"
ip address 192.168.20.1 255.255.255.0
no shutdown
exit

# Configure SVI for VLAN 30 (IT)
interface vlan 30
description "IT Gateway"
ip address 192.168.30.1 255.255.255.0
no shutdown
exit

# Configure Management SVI
interface vlan 99
description "Management Interface"
ip address 192.168.99.10 255.255.255.0
no shutdown
exit
```

### Access Port Configuration
```cisco
# Configure access ports for different VLANs
interface range fastethernet 0/1-8
description "Sales Department"
switchport mode access
switchport access vlan 10
spanning-tree portfast
no shutdown
exit

interface range fastethernet 0/9-16
description "Marketing Department"
switchport mode access
switchport access vlan 20
spanning-tree portfast
no shutdown
exit

interface range fastethernet 0/17-23
description "IT Department"
switchport mode access
switchport access vlan 30
spanning-tree portfast
no shutdown
exit
```

### Routed Port Configuration
```cisco
# Configure routed port (no switchport)
interface fastethernet 0/24
description "Routed connection to Router"
no switchport
ip address 10.1.1.2 255.255.255.252
no shutdown
exit

# Configure Gigabit routed port
interface gigabitethernet 0/1
description "Routed uplink"
no switchport
ip address 172.16.1.10 255.255.255.0
no shutdown
exit
```

## EtherChannel (Port Channel) Configuration

### Why Configure EtherChannel?
- **Bandwidth Aggregation**: Combine multiple links for higher bandwidth
- **Redundancy**: Load balancing and failover protection
- **Loop Prevention**: STP treats bundle as single link
- **Cost Effective**: Use multiple cheaper links instead of expensive high-speed links

### Layer 2 EtherChannel Configuration
```cisco
# Configure LACP EtherChannel (IEEE 802.3ad)
interface range fastethernet 0/23-24
description "EtherChannel to SW2"
channel-group 1 mode active
switchport mode trunk
switchport trunk allowed vlan 10,20,30,99
no shutdown
exit

# Configure the Port-Channel interface
interface port-channel 1
description "Layer 2 EtherChannel to SW2"
switchport mode trunk
switchport trunk allowed vlan 10,20,30,99
no shutdown
exit
```

### Layer 3 EtherChannel Configuration
```cisco
# Configure Layer 3 EtherChannel
interface range fastethernet 0/21-22
description "Layer 3 EtherChannel"
no switchport
channel-group 2 mode active
no shutdown
exit

# Configure Port-Channel interface for Layer 3
interface port-channel 2
description "Layer 3 EtherChannel to Core"
no switchport
ip address 10.10.10.1 255.255.255.252
no shutdown
exit
```

### PAgP EtherChannel (Cisco Proprietary)
```cisco
# Configure PAgP EtherChannel
interface range gigabitethernet 0/1-2
description "PAgP EtherChannel"
channel-group 3 mode desirable
no switchport
no shutdown
exit

interface port-channel 3
description "PAgP Layer 3 EtherChannel"
no switchport
ip address 192.168.100.1 255.255.255.0
no shutdown
exit
```

## Routing Configuration

### Static Routing
```cisco
# Configure static routes
ip route 192.168.40.0 255.255.255.0 10.1.1.1
ip route 192.168.50.0 255.255.255.0 172.16.1.1
ip route 0.0.0.0 0.0.0.0 10.1.1.1

# Configure floating static route (backup)
ip route 0.0.0.0 0.0.0.0 172.16.1.1 10
```

### OSPF Configuration
```cisco
# Enable OSPF
router ospf 1
router-id 1.1.1.1

# Advertise networks
network 192.168.10.0 0.0.0.255 area 0
network 192.168.20.0 0.0.0.255 area 0
network 192.168.30.0 0.0.0.255 area 0
network 10.1.1.0 0.0.0.3 area 0
network 172.16.1.0 0.0.0.255 area 0

# Configure passive interfaces for access VLANs
passive-interface vlan 10
passive-interface vlan 20
passive-interface vlan 30
exit
```

### EIGRP Configuration
```cisco
# Enable EIGRP
router eigrp 100

# Advertise networks
network 192.168.10.0 0.0.0.255
network 192.168.20.0 0.0.0.255
network 192.168.30.0 0.0.0.255
network 10.1.1.0 0.0.0.3
network 172.16.1.0 0.0.0.255

# Configure passive interfaces
passive-interface vlan 10
passive-interface vlan 20
passive-interface vlan 30

# Disable auto-summary
no auto-summary
exit
```

### RIP Configuration
```cisco
# Enable RIP version 2
router rip
version 2

# Advertise networks
network 192.168.10.0
network 192.168.20.0
network 192.168.30.0
network 10.1.1.0
network 172.16.1.0

# Configure passive interfaces
passive-interface vlan 10
passive-interface vlan 20
passive-interface vlan 30

# Disable auto-summary
no auto-summary
exit
```

## Verification Commands

### Layer 3 Verification
```cisco
# Show IP routing table
show ip route

# Show IP interface brief
show ip interface brief

# Show specific interface
show interface vlan 10

# Show routing protocols
show ip protocols

# Show OSPF neighbors
show ip ospf neighbor

# Show OSPF database
show ip ospf database

# Show EIGRP neighbors
show ip eigrp neighbors

# Show EIGRP topology
show ip eigrp topology
```

### EtherChannel Verification
```cisco
# Show EtherChannel summary
show etherchannel summary

# Show specific port-channel
show etherchannel 1 detail

# Show port-channel load balancing
show etherchannel load-balance

# Show LACP neighbor information
show lacp neighbor

# Show PAgP neighbor information
show pagp neighbor
```

### Layer 2 Verification
```cisco
# Show VLAN information
show vlan brief

# Show interface switchport status
show interfaces switchport

# Show spanning tree
show spanning-tree

# Show MAC address table
show mac address-table
```

## Troubleshooting and Debug Commands

### General Troubleshooting
```cisco
# Show running configuration
show running-config

# Show system information
show version

# Show interface statistics
show interfaces

# Show CDP neighbors
show cdp neighbors detail

# Show ARP table
show arp

# Clear ARP table
clear arp-cache
```

### Routing Troubleshooting
```cisco
# Debug IP routing
debug ip routing

# Debug OSPF events
debug ip ospf events

# Debug EIGRP packets
debug ip eigrp

# Show IP route details
show ip route [network]

# Test connectivity
ping [destination_ip]
traceroute [destination_ip]
```

### EtherChannel Troubleshooting
```cisco
# Debug EtherChannel events
debug etherchannel events

# Debug LACP
debug lacp

# Debug PAgP
debug pagp

# Show EtherChannel protocol
show etherchannel protocol

# Clear EtherChannel information
clear etherchannel
```

### Interface Troubleshooting
```cisco
# Show interface errors
show interfaces [interface] | include error

# Clear interface counters
clear counters [interface]

# Debug interface events
debug interface

# Show interface utilization
show interfaces [interface] | include rate
```

## Advanced Configuration Examples

### Complete Multilayer Switch Configuration

```cisco
# ===== MULTILAYER SWITCH CONFIGURATION =====

# Initial setup
enable
configure terminal
hostname MLS-CORE-1

# Enable routing
ip routing

# Set passwords
enable secret Cisco123!
line console 0
password Console123!
login
exit

line vty 0 15
password VTY123!
login
transport input ssh telnet
exit

# Configure SSH
ip domain-name company.com
crypto key generate rsa modulus 1024
username admin secret Admin123!
line vty 0 15
login local
exit

# Create VLANs
vlan 10
name Sales
exit

vlan 20
name Marketing
exit

vlan 30
name IT
exit

vlan 40
name Guest
exit

vlan 99
name Management
exit

# Configure SVIs for inter-VLAN routing
interface vlan 10
description "Sales Network Gateway"
ip address 192.168.10.1 255.255.255.0
ip helper-address 192.168.99.100
no shutdown
exit

interface vlan 20
description "Marketing Network Gateway"
ip address 192.168.20.1 255.255.255.0
ip helper-address 192.168.99.100
no shutdown
exit

interface vlan 30
description "IT Network Gateway"
ip address 192.168.30.1 255.255.255.0
ip helper-address 192.168.99.100
no shutdown
exit

interface vlan 40
description "Guest Network Gateway"
ip address 192.168.40.1 255.255.255.0
no shutdown
exit

interface vlan 99
description "Management Network"
ip address 192.168.99.10 255.255.255.0
no shutdown
exit

# Configure access ports
interface range fastethernet 0/1-6
description "Sales Department"
switchport mode access
switchport access vlan 10
switchport port-security
switchport port-security maximum 3
switchport port-security violation restrict
switchport port-security mac-address sticky
spanning-tree portfast
spanning-tree bpduguard enable
no shutdown
exit

interface range fastethernet 0/7-12
description "Marketing Department"
switchport mode access
switchport access vlan 20
switchport port-security
switchport port-security maximum 3
switchport port-security violation restrict
switchport port-security mac-address sticky
spanning-tree portfast
spanning-tree bpduguard enable
no shutdown
exit

interface range fastethernet 0/13-18
description "IT Department"
switchport mode access
switchport access vlan 30
switchport port-security
switchport port-security maximum 5
switchport port-security violation restrict
switchport port-security mac-address sticky
spanning-tree portfast
spanning-tree bpduguard enable
no shutdown
exit

# Configure EtherChannel to distribution switch
interface range fastethernet 0/23-24
description "EtherChannel to MLS-DIST-1"
channel-group 1 mode active
switchport mode trunk
switchport trunk allowed vlan 10,20,30,40,99
switchport trunk native vlan 99
no shutdown
exit

interface port-channel 1
description "Trunk to MLS-DIST-1"
switchport mode trunk
switchport trunk allowed vlan 10,20,30,40,99
switchport trunk native vlan 99
no shutdown
exit

# Configure routed uplink to core router
interface gigabitethernet 0/1
description "Routed uplink to Core Router"
no switchport
ip address 10.10.10.2 255.255.255.252
no shutdown
exit

# Configure Layer 3 EtherChannel to another core switch
interface range gigabitethernet 0/3-4
description "Layer 3 EtherChannel to MLS-CORE-2"
no switchport
channel-group 3 mode active
no shutdown
exit

interface port-channel 3
description "Layer 3 EtherChannel to MLS-CORE-2"
no switchport
ip address 172.16.1.1 255.255.255.252
no shutdown
exit

# Configure OSPF routing
router ospf 1
router-id 10.10.10.2
network 192.168.10.0 0.0.0.255 area 0
network 192.168.20.0 0.0.0.255 area 0
network 192.168.30.0 0.0.0.255 area 0
network 192.168.40.0 0.0.0.255 area 0
network 192.168.99.0 0.0.0.255 area 0
network 10.10.10.0 0.0.0.3 area 0
network 172.16.1.0 0.0.0.3 area 0
passive-interface vlan 10
passive-interface vlan 20
passive-interface vlan 30
passive-interface vlan 40
passive-interface vlan 99
exit

# Configure spanning tree
spanning-tree mode rapid-pvst
spanning-tree vlan 1,10,20,30,40,99 priority 4096

# Configure default route
ip route 0.0.0.0 0.0.0.0 10.10.10.1

# Save configuration
end
copy running-config startup-config
```

## Layer 2 and Layer 3 Switch Interconnection

### Why Connect Layer 2 and Layer 3 Switches?

#### 1. Hierarchical Design
- **Access Layer**: Layer 2 switches for end device connectivity
- **Distribution Layer**: Multilayer switches for inter-VLAN routing
- **Core Layer**: High-speed Layer 3 switches for backbone connectivity

#### 2. Cost Optimization
- **Edge Devices**: Use cheaper Layer 2 switches at access
- **Aggregation Points**: Use multilayer switches where routing needed
- **Scalability**: Add Layer 2 switches as network grows

#### 3. Functionality Separation
- **Access Layer**: VLAN assignment, port security, basic switching
- **Distribution Layer**: Inter-VLAN routing, policy enforcement
- **Core Layer**: High-speed forwarding, redundancy

### Configuration Example: Layer 2 to Layer 3 Connection

#### Layer 2 Switch (Access Layer)
```cisco
# ===== ACCESS LAYER SWITCH (Layer 2 Only) =====
hostname ACCESS-SW-1

# Create VLANs
vlan 10
name Sales
exit

vlan 20
name Marketing
exit

# Configure access ports
interface range fastethernet 0/1-12
switchport mode access
switchport access vlan 10
spanning-tree portfast
no shutdown
exit

interface range fastethernet 0/13-24
switchport mode access
switchport access vlan 20
spanning-tree portfast
no shutdown
exit

# Configure trunk to distribution layer
interface gigabitethernet 0/1
description "Trunk to Distribution MLS"
switchport mode trunk
switchport trunk allowed vlan 10,20
no shutdown
exit

# No IP routing configuration needed
# No SVIs needed (except management)
interface vlan 99
ip address 192.168.99.20 255.255.255.0
no shutdown
exit

ip default-gateway 192.168.99.1
```

#### Multilayer Switch (Distribution Layer)
```cisco
# ===== DISTRIBUTION LAYER SWITCH (Multilayer) =====
hostname DIST-MLS-1

# Enable routing
ip routing

# Configure SVIs for inter-VLAN routing
interface vlan 10
ip address 192.168.10.1 255.255.255.0
no shutdown
exit

interface vlan 20
ip address 192.168.20.1 255.255.255.0
no shutdown
exit

interface vlan 99
ip address 192.168.99.1 255.255.255.0
no shutdown
exit

# Configure trunk from access layer
interface gigabitethernet 0/1
description "Trunk from Access Switch"
switchport mode trunk
switchport trunk allowed vlan 10,20,99
no shutdown
exit

# Configure routed uplink to core
interface gigabitethernet 0/2
description "Routed uplink to Core"
no switchport
ip address 10.1.1.1 255.255.255.252
no shutdown
exit

# Configure routing
router ospf 1
network 192.168.10.0 0.0.0.255 area 0
network 192.168.20.0 0.0.0.255 area 0
network 192.168.99.0 0.0.0.255 area 0
network 10.1.1.0 0.0.0.3 area 0
passive-interface vlan 10
passive-interface vlan 20
passive-interface vlan 99
exit
```

## Performance and Monitoring

### Monitoring Commands
```cisco
# Monitor CPU utilization
show processes cpu

# Monitor memory usage
show memory

# Monitor interface utilization
show interfaces | include rate

# Monitor EtherChannel load distribution
show etherchannel summary

# Monitor routing table size
show ip route summary

# Monitor OSPF neighbor states
show ip ospf neighbor

# Monitor spanning tree topology
show spanning-tree summary
```

### Performance Optimization
```cisco
# Configure load balancing for EtherChannel
port-channel load-balance src-dst-ip

# Optimize spanning tree
spanning-tree mode rapid-pvst
spanning-tree portfast default
spanning-tree portfast bpduguard default

# Configure QoS (if supported)
mls qos
interface range fastethernet 0/1-24
mls qos trust dscp
exit
```

## Best Practices for Multilayer Switches

### 1. Design Considerations
- **Use SVIs for inter-VLAN routing** instead of router-on-a-stick
- **Implement redundant uplinks** with EtherChannel
- **Separate management traffic** with dedicated VLAN
- **Plan IP addressing** carefully for scalability

### 2. Security
- **Configure port security** on access ports
- **Use VLANs** to segment traffic
- **Implement access control** with routing protocols
- **Secure management access** with SSH

### 3. Redundancy
- **Configure multiple uplinks** with different protocols
- **Use EtherChannel** for link aggregation
- **Implement spanning tree** properly
- **Configure backup routes** with floating static routes

### 4. Monitoring
- **Monitor interface utilization** regularly
- **Check routing table convergence** after changes
- **Verify EtherChannel** load balancing
- **Monitor CPU and memory** usage

---

**Note**: This guide covers multilayer switch features available in Cisco Packet Tracer. Some advanced features may be simplified compared to real hardware. Practice these configurations in lab environments before implementing in production networks.

**Important**: Always test routing convergence and failover scenarios to ensure proper network operation. Document all configurations and maintain network diagrams for troubleshooting purposes.