# Cisco Catalyst 2950 Switch - Comprehensive Guide

## Table of Contents
- [Overview](#overview)
- [2950 Series Models](#2950-series-models)
- [Hardware Capabilities](#hardware-capabilities)
- [Use Cases](#use-cases)
- [Core Switching Concepts](#core-switching-concepts)
- [VLAN Configuration](#vlan-configuration)
- [VTP (VLAN Trunking Protocol)](#vtp-vlan-trunking-protocol)
- [Spanning Tree Protocol](#spanning-tree-protocol)
- [Port Aggregation](#port-aggregation)
- [Port Types](#port-types)
- [Command Reference](#command-reference)
- [Troubleshooting Guide](#troubleshooting-guide)

## Overview

The Cisco Catalyst 2950 series is a legacy line of Layer 2 switches that was widely deployed in enterprise networks during the early 2000s. While now end-of-life, these switches are still found in many lab environments and legacy networks, making them important for CCNA/CCNP studies and network maintenance.

## 2950 Series Models

### Main Variants
- **2950-12**: 12 10/100 ports, 2 GBIC slots
- **2950-24**: 24 10/100 ports, 2 GBIC slots
- **2950-48**: 48 10/100 ports, 2 GBIC slots
- **2950C-12**: 12 10/100 ports, copper uplinks
- **2950C-24**: 24 10/100 ports, copper uplinks
- **2950C-48**: 48 10/100 ports, copper uplinks

### Enhanced Models
- **2950G-12**: 12 ports with 2 Gigabit Ethernet ports
- **2950G-24**: 24 ports with 2 Gigabit Ethernet ports
- **2950G-48**: 48 ports with 2 Gigabit Ethernet ports
- **2950T-24**: 24 ports with 4 10/100/1000 copper ports

### PoE Models
- **2950-24-PWR**: 24 ports with Power over Ethernet
- **2950-48-PWR**: 48 ports with Power over Ethernet

### Key Features by Model
- **Standard**: 10/100 Mbps access ports with GBIC uplinks
- **C**: Copper uplinks instead of GBIC
- **G**: Gigabit Ethernet uplinks
- **T**: Dual-purpose uplinks (copper/fiber)
- **PWR**: Power over Ethernet capabilities

## Hardware Capabilities

### Switching Capacity
- **Forwarding Rate**: 6.8-13.6 Gbps (varies by model)
- **Packet Forwarding Rate**: 6.5-10.1 Mpps
- **MAC Address Table**: 8,000 entries
- **VLAN Support**: Up to 250 VLANs

### Memory and Processing
- **DRAM**: 64MB-128MB
- **Flash Memory**: 16MB-32MB
- **CPU**: Motorola PowerPC 8245 processor

### Physical Specifications
- **Form Factor**: 1U rack-mountable
- **Weight**: 3.2-7.0 kg (varies by model)
- **Power Consumption**: 30-50W (non-PoE), up to 370W (PoE models)
- **Operating Temperature**: 0°C to 40°C
- **Operating Humidity**: 10% to 85% (non-condensing)

### Interface Types
- **10/100 Mbps Ethernet**: RJ-45 access ports
- **GBIC Slots**: Fiber connectivity (1000BASE-SX, 1000BASE-LX)
- **Gigabit Ethernet**: RJ-45 or fiber uplinks (varies by model)
- **Console Port**: RS-232 serial management

### Limitations vs 2960
- **Lower Performance**: Reduced forwarding capacity
- **Limited VLANs**: 250 vs 1,005 VLANs
- **No IPv6**: No IPv6 management support
- **Limited QoS**: Basic QoS features only
- **No StackWise**: No stacking capabilities

## Use Cases

### 1. Legacy Network Support
- **Primary Role**: Maintaining existing installations
- **Typical Deployment**: Networks with mixed hardware generations
- **Key Benefits**: Compatibility with existing infrastructure

### 2. Lab and Training Environments
- **Primary Role**: CCNA/CCNP lab equipment
- **Typical Deployment**: Educational institutions and training centers
- **Key Benefits**: Low-cost learning platform

### 3. Small Office Networks
- **Primary Role**: Basic connectivity for small offices
- **Typical Deployment**: 10-50 users per switch
- **Key Benefits**: Simple configuration, reliable operation

### 4. Branch Office Edge
- **Primary Role**: Edge connectivity for remote sites
- **Typical Deployment**: Connected to central site via WAN
- **Key Benefits**: Cost-effective edge solution

### 5. Industrial Control Networks
- **Primary Role**: Legacy industrial networking
- **Typical Deployment**: Manufacturing environments
- **Key Benefits**: Proven reliability in harsh conditions

## Core Switching Concepts

### VLAN (Virtual Local Area Network)

#### What is VLAN?
VLAN is a logical segmentation of a physical network into multiple broadcast domains. Devices in different VLANs cannot communicate directly without a Layer 3 device.

#### VLAN Benefits
- **Security**: Isolates traffic between departments
- **Performance**: Reduces broadcast traffic
- **Management**: Simplifies network administration
- **Flexibility**: Logical grouping regardless of physical location

#### VLAN Types on 2950
- **Data VLAN**: Standard user traffic
- **Native VLAN**: Untagged traffic on trunk ports
- **Management VLAN**: Switch management traffic
- **Default VLAN**: VLAN 1 (used for management by default)

### VTP (VLAN Trunking Protocol)

#### What is VTP?
VTP is a Cisco proprietary protocol that propagates VLAN information across the switched network. It ensures consistent VLAN configuration throughout the network.

#### VTP Modes
- **Server Mode**: Can create, modify, and delete VLANs; propagates changes
- **Client Mode**: Receives and synchronizes VLAN information; cannot modify
- **Transparent Mode**: Forwards VTP advertisements but doesn't participate; maintains local VLAN database

#### VTP Benefits
- **Centralized Management**: Single point of VLAN administration
- **Consistency**: Ensures all switches have same VLAN information
- **Scalability**: Simplifies VLAN management in large networks

#### VTP Configuration
```bash
# Set VTP mode
vtp mode server
vtp mode client
vtp mode transparent

# Set VTP domain name
vtp domain COMPANY

# Set VTP password
vtp password cisco

# Set VTP version
vtp version 2

# Set VTP pruning
vtp pruning
```

### STP (Spanning Tree Protocol)

#### What is STP?
STP prevents network loops in Layer 2 networks by creating a loop-free logical topology. It blocks redundant paths while maintaining backup links for failover.

#### STP Operation
1. **Root Bridge Election**: Switch with lowest bridge ID becomes root
2. **Port Roles**: Root port, designated port, blocking port
3. **Path Cost**: Calculates best path to root bridge
4. **Convergence**: Network adapts to topology changes

#### STP States
- **Blocking**: No user traffic, only BPDUs
- **Listening**: Process BPDUs, prepare to forward
- **Learning**: Learn MAC addresses, prepare to forward
- **Forwarding**: Forward user traffic
- **Disabled**: Administratively down

### PVST (Per-VLAN Spanning Tree)

#### What is PVST?
PVST runs a separate STP instance for each VLAN, providing better load balancing and faster convergence than traditional STP.

#### PVST Benefits
- **Load Balancing**: Different VLANs can use different paths
- **Optimization**: Better bandwidth utilization
- **Isolation**: VLAN-specific spanning tree calculations

### MST (Multiple Spanning Tree)

#### What is MST?
MST maps multiple VLANs to a single spanning tree instance, reducing CPU overhead while maintaining load balancing capabilities.

#### MST Benefits
- **Efficiency**: Fewer STP instances than PVST
- **Scalability**: Better for networks with many VLANs
- **Flexibility**: Custom VLAN-to-instance mapping

### PortChannel (Link Aggregation)

#### What is PortChannel?
PortChannel bundles multiple physical links into a single logical link, providing increased bandwidth and redundancy.

#### PortChannel Benefits
- **Bandwidth**: Aggregated bandwidth across multiple links
- **Redundancy**: Automatic failover if one link fails
- **Load Balancing**: Traffic distributed across member links

#### PortChannel Protocols
- **LACP (802.3ad)**: Industry standard protocol (limited support on 2950)
- **PAgP (Cisco Proprietary)**: Cisco's proprietary protocol (full support)

### Trunk and Access Ports

#### Access Ports
- **Purpose**: Connect end devices (PCs, printers, phones)
- **VLAN Membership**: Single VLAN only
- **Traffic**: Untagged Ethernet frames

#### Trunk Ports
- **Purpose**: Connect switches or routers
- **VLAN Membership**: Multiple VLANs
- **Traffic**: Tagged frames (802.1Q)

## Command Reference

### Basic Switch Configuration

#### Global Configuration Mode
```bash
# Enter privileged EXEC mode
enable

# Enter global configuration mode
configure terminal

# Set hostname
hostname SW-2950-01

# Set enable secret password
enable secret class

# Configure console line
line console 0
 password cisco
 login

# Configure vty lines
line vty 0 15
 password cisco
 login

# Enable password encryption
service password-encryption
```

#### Interface Configuration
```bash
# Enter interface configuration
interface fastethernet 0/1

# Set interface description
description "Uplink to Core Switch"

# Set interface mode to access
switchport mode access

# Assign VLAN to access port
switchport access vlan 10

# Enable interface
no shutdown

# Configure trunk port
interface fastethernet 0/24
switchport mode trunk
switchport trunk native vlan 99
switchport trunk allowed vlan 10,20,30
```

### VLAN Configuration

#### Creating VLANs
```bash
# Create VLAN 10
vlan 10
 name SALES
 exit

# Create VLAN 20
vlan 20
 name MARKETING
 exit

# Verify VLAN configuration
show vlan brief
show vlan id 10
```

#### Assigning Ports to VLANs
```bash
# Assign multiple ports to VLAN 10
interface range fastethernet 0/1 - 12
switchport mode access
switchport access vlan 10
exit

# Verify port VLAN assignment
show interfaces switchport
```

### VTP Configuration

#### VTP Server Configuration
```bash
# Configure VTP server
vtp mode server
vtp domain COMPANY
vtp password cisco
vtp version 2

# Verify VTP configuration
show vtp status
show vtp counters
```

#### VTP Client Configuration
```bash
# Configure VTP client
vtp mode client
vtp domain COMPANY
vtp password cisco

# Verify VTP status
show vtp status
```

#### VTP Transparent Configuration
```bash
# Configure VTP transparent
vtp mode transparent
vtp domain COMPANY

# Verify VTP status
show vtp status
```

### STP Configuration

#### Basic STP Commands
```bash
# View STP status
show spanning-tree

# View STP for specific VLAN
show spanning-tree vlan 10

# Set bridge priority (lower = better root)
spanning-tree vlan 10 priority 4096

# Set port priority
interface fastethernet 0/1
spanning-tree port-priority 32
```

#### PVST Configuration
```bash
# Enable PVST (default on Catalyst switches)
spanning-tree mode pvst

# Configure root bridge for VLAN 10
spanning-tree vlan 10 root primary

# Configure secondary root bridge
spanning-tree vlan 10 root secondary
```

#### MST Configuration
```bash
# Enter MST configuration mode
spanning-tree mode mst
spanning-tree mst configuration

# Create MST instance
name MST_REGION
revision 1
instance 1 vlan 10,20,30
instance 2 vlan 40,50,60

# Set MST priority
spanning-tree mst 1 priority 4096
```

### PortChannel Configuration

#### PAgP Configuration
```bash
# Create PortChannel
interface port-channel 1
switchport mode trunk
switchport trunk allowed vlan 10,20,30

# Add member interfaces
interface range fastethernet 0/23 - 24
channel-group 1 mode desirable
switchport mode trunk
switchport trunk allowed vlan 10,20,30
```

#### LACP Configuration (Limited Support)
```bash
# Create PortChannel with LACP
interface port-channel 2
switchport mode trunk

# Add member interfaces
interface range fastethernet 0/21 - 22
channel-group 2 mode active
switchport mode trunk
```

### Security Configuration

#### Port Security
```bash
# Enable port security
interface fastethernet 0/5
switchport mode access
switchport port-security

# Set maximum MAC addresses
switchport port-security maximum 2

# Set violation action
switchport port-security violation shutdown

# Configure sticky MAC addresses
switchport port-security mac-address sticky
```

#### Basic Security Features
```bash
# Enable storm control
interface fastethernet 0/1
storm-control broadcast level 10.0

# Configure BPDU guard
spanning-tree portfast bpduguard default

# Configure root guard
interface fastethernet 0/1
spanning-tree guard root
```

### Monitoring and Verification

#### Show Commands
```bash
# Show system information
show version
show inventory

# Show interface status
show interfaces status
show interfaces counters

# Show MAC address table
show mac-address-table
show mac-address-table dynamic

# Show VLAN information
show vlan brief
show interfaces trunk

# Show VTP information
show vtp status
show vtp counters
show vtp interfaces

# Show spanning tree
show spanning-tree summary
show spanning-tree detail

# Show PortChannel
show etherchannel summary
show etherchannel port-channel

# Show logging
show logging
```

#### Debug Commands
```bash
# Debug STP
debug spanning-tree events
debug spanning-tree bpdu

# Debug VLANs
debug vlan events

# Debug VTP
debug vtp events
debug vtp packets

# Debug interfaces
debug interface events

# Disable all debugging
no debug all
```

## Troubleshooting Guide

### Common Issues and Solutions

#### 1. Port Not Coming Up
**Symptoms**: Interface status shows "down" or "err-disabled"

**Troubleshooting Steps**:
```bash
# Check interface status
show interfaces status

# Check for error-disabled state
show interfaces status err-disabled

# Check port security violations
show port-security interface fastethernet 0/1

# Re-enable err-disabled port
interface fastethernet 0/1
shutdown
no shutdown
```

**Common Causes**:
- Cable issues (bad cable, wrong type)
- Speed/duplex mismatch
- Port security violation
- BPDU guard enabled
- Spanning Tree blocking

#### 2. VLAN Communication Issues
**Symptoms**: Devices in same VLAN cannot communicate

**Troubleshooting Steps**:
```bash
# Verify VLAN exists
show vlan brief

# Check port VLAN assignment
show interfaces switchport

# Verify trunk configuration
show interfaces trunk

# Check native VLAN mismatch
show spanning-tree inconsistentports
```

**Common Causes**:
- VLAN not created
- Wrong VLAN assignment
- Trunk not allowing VLAN
- Native VLAN mismatch

#### 3. VTP Issues
**Symptoms**: VLAN information not propagating between switches

**Troubleshooting Steps**:
```bash
# Check VTP status
show vtp status

# Verify VTP domain matches
show vtp counters

# Check VTP passwords
show running-config | include vtp

# Verify trunk configuration
show interfaces trunk
```

**Common Causes**:
- VTP domain name mismatch
- VTP password mismatch
- Trunk not configured
- VTP version mismatch
- Configuration revision number issues

#### 4. STP Loop Issues
**Symptoms**: Network slow, high CPU utilization, broadcast storms

**Troubleshooting Steps**:
```bash
# Check STP status
show spanning-tree

# Look for topology changes
show spanning-tree detail

# Check for BPDU guard
show spanning-tree blockedports

# Verify STP consistency
show spanning-tree inconsistentports
```

**Common Causes**:
- Redundant links without STP
- STP disabled
- BPDU filter enabled incorrectly
- Root bridge issues

#### 5. PortChannel Issues
**Symptoms**: Link aggregation not working, inconsistent bandwidth

**Troubleshooting Steps**:
```bash
# Check PortChannel status
show etherchannel summary

# Verify member interfaces
show etherchannel detail

# Check PAgP status
show pagp neighbor

# Verify load balancing
show etherchannel load-balance
```

**Common Causes**:
- Mismatched configuration
- Different speed/duplex
- Wrong protocol (LACP vs PAgP)
- Physical link issues

### VTP-Specific Troubleshooting

#### VTP Domain Issues
```bash
# Check VTP domain on all switches
show vtp status | include Domain

# Verify domain consistency
show vtp status | include Domain

# Reset VTP configuration
no vtp domain
vtp domain NEW_DOMAIN
```

#### VTP Password Issues
```bash
# Check VTP password
show running-config | include vtp.*password

# Reset VTP password
no vtp password
vtp password NEW_PASSWORD
```

#### VTP Version Issues
```bash
# Check VTP version
show vtp status | include VTP Version

# Change VTP version
vtp version 1
vtp version 2
```

### Advanced Troubleshooting

#### Packet Capture
```bash
# Enable SPAN for monitoring
monitor session 1 source interface fastethernet 0/1
monitor session 1 destination interface fastethernet 0/24
```

#### Diagnostic Tests
```bash
# Run diagnostic tests
diagnostic start all
diagnostic result all

# Test hardware
test cablediag tdr interface fastethernet 0/1
```

#### Recovery Procedures
```bash
# Save configuration
write memory
copy running-config startup-config

# Reset to factory defaults
write erase
reload
```

### Best Practices

#### 1. Configuration Management
- Always document changes
- Use configuration backup regularly
- Test changes in lab first
- Use descriptive interface descriptions

#### 2. VTP Best Practices
- Use VTP version 2 for better features
- Set VTP passwords for security
- Use transparent mode for edge switches
- Monitor VTP advertisements

#### 3. Security Hardening
- Enable port security on access ports
- Disable unused ports
- Use strong passwords
- Enable logging and monitoring

#### 4. Performance Optimization
- Proper VLAN design
- Optimize STP configuration
- Use QoS for critical traffic
- Monitor utilization regularly

#### 5. Legacy Considerations
- Plan for migration to newer hardware
- Monitor for hardware failures
- Keep firmware updated when possible
- Document workarounds for limitations

### Migration Planning

#### Upgrade Considerations
- **Hardware Age**: 2950 switches are end-of-life
- **Performance Limits**: Limited forwarding capacity
- **Feature Gaps**: Missing modern features
- **Security**: No longer receiving security updates

#### Migration Steps
1. **Inventory**: Document current 2950 deployments
2. **Analysis**: Identify performance bottlenecks
3. **Planning**: Schedule phased replacement
4. **Testing**: Validate new hardware compatibility
5. **Implementation**: Execute migration plan
6. **Documentation**: Update network documentation

---

This guide provides comprehensive information for configuring, managing, and troubleshooting Cisco Catalyst 2950 switches in legacy and lab environments. While these switches are no longer current, they remain valuable for learning and maintaining existing installations.
