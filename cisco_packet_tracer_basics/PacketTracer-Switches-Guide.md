# Packet Tracer Layer 2 Switches Guide

## Overview

This guide covers Layer 2 switches available in Cisco Packet Tracer, with detailed focus on the 2950-24, 2960, and other switch models. Learn about their differences, use cases, basic configuration commands, verification techniques, and supported protocols.

## Available Layer 2 Switches in Packet Tracer

### 1. Cisco Catalyst 2950-24
- **Ports**: 24 FastEthernet ports + 2 Gigabit uplinks
- **Use Case**: Small to medium business networks
- **Features**: Basic Layer 2 switching, VLANs, STP
- **IOS Version**: Limited feature set

### 2. Cisco Catalyst 2960
- **Ports**: 24 FastEthernet ports + 2 Gigabit uplinks
- **Use Case**: Enterprise access layer
- **Features**: Enhanced Layer 2 features, advanced VLANs, security
- **IOS Version**: More comprehensive feature set

### 3. Cisco Catalyst 3560 (Layer 2/3)
- **Ports**: 24/48 ports with Gigabit options
- **Use Case**: Distribution layer, can do Layer 3 routing
- **Features**: Layer 3 routing capabilities, advanced QoS
- **Note**: Can be configured as Layer 2 only

### 4. Generic Switch
- **Use Case**: Basic learning and simple topologies
- **Features**: Minimal configuration options
- **Purpose**: Educational basics

## Switch Comparison: 2950 vs 2960

| Feature | Catalyst 2950-24 | Catalyst 2960 |
|---------|------------------|----------------|
| **Ports** | 24 FastEthernet + 2 Gig | 24 FastEthernet + 2 Gig |
| **VLANs** | Up to 64 VLANs | Up to 255 VLANs |
| **STP Variants** | STP, RSTP | STP, RSTP, MST |
| **Security Features** | Basic port security | Enhanced port security |
| **QoS** | Limited | Advanced QoS features |
| **Management** | Basic SNMP | Enhanced management |
| **Power over Ethernet** | No | Available on some models |
| **Stacking** | No | No (2960-S supports stacking) |
| **Price/Performance** | Budget-friendly | Better performance/features |

## Why Use These Switches?

### Catalyst 2950-24
- **Cost-effective**: Budget-conscious deployments
- **Small networks**: Perfect for small office environments
- **Learning**: Good for basic switching concepts
- **Legacy support**: Still found in many networks

### Catalyst 2960
- **Enterprise standard**: Widely deployed in enterprise networks
- **Feature-rich**: Advanced Layer 2 features
- **Security**: Enhanced security capabilities
- **Scalability**: Better scalability options
- **Future-proof**: More current technology

## Basic Switch Configuration Commands

### Initial Setup

#### Accessing the Switch
```cisco
# Connect via console cable
# Press Enter to activate console
# No password required initially

# Enter privileged mode
enable

# Enter global configuration mode
configure terminal
```

#### Basic Hostname and Passwords
```cisco
# Set hostname
hostname SW1

# Set enable password
enable secret cisco123

# Set console password
line console 0
password console123
login
exit

# Set VTY (Telnet/SSH) passwords
line vty 0 15
password telnet123
login
exit
```

#### Interface Configuration
```cisco
# Enter interface configuration
interface fastethernet 0/1

# Set interface description
description "Connection to PC1"

# Enable the interface (if shutdown)
no shutdown

# Set interface to access mode
switchport mode access

# Assign to VLAN
switchport access vlan 10

# Exit interface configuration
exit
```

### VLAN Configuration

#### Creating VLANs
```cisco
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

vlan 99
name Management
exit
```

#### Assigning Ports to VLANs
```cisco
# Assign single port
interface fastethernet 0/1
switchport mode access
switchport access vlan 10
exit

# Assign range of ports
interface range fastethernet 0/2-5
switchport mode access
switchport access vlan 20
exit

# Configure trunk port
interface fastethernet 0/24
switchport mode trunk
switchport trunk allowed vlan 10,20,30,99
exit
```

### Spanning Tree Protocol (STP)

#### Basic STP Configuration
```cisco
# Enable spanning tree (enabled by default)
spanning-tree mode pvst

# Set root bridge priority
spanning-tree vlan 1 priority 4096

# Set port priority
interface fastethernet 0/1
spanning-tree vlan 1 port-priority 64
exit

# Set path cost
interface fastethernet 0/2
spanning-tree vlan 1 cost 19
exit
```

#### Rapid Spanning Tree (RSTP)
```cisco
# Enable RSTP
spanning-tree mode rapid-pvst

# Configure portfast for access ports
interface fastethernet 0/1
spanning-tree portfast
exit

# Configure BPDU guard
interface fastethernet 0/1
spanning-tree bpduguard enable
exit
```

