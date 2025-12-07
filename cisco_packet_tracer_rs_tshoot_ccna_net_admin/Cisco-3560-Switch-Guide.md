# Cisco Catalyst 3560 Switch - Comprehensive Guide

## Table of Contents
- [Overview](#overview)
- [3560 Series Models](#3560-series-models)
- [Hardware Capabilities](#hardware-capabilities)
- [Layer 2 vs Layer 3 Capabilities](#layer-2-vs-layer-3-capabilities)
- [Use Cases](#use-cases)
- [Core Switching Concepts](#core-switching-concepts)
- [VLAN Configuration](#vlan-configuration)
- [VTP (VLAN Trunking Protocol)](#vtp-vlan-trunking-protocol)
- [Spanning Tree Protocol](#spanning-tree-protocol)
- [Port Aggregation](#port-aggregation)
- [Port Types](#port-types)
- [Layer 3 Routing](#layer-3-routing)
- [Command Reference](#command-reference)
- [Troubleshooting Guide](#troubleshooting-guide)

## Overview

The Cisco Catalyst 3560 series is a powerful line of Layer 3 switches that combines high-performance switching with advanced routing capabilities. These switches are ideal for enterprise branch offices and medium-sized networks requiring both switching and routing functionality in a single device.

## 3560 Series Models

### Main Variants
- **3560-24PS**: 24 10/100/1000 ports with PoE, 4 SFP ports
- **3560-48PS**: 48 10/100/1000 ports with PoE, 4 SFP ports
- **3560-24TS**: 24 10/100/1000 ports, 4 SFP ports
- **3560-48TS**: 48 10/100/1000 ports, 4 SFP ports
- **3560G-24TS**: 24 10/100/1000 ports, 4 SFP ports (enhanced)
- **3560G-48TS**: 48 10/100/1000 ports, 4 SFP ports (enhanced)

### Enhanced Models
- **3560E-24TD**: 24 10/100/1000 ports, 2 10GbE ports, 2 SFP ports
- **3560E-48TD**: 48 10/100/1000 ports, 2 10GbE ports, 2 SFP ports
- **3560E-24PD**: 24 10/100/1000 PoE ports, 2 10GbE ports, 2 SFP ports
- **3560E-48PD**: 48 10/100/1000 PoE ports, 2 10GbE ports, 2 SFP ports

### Key Features by Model
- **PS**: Power over Ethernet (PoE) capable
- **TS**: Standard switching with SFP uplinks
- **G**: Enhanced performance with more memory
- **E**: Enhanced series with 10GbE uplinks and improved performance

## Hardware Capabilities

### Switching Capacity
- **Forwarding Rate**: 32-128 Gbps (varies by model)
- **Packet Forwarding Rate**: 31.5-101 Mpps
- **MAC Address Table**: 12,000-16,000 entries
- **VLAN Support**: Up to 1,005 VLANs
- **Routing Performance**: 38-87 Mpps (varies by model)

### Memory and Processing
- **DRAM**: 256MB-512MB
- **Flash Memory**: 64MB-128MB
- **CPU**: PowerPC processor with enhanced performance
- **TCAM**: Hardware ACL and QoS support

### Physical Specifications
- **Form Factor**: 1U rack-mountable
- **Weight**: 4.5-9.0 kg (varies by model)
- **Power Consumption**: 50-370W (varies by model and PoE usage)
- **Operating Temperature**: 0°C to 45°C
- **Operating Humidity**: 10% to 85% (non-condensing)

### Interface Types
- **10/100/1000 Mbps Ethernet**: RJ-45 access ports
- **SFP Ports**: 1GbE fiber connectivity
- **10GbE Ports**: Enhanced models only
- **Console Port**: RS-232 serial management
- **Management Port**: Ethernet out-of-band management

### Advanced Features
- **Layer 3 Switching**: Hardware-based routing
- **MLS (Multilayer Switching)**: Wire-speed routing
- **IPv6 Support**: Full IPv6 routing and switching
- **QoS**: Advanced quality of service
- **Security**: Comprehensive security features
- **StackWise Plus**: Stacking capabilities (selected models)

## Layer 2 vs Layer 3 Capabilities

### Layer 2 Capabilities
- **VLAN Support**: 1,005 VLANs
- **STP Variants**: PVST+, RSTP, MST
- **Port Security**: Advanced port security features
- **Link Aggregation**: LACP, PAgP support
- **QoS**: Classification, marking, queuing
- **Storm Control**: Broadcast, multicast, unicast control

### Layer 3 Capabilities
- **Static Routing**: Manual route configuration
- **Dynamic Routing**: RIP, OSPF, EIGRP, BGP support
- **Inter-VLAN Routing**: Hardware-based routing between VLANs
- **ACL Support**: Standard, extended, named ACLs
- **NAT Support**: Basic NAT capabilities
- **IPv6 Routing**: Static and dynamic IPv6 routing

### MLS (Multilayer Switching)
- **Hardware Routing**: TCAM-based route lookups
- **CEF (Cisco Express Forwarding)**: Optimized packet forwarding
- **FIB (Forwarding Information Base)**: Route caching
- **Adjacency Table**: Layer 2 next-hop information

## Use Cases

### 1. Branch Office Router Replacement
- **Primary Role**: Replace traditional routers in branch offices
- **Typical Deployment**: 50-200 users per location
- **Key Benefits**: Combined routing and switching, reduced complexity

### 2. Campus Distribution Layer
- **Primary Role**: Distribution layer switch in campus networks
- **Typical Deployment**: Connecting access layer switches to core
- **Key Benefits**: High performance, advanced features, redundancy

### 3. Small to Medium Business Core
- **Primary Role**: Core switch for SMB networks
- **Typical Deployment**: Central connectivity for entire organization
- **Key Benefits**: All-in-one solution, cost-effective

### 4. Data Center Access
- **Primary Role**: Data center server connectivity
- **Typical Deployment**: Server aggregation and interconnectivity
- **Key Benefits**: High performance, low latency, advanced features

### 5. VoIP and Unified Communications
- **Primary Role**: Voice and video network support
- **Typical Deployment**: PoE-powered phones, QoS for voice/video
- **Key Benefits**: Integrated voice support, quality of service

## Core Switching Concepts

### VLAN (Virtual Local Area Network)

#### What is VLAN?
VLAN is a logical segmentation of a physical network into multiple broadcast domains. Devices in different VLANs cannot communicate directly without a Layer 3 device.

#### VLAN Benefits
- **Security**: Isolates traffic between departments
- **Performance**: Reduces broadcast traffic
- **Management**: Simplifies network administration
- **Flexibility**: Logical grouping regardless of physical location

#### VLAN Types on 3560
- **Data VLAN**: Standard user traffic
- **Voice VLAN**: VoIP traffic separation
- **Native VLAN**: Untagged traffic on trunk ports
- **Management VLAN**: Switch management traffic
- **Private VLAN**: Isolated VLANs for enhanced security

### VTP (VLAN Trunking Protocol)

#### What is VTP?
VTP is a Cisco proprietary protocol that propagates VLAN information across the switched network. It ensures consistent VLAN configuration throughout the network.

#### VTP Modes
- **Server Mode**: Can create, modify, and delete VLANs; propagates changes
- **Client Mode**: Receives and synchronizes VLAN information; cannot modify
- **Transparent Mode**: Forwards VTP advertisements but doesn't participate; maintains local VLAN database
- **Off Mode**: Disables VTP completely

#### VTP Benefits
- **Centralized Management**: Single point of VLAN administration
- **Consistency**: Ensures all switches have same VLAN information
- **Scalability**: Simplifies VLAN management in large networks

### STP (Spanning Tree Protocol)

#### What is STP?
STP prevents network loops in Layer 2 networks by creating a loop-free logical topology. It blocks redundant paths while maintaining backup links for failover.

#### STP Variants on 3560
- **PVST+**: Per-VLAN Spanning Tree Plus (Cisco enhanced)
- **RSTP**: Rapid Spanning Tree Protocol (802.1w)
- **MST**: Multiple Spanning Tree (802.1s)
- **STP**: Classic Spanning Tree Protocol (802.1D)

#### STP Features
- **PortFast**: Fast startup for access ports
- **UplinkFast**: Fast convergence for uplink failures
- **BackboneFast**: Fast convergence for indirect link failures
- **BPDU Guard**: Protect against BPDU injection
- **Root Guard**: Prevent root bridge placement

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
- **Static**: Manual configuration without negotiation

### Trunk and Access Ports

#### Access Ports
- **Purpose**: Connect end devices (PCs, printers, phones)
- **VLAN Membership**: Single VLAN only
- **Traffic**: Untagged Ethernet frames
- **Features**: PortFast, BPDU Guard, Storm Control

#### Trunk Ports
- **Purpose**: Connect switches or routers
- **VLAN Membership**: Multiple VLANs
- **Traffic**: Tagged frames (802.1Q)
- **Features**: Native VLAN, allowed VLAN list, pruning

## Layer 3 Routing

### Static Routing
```bash
# Configure static route
ip route 192.168.2.0 255.255.255.0 10.1.1.1

# Configure default route
ip route 0.0.0.0 0.0.0.0 10.1.1.254

# Configure floating static route
ip route 10.2.2.0 255.255.255.0 10.1.1.2 100
```

### Dynamic Routing Protocols

#### RIP (Routing Information Protocol)
```bash
# Enable RIP routing
router rip
 version 2
 network 10.0.0.0
 network 192.168.1.0
 no auto-summary
 passive-interface default
 no passive-interface GigabitEthernet0/1
```

#### OSPF (Open Shortest Path First)
```bash
# Enable OSPF routing
router ospf 1
 router-id 1.1.1.1
 network 10.0.0.0 0.0.0.255 area 0
 network 192.168.1.0 0.0.0.255 area 0
 passive-interface default
 no passive-interface GigabitEthernet0/1
```

#### EIGRP (Enhanced Interior Gateway Routing Protocol)
```bash
# Enable EIGRP routing
router eigrp 100
 network 10.0.0.0
 network 192.168.1.0
 passive-interface default
 no passive-interface GigabitEthernet0/1
```

#### BGP (Border Gateway Protocol)
```bash
# Enable BGP routing
router bgp 65001
 neighbor 10.1.1.2 remote-as 65002
 neighbor 192.168.1.1 remote-as 65001
 network 10.0.0.0 mask 255.255.255.0
```

### Inter-VLAN Routing
```bash
# Enable IP routing
ip routing

# Create SVI (Switched Virtual Interface)
interface Vlan10
 ip address 192.168.10.1 255.255.255.0
 no shutdown

interface Vlan20
 ip address 192.168.20.1 255.255.255.0
 no shutdown

# Configure routing between VLANs
ip routing
```

### ACL Configuration
```bash
# Standard ACL
access-list 1 permit 192.168.10.0 0.0.0.255
access-list 1 deny any

# Extended ACL
access-list 101 permit tcp 192.168.10.0 0.0.0.255 192.168.20.0 0.0.0.255 eq 80
access-list 101 deny ip any any

# Apply ACL to interface
interface Vlan10
 ip access-group 101 in
```

## Command Reference

### Basic Switch Configuration

#### Global Configuration Mode
```bash
# Enter privileged EXEC mode
enable

# Enter global configuration mode
configure terminal

# Set hostname
hostname SW-3560-01

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
interface GigabitEthernet0/1

# Set interface description
description "Uplink to Core Switch"

# Set interface mode to access
switchport mode access

# Assign VLAN to access port
switchport access vlan 10

# Enable interface
no shutdown

# Configure trunk port
interface GigabitEthernet0/24
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
 private-vlan primary
 exit

# Create VLAN 20
vlan 20
 name MARKETING
 private-vlan isolated
 exit

# Verify VLAN configuration
show vlan brief
show vlan id 10
```

#### Assigning Ports to VLANs
```bash
# Assign multiple ports to VLAN 10
interface range GigabitEthernet0/1 - 12
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
vtp pruning

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
interface GigabitEthernet0/1
spanning-tree port-priority 32
```

#### PVST+ Configuration
```bash
# Enable PVST+ (default on Catalyst switches)
spanning-tree mode rapid-pvst

# Configure root bridge for VLAN 10
spanning-tree vlan 10 root primary

# Configure secondary root bridge
spanning-tree vlan 10 root secondary

# Enable PortFast
interface range GigabitEthernet0/1 - 12
spanning-tree portfast
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
interface Port-channel 1
switchport mode trunk
switchport trunk allowed vlan 10,20,30

# Add member interfaces
interface range GigabitEthernet0/23 - 24
channel-group 1 mode active
switchport mode trunk
switchport trunk allowed vlan 10,20,30
```

#### PAgP Configuration
```bash
# Create PortChannel with PAgP
interface Port-channel 2
switchport mode trunk

# Add member interfaces
interface range GigabitEthernet0/21 - 22
channel-group 2 mode desirable
switchport mode trunk
```

### Layer 3 Configuration

#### Enable IP Routing
```bash
# Enable IP routing globally
ip routing

# Enable IPv6 routing
ipv6 unicast-routing
```

#### SVI Configuration
```bash
# Create SVI for VLAN 10
interface Vlan10
 ip address 192.168.10.1 255.255.255.0
 ipv6 address 2001:db8:1::1/64
 no shutdown

# Create SVI for VLAN 20
interface Vlan20
 ip address 192.168.20.1 255.255.255.0
 ipv6 address 2001:db8:2::1/64
 no shutdown
```

#### Routing Interface Configuration
```bash
# Configure routed port
interface GigabitEthernet0/1
 no switchport
 ip address 10.1.1.1 255.255.255.0
 ip ospf 1 area 0
```

### Security Configuration

#### Port Security
```bash
# Enable port security
interface GigabitEthernet0/5
switchport mode access
switchport port-security

# Set maximum MAC addresses
switchport port-security maximum 2

# Set violation action
switchport port-security violation shutdown

# Configure sticky MAC addresses
switchport port-security mac-address sticky
```

#### DHCP Snooping
```bash
# Enable DHCP snooping globally
ip dhcp snooping

# Enable DHCP snooping on VLAN
ip dhcp snooping vlan 10

# Configure trusted interface
interface GigabitEthernet0/24
ip dhcp snooping trust
```

#### Dynamic ARP Inspection
```bash
# Enable DAI globally
ip arp inspection vlan 10

# Configure trusted interface
interface GigabitEthernet0/24
ip arp inspection trust
```

### QoS Configuration

#### Basic QoS
```bash
# Enable QoS globally
mls qos

# Trust DSCP on uplink
interface GigabitEthernet0/24
mls qos trust dscp

# Configure port-based QoS
interface GigabitEthernet0/1
mls qos cos 5
```

#### Auto QoS
```bash
# Enable Auto QoS for VoIP
interface range GigabitEthernet0/1 - 12
auto qos voip cisco-phone

# Enable Auto QoS for trusted devices
interface GigabitEthernet0/24
auto qos trust
```

### Monitoring and Verification

#### Show Commands
```bash
# Show system information
show version
show inventory
show running-config

# Show interface status
show interfaces status
show interfaces counters

# Show MAC address table
show mac address-table
show mac address-table dynamic

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

# Show routing information
show ip route
show ip protocols
show ip interface brief

# Show CEF information
show ip cef
show ip cef summary

# Show logging
show logging
```

#### Debug Commands
```bash
# Debug routing protocols
debug ip routing
debug ospf events
debug eigrp packets

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
show port-security interface GigabitEthernet0/1

# Check BPDU guard status
show spanning-tree interface GigabitEthernet0/1

# Re-enable err-disabled port
interface GigabitEthernet0/1
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

# Verify SVI is up
show ip interface brief
```

**Common Causes**:
- VLAN not created
- Wrong VLAN assignment
- Trunk not allowing VLAN
- Native VLAN mismatch
- SVI not configured or down

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

# Check VTP pruning
show vtp status | include Pruning
```

**Common Causes**:
- VTP domain name mismatch
- VTP password mismatch
- Trunk not configured
- VTP version mismatch
- Configuration revision number issues

#### 4. Routing Issues
**Symptoms**: Cannot route between VLANs or to external networks

**Troubleshooting Steps**:
```bash
# Verify IP routing is enabled
show running-config | include ip routing

# Check routing table
show ip route

# Verify SVI configuration
show ip interface brief

# Check routing protocol status
show ip protocols
show ip ospf neighbor
show ip eigrp neighbors

# Verify ACLs
show access-lists
```

**Common Causes**:
- IP routing not enabled
- SVI not configured or down
- Routing protocol not configured
- ACL blocking traffic
- Incorrect subnet masks

#### 5. STP Loop Issues
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

# Check for rapid transitions
show spanning-tree mst
```

**Common Causes**:
- Redundant links without STP
- STP disabled
- BPDU filter enabled incorrectly
- Root bridge issues
- Rapid PVST configuration errors

#### 6. PortChannel Issues
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

# Check interface consistency
show running-config interface Port-channel 1
```

**Common Causes**:
- Mismatched configuration
- Different speed/duplex
- Wrong protocol (LACP vs PAgP)
- Physical link issues
- Trunk configuration mismatch

### Layer 3 Specific Troubleshooting

#### CEF Issues
```bash
# Check CEF status
show ip cef
show ip cef summary

# Check FIB entries
show ip cef 192.168.10.0

# Check adjacency table
show adjacency detail

# Disable/enable CEF
no ip cef
ip cef
```

#### Routing Protocol Issues
```bash
# OSPF troubleshooting
show ip ospf interface
show ip ospf neighbor
show ip ospf database
debug ospf events

# EIGRP troubleshooting
show ip eigrp interface
show ip eigrp neighbors
show ip eigrp topology
debug eigrp packets

# BGP troubleshooting
show ip bgp summary
show ip bgp neighbors
debug bgp events
```

#### ACL Issues
```bash
# Check ACL configuration
show access-lists
show ip interface access-lists

# Test ACL functionality
show access-lists 101

# Remove problematic ACL
interface Vlan10
no ip access-group 101 in
```

### Advanced Troubleshooting

#### Packet Capture
```bash
# Enable SPAN for monitoring
monitor session 1 source interface GigabitEthernet0/1
monitor session 1 destination interface GigabitEthernet0/24

# Enable RSPAN
monitor session 1 source interface GigabitEthernet0/1
monitor session 1 destination remote vlan 99
```

#### Diagnostic Tests
```bash
# Run diagnostic tests
diagnostic start all
diagnostic result all

# Test hardware
test cablediag tdr interface GigabitEthernet0/1

# Check memory utilization
show processes memory
show memory statistics
```

#### Performance Monitoring
```bash
# Check CPU utilization
show processes cpu sorted

# Check interface utilization
show interfaces GigabitEthernet0/1 counters

# Check buffer utilization
show buffers
show buffers summary
```

### Recovery Procedures
```bash
# Save configuration
write memory
copy running-config startup-config

# Reset to factory defaults
write erase
reload

# Recover from corrupted IOS
copy tftp: flash:
boot system flash:c3560-ipservicesk9-mz.122-55.SE.bin
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

#### 3. Routing Best Practices
- Use passive interfaces where appropriate
- Implement route summarization
- Use route filtering for security
- Monitor routing table size

#### 4. Security Hardening
- Enable port security on access ports
- Disable unused ports
- Use strong passwords
- Enable logging and monitoring
- Implement DHCP snooping and DAI

#### 5. Performance Optimization
- Proper VLAN design
- Optimize STP configuration
- Use QoS for critical traffic
- Monitor utilization regularly
- Enable CEF for optimal performance

---

This guide provides comprehensive information for configuring, managing, and troubleshooting Cisco Catalyst 3560 switches in enterprise environments, with detailed coverage of both Layer 2 switching and Layer 3 routing capabilities.
