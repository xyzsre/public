# Layer 2 and Layer 3 Switching - Comprehensive Guide

## Table of Contents
- [Overview](#overview)
- [Layer 2 Switching Fundamentals](#layer-2-switching-fundamentals)
- [Layer 3 Switching Fundamentals](#layer-3-switching-fundamentals)
- [VLAN Configuration](#vlan-configuration)
- [Trunking Configuration](#trunking-configuration)
- [Access Port Configuration](#access-port-configuration)
- [VTP Configuration](#vtp-configuration)
- [PortChannel Configuration](#portchannel-configuration)
- [HSRP Configuration](#hsrp-configuration)
- [VRRP Configuration](#vrrp-configuration)
- [GLBP Configuration](#glbp-configuration)
- [DHCP Configuration](#dhcp-configuration)
- [ARP Configuration](#arp-configuration)
- [MAC Table Management](#mac-table-management)
- [MLS (Multilayer Switching)](#mls-multilayer-switching)
- [Subinterface Configuration](#subinterface-configuration)
- [Command Reference](#command-reference)
- [Troubleshooting Guide](#troubleshooting-guide)

## Overview

This guide provides comprehensive coverage of Layer 2 and Layer 3 switching concepts, configurations, and troubleshooting procedures for Cisco switches. It covers fundamental switching technologies, VLANs, trunking, high availability protocols, and advanced switching features essential for network engineers and CCNA/CCNP students.

## Layer 2 Switching Fundamentals

### What is Layer 2 Switching?
Layer 2 switching operates at the Data Link layer (OSI Layer 2) and makes forwarding decisions based on MAC addresses. Switches build MAC address tables to track which devices are connected to which ports.

### Key Concepts
- **MAC Address Table**: Database mapping MAC addresses to ports
- **Broadcast Domain**: All devices that receive broadcast frames
- **Collision Domain**: Network segment where collisions can occur
- **Frame Forwarding**: Process of forwarding Ethernet frames
- **Learning**: Process of building MAC address table
- **Flooding**: Sending frames to all ports except source

### MAC Address Table Operations
```bash
# Show MAC address table
show mac address-table
show mac address-table dynamic
show mac address-table static
show mac address-table aging-time

# Show MAC address table for specific VLAN
show mac address-table vlan 10

# Show MAC address table for specific interface
show mac address-table interface GigabitEthernet0/1

# Clear MAC address table
clear mac address-table dynamic
clear mac address-table interface GigabitEthernet0/1
```

### MAC Address Configuration
```bash
# Configure static MAC address
mac address-table static 0000.0c12.3456 vlan 10 interface GigabitEthernet0/1

# Configure MAC address aging time
mac address-table aging-time 300

# Configure MAC address learning limit
mac address-table learning-limit 100

# Verify MAC address configuration
show mac address-table static
show running-config | include mac address-table
```

## Layer 3 Switching Fundamentals

### What is Layer 3 Switching?
Layer 3 switching combines Layer 2 switching with Layer 3 routing capabilities. It enables routing between VLANs and subnets at wire speed using hardware acceleration.

### Key Concepts
- **SVI (Switch Virtual Interface)**: Layer 3 interface for VLANs
- **Routed Port**: Physical interface configured for routing
- **MLS (Multilayer Switching)**: Hardware-based routing
- **CEF (Cisco Express Forwarding)**: Optimized packet forwarding
- **Inter-VLAN Routing**: Routing between different VLANs

### Layer 3 Switching vs Traditional Routing
- **Performance**: Hardware-based vs software-based routing
- **Latency**: Lower latency in Layer 3 switches
- **Cost**: Higher cost but integrated solution
- **Flexibility**: Combined switching and routing in one device

## VLAN Configuration

### VLAN Basics
VLANs (Virtual Local Area Networks) logically segment a physical network into multiple broadcast domains.

### VLAN Types
- **Data VLAN**: Standard user traffic
- **Voice VLAN**: VoIP traffic separation
- **Native VLAN**: Untagged traffic on trunk ports
- **Management VLAN**: Switch management traffic
- **Private VLAN**: Enhanced security VLANs

### VLAN Configuration Examples
```bash
# Create VLANs
vlan 10
 name SALES
 exit

vlan 20
 name MARKETING
 exit

vlan 30
 name ENGINEERING
 exit

vlan 99
 name MANAGEMENT
 exit

# Configure VLAN membership
interface range GigabitEthernet0/1 - 12
 switchport mode access
 switchport access vlan 10
 exit

interface range GigabitEthernet0/13 - 24
 switchport mode access
 switchport access vlan 20
 exit

# Configure voice VLAN
interface GigabitEthernet0/25
 switchport mode access
 switchport access vlan 10
 switchport voice vlan 30
 spanning-tree portfast
 exit

# Verify VLAN configuration
show vlan brief
show vlan id 10
show interfaces switchport
```

### Private VLAN Configuration
```bash
# Configure primary VLAN
vlan 100
 private-vlan primary
 private-vlan association 101 102
 exit

# Configure isolated VLAN
vlan 101
 private-vlan isolated
 exit

# Configure community VLAN
vlan 102
 private-vlan community
 exit

# Assign ports to private VLANs
interface GigabitEthernet0/1
 switchport mode private-vlan host
 switchport private-vlan host-association 100 101
 exit

interface GigabitEthernet0/2
 switchport mode private-vlan host
 switchport private-vlan host-association 100 102
 exit

# Configure promiscuous port
interface GigabitEthernet0/24
 switchport mode private-vlan promiscuous
 switchport private-vlan mapping 100 101 102
 exit

# Verify private VLAN configuration
show vlan private-vlan
show interfaces private-vlan mapping
```

## Trunking Configuration

### Trunking Basics
Trunking allows multiple VLANs to be carried over a single physical link between switches or between a switch and router.

### Trunking Protocols
- **802.1Q**: Industry standard trunking protocol
- **ISL**: Cisco proprietary (legacy)

### Trunk Configuration Examples
```bash
# Configure 802.1Q trunk
interface GigabitEthernet0/24
 switchport mode trunk
 switchport trunk native vlan 99
 switchport trunk allowed vlan 10,20,30,99
 switchport trunk allowed vlan add 40,50
 exit

# Configure trunk with DTP
interface GigabitEthernet0/24
 switchport mode dynamic desirable
 switchport trunk encapsulation dot1q
 switchport trunk native vlan 99
 exit

# Configure trunk negotiation
interface GigabitEthernet0/24
 switchport mode dynamic auto
 switchport nonegotiate
 exit

# Verify trunk configuration
show interfaces trunk
show interfaces GigabitEthernet0/24 switchport
show spanning-tree interface GigabitEthernet0/24
```

### Trunking Best Practices
```bash
# Configure trunk security
interface GigabitEthernet0/24
 switchport mode trunk
 switchport trunk native vlan 999
 switchport trunk allowed vlan 10,20,30
 spanning-tree portfast trunk
 exit

# Configure trunk pruning
interface GigabitEthernet0/24
 switchport mode trunk
 switchport trunk pruning vlan 40,50
 exit
```

## Access Port Configuration

### Access Port Basics
Access ports connect end devices (PCs, printers, phones) to the network and carry traffic for a single VLAN.

### Access Port Configuration Examples
```bash
# Configure basic access port
interface GigabitEthernet0/1
 switchport mode access
 switchport access vlan 10
 spanning-tree portfast
 exit

# Configure access port with BPDU guard
interface GigabitEthernet0/1
 switchport mode access
 switchport access vlan 10
 spanning-tree portfast
 spanning-tree bpduguard enable
 exit

# Configure access port with port security
interface GigabitEthernet0/1
 switchport mode access
 switchport access vlan 10
 switchport port-security
 switchport port-security maximum 2
 switchport port-security violation shutdown
 switchport port-security mac-address sticky
 spanning-tree portfast
 exit

# Configure access port for VoIP
interface GigabitEthernet0/1
 switchport mode access
 switchport access vlan 10
 switchport voice vlan 30
 mls qos trust cos
 spanning-tree portfast
 exit

# Verify access port configuration
show interfaces switchport
show running-config interface GigabitEthernet0/1
show spanning-tree interface GigabitEthernet0/1
```

## VTP Configuration

### VTP Basics
VTP (VLAN Trunking Protocol) propagates VLAN information across the switched network.

### VTP Modes
- **Server**: Can create, modify, delete VLANs
- **Client**: Receives VLAN information
- **Transparent**: Forwards VTP advertisements but doesn't participate
- **Off**: Disables VTP

### VTP Configuration Examples
```bash
# Configure VTP server
vtp mode server
vtp domain COMPANY
vtp password cisco
vtp version 2
vtp pruning
exit

# Configure VTP client
vtp mode client
vtp domain COMPANY
vtp password cisco
vtp version 2
exit

# Configure VTP transparent
vtp mode transparent
vtp domain COMPANY
exit

# Configure VTP off
vtp mode off
exit

# Verify VTP configuration
show vtp status
show vtp counters
show vtp interfaces
show vtp password
```

### VTP Troubleshooting
```bash
# Check VTP configuration
show vtp status
show vtp counters

# Check VTP domain
show vtp status | include Domain

# Check VTP version
show vtp status | include VTP

# Debug VTP
debug vtp events
debug vtp packets
debug vtp pruning
```

## PortChannel Configuration

### PortChannel Basics
PortChannel (Link Aggregation) bundles multiple physical links into a single logical link for increased bandwidth and redundancy.

### PortChannel Protocols
- **LACP (802.3ad)**: Industry standard
- **PAgP**: Cisco proprietary
- **Static**: Manual configuration

### PortChannel Configuration Examples
```bash
# Configure LACP PortChannel
interface Port-channel1
 switchport mode trunk
 switchport trunk allowed vlan 10,20,30
 exit

interface range GigabitEthernet0/23 - 24
 channel-group 1 mode active
 switchport mode trunk
 switchport trunk allowed vlan 10,20,30
 exit

# Configure PAgP PortChannel
interface Port-channel2
 switchport mode trunk
 switchport trunk allowed vlan 10,20,30
 exit

interface range GigabitEthernet0/21 - 22
 channel-group 2 mode desirable
 switchport mode trunk
 switchport trunk allowed vlan 10,20,30
 exit

# Configure static PortChannel
interface Port-channel3
 switchport mode trunk
 switchport trunk allowed vlan 10,20,30
 exit

interface range GigabitEthernet0/19 - 20
 channel-group 3 mode on
 switchport mode trunk
 switchport trunk allowed vlan 10,20,30
 exit
```

### PortChannel Load Balancing
```bash
# Configure load balancing method
port-channel load-balance src-dst-ip
port-channel load-balance src-dst-mac
port-channel load-balance src-dst-port

# Verify load balancing
show etherchannel load-balance
show etherchannel port-channel
```

### PortChannel Verification
```bash
# Show PortChannel summary
show etherchannel summary
show etherchannel detail
show etherchannel port-channel

# Show PortChannel statistics
show etherchannel statistics
show interfaces port-channel

# Debug PortChannel
debug etherchannel
debug pagp packets
debug lacp packets
```

## HSRP Configuration

### HSRP Basics
HSRP (Hot Standby Router Protocol) provides gateway redundancy for high availability.

### HSRP Configuration Examples
```bash
# Configure basic HSRP
interface GigabitEthernet0/1
 ip address 192.168.10.2 255.255.255.0
 standby 1 ip 192.168.10.1
 standby 1 priority 110
 standby 1 preempt
 exit

interface GigabitEthernet0/1
 ip address 192.168.10.3 255.255.255.0
 standby 1 ip 192.168.10.1
 standby 1 priority 90
 exit

# Configure HSRP authentication
interface GigabitEthernet0/1
 ip address 192.168.10.2 255.255.255.0
 standby 1 ip 192.168.10.1
 standby 1 priority 110
 standby 1 preempt
 standby 1 authentication md5 key-string cisco123
 exit

# Configure HSRP tracking
interface GigabitEthernet0/1
 ip address 192.168.10.2 .
 standby 	1 ip.
 standby .
 standby.
.
 standby.
.
 standby.
 exit

# Configure HSRP with object tracking
track 1 interface GigabitEthernet0/2 line-protocol
track 2 ip route 10.1.1.0 255.255.255.0 reachability

interface GigabitEthernet0/1
 ip address 192.168.10.2 255.255.255.0
 standby 1 ip 192.168.10.1
 standby 1 priority 110
 standby 1 preempt
 standby 1 track 1 decrement 20
 standby 1 track 2 decrement 30
 1.
 exit

# Configure HSRP version 2
interface GigabitEthernet0/1
 ip address 192.168.10.2 255.255.255.0
 standby version 2
 standby 1 ip 192.168.10.1
 standby 1 priority 110
 standby 1 preempt
 exit

# Verify HSRP configuration
show standby brief
show standby
show standby detail
debug standby
```

## VRRP Configuration

### VRRP Basics
VRRP (Virtual Router Redundancy Protocol) is an industry standard for gateway redundancy.

### VRRP Configuration Examples
```bash
# Configure basic VRRP
interface GigabitEthernet0/1
 ip address 192.168.10.2 255.255.255.0
 vrrp 1 ip 192.168.10.1
 vrrp 1 priority 110
 vrrp 1 preempt
 exit

interface GigabitEthernet0/1
 ip address 192.168.10.3 255.255.255.0
 vrrp 1 ip 192.168.10.1
 vrrp 1 priority 90
 exit

# Configure VRRP authentication
interface GigabitEthernet0/1
 ip address 192.168.10.2 255.255.255.0
 vrrp 1 ip 192.168.10.1
 vrrp 1 priority 110
 vrrp 1 preempt
 vrrp 1 authentication text cisco123
 exit

# Configure VRRP tracking
track 1 interface GigabitEthernet0/2 line-protocol

interface GigabitEthernet0/1
 ip address 192.168.10.2 255.255.255.0
 vrrp 1 ip 192.168.10.1
 vrrp 1 priority 110
 vrrp 1 preempt
 vrrp 1 track 1 decrement 20
 exit

# Verify VRRP configuration
show vrrp
show vrrp brief
debug vrrp
```

## GLBP Configuration

### GLBP Basics
GLBP (Gateway Load Balancing Protocol) provides both gateway redundancy and load balancing.

### GLBP Configuration Examples
```bash
# Configure basic GLBP
interface GigabitEthernet0/1
 ip address 192.168.10.2 255.255.255.0
 glbp 1 ip 192.168.10.1
 glbp 1 priority 110
 glbp 1 preempt
 exit

interface GigabitEthernet0/1
 ip address 192.168.10.3 255.255.255.0
 glbp 1 ip 192.168.10.1
 glbp 1 priority 90
 exit

# Configure GLBP load balancing
interface GigabitEthernet0/1
 ip address 192.168.10.2 255.255.255.0
 glbp 1 ip 192.168.10.1
 glbp 1 priority 110
 glbp 1 preempt
 glbp 1 load-balancing round-robin
 exit

# Configure GLBP authentication
interface GigabitEthernet0/1
 ip address 192.168.10.2 255.255.255.0
 glbp 1 ip 192.168.10.1
 glbp 1 priority 110
 glbp 1 preempt
 glbp 1 authentication md5 key-string cisco123
 exit

# Configure GLBP weighting
interface GigabitEthernet0/1
 ip address 192.168.10.2 255.255.255.0
 glbp 1 ip 192.168.10.1
 glbp 1 priority 110
 glbp 1 preempt
 glbp 1 weighting 100 lower 90 upper 95
 exit

# Verify GLBP configuration
show glbp
show glbp brief
debug glbp
```

## DHCP Configuration

### DHCP Server Configuration
```bash
# Configure DHCP server
ip dhcp excluded-address 192.168.10.1 192.168.10.10
ip dhcp excluded-address 192.168.20.1 192.168.20.10

ip dhcp pool VLAN10
 network 192.168.10.0 255.255.255.0
 default-router 192.168.10.1
 dns-server 8.8.8.8 8.8.4.4
 lease 7
 exit

ip dhcp pool VLAN20
 network 192.168.20.0 255.255.255.0
 default-router 192.168.20.1
 dns-server 8.8.8.8 8.8.4.4
 lease 7
 exit

# Verify DHCP configuration
show ip dhcp binding
show ip dhcp pool
show ip dhcp conflict
show ip dhcp server statistics
debug ip dhcp server events
```

### DHCP Snooping Configuration
```bash
# Configure DHCP snooping
ip dhcp snooping
ip dhcp snooping vlan 10,20
ip dhcp snooping information option

interface GigabitEthernet0/24
 ip dhcp snooping trust
 ip dhcp snooping limit rate 100
 exit

interface range GigabitEthernet0/1 - 12
 ip dhcp snooping limit rate 50
 exit

# Verify DHCP snooping
show ip dhcp snooping
show ip dhcp snooping binding
show ip dhcp snooping statistics
debug ip dhcp snooping
```

### DHCP Option 82 Configuration
```bash
# Configure DHCP option 82
ip dhcp snooping information option
ip dhcp snooping information option allow-untrusted

interface GigabitEthernet0/24
 ip dhcp snooping trust
 ip dhcp snooping information option format remote-id
 exit

# Verify DHCP option 82
show ip dhcp snooping information
```

## ARP Configuration

### ARP Configuration Examples
```bash
# Configure static ARP entry
arp 192.168.10.10 0000.0c12.3456 ARPA

# Configure ARP timeout
arp timeout 1200

# Configure ARP inspection
ip arp inspection vlan 10,20

interface GigabitEthernet0/24
 ip arp inspection trust
 exit

interface range GigabitEthernet0/1 - 12
 ip arp inspection limit rate 15
 exit

# Verify ARP configuration
show arp
show ip arp
show ip arp inspection
show ip arp inspection interfaces
debug arp
debug ip arp inspection
```

### Proxy ARP Configuration
```bash
# Configure proxy ARP
interface GigabitEthernet0/1
 ip proxy-arp
 exit

# Disable proxy ARP
interface GigabitEthernet0/1
 no ip proxy-arp
 exit

# Verify proxy ARP
show ip interface GigabitEthernet0/1
```

## MAC Table Management

### MAC Address Table Configuration
```bash
# Configure MAC address table aging time
mac address-table aging-time 300

# Configure MAC address table learning limit
mac address-table learning-limit 100

# Configure static MAC address
mac address-table static 0000.0c12.3456 vlan 10 interface GigabitEthernet0/1

# Configure MAC address table notification
mac address-table notification change
mac address-table notification history-size 100

# Verify MAC address table
show mac address-table
show mac address-table dynamic
show mac address-table static
show mac address-table aging-time
show mac address-table count
```

### MAC Address Table Security
```bash
# Configure MAC address table security
mac address-table secure notification
mac address-table learning-limit 50

# Configure MAC address table aging
mac address-table aging-time 600 vlan 10
mac address-table aging-time 300 vlan 20

# Verify MAC address table security
show mac address-table secure
show mac address-table notification
```

## MLS (Multilayer Switching)

### MLS Configuration Examples
```bash
# Enable IP routing
ip routing

# Configure SVI for inter-VLAN routing
interface Vlan10
 ip address 192.168.10.1 255.255.255.0
 no shutdown
 exit

interface Vlan20
 ip address 192.168.20.1 255.255.255.0
 no shutdown
 exit

# Configure routed port
interface GigabitEthernet0/24
 no switchport
 ip address 10.1.1.1 255.255.255.252
 no shutdown
 exit

# Configure CEF
ip cef
ip cef load-sharing algorithm universal

# Verify MLS configuration
show ip route
show ip interface brief
show ip cef
show ip cef summary
```

### MLS Verification
```bash
# Show routing table
show ip route
show ip route summary

# Show CEF table
show ip cef
show ip cef interface
show ip cef summary

# Debug MLS
debug ip packet
debug ip cef
```

## Subinterface Configuration

### Subinterface Configuration Examples
```bash
# Configure subinterfaces for router-on-a-stick
interface GigabitEthernet0/1
 no switchport
 ip address 10.1.1.1 255.255.255.252
 no shutdown
 exit

interface GigabitEthernet0/1.10
 encapsulation dot1q 10
 ip address 192.168.10.1 255.255.255.0
 exit

interface GigabitEthernet0/1.20
 encapsulation dot1q 20
 ip address 192.168.20.1 255.255.255.0
 exit

interface GigabitEthernet0/1.30
 encapsulation dot1q 30 native
 ip address 192.168.30.1 255.255.255.0
 exit

# Configure subinterface with QoS
interface GigabitEthernet0/1.10
 encapsulation dot1q 10
 ip address 192.168.10.1 255.255.255.0
 service-policy output QOS_POLICY
 exit

# Verify subinterface configuration
show ip interface brief
show running-config interface GigabitEthernet0/1.10
show interfaces GigabitEthernet0/1.10
```

## Command Reference

### VLAN Commands
```bash
# VLAN configuration
vlan 10
 name SALES
 exit

# VLAN verification
show vlan brief
show vlan id 10
show vlan summary
```

### Interface Commands
```bash
# Interface configuration
interface GigabitEthernet0/1
 switchport mode access
 switchport access vlan 10
 spanning-tree portfast
 exit

# Interface verification
show interfaces status
show interfaces switchport
show interfaces GigabitEthernet0/1
```

### Trunking Commands
```bash
# Trunk configuration
interface GigabitEthernet0/24
 switchport mode trunk
 switchport trunk native vlan 99
 switchport trunk allowed vlan 10,20,30
 exit

# Trunk verification
show interfaces trunk
show interfaces GigabitEthernet0/24 switchport
```

### VTP Commands
```bash
# VTP configuration
vtp mode server
vtp domain COMPANY
vtp password cisco
vtp version 2
exit

# VTP verification
show vtp status
show vtp counters
show vtp interfaces
```

### PortChannel Commands
```bash
# PortChannel configuration
interface Port-channel1
 switchport mode trunk
 switchport trunk allowed vlan 10,20,30
 exit

interface range GigabitEthernet0/23 - 24
 channel-group 1 mode active
 exit

# PortChannel verification
show etherchannel summary
show etherchannel detail
```

### HSRP Commands
```bash
# HSRP configuration
interface GigabitEthernet0/1
 standby 1 ip 192.168.10.1
 standby 1 priority 110
 standby 1 preempt
 exit

# HSRP verification
show standby brief
show standby
show standby detail
```

### DHCP Commands
```bash
# DHCP configuration
ip dhcp pool VLAN10
 network 192.168.10.0 255.255.255.0
 default-router 192.168.10.1
 exit

# DHCP verification
show ip dhcp binding
show ip dhcp pool
show ip dhcp server statistics
```

### MAC Address Commands
```bash
# MAC address configuration
mac address-table static 0000.0c12.3456 vlan 10 interface GigabitEthernet0/1
mac address-table aging-time 300

# MAC address verification
show mac address-table
show mac address-table dynamic
show mac address-table static
```

## Troubleshooting Guide

### VLAN Troubleshooting
```bash
# Check VLAN configuration
show vlan brief
show vlan id 10
show running-config | include vlan

# Check port VLAN assignment
show interfaces switchport
show running-config interface GigabitEthernet0/1

# Common issues:
# - VLAN not created
# - Wrong VLAN assignment
# - Trunk not allowing VLAN
# - Native VLAN mismatch
```

### Trunking Troubleshooting
```bash
# Check trunk configuration
show interfaces trunk
show interfaces GigabitEthernet0/24 switchport
show spanning-tree interface GigabitEthernet0/24

# Check DTP status
show dtp interface GigabitEthernet0/24

# Common issues:
# - Trunk mode mismatch
# - Native VLAN mismatch
# - Allowed VLAN list mismatch
# - DTP negotiation failure
```

### VTP Troubleshooting
```bash
# Check VTP configuration
show vtp status
show vtp counters
show vtp interfaces

# Check VTP domain
show vtp status | include Domain

# Common issues:
# - VTP domain mismatch
# - VTP password mismatch
# - VTP version mismatch
# - Trunk not configured
```

### PortChannel Troubleshooting
```bash
# Check PortChannel status
show etherchannel summary
show etherchannel detail
show etherchannel port-channel

# Check member interfaces
show etherchannel load-balance
show interfaces GigabitEthernet0/23 etherchannel

# Common issues:
# - Channel mode mismatch
# - Speed/duplex mismatch
# - Trunk configuration mismatch
# - Physical link issues
```

### HSRP/VRRP/GLBP Troubleshooting
```bash
# Check HSRP status
show standby brief
show standby
show standby detail

# Check VRRP status
show vrrp
show vrrp brief

# Check GLBP status
show glbp
show glbp brief

# Common issues:
# - Priority configuration
# - Authentication mismatch
# - Interface issues
# - Tracking problems
```

### DHCP Troubleshooting
```bash
# Check DHCP server
show ip dhcp binding
show ip dhcp pool
show ip dhcp server statistics

# Check DHCP snooping
show ip dhcp snooping
show ip dhcp snooping binding

# Debug DHCP
debug ip dhcp server events
debug ip dhcp snooping

# Common issues:
# - Address pool exhaustion
# - Configuration errors
# - DHCP snooping blocking
# - Option 82 issues
```

### MAC Address Table Troubleshooting
```bash
# Check MAC address table
show mac address-table
show mac address-table dynamic
show mac address-table static

# Check MAC address learning
show mac address-table learning-limit
show mac address-table aging-time

# Common issues:
# - MAC address table full
# - Learning limit reached
# - Aging time issues
# - Static MAC conflicts
```

### General Troubleshooting Commands
```bash
# System status
show version
show running-config
show startup-config
show environment all

# Interface status
show interfaces status
show interfaces counters
show interfaces errors

# Spanning Tree
show spanning-tree
show spanning-tree summary
show spanning-tree interface

# Debug commands
debug spanning-tree events
debug vtp events
debug etherchannel
debug standby
```

### Troubleshooting Methodology
1. **Identify the Problem**: Determine what is not working
2. **Gather Information**: Collect relevant data and logs
3. **Analyze the Data**: Look for patterns and anomalies
4. **Formulate Hypothesis**: Develop potential causes
5. **Test Hypothesis**: Verify or eliminate causes
6. **Implement Solution**: Apply the fix
7. **Verify Resolution**: Confirm the problem is solved
8. **Document**: Record the solution for future reference

---

This guide provides comprehensive coverage of Layer 2 and Layer 3 switching technologies, configurations, and troubleshooting procedures for Cisco switches, serving as a complete reference for network engineers and CCNA/CCNP students.