### Port Security

#### Basic Port Security
```cisco
# Configure port security
interface fastethernet 0/1
switchport mode access
switchport port-security

# Set maximum MAC addresses
switchport port-security maximum 2

# Set violation action
switchport port-security violation shutdown

# Enable sticky learning
switchport port-security mac-address sticky

# Manually set MAC address
switchport port-security mac-address 0050.56c0.0001
exit
```

### Management IP Configuration

#### Setting Management IP
```cisco
# Configure management VLAN
interface vlan 99
ip address 192.168.99.10 255.255.255.0
no shutdown
exit

# Set default gateway
ip default-gateway 192.168.99.1
```

## Verification Commands

### Basic Show Commands
```cisco
# Show running configuration
show running-config

# Show startup configuration
show startup-config

# Show interface status
show interfaces status

# Show specific interface
show interface fastethernet 0/1

# Show IP interface brief
show ip interface brief
```

### VLAN Verification
```cisco
# Show VLAN database
show vlan brief

# Show VLAN detailed information
show vlan

# Show interface VLAN assignment
show interfaces switchport

# Show trunk interfaces
show interfaces trunk
```

### Spanning Tree Verification
```cisco
# Show spanning tree summary
show spanning-tree

# Show spanning tree for specific VLAN
show spanning-tree vlan 1

# Show spanning tree interface details
show spanning-tree interface fastethernet 0/1

# Show spanning tree root bridge
show spanning-tree root
```

### Port Security Verification
```cisco
# Show port security
show port-security

# Show port security interface
show port-security interface fastethernet 0/1

# Show port security addresses
show port-security address
```

### MAC Address Table
```cisco
# Show MAC address table
show mac address-table

# Show MAC addresses for specific VLAN
show mac address-table vlan 10

# Show MAC addresses for specific interface
show mac address-table interface fastethernet 0/1
```

## Troubleshooting Commands

### Interface Troubleshooting
```cisco
# Show interface errors
show interfaces fastethernet 0/1

# Clear interface counters
clear counters fastethernet 0/1

# Reset interface
interface fastethernet 0/1
shutdown
no shutdown
exit
```

### VLAN Troubleshooting
```cisco
# Verify VLAN membership
show vlan id 10

# Check trunk allowed VLANs
show interfaces fastethernet 0/24 trunk

# Verify VLAN configuration
show running-config | include vlan
```

### STP Troubleshooting
```cisco
# Check STP topology changes
show spanning-tree summary

# Debug STP (use carefully)
debug spanning-tree events

# Clear spanning tree counters
clear spanning-tree detected-protocols
```

## Supported Protocols and Features

### Layer 2 Protocols
1. **Spanning Tree Protocol (STP)**
   - 802.1D STP
   - 802.1w RSTP (Rapid STP)
   - Per-VLAN STP (PVST+)

2. **VLAN (Virtual LAN)**
   - 802.1Q VLAN tagging
   - VLAN Trunking Protocol (VTP)
   - Inter-Switch Link (ISL) - limited support

3. **Link Aggregation**
   - EtherChannel (LACP/PAgP)
   - Port bundling

4. **CDP (Cisco Discovery Protocol)**
   - Neighbor discovery
   - Device information sharing

### Security Features
1. **Port Security**
   - MAC address limiting
   - Sticky MAC learning
   - Violation actions

2. **DHCP Snooping**
   - DHCP message filtering
   - IP-MAC binding database

3. **Dynamic ARP Inspection**
   - ARP packet validation
   - Man-in-the-middle prevention

4. **Storm Control**
   - Broadcast storm prevention
   - Multicast storm control

## Complete Configuration Example

### Scenario: Small Office Network
- **3 VLANs**: Sales (10), Marketing (20), IT (30)
- **Management VLAN**: 99
- **Trunk link**: Between switches
- **Port security**: On access ports

