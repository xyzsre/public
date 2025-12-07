# Cisco Catalyst 3650 Switch - Comprehensive Guide

## Table of Contents
- [Overview](#overview)
- [3650 Series Models](#3650-series-models)
- [Hardware Capabilities](#hardware-capabilities)
- [Use Cases](#use-cases)
- [Routing Capabilities](#routing-capabilities)
- [Switching Capabilities](#switching-capabilities)
- [Security Features](#security-features)
- [Protocol Support](#protocol-support)
- [Command Reference](#command-reference)
- [Troubleshooting Guide](#troubleshooting-guide)

## Overview

The Cisco Catalyst 3650 series is a line of enterprise-class Layer 3 switches that combine high-performance switching with advanced routing capabilities. These switches are designed for enterprise access layer deployments and offer StackWise-160 technology, advanced security features, and support for wireless controller functionality, making them ideal for modern campus networks.

## 3650 Series Models

### Main Variants
- **C3650-24PS**: 24 10/100/1000 ports with PoE+, 4 SFP+ ports
- **C3650-48PS**: 48 10/100/1000 ports with PoE+, 4 SFP+ ports
- **C3650-24PS-E**: 24 10/100/1000 ports with PoE+, 4 SFP+ ports (enhanced)
- **C3650-48PS-E**: 48 10/100/1000 ports with PoE+, 4 SFP+ ports (enhanced)
- **C3650-24TD**: 24 10/100/1000 ports, 2 10GbE SFP+, 2 1GbE SFP
- **C3650-48TD**: 48 10/100/1000 ports, 2 10GbE SFP+, 2 1GbE SFP

### Enhanced Models
- **C3650-24TQ**: 24 10/100/1000 ports, 4 10GbE SFP+
- **C3650-48TQ**: 48 10/100/1000 ports, 4 10GbE SFP+
- **C3650-24LQ**: 24 10/100/1000 ports, 4 10GbE SFP+ (low power)
- **C3650-48LQ**: 48 10/100/1000 ports, 4 10GbE SFP+ (low power)

### Key Features by Model
- **PS**: Power over Ethernet Plus (PoE+)
- **TD**: Twin Downlink with 10GbE uplinks
- **TQ**: Quad 10GbE uplinks
- **LQ**: Quad 10GbE uplinks with low power consumption
- **E**: Enhanced performance with more memory

## Hardware Capabilities

### Switching Capacity
- **Forwarding Rate**: 160-384 Gbps (varies by model)
- **Packet Forwarding Rate**: 130-304 Mpps
- **MAC Address Table**: 16,000-32,000 entries
- **VLAN Support**: Up to 4,000 VLANs
- **Routing Performance**: 87-240 Mpps (varies by model)

### Memory and Processing
- **DRAM**: 4GB-8GB
- **Flash Memory**: 2GB-4GB
- **CPU**: Multi-core processor with hardware acceleration
- **TCAM**: Hardware ACL and QoS support

### StackWise-160 Technology
- **Stack Bandwidth**: 160 Gbps
- **Maximum Stack Members**: 9 switches
- **Stack Bandwidth per Member**: 20 Gbps
- **Hot Swappable**: Support for hot-swappable stack members

### Physical Specifications
- **Form Factor**: 1U rack-mountable
- **Weight**: 6.0-12.0 kg (varies by model)
- **Power Consumption**: 80-370W (varies by model and PoE usage)
- **Operating Temperature**: 0°C to 45°C
- **Operating Humidity**: 10% to 85% (non-condensing)

### Interface Types
- **10/100/1000 Mbps Ethernet**: RJ-45 access ports
- **SFP+ Ports**: 10GbE fiber connectivity
- **SFP Ports**: 1GbE fiber connectivity
- **Console Port**: RJ-45 and USB console
- **Management Port**: Dedicated management Ethernet port

### Advanced Features
- **Layer 3 Switching**: Hardware-based routing
- **Wireless Controller**: Built-in wireless controller capabilities
- **AP Count**: Support for up to 50 access points
- **Client Count**: Support for up to 1000 wireless clients
- **StackPower**: Power stacking capabilities

## Use Cases

### 1. Campus Access Layer
- **Primary Role**: Access layer switch in campus networks
- **Typical Deployment**: 50-500 users per switch
- **Key Benefits**: PoE+, wireless controller, stacking capabilities

### 2. Small to Medium Business Core
- **Primary Role**: Core switch for SMB networks
- **Typical Deployment**: Central connectivity for entire organization
- **Key Benefits**: All-in-one solution, advanced features, scalability

### 3. Branch Office Aggregation
- **Primary Role**: Branch office aggregation and routing
- **Typical Deployment**: Multiple VLANs, inter-VLAN routing
- **Key Benefits**: Routing capabilities, security features

### 4. Wireless Network Deployment
- **Primary Role**: Wireless controller and access point connectivity
- **Typical Deployment**: Campus-wide wireless deployment
- **Key Benefits**: Built-in wireless controller, PoE+ for APs

### 5. VoIP and Unified Communications
- **Primary Role**: Voice and video network support
- **Typical Deployment**: PoE+ powered phones, QoS for voice/video
- **Key Benefits**: Enhanced PoE, QoS capabilities, voice optimization

## Routing Capabilities

### Static Routing
```bash
# Configure static route
ip route 192.168.2.0 255.255.255.0 10.1.1.1

# Configure default route
ip route 0.0.0.0 0.0.0.0 10.1.1.254

# Configure floating static route
ip route 10.2.2.0 255.255.255.0 10.1.1.2 100

# Verify static routes
show ip route
show ip route static
show ip route 192.168.2.0
```

### Dynamic Routing Protocols

#### RIP (Routing Information Protocol)
```bash
# Enable RIP
router rip
 version 2
 network 10.0.0.0
 network 192.168.1.0
 no auto-summary
 passive-interface default
 no passive-interface GigabitEthernet1/0/1

# Verify RIP
show ip protocols
show ip route rip
show ip rip database
debug ip rip
debug ip rip events
```

#### EIGRP (Enhanced Interior Gateway Routing Protocol)
```bash
# Enable EIGRP
router eigrp 100
 network 10.0.0.0
 network 192.168.1.0
 passive-interface default
 no passive-interface GigabitEthernet1/0/1
 eigrp router-id 1.1.1.1

# Configure EIGRP authentication
interface GigabitEthernet1/0/1
 ip authentication mode eigrp 100 md5
 ip authentication key-chain eigrp-key

# Create key chain
key chain eigrp-key
 key 1
  key-string cisco123

# Verify EIGRP
show ip eigrp neighbors
show ip eigrp topology
show ip eigrp interfaces
show ip eigrp traffic
debug eigrp packets
debug eigrp neighbors
```

#### OSPF (Open Shortest Path First)
```bash
# Enable OSPF
router ospf 1
 router-id 1.1.1.1
 network 10.0.0.0 0.0.0.255 area 0
 network 192.168.1.0 0.0.0.255 area 0
 passive-interface default
 no passive-interface GigabitEthernet1/0/1

# Configure OSPF authentication
interface GigabitEthernet1/0/1
 ip ospf authentication message-digest
 ip ospf message-digest-key 1 md5 cisco123

# Configure OSPF cost
interface GigabitEthernet1/0/1
 ip ospf cost 10

# Verify OSPF
show ip ospf neighbor
show ip ospf database
show ip ospf interface
show ip ospf interface brief
debug ospf events
debug ospf adj
```

#### BGP (Border Gateway Protocol)
```bash
# Enable BGP
router bgp 65001
 neighbor 10.1.1.2 remote-as 65002
 neighbor 10.1.1.2 description "ISP Peer"
 neighbor 192.168.1.1 remote-as 65001
 neighbor 192.168.1.1 description "Internal Peer"
 network 10.0.0.0 mask 255.255.255.0
 network 192.168.1.0 mask 255.255.255.0

# Configure BGP authentication
neighbor 10.1.1.2 password cisco123

# Configure BGP route filtering
neighbor 10.1.1.2 route-filter IN in
neighbor 10.1.1.2 route-filter OUT out

# Verify BGP
show ip bgp summary
show ip bgp neighbors
show ip bgp
show ip bgp routes
debug bgp events
debug bgp updates
```

### Advanced Routing Features

#### Policy-Based Routing (PBR)
```bash
# Create route map
route-map PBR permit 10
 match ip address 101
 set ip next-hop 10.1.1.254
 set ip default next-hop 10.1.1.253

# Create ACL for PBR
access-list 101 permit ip 192.168.10.0 0.0.0.255 any

# Apply to interface
interface GigabitEthernet1/0/1
 ip policy route-map PBR

# Verify PBR
show route-map
show ip policy
show ip interface GigabitEthernet1/0/1
```

#### Route Redistribution
```bash
# Redistribute between OSPF and EIGRP
router ospf 1
 redistribute eigrp 100 metric 20 subnets
 distribute-list prefix OSPF_FILTER in

router eigrp 100
 redistribute ospf 1 metric 10000 100 255 1 1500

# Create prefix list
ip prefix-list OSPP_FILTER seq 5 permit 10.0.0.0/8 le 24

# Verify redistribution
show ip protocols
show ip route eigrp
show ip route ospf
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

# Verify inter-VLAN routing
show ip interface brief
show ip route
```

## Switching Capabilities

### Enhanced Switching Features
- **Layer 2 Switching**: High-performance switching
- **VLAN Support**: Up to 4,000 VLANs
- **StackWise-160**: 160 Gbps stacking bandwidth
- **Private VLANs**: Enhanced security features
- **FlexStack**: Flexible stacking options

### VLAN Configuration
```bash
# Create VLANs
vlan 10
 name SALES
 private-vlan primary
 exit

vlan 20
 name MARKETING
 private-vlan isolated
 exit

vlan 99
 name NATIVE
 exit

# Assign ports to VLANs
interface range GigabitEthernet1/0/1 - 12
 switchport mode access
 switchport access vlan 10
 spanning-tree portfast
 exit

# Verify VLAN configuration
show vlan brief
show interfaces switchport
show spanning-tree vlan 10
```

### Trunk Configuration
```bash
# Configure trunk port
interface GigabitEthernet1/0/48
 switchport mode trunk
 switchport trunk native vlan 99
 switchport trunk allowed vlan 10,20,30
 switchport trunk allowed vlan add 40,50

# Verify trunk configuration
show interfaces trunk
show interfaces GigabitEthernet1/0/48 switchport
```

### PortChannel Configuration
```bash
# Create PortChannel
interface Port-channel1
 switchport mode trunk
 switchport trunk allowed vlan 10,20,30

# Add member interfaces
interface range GigabitEthernet1/0/47 - 48
 channel-group 1 mode active
 switchport mode trunk
 switchport trunk allowed vlan 10,20,30

# Verify PortChannel
show etherchannel summary
show etherchannel port-channel
show etherchannel detail
```

### Spanning Tree Configuration
```bash
# Configure Rapid PVST+
spanning-tree mode rapid-pvst

# Configure root bridge
spanning-tree vlan 10 root primary
spanning-tree vlan 20 root secondary

# Configure PortFast
interface range GigabitEthernet1/0/1 - 24
 spanning-tree portfast

# Configure BPDU Guard
spanning-tree portfast bpduguard default

# Verify STP
show spanning-tree summary
show spanning-tree vlan 10
show spanning-tree interface GigabitEthernet1/0/1
```

## Security Features

### Access Control Lists (ACLs)

#### Standard ACLs
```bash
# Create standard ACL
access-list 1 permit 192.168.10.0 0.0.0.255
access-list 1 deny any

# Apply to interface
interface Vlan10
 ip access-group 1 in

# Verify ACL
show access-lists
show ip interface
```

#### Extended ACLs
```bash
# Create extended ACL
access-list 101 permit tcp 192.168.10.0 0.0.0.255 192.168.20.0 0.0.0.255 eq 80
access-list 101 permit tcp 192.168.10.0 0.0.0.255 192.168.20.0 0.0.0.255 eq 443
access-list 101 permit icmp 192.168.10.0 0.0.0.255 192.168.20.0 0.0.0.255
access-list 101 deny ip any any

# Apply to interface
interface Vlan10
 ip access-group 101 in

# Verify extended ACL
show access-lists 101
show ip access-lists
```

#### Named ACLs
```bash
# Create named extended ACL
ip access-list extended WEB_ACCESS
 permit tcp 192.168.10.0 0.0.0.255 192.168.20.0 0.0.0.255 eq 80
 permit tcp 192.168.10.0 0.0.0.255 192.168.20.0 0.0.0.255 eq 443
 permit icmp 192.168.10.0 0.0.0.255 192.168.20.0 0.0.0.255
 deny ip any any

# Apply to interface
interface Vlan10
 ip access-group WEB_ACCESS in

# Verify named ACL
show ip access-lists WEB_ACCESS
```

### Port Security
```bash
# Configure port security
interface GigabitEthernet1/0/1
 switchport mode access
 switchport port-security
 switchport port-security maximum 2
 switchport port-security violation shutdown
 switchport port-security mac-address sticky

# Verify port security
show port-security interface GigabitEthernet1/0/1
show port-security
```

### DHCP Snooping
```bash
# Enable DHCP snooping globally
ip dhcp snooping

# Enable DHCP snooping on VLAN
ip dhcp snooping vlan 10

# Configure trusted interface
interface GigabitEthernet1/0/48
 ip dhcp snooping trust

# Verify DHCP snooping
show ip dhcp snooping
show ip dhcp snooping binding
```

### Dynamic ARP Inspection
```bash
# Enable DAI globally
ip arp inspection vlan 10

# Configure trusted interface
interface GigabitEthernet1/0/48
 ip arp inspection trust

# Verify DAI
show ip arp inspection
show ip arp inspection interfaces
```

### Network Address Translation (NAT)

#### Static NAT
```bash
# Configure static NAT
ip nat inside source static 192.168.10.10 203.0.113.10
ip nat inside source static tcp 192.168.10.20 80 203.0.113.20 80

# Define inside and outside interfaces
interface Vlan10
 ip nat inside

interface GigabitEthernet1/0/48
 ip nat outside

# Verify NAT
show ip nat translations
show ip nat statistics
debug ip nat
debug ip nat detailed
```

#### Dynamic NAT
```bash
# Create ACL for NAT
access-list 10 permit 192.168.10.0 0.0.0.255

# Configure dynamic NAT pool
ip nat pool PUBLIC_POOL 203.0.113.20 203.0.113.30 netmask 255.255.255.240

# Configure dynamic NAT
ip nat inside source list 10 pool PUBLIC_POOL

# Verify dynamic NAT
show ip nat translations
show ip nat statistics
```

#### PAT (Port Address Translation)
```bash
# Configure PAT
ip nat inside source list 10 interface GigabitEthernet1/0/48 overload

# Verify PAT
show ip nat translations
show ip nat statistics
```

## Wireless Controller Features

### Wireless Controller Configuration
```bash
# Enable wireless controller
wireless controller

# Create WLAN
wlan MyWLAN 1 MyWLAN
 client vlan 10
 security wpa2 psk
 wpa-psk ascii cisco123

# Create AP group
ap-group default
 wlan 1 MyWLAN

# Configure interface
interface Vlan10
 ip address 192.168.10.1 255.255.255.0

# Verify wireless configuration
show wlan summary
show ap summary
show client summary
```

### AP Configuration
```bash
# Configure AP
ap name AP-01
 ap-group default

# Verify AP status
show ap name AP-01 config
show ap name AP-01 client summary
```

## Protocol Support

### Routing Protocols
- **Static Routing**: Manual route configuration
- **RIP v1/v2**: Distance vector routing protocol
- **EIGRP**: Cisco proprietary distance vector protocol
- **OSPFv2/v3**: Link state routing protocol (IPv4 and IPv6)
- **BGP**: Exterior gateway protocol
- **IS-IS**: Link state protocol

### Switching Protocols
- **STP Variants**: PVST+, RSTP, MST
- **VTP**: VLAN Trunking Protocol
- **CDP**: Cisco Discovery Protocol
- **LLDP**: Link Layer Discovery Protocol
- **LACP**: Link Aggregation Control Protocol
- **PAgP**: Port Aggregation Protocol

### Security Protocols
- **802.1X**: Port-based authentication
- **MAC Authentication Bypass**: Alternative to 802.1X
- **IPsec**: IP security protocol
- **SSL/TLS**: Secure socket layer
- **SSH**: Secure Shell

### Wireless Protocols
- **802.11a/b/g/n/ac**: Wireless standards
- **CAPWAP**: Control and Provisioning of Wireless Access Points
- **802.1X**: Wireless authentication
- **WPA/WPA2**: Wireless security

### Management Protocols
- **SNMP**: Simple Network Management Protocol
- **Syslog**: System logging
- **NetFlow**: Network traffic analysis
- **NTP**: Network Time Protocol

## Command Reference

### Basic Configuration

#### Global Configuration
```bash
# Enter privileged EXEC mode
enable

# Enter global configuration mode
configure terminal

# Set hostname
hostname Switch3650

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
 transport input ssh

# Enable password encryption
service password-encryption

# Set clock timezone
clock timezone EST -5

# Configure domain name
ip domain-name company.local
```

#### Interface Configuration
```bash
# Configure GigabitEthernet interface
interface GigabitEthernet1/0/1
 description "Access Port"
 switchport mode access
 switchport access vlan 10
 spanning-tree portfast

# Configure uplink interface
interface GigabitEthernet1/0/48
 description "Uplink to Core"
 switchport mode trunk
 switchport trunk allowed vlan 10,20,30

# Verify interface configuration
show ip interface brief
show interfaces
show running-config interface GigabitEthernet1/0/1
```

### Stacking Configuration

#### StackWise-160 Configuration
```bash
# Configure stack member priority
switch 1 priority 15
switch 2 priority 10

# Configure stack MAC address
stack-mac persistent timer 0

# Verify stack configuration
show switch
show switch stack-ports
show switch stack-ring speed
```

#### StackPower Configuration
```bash
# Configure StackPower
stack-power stack PowerStack1
 mode power-pool

# Configure stack member
switch 1
 stack-power stack PowerStack1
 priority 10

# Verify StackPower
show stack-power
show stack-power budget
```

### Monitoring and Verification

#### System Monitoring
```bash
# Show system information
show version
show running-config
show startup-config
show inventory

# Show memory utilization
show memory statistics
show processes memory

# Show CPU utilization
show processes cpu sorted

# Show environment
show environment all
show temperature
show platform

# Show stack information
show switch
show switch stack-ports
```

#### Interface Monitoring
```bash
# Show interface statistics
show interfaces
show interfaces counters
show interfaces GigabitEthernet1/0/1

# Show interface errors
show interfaces errors
show interfaces GigabitEthernet1/0/1 errors

# Show interface utilization
show interfaces GigabitEthernet1/0/1 accounting
```

#### Routing Monitoring
```bash
# Show routing table
show ip route
show ip route summary

# Show routing protocols
show ip protocols

# Show ARP table
show arp
show ip arp

# Show CEF information
show ip cef
show ip cef summary
```

#### Wireless Monitoring
```bash
# Show wireless information
show wlan summary
show ap summary
show client summary

# Show wireless statistics
show dot11 statistics
show dot11 associations
```

### Debug Commands

#### General Debugging
```bash
# Debug routing protocols
debug ip routing
debug rip events
debug ospf events
debug eigrp packets
debug bgp events

# Debug interfaces
debug interface events
debug spanning-tree events

# Debug wireless
debug dot11 events
debug capwap events

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
show ip interface brief

# Check interface configuration
show running-config interface GigabitEthernet1/0/1

# Check for error-disabled state
show interfaces status err-disabled

# Check port security violations
show port-security interface GigabitEthernet1/0/1

# Re-enable err-disabled port
interface GigabitEthernet1/0/1
shutdown
no shutdown
```

**Common Causes**:
- Interface administratively shutdown
- Cable not connected
- Speed/duplex mismatch
- Port security violation
- BPDU guard enabled

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

#### 3. Routing Issues
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

#### 4. Stack Issues
**Symptoms**: Stack not forming, members not communicating

**Troubleshooting Steps**:
```bash
# Check stack status
show switch
show switch stack-ports

# Check stack cables
show switch stack-ring speed

# Check stack MAC address
show switch stack-mac

# Reconfigure stack member
switch 2 renumber 3
```

**Common Causes**:
- Stack cables not connected properly
- Different IOS versions
- Stack priority conflicts
- Hardware failures

#### 5. Wireless Issues
**Symptoms**: Access points not joining, clients not connecting

**Troubleshooting Steps**:
```bash
# Check AP status
show ap summary
show ap join statistics

# Check WLAN configuration
show wlan summary

# Check client status
show client summary

# Debug wireless
debug dot11 events
debug capwap events
```

**Common Causes**:
- AP not powered properly
- WLAN configuration issues
- Authentication problems
- RF interference

#### 6. Performance Issues
**Symptoms**: Slow performance, high CPU utilization

**Troubleshooting Steps**:
```bash
# Check CPU utilization
show processes cpu sorted

# Check memory utilization
show memory statistics

# Check interface utilization
show interfaces counters

# Check for errors
show interfaces errors

# Check for packet drops
show interfaces GigabitEthernet1/0/1 accounting
```

**Common Causes**:
- High CPU utilization
- Memory exhaustion
- Interface errors
- ACL processing overhead
- Broadcast storms

### Advanced Troubleshooting

#### Packet Tracing
```bash
# Enable IP packet debugging
debug ip packet

# Enable detailed IP debugging
debug ip packet detail

# Enable ACL debugging
debug ip packet 101

# Enable routing debugging
debug ip routing
```

#### Performance Analysis
```bash
# Show process utilization
show processes cpu history
show processes memory sorted

# Show interface statistics
show interfaces GigabitEthernet1/0/1 stats

# Show buffer utilization
show buffers
show buffers summary
```

#### Configuration Recovery
```bash
# Save configuration
write memory
copy running-config startup-config

# Reset to factory defaults
write erase
reload

# Recover from corrupted configuration
copy startup-config running-config
```

### Best Practices

#### 1. Configuration Management
- Always document changes
- Use configuration backup regularly
- Test changes in lab first
- Use descriptive interface descriptions

#### 2. Security Hardening
- Use strong passwords
- Enable SSH instead of Telnet
- Configure ACLs for security
- Enable logging and monitoring
- Disable unused services

#### 3. Performance Optimization
- Use appropriate routing protocols
- Optimize ACL placement
- Monitor resource utilization
- Use hardware acceleration when available

#### 4. Wireless Optimization
- Plan RF coverage properly
- Use appropriate channels
- Monitor interference
- Optimize AP placement

#### 5. Maintenance
- Regular firmware updates
- Monitor system logs
- Check hardware status
- Verify configuration backups

---

This guide provides comprehensive information for configuring, managing, and troubleshooting Cisco Catalyst 3650 switches, covering all essential topics for CCNA students and network administrators working with modern enterprise switching solutions.
