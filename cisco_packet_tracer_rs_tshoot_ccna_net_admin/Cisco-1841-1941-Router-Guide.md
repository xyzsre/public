# Cisco 1841 and 1941 Router - Comprehensive Guide

## Table of Contents
- [Overview](#overview)
- [1841 and 1941 Models](#1841-and-1941-models)
- [Hardware Capabilities](#hardware-capabilities)
- [Use Cases](#use-cases)
- [Routing Capabilities](#routing-capabilities)
- [Switching Capabilities](#switching-capabilities)
- [Security Features](#security-features)
- [Protocol Support](#protocol-support)
- [Command Reference](#command-reference)
- [Troubleshooting Guide](#troubleshooting-guide)

## Overview

The Cisco 1841 and 1941 are Integrated Services Routers designed for small to medium-sized branch offices and enterprise edge applications. The 1841 represents the older generation while the 1941 offers enhanced performance and modern features. Both routers provide routing, security, and voice capabilities in compact, cost-effective platforms.

### Key Differences Between 1841 and 1941
- **1841**: Legacy ISR with classic IOS, lower performance
- **1941**: Enhanced ISR with IOS XE support, higher performance
- **Architecture**: 1841 uses PowerPC, 1941 uses enhanced processor
- **Software**: 1841 runs IOS, 1941 can run IOS XE

## 1841 and 1941 Models

### Cisco 1841 Models
- **1841**: Base model with 2 Fast Ethernet ports
- **1841/K9**: Base model with advanced security features
- **1841-V**: Voice-enabled model with DSP support
- **1841-V/K9**: Voice-enabled with advanced security

### Cisco 1941 Models
- **C1941/K9**: Standard security model
- **C1941/K9-SEC**: Enhanced security model
- **C1941/K9-APP**: Application performance model
- **C1941/K9-AX**: Advanced security model
- **C1941-V/K9**: Voice-enabled model
- **C1941-V/K9-SEC**: Voice-enabled with enhanced security

### Key Features by Model
- **Base**: Standard routing and switching capabilities
- **K9**: Advanced security (VPN, firewall, intrusion prevention)
- **V**: Voice over IP capabilities with DSP modules
- **SEC**: Enhanced security with additional licenses
- **APP**: Application visibility and control
- **AX**: Advanced security with threat defense

## Hardware Capabilities

### Cisco 1841 Specifications
- **CPU**: 266MHz PowerPC processor
- **DRAM**: 128MB-256MB (upgradeable)
- **Flash Memory**: 32MB-64MB (upgradeable)
- **Packet Forwarding**: Up to 75,000 pps
- **Throughput**: Up to 100 Mbps with encryption, 200 Mbps without

### Cisco 1941 Specifications
- **CPU**: 800MHz processor (enhanced)
- **DRAM**: 256MB-512MB (upgradeable to 1GB)
- **Flash Memory**: 256MB-512MB (upgradeable)
- **Packet Forwarding**: Up to 150,000 pps
- **Throughput**: Up to 300 Mbps with encryption, 500 Mbps without

### Physical Interfaces

#### Cisco 1841
- **Fast Ethernet Ports**: 2 integrated 10/100 Mbps ports
- **WIC Slots**: 2 slots for WAN Interface Cards
- **HWIC Slots**: 4 slots for High-Speed WAN Interface Cards
- **AIM Slots**: 1 slot for Advanced Integration Modules
- **Console Port**: RJ-45 serial management
- **Auxiliary Port**: RJ-45 for modem connections

#### Cisco 1941
- **Gigabit Ethernet Ports**: 2 integrated 10/100/1000 Mbps ports
- **WIC Slots**: 2 slots for WAN Interface Cards
- **HWIC Slots**: 4 slots for High-Speed WAN Interface Cards
- **AIM Slots**: 2 slots for Advanced Integration Modules
- **Console Port**: RJ-45 and USB console
- **Management Port**: Dedicated management Ethernet port

### Interface Card Support
- **WIC-1T/2T**: Serial interfaces
- **WIC-1ENET**: Ethernet interface
- **WIC-1B-S/T**: ISDN BRI interface
- **HWIC-1FE**: Fast Ethernet interface
- **HWIC-4ESW**: 4-port Ethernet switch module
- **HWIC-3G-CDMA**: 3G cellular WAN card
- **PVDM**: Packet Voice DSP Modules

### Power and Environmental
- **1841 Power**: 20-40W typical
- **1941 Power**: 30-60W typical
- **Operating Temperature**: 0°C to 40°C
- **Operating Humidity**: 10% to 85% (non-condensing)
- **Form Factor**: 1U rack-mountable or desktop

## Use Cases

### 1. Small Branch Office Router
- **Primary Role**: Connect small branch office to central site
- **Typical Deployment**: 10-50 users per location
- **Key Benefits**: Cost-effective, reliable, feature-rich

### 2. Small Office/Home Office (SOHO)
- **Primary Role**: Internet connectivity and basic routing
- **Typical Deployment**: 1-10 users
- **Key Benefits**: All-in-one solution, easy management

### 3. VPN Concentrator
- **Primary Role**: Secure remote access for mobile users
- **Typical Deployment**: Remote workforce connectivity
- **Key Benefits**: Hardware encryption, secure tunnels

### 4. Voice Gateway
- **Primary Role**: VoIP network integration
- **Typical Deployment**: PBX to IP network conversion
- **Key Benefits**: Voice quality optimization, codec support

### 5. Internet Edge Router
- **Primary Role**: Internet connectivity and security
- **Typical Deployment**: Network perimeter security
- **Key Benefits**: Firewall, NAT, VPN capabilities

## Routing Capabilities

### Static Routing
```bash
# Configure static route
ip route 192.168.2.0 255.255.255.0 10.1.1.1

# Configure default route
ip route 0.0.0.0 0.0.0.0 10.1.1.254

# Configure floating static route
ip route 10.2.2.0 255.255.255.0 10.1.1.2 100

# Configure recursive static route
ip route 192.168.3.0 255.255.255.0 10.1.1.1

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
 no passive-interface FastEthernet0/0

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
 no passive-interface FastEthernet0/0
 eigrp router-id 1.1.1.1

# Configure EIGRP authentication
interface FastEthernet0/0
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
 no passive-interface FastEthernet0/0

# Configure OSPF authentication
interface FastEthernet0/0
 ip ospf authentication message-digest
 ip ospf message-digest-key 1 md5 cisco123

# Configure OSPF cost
interface FastEthernet0/0
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
interface FastEthernet0/0
 ip policy route-map PBR

# Verify PBR
show route-map
show ip policy
show ip interface FastEthernet0/0
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
ip prefix-list OSPF_FILTER seq 5 permit 10.0.0.0/8 le 24

# Verify redistribution
show ip protocols
show ip route eigrp
show ip route ospf
```

## Switching Capabilities

### Basic Switching Features
- **Layer 2 Switching**: Limited switching capabilities with HWIC modules
- **VLAN Support**: Basic VLAN configuration with switch modules
- **Bridge Groups**: Software bridging between interfaces

### HWIC-4ESW Configuration
```bash
# Configure switch module
interface FastEthernet0/1/0
 switchport mode access
 switchport access vlan 10

interface FastEthernet0/1/1
 switchport mode trunk
 switchport trunk allowed vlan 10,20,30

# Create VLANs
vlan 10
 name SALES
 exit

vlan 20
 name MARKETING
 exit

# Verify switching
show vlan brief
show interfaces switchport
```

### Bridge Groups
```bash
# Create bridge group
interface FastEthernet0/0
 bridge-group 1

interface FastEthernet0/1
 bridge-group 1

# Configure bridge
bridge 1 route ip

# Verify bridge
show bridge
show bridge group
```

## Security Features

### Access Control Lists (ACLs)

#### Standard ACLs
```bash
# Create standard ACL
access-list 1 permit 192.168.10.0 0.0.0.255
access-list 1 deny any

# Apply to interface
interface FastEthernet0/0
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
interface FastEthernet0/0
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
interface FastEthernet0/0
 ip access-group WEB_ACCESS in

# Verify named ACL
show ip access-lists WEB_ACCESS
```

#### Time-Based ACLs
```bash
# Create time range
time-range BUSINESS_HOURS
 periodic weekdays 8:00 to 17:00

# Apply time range to ACL
ip access-list extended TIME_ACL
 permit tcp 192.168.10.0 0.0.0.255 any eq 80 time-range BUSINESS_HOURS

# Verify time range
show time-range
```

### Network Address Translation (NAT)

#### Static NAT
```bash
# Configure static NAT
ip nat inside source static 192.168.10.10 203.0.113.10
ip nat inside source static tcp 192.168.10.20 80 203.0.113.20 80

# Define inside and outside interfaces
interface FastEthernet0/0
 ip nat inside

interface FastEthernet0/1
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
show ip nat translations verbose
```

#### PAT (Port Address Translation)
```bash
# Configure PAT
ip nat inside source list 10 interface FastEthernet0/1 overload

# Configure PAT with overload
ip nat inside source list 10 pool PUBLIC_POOL overload

# Verify PAT
show ip nat translations
show ip nat statistics
```

### VPN and Tunnels

#### Site-to-Site VPN (IPsec)
```bash
# Create ISAKMP policy
crypto isakmp policy 10
 encr aes 256
 authentication pre-share
 group 5
 lifetime 86400

# Set pre-shared key
crypto isakmp key cisco@123 address 203.0.113.50

# Create IPsec transform set
crypto ipsec transform-set ESP-AES256 esp-aes 256 esp-sha-hmac
 mode tunnel

# Create crypto map
crypto map VPN_MAP 10 ipsec-isakmp
 set peer 203.0.113.50
 set transform-set ESP-AES256
 match address 101
 set security-association lifetime seconds 3600

# Apply crypto map to interface
interface FastEthernet0/1
 crypto map VPN_MAP

# Create ACL for VPN traffic
access-list 101 permit ip 192.168.10.0 0.0.0.255 192.168.20.0 0.0.0.255

# Verify IPsec VPN
show crypto isakmp sa
show crypto ipsec sa
show crypto map
show crypto isakmp policy
show crypto ipsec transform-set
debug crypto isakmp
debug crypto ipsec
```

#### GRE Tunnel
```bash
# Create GRE tunnel
interface Tunnel0
 ip address 10.255.255.1 255.255.255.252
 tunnel source FastEthernet0/1
 tunnel destination 203.0.113.50
 tunnel mode gre
 tunnel key 12345

# Configure routing over tunnel
router ospf 1
 network 10.255.255.0 0.0.0.3 area 0

# Verify tunnel
show interface Tunnel0
show ip interface brief
show running-config interface Tunnel0
debug tunnel
```

#### DMVPN (Dynamic Multipoint VPN)
```bash
# Create tunnel interface
interface Tunnel0
 ip address 10.255.255.1 255.255.255.0
 ip nhrp authentication DMVPN
 ip nhrp network-id 1
 ip nhrp holdtime 300
 ip nhrp map multicast dynamic
 tunnel source FastEthernet0/1
 tunnel mode gre multipoint
 tunnel key 12345

# Configure NHRP
ip nhrp nhs 10.255.255.1

# Configure routing over DMVPN
router ospf 1
 network 10.255.255.0 0.0.0.255 area 0

# Verify DMVPN
show ip nhrp
show ip nhrp traffic
show interface Tunnel0
```

### Firewall Features

#### Zone-Based Firewall
```bash
# Create security zones
zone security INSIDE
zone security OUTSIDE

# Create zone-pair
zone-pair security INSIDE-TO-OUTSIDE source INSIDE destination OUTSIDE
 service-policy type inspect OUTBOUND_POLICY

# Create class map
class-map type inspect match-any INSIDE_TRAFFIC
 match protocol tcp
 match protocol udp
 match protocol icmp

# Create policy map
policy-map type inspect OUTBOUND_POLICY
 class type inspect INSIDE_TRAFFIC
  inspect

# Apply zones to interfaces
interface FastEthernet0/0
 zone-member security INSIDE

interface FastEthernet0/1
 zone-member security OUTSIDE

# Verify firewall
show zone-pair security
show policy-map type inspect
show class-map type inspect
```

#### CBAC (Context-Based Access Control)
```bash
# Create inspection rule
ip inspect name MY_INSPECT tcp
ip inspect name MY_INSPECT udp
ip inspect name MY_INSPECT icmp

# Apply inspection to interface
interface FastEthernet0/0
 ip inspect MY_INSPECT out

# Verify CBAC
show ip inspect session
show ip inspect config
debug ip inspect
```

## Protocol Support

### Routing Protocols
- **Static Routing**: Manual route configuration
- **RIP v1/v2**: Distance vector routing protocol
- **EIGRP**: Cisco proprietary distance vector protocol
- **OSPF**: Link state routing protocol
- **BGP**: Exterior gateway protocol
- **IS-IS**: Link state protocol (limited support)

### WAN Protocols
- **PPP**: Point-to-Point Protocol
- **HDLC**: High-Level Data Link Control
- **Frame Relay**: Packet-switched WAN technology
- **PPP over Ethernet (PPPoE)**: DSL connections
- **X.25**: Legacy packet-switching protocol

### Voice Protocols
- **H.323**: Video conferencing protocol
- **SIP**: Session Initiation Protocol
- **MGCP**: Media Gateway Control Protocol
- **SCCP**: Skinny Call Control Protocol

### Security Protocols
- **IPsec**: IP security protocol
- **SSL/TLS**: Secure socket layer
- **SSH**: Secure Shell
- **HTTPS**: HTTP over SSL/TLS

## Command Reference

### Basic Configuration

#### Global Configuration
```bash
# Enter privileged EXEC mode
enable

# Enter global configuration mode
configure terminal

# Set hostname
hostname Router1841

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
 transport input ssh telnet

# Enable password encryption
service password-encryption

# Set clock timezone
clock timezone EST -5
```

#### Interface Configuration
```bash
# Configure FastEthernet interface (1841)
interface FastEthernet0/0
 description "LAN Interface"
 ip address 192.168.10.1 255.255.255.0
 ip nat inside
 no shutdown

# Configure GigabitEthernet interface (1941)
interface GigabitEthernet0/0
 description "LAN Interface"
 ip address 192.168.10.1 255.255.255.0
 ip nat inside
 no shutdown

# Configure WAN interface
interface FastEthernet0/1
 description "WAN Interface"
 ip address 203.0.113.10 255.255.255.252
 ip nat outside
 no shutdown

# Verify interface configuration
show ip interface brief
show interfaces
show running-config interface FastEthernet0/0
```

### Advanced Configuration

#### DHCP Server
```bash
# Create DHCP pool
ip dhcp pool LAN_POOL
 network 192.168.10.0 255.255.255.0
 default-router 192.168.10.1
 dns-server 8.8.8.8 8.8.4.4
 lease 7

# Exclude addresses from pool
ip dhcp excluded-address 192.168.10.1 192.168.10.10

# Verify DHCP
show ip dhcp binding
show ip dhcp pool
show ip dhcp conflict
debug ip dhcp server events
```

#### DNS Configuration
```bash
# Configure DNS lookup
ip domain-lookup
ip name-server 8.8.8.8
ip name-server 8.8.4.4

# Configure local domain
ip domain-name company.local

# Verify DNS
show hosts
nslookup www.cisco.com
```

#### NTP Configuration
```bash
# Configure NTP server
ntp server 129.6.15.28
ntp server 129.6.15.29

# Configure NTP authentication
ntp authenticate
ntp authentication-key 1 md5 cisco123
ntp trusted-key 1

# Verify NTP
show ntp status
show ntp associations
show ntp authentication-keys
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
```

#### Interface Monitoring
```bash
# Show interface statistics
show interfaces
show interfaces counters
show interfaces FastEthernet0/0

# Show interface errors
show interfaces errors
show interfaces FastEthernet0/0 errors

# Show interface utilization
show interfaces FastEthernet0/0 accounting
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

# Show CEF information (if enabled)
show ip cef
show ip cef summary
```

#### Security Monitoring
```bash
# Show ACLs
show access-lists
show ip access-lists

# Show NAT
show ip nat translations
show ip nat statistics

# Show VPN
show crypto isakmp sa
show crypto ipsec sa
show crypto map

# Show firewall
show zone-pair security
show ip inspect session
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
debug serial interface

# Debug NAT
debug ip nat
debug ip nat detailed

# Debug VPN
debug crypto isakmp
debug crypto ipsec

# Disable all debugging
no debug all
```

## Troubleshooting Guide

### Common Issues and Solutions

#### 1. Interface Not Coming Up
**Symptoms**: Interface status shows "down" or "administratively down"

**Troubleshooting Steps**:
```bash
# Check interface status
show ip interface brief

# Check interface configuration
show running-config interface FastEthernet0/0

# Check for physical layer issues
show controllers FastEthernet0/0

# Enable interface if shutdown
interface FastEthernet0/0
no shutdown

# Check cable connectivity
show interface FastEthernet0/0
```

**Common Causes**:
- Interface administratively shutdown
- Cable not connected
- Speed/duplex mismatch
- Hardware failure

#### 2. Routing Issues
**Symptoms**: Cannot reach remote networks, routing table incomplete

**Troubleshooting Steps**:
```bash
# Check routing table
show ip route

# Check routing protocol status
show ip protocols

# Check interface IP configuration
show ip interface brief

# Check ACLs
show access-lists
show ip interface access-lists

# Debug routing protocol
debug ip routing
debug ospf events
debug eigrp packets
```

**Common Causes**:
- Incorrect routing protocol configuration
- Interface not participating in routing
- ACL blocking routing protocol traffic
- Network connectivity issues

#### 3. NAT Issues
**Symptoms**: Internal hosts cannot access internet, NAT not working

**Troubleshooting Steps**:
```bash
# Check NAT configuration
show running-config | include ip nat

# Check NAT translations
show ip nat translations
show ip nat statistics

# Check interface NAT designation
show ip interface brief

# Debug NAT
debug ip nat
debug ip nat detailed

# Test NAT translation
ping 8.8.8.8 source 192.168.10.10
```

**Common Causes**:
- Wrong inside/outside interface designation
- ACL not matching correct traffic
- NAT pool exhausted
- Overload not configured for PAT

#### 4. VPN Issues
**Symptoms**: VPN tunnel not establishing, no traffic through tunnel

**Troubleshooting Steps**:
```bash
# Check ISAKMP status
show crypto isakmp sa

# Check IPsec status
show crypto ipsec sa

# Check crypto map
show crypto map

# Check ACL for VPN traffic
show access-lists

# Debug VPN
debug crypto isakmp
debug crypto ipsec

# Test connectivity
ping 192.168.20.1 source 192.168.10.1
```

**Common Causes**:
- ISAKMP policy mismatch
- Pre-shared key mismatch
- ACL not matching traffic
- NAT traversal issues
- Firewall blocking IPsec ports

#### 5. ACL Issues
**Symptoms**: Legitimate traffic being blocked, unexpected access denied

**Troubleshooting Steps**:
```bash
# Check ACL configuration
show access-lists
show ip access-lists

# Check ACL application
show ip interface

# Test ACL functionality
show access-lists 101

# Remove problematic ACL
interface FastEthernet0/0
no ip access-group 101 in

# Debug ACL
debug ip packet
```

**Common Causes**:
- ACL too restrictive
- Wrong ACL applied to interface
- ACL applied in wrong direction
- Implicit deny blocking traffic

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
show interfaces FastEthernet0/0 accounting
```

**Common Causes**:
- High CPU utilization
- Memory exhaustion
- Interface errors
- ACL processing overhead
- Encryption overhead

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
show interfaces FastEthernet0/0 stats

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

#### 4. Maintenance
- Regular firmware updates
- Monitor system logs
- Check hardware status
- Verify configuration backups

#### 5. Documentation
- Maintain network diagrams
- Document IP addressing schemes
- Record configuration changes
- Keep contact information

---

This guide provides comprehensive information for configuring, managing, and troubleshooting Cisco 1841 and 1941 routers, covering all essential topics for CCNA students and network administrators working with branch office and edge routing solutions.