```cisco
# ===== SWITCH 1 CONFIGURATION =====

# Initial setup
enable
configure terminal
hostname SW1

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

vlan 99
name Management
exit

# Configure access ports for Sales VLAN
interface range fastethernet 0/1-8
description "Sales Department"
switchport mode access
switchport access vlan 10
switchport port-security
switchport port-security maximum 2
switchport port-security violation shutdown
switchport port-security mac-address sticky
spanning-tree portfast
spanning-tree bpduguard enable
no shutdown
exit

# Configure access ports for Marketing VLAN
interface range fastethernet 0/9-16
description "Marketing Department"
switchport mode access
switchport access vlan 20
switchport port-security
switchport port-security maximum 2
switchport port-security violation shutdown
switchport port-security mac-address sticky
spanning-tree portfast
spanning-tree bpduguard enable
no shutdown
exit

# Configure access ports for IT VLAN
interface range fastethernet 0/17-23
description "IT Department"
switchport mode access
switchport access vlan 30
switchport port-security
switchport port-security maximum 2
switchport port-security violation shutdown
switchport port-security mac-address sticky
spanning-tree portfast
spanning-tree bpduguard enable
no shutdown
exit

# Configure trunk port to SW2
interface fastethernet 0/24
description "Trunk to SW2"
switchport mode trunk
switchport trunk allowed vlan 10,20,30,99
no shutdown
exit

# Configure Gigabit uplink to router
interface gigabitethernet 0/1
description "Uplink to Router"
switchport mode trunk
switchport trunk allowed vlan 10,20,30,99
no shutdown
exit

# Configure management IP
interface vlan 99
description "Management Interface"
ip address 192.168.99.10 255.255.255.0
no shutdown
exit

# Set default gateway
ip default-gateway 192.168.99.1

# Configure STP
spanning-tree mode rapid-pvst
spanning-tree vlan 1,10,20,30,99 priority 8192

# Save configuration
end
copy running-config startup-config
```

### Verification Commands for the Example
```cisco
# Verify VLAN configuration
show vlan brief

# Check interface status
show interfaces status

# Verify trunk configuration
show interfaces trunk

# Check spanning tree
show spanning-tree summary

# Verify port security
show port-security

# Check MAC address table
show mac address-table

# Verify management IP
show ip interface brief
```

### Expected Output Examples
```cisco
# show vlan brief output
VLAN Name                             Status    Ports
---- -------------------------------- --------- -------------------------------
1    default                          active    
10   Sales                            active    Fa0/1, Fa0/2, Fa0/3, Fa0/4
                                                Fa0/5, Fa0/6, Fa0/7, Fa0/8
20   Marketing                        active    Fa0/9, Fa0/10, Fa0/11, Fa0/12
                                                Fa0/13, Fa0/14, Fa0/15, Fa0/16
30   IT                               active    Fa0/17, Fa0/18, Fa0/19, Fa0/20
                                                Fa0/21, Fa0/22, Fa0/23
99   Management                       active    

# show interfaces status output
Port      Name               Status       Vlan       Duplex  Speed Type
Fa0/1     Sales Department   connected    10         auto    auto  10/100BaseTX
Fa0/24    Trunk to SW2       connected    trunk      auto    auto  10/100BaseTX
Gi0/1     Uplink to Router   connected    trunk      auto    auto  10/100BaseTX
```

## Common Troubleshooting Scenarios

### 1. VLAN Connectivity Issues
```cisco
# Problem: PC in VLAN 10 cannot communicate
# Solution steps:

# Check VLAN assignment
show vlan id 10

# Verify interface VLAN membership
show interfaces fastethernet 0/1 switchport

# Check trunk allowed VLANs
show interfaces trunk

# Verify spanning tree state
show spanning-tree vlan 10
```

### 2. Port Security Violations
```cisco
# Problem: Port keeps shutting down
# Solution steps:

# Check port security status
show port-security interface fastethernet 0/1

# Check for violations
show port-security

# Clear violation and re-enable
interface fastethernet 0/1
shutdown
clear port-security sticky interface fastethernet 0/1
no shutdown
exit
```

### 3. Spanning Tree Loops
```cisco
# Problem: Network performance issues
# Solution steps:

# Check for topology changes
show spanning-tree summary

# Identify root bridge
show spanning-tree root

# Check port states
show spanning-tree interface fastethernet 0/1 detail

# Configure portfast on access ports
interface fastethernet 0/1
spanning-tree portfast
exit
```

## Best Practices

### 1. Security
- Always configure port security on access ports
- Use strong passwords for management access
- Disable unused ports
- Configure management VLAN separate from user VLANs

### 2. VLAN Design
- Plan VLAN numbering scheme
- Document VLAN assignments
- Use descriptive VLAN names
- Limit broadcast domains appropriately

### 3. Spanning Tree
- Configure root bridge manually
- Use portfast on access ports
- Enable BPDU guard on access ports
- Monitor for topology changes

### 4. Management
- Configure management IP for remote access
- Use consistent naming conventions
- Document configurations
- Regular configuration backups

---

**Note**: This guide covers switch configurations available in Cisco Packet Tracer. Some advanced features may be simplified or unavailable compared to real hardware. Always test configurations in a lab environment before implementing in production networks.

**Practice Tip**: Start with basic configurations and gradually add complexity. Use the simulation mode in Packet Tracer to understand how protocols work at the packet level.