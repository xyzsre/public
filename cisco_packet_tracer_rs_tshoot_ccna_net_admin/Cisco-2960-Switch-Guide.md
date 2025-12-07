# Cisco Catalyst 2960 Switch - Comprehensive Guide

## Table of Contents
- [Overview](#overview)
- [2960 Series Models](#2960-series-models)
- [Hardware Capabilities](#hardware-capabilities)
- [Use Cases](#use-cases)
- [Core Switching Concepts](#core-switching-concepts)
- [VLAN Configuration](#vlan-configuration)
- [Spanning Tree Protocol](#spanning-tree-protocol)
- [Port Aggregation](#port-aggregation)
- [Port Types](#port-types)
- [Command Reference](#command-reference)
- [Troubleshooting Guide](#troubleshooting-guide)

## Overview

The Cisco Catalyst 2960 series is Cisco's most popular line of Layer 2 switches, designed for enterprise branch offices and small-to-medium businesses. These switches provide reliable, secure, and intelligent network connectivity with advanced features for network optimization and security.

## 2960 Series Models

### Main Variants
- **2960-8TC-L**: 8 ports, 2 Gigabit uplinks
- **2960-24TC-L**: 24 ports, 2 Gigabit uplinks  
- **2960-48TC-L**: 48 ports, 2 Gigabit uplinks
- **2960-24TT-L**: 24 ports, 2 dual-purpose uplinks
- **2960-48TT-L**: 48 ports, 2 dual-purpose uplinks

### Enhanced Models
- **2960G-8TC-L**: 8 ports with Gigabit Ethernet
- **2960G-24TC-L**: 24 ports with Gigabit Ethernet
- **2960G-48TC-L**: 48 ports with Gigabit Ethernet
- **2960PD-8TC-L**: 8 ports with Power over Ethernet (PoE)
- **2960PD-24TC-L**: 24 ports with Power over Ethernet (PoE)
- **2960PD-48TC-L**: 48 ports with Power over Ethernet (PoE)

### Key Features by Model
- **TC**: Standard copper ports with Gigabit uplinks
- **TT**: Standard copper ports with dual-purpose uplinks (copper/fiber)
- **G**: All Gigabit Ethernet ports
- **PD**: Power over Ethernet capable models

## Hardware Capabilities

### Switching Capacity
- **Forwarding Rate**: 16-64 Gbps (varies by model)
- **Packet Forwarding Rate**: 6.5-38.7 Mpps
- **MAC Address Table**: 8,000-16,000 entries
- **VLAN Support**: Up to 1,005 VLANs

### Memory and Processing
- **DRAM**: 128MB-512MB
- **Flash Memory**: 32MB-64MB
- **CPU**: PowerPC processor (varies by model)

### Physical Specifications
- **Form Factor**: 1U rack-mountable
- **Weight**: 3.2-7.5 kg (varies by model)
- **Power Consumption**: 20-65W (non-PoE), up to 370W (PoE models)
- **Operating Temperature**: 0°C to 45°C
- **Operating Humidity**: 10% to 85% (non-condensing)

### Interface Types
- **10/100/1000 Mbps Ethernet**: RJ-45 ports
- **SFP/Uplink Ports**: Fiber connectivity options
- **Console Port**: RS-232 serial management
- **Management Port**: Ethernet out-of-band management

## Use Cases

### 1. Branch Office Connectivity
- **Primary Role**: Edge switch for branch offices
- **Typical Deployment**: 10-50 users per switch
- **Key Benefits**: Cost-effective, reliable, easy management

### 2. Small to Medium Business (SMB)
- **Primary Role**: Core or distribution switch
- **Typical Deployment**: 50-200 users per network
- **Key Benefits**: Advanced features without enterprise complexity

### 3. Campus Network Access Layer
- **Primary Role**: Building access switch
- **Typical Deployment**: Connected to distribution layer switches
- **Key Benefits**: Stackable options, PoE support, security features

### 4. Industrial Environments
- **Primary Role**: Factory floor or warehouse connectivity
- **Typical Deployment**: Harsh environment networking
- **Key Benefits**: Extended temperature range models available

### 5. Voice and Video Networks
- **Primary Role**: VoIP and video surveillance support
- **Typical Deployment**: PoE-powered phones and cameras
- **Key Benefits**: QoS support, PoE power management

## Core Switching Concepts

### VLAN (Virtual Local Area Network)

#### What is VLAN?
VLAN is a logical segmentation of a physical network into multiple broadcast domains. Devices in different VLANs cannot communicate directly without a Layer 3 device.

#### VLAN Benefits
- **Security**: Isolates traffic between departments
- **Performance**: Reduces broadcast traffic
- **Management**: Simplifies network administration
- **Flexibility**: Logical grouping regardless of physical location

#### VLAN Types
- **Data VLAN**: Standard user traffic
- **Voice VLAN**: VoIP traffic separation
- **Native VLAN**: Untagged traffic on trunk ports
- **Management VLAN**: Switch management traffic

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
- **LACP (802.3ad)**: Industry standard protocol
- **PAgP (Cisco Proprietary)**: Cisco's proprietary protocol

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
hostname SW-2960-01

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

#### LACP Configuration
```bash
# Create PortChannel
interface port-channel 1
switchport mode trunk
switchport trunk allowed vlan 10,20,30

# Add member interfaces
interface range fastethernet 0/23 - 24
channel-group 1 mode active
switchport mode trunk
switchport trunk allowed vlan 10,20,30
```

#### PAgP Configuration
```bash
# Create PortChannel with PAgP
interface port-channel 2
switchport mode trunk

# Add member interfaces
interface range fastethernet 0/21 - 22
channel-group 2 mode desirable
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

#### Storm Control
```bash
# Configure broadcast storm control
interface fastethernet 0/1
storm-control broadcast level 10.0
storm-control multicast level 20.0
```

### QoS Configuration

#### Basic QoS
```bash
# Enable QoS globally
mls qos

# Trust DSCP on uplink
interface fastethernet 0/24
mls qos trust dscp

# Configure queue settings
interface fastethernet 0/1
priority-queue out
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
show mac address-table
show mac address-table dynamic

# Show VLAN information
show vlan brief
show interfaces trunk

# Show spanning tree
show spanning-tree summary
show spanning-tree detail

# Show PortChannel
show etherchannel summary
show etherchannel port-channel

# Show logging
show logging
show logging history
```

#### Debug Commands
```bash
# Debug STP
debug spanning-tree events
debug spanning-tree bpdu

# Debug VLANs
debug vlan events

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

#### 3. STP Loop Issues
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

#### 4. PortChannel Issues
**Symptoms**: Link aggregation not working, inconsistent bandwidth

**Troubleshooting Steps**:
```bash
# Check PortChannel status
show etherchannel summary

# Verify member interfaces
show etherchannel detail

# Check LACP/PAgP status
show lacp neighbor
show pagp neighbor

# Verify load balancing
show etherchannel load-balance
```

**Common Causes**:
- Mismatched configuration
- Different speed/duplex
- Wrong protocol (LACP vs PAgP)
- Physical link issues

#### 5. Performance Issues
**Symptoms**: Slow network response, high latency

**Troubleshooting Steps**:
```bash
# Check interface counters
show interfaces counters

# Look for errors
show interfaces errors

# Check CPU utilization
show processes cpu

# Monitor traffic
show interfaces fastethernet 0/1 counters
```

**Common Causes**:
- High utilization
- Duplex mismatch
- Bad cable
- Hardware issues

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

#### 2. Security Hardening
- Enable port security on access ports
- Disable unused ports
- Use strong passwords
- Enable logging and monitoring

#### 3. Performance Optimization
- Proper VLAN design
- Optimize STP configuration
- Use QoS for critical traffic
- Monitor utilization regularly

#### 4. Maintenance
- Regular firmware updates
- Clean equipment regularly
- Check cable connections
- Monitor environmental conditions

---

This guide provides comprehensive information for configuring, managing, and troubleshooting Cisco Catalyst 2960 switches in various network environments.
