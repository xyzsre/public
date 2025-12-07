# Cisco 2901 and 2911 Router - Comprehensive Guide

## Table of Contents
- [Overview](#overview)
- [2901 and 2911 Models](#2901-and-2911-models)
- [Hardware Capabilities](#hardware-capabilities)
- [Use Cases](#use-cases)
- [Routing Capabilities](#routing-capabilities)
- [Switching Capabilities](#switching-capabilities)
- [Security Features](#security-features)
- [Protocol Support](#protocol-support)
- [Command Reference](#command-reference)
- [Troubleshooting Guide](#troubleshooting-guide)

## Overview

The Cisco 2901 and 2911 are part of the Cisco Integrated Services Router Generation 2 (ISR G2) family, representing modern, high-performance routers designed for small to medium-sized branch offices and enterprise edge applications. These routers offer significantly enhanced performance, advanced security features, and support for modern networking protocols compared to legacy ISR series.

### Key Differences Between 2901 and 2911
- **2901**: Compact form factor, 2 integrated Gigabit Ethernet ports
- **2911**: Larger form factor, 3 integrated Gigabit Ethernet ports
- **Performance**: 2911 offers higher throughput and more expansion slots
- **Architecture**: Both use multi-core processors with hardware acceleration

## 2901 and 2911 Models

### Cisco 2901 Models
- **C2901/K9**: Standard security model
- **C2901/K9-SEC**: Enhanced security model
- **C2901/K9-APP**: Application performance model
- **C2901/K9-AX**: Advanced security model
- **C2901-V/K9**: Voice-enabled model
- **C2901-V/K9-SEC**: Voice-enabled with enhanced security

### Cisco 2911 Models
- **C2911/K9**: Standard security model
- **C2911/K9-SEC**: Enhanced security model
- **C2911/K9-APP**: Application performance model
- **C2911/K9-AX**: Advanced security model
- **C2911-V/K9**: Voice-enabled model
- **C2911-V/K9-SEC**: Voice-enabled with enhanced security

### Key Features by Model
- **K9**: Basic security features
- **SEC**: Enhanced security with additional licenses
- **APP**: Application visibility and control
- **AX**: Advanced security with threat defense
- **V**: Voice over IP capabilities with DSP modules

### Licensing Options
- **IP Base**: Basic routing and switching
- **Security**: Advanced security features
- **UC**: Unified Communications support
- **Data**: Advanced data services
- **App**: Application performance

## Hardware Capabilities

### Cisco 2901 Specifications
- **CPU**: 800MHz multi-core processor
- **DRAM**: 256MB-512MB (upgradeable to 2GB)
- **Flash Memory**: 256MB-512MB (upgradeable)
- **Packet Forwarding**: Up to 150,000 pps
- **Throughput**: Up to 300 Mbps with encryption, 500 Mbps without

### Cisco 2911 Specifications
- **CPU**: 1.2GHz multi-core processor
- **DRAM**: 512MB-1GB (upgradeable to 2.5GB)
- **Flash Memory**: 512MB-1GB (upgradeable)
- **Packet Forwarding**: Up to 250,000 pps
- **Throughput**: Up to 500 Mbps with encryption, 800 Mbps without

### Physical Interfaces

#### Cisco 2901
- **Gigabit Ethernet Ports**: 2 integrated 10/100/1000 Mbps ports
- **EHWIC Slots**: 2 slots for Enhanced High-Speed WAN Interface Cards
- **SM Slots**: 1 slot for Service Modules
- **PVDM Slots**: 2 slots for Packet Voice DSP Modules
- **Console Port**: RJ-45 and USB console
- **Management Port**: Dedicated management Ethernet port
- **USB Ports**: 2 USB 2.0 ports

#### Cisco 2911
- **Gigabit Ethernet Ports**: 3 integrated 10/100/1000 Mbps ports
- **EHWIC Slots**: 3 slots for Enhanced High-Speed WAN Interface Cards
- **SM Slots**: 2 slots for Service Modules
- **PVDM Slots**: 3 slots for Packet Voice DSP Modules
- **Console Port**: RJ-45 and USB console
- **Management Port**: Dedicated management Ethernet port
- **USB Ports**: 2 USB 2.0 ports

### Module Support
- **EHWIC-1GE-SFP**: Gigabit Ethernet SFP module
- **EHWIC-4ESG**: 4-port Gigabit Ethernet switch module
- **EHWIC-4SHDSL-E**: 4-port SHDSL module
- **EHWIC-3G-HSPA**: 3G cellular WAN module
- **SM-X-4G**: 4-port Gigabit Ethernet service module
- **PVDM3-32/64/128**: Voice DSP modules

### Power and Environmental
- **2901 Power**: 30-50W typical
- **2911 Power**: 40-80W typical
- **Operating Temperature**: 0°C to 40°C
- **Operating Humidity**: 10% to 85% (non-condensing)
- **Form Factor**: 1U rack-mountable or desktop

## Use Cases

### 1. Small to Medium Branch Office Router
- **Primary Role**: Connect branch office to central site
- **Typical Deployment**: 50-200 users per location
- **Key Benefits**: High performance, advanced features, scalable

### 2. Enterprise Edge Router
- **Primary Role**: Internet edge and WAN aggregation
- **Typical Deployment**: Corporate headquarters or data center edge
- **Key Benefits**: High throughput, advanced security, multiple WAN connections

### 3. SD-WAN Edge
- **Primary Role**: Software-defined WAN edge device
- **Typical Deployment**: Cloud-connected branch offices
- **Key Benefits**: SD-WAN optimization, application visibility

### 4. Voice and Video Gateway
- **Primary Role**: Unified communications gateway
- **Typical Deployment**: VoIP, video conferencing, unified communications
- **Key Benefits**: Voice optimization, QoS, codec support

### 5. Security Appliance
- **Primary Role**: Network security and threat defense
- **Typical Deployment**: Perimeter security with advanced threat protection
- **Key Benefits**: Advanced security, firewall, intrusion prevention

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
 no passive-interface GigabitEthernet0/0

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
 no passive-interface GigabitEthernet0/0
 eigrp router-id 1.1.1.1

# Configure EIGRP authentication
interface GigabitEthernet0/0
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
 no passive-interface GigabitEthernet0/0

# Configure OSPF authentication
interface GigabitEthernet0/0
 ip ospf authentication message-digest
 ip ospf message-digest-key 1 md5 cisco123

# Configure OSPF cost
interface GigabitEthernet0/0
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

#### IS-IS (Intermediate System to Intermediate System)
```bash
# Enable IS-IS
router isis
 net 49.0001.0000.0000.0001.00

# Configure IS-IS on interfaces
interface GigabitEthernet0/0
 ip router isis
 isis metric 10

# Verify IS-IS
show isis database
show isis neighbors
show isis topology
debug isis adj packets
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
interface GigabitEthernet0/0
 ip policy route-map PBR

# Verify PBR
show route-map
show ip policy
show ip interface GigabitEthernet0/0
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

### SD-WAN Features

#### vEdge Configuration (SD-WAN)
```bash
# Configure SD-WAN
sdwan
 interface GigabitEthernet0/0
  tunnel-interface
   encapsulation ipsec
   color gold
   carrier default

# Configure VPN
vpn 0
 interface GigabitEthernet0/1
  ip address 203.0.113.10 255.255.255.252
  tunnel-interface
   encapsulation ipsec
   color blue
   carrier default

# Verify SD-WAN
show sdwan control connections
show sdwan bfd sessions
show sdwan tunnel statistics
```

## Switching Capabilities

### Enhanced Switching Features
- **Layer 2 Switching**: Advanced switching with EHWIC modules
- **VLAN Support**: Full VLAN support with switch modules
- **Bridge Groups**: Software bridging between interfaces
- **Switch Virtual Interfaces (SVI)**: Layer 3 interfaces for VLANs

### EHWIC-4ESG Configuration
```bash
# Configure switch module
interface GigabitEthernet0/0/0
 switchport mode access
 switchport access vlan 10
 spanning-tree portfast

interface GigabitEthernet0/0/1
 switchport mode trunk
 switchport trunk allowed vlan 10,20,30
 switchport trunk native vlan 99

# Create VLANs
vlan 10
 name SALES
 exit

vlan 20
 name MARKETING
 exit

vlan 99
 name NATIVE
 exit

# Create SVI for VLAN routing
interface Vlan10
 ip address 192.168.10.1 255.255.255.0
 no shutdown

# Verify switching
show vlan brief
show interfaces switchport
show spanning-tree vlan 10
```

### Bridge Groups
```bash
# Create bridge group
interface GigabitEthernet0/0
 bridge-group 1

interface GigabitEthernet0/1
 bridge-group 1

# Configure bridge
bridge 1 route ip
bridge 1 priority 32768

# Verify bridge
show bridge
show bridge group
show bridge 1
```

### Port Security on Switch Module
```bash
# Configure port security on switch module
interface GigabitEthernet0/0/0
 switchport mode access
 switchport port-security
 switchport port-security maximum 2
 switchport port-security violation shutdown
 switchport port-security mac-address sticky

# Verify port security
show port-security interface GigabitEthernet0/0/0
show port-security
```

## Security Features

### Access Control Lists (ACLs)

#### Standard ACLs
```bash
# Create standard ACL
access-list 1 permit 192.168.10.0 0.0.0.255
access-list 1 deny any

# Apply to interface
interface GigabitEthernet0/0
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
interface GigabitEthernet0/0
 ip access-group 101 in

# Verify extended ACL
show access-lists 101
show ip access-lists
show access-lists 101 | include 192.168.10
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
interface GigabitEthernet0/0
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

### Zone-Based Firewall
```bash
# Create security zones
zone security INSIDE
zone security OUTSIDE
zone security DMZ

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
interface GigabitEthernet0/0
 zone-member security INSIDE

interface GigabitEthernet0/1
 zone-member security OUTSIDE

# Verify firewall
show zone-pair security
show policy-map type inspect
show class-map type inspect
```

### Network Address Translation (NAT)

#### Static NAT
```bash
# Configure static NAT
ip nat inside source static 192.168.10.10 203.0.113.10
ip nat inside source static tcp 192.168.10.20 80 203.0.113.20 80

# Define inside and outside interfaces
interface GigabitEthernet0/0
 ip nat inside

interface GigabitEthernet0/1
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
ip nat inside source list 10 interface GigabitEthernet0/1 overload

# Configure PAT with overload
ip nat inside source list 10 pool PUBLIC_POOL overload

# Verify PAT
show ip nat translations
show ip nat statistics
```

#### NAT64
```bash
# Configure NAT64 for IPv6 to IPv4 translation
interface GigabitEthernet0/0
 ipv6 nat
 ipv6 address 2001:db8:1::1/64

# Create NAT64 prefix
ipv6 nat prefix 64:ff9b::/96

# Configure NAT64 translation
ipv6 nat v4v6 pool IPv4_POOL 203.0.113.100 203.0.113.200

# Verify NAT64
show ipv6 nat translations
show ipv6 nat statistics
```

### VPN and Tunnels

#### Site-to-Site VPN (IPsec)
```bash
# Create ISAKMP policy
crypto isakmp policy 10
 encr aes 256
 authentication pre-share
 group 14
 lifetime 86400

# Set pre-shared key
crypto isakmp key cisco@123 address 203.0.113.50

# Create IPsec transform set
crypto ipsec transform-set ESP-AES256 esp-aes 256 esp-sha256-hmac
 mode tunnel

# Create crypto map
crypto map VPN_MAP 10 ipsec-isakmp
 set peer 203.0.113.50
 set transform-set ESP-AES256
 match address 101
 set security-association lifetime seconds 3600

# Apply crypto map to interface
interface GigabitEthernet0/1
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

#### DMVPN (Dynamic Multipoint VPN)
```bash
# Create tunnel interface
interface Tunnel0
 ip address 10.255.255.1 255.255.255.0
 ip nhrp authentication DMVPN
 ip nhrp network-id 1
 ip nhrp holdtime 300
 ip nhrp map multicast dynamic
 tunnel source GigabitEthernet0/1
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
show dmvpn
```

#### FlexVPN
```bash
# Create FlexVPN profile
crypto ikev2 profile FLEX_PROFILE
 match identity remote address 203.0.113.0 255.255.255.0
 authentication remote pre-share
 authentication local pre-share
 key remote cisco@123
 key local cisco@123

# Create IPsec profile
crypto ipsec profile FLEX_IPSEC
 set ikev2 ipsec-proposal FLEX_PROPOSAL

# Create IPsec proposal
crypto ipsec ikev2 ipsec-proposal FLEX_PROPOSAL
 protocol esp
 encryption aes-cbc 256
 integrity sha256

# Apply to tunnel interface
interface Tunnel0
 tunnel protection ipsec profile FLEX_IPSEC
 tunnel source GigabitEthernet0/1
 tunnel destination 203.0.113.50

# Verify FlexVPN
show crypto ikev2 sa
show crypto ipsec sa
show crypto ikev2 profile
```

## Protocol Support

### Routing Protocols
- **Static Routing**: Manual route configuration
- **RIP v1/v2**: Distance vector routing protocol
- **EIGRP**: Cisco proprietary distance vector protocol
- **OSPFv2/v3**: Link state routing protocol (IPv4 and IPv6)
- **BGP**: Exterior gateway protocol
- **IS-IS**: Link state protocol
- **RIPng**: RIP for IPv6
- **EIGRP for IPv6**: EIGRP for IPv6 networks

### WAN Protocols
- **PPP**: Point-to-Point Protocol
- **HDLC**: High-Level Data Link Control
- **Frame Relay**: Packet-switched WAN technology
- **PPP over Ethernet (PPPoE)**: DSL connections
- **MLPPP**: Multilink PPP
- **ATM**: Asynchronous Transfer Mode

### Security Protocols
- **IPsec**: IP security protocol
- **SSL/TLS**: Secure socket layer
- **SSH**: Secure Shell
- **HTTPS**: HTTP over SSL/TLS
- **IKEv1/IKEv2**: Internet Key Exchange
- **DMVPN**: Dynamic Multipoint VPN
- **FlexVPN**: Flexible VPN implementation

### Voice Protocols
- **SIP**: Session Initiation Protocol
- **H.323**: Video conferencing protocol
- **MGCP**: Media Gateway Control Protocol
- **SCCP**: Skinny Call Control Protocol
- **RTP**: Real-time Transport Protocol

### Application Protocols
- **QoS**: Quality of Service
- **NetFlow**: Network traffic analysis
- **SNMP**: Simple Network Management Protocol
- **Syslog**: System logging
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
hostname Router2901

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
interface GigabitEthernet0/0
 description "LAN Interface"
 ip address 192.168.10.1 255.255.255.0
 ip nat inside
 no shutdown

# Configure WAN interface
interface GigabitEthernet0/1
 description "WAN Interface"
 ip address 203.0.113.10 255.255.255.252
 ip nat outside
 no shutdown

# Verify interface configuration
show ip interface brief
show interfaces
show running-config interface GigabitEthernet0/0
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
show platform

# Show software version
show version | include IOS
show version | include uptime
```

#### Interface Monitoring
```bash
# Show interface statistics
show interfaces
show interfaces counters
show interfaces GigabitEthernet0/0

# Show interface errors
show interfaces errors
show interfaces GigabitEthernet0/0 errors

# Show interface utilization
show interfaces GigabitEthernet0/0 accounting
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
debug spanning-tree events

# Debug wireless
debug dot11 events
debug capwap events

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
show running-config interface GigabitEthernet0/0

# Check for physical layer issues
show controllers GigabitEthernet0/0

# Enable interface if shutdown
interface GigabitEthernet0/0
no shutdown

# Check cable connectivity
show interface GigabitEthernet0/0
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
interface GigabitEthernet0/0
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
show interfaces GigabitEthernet0/0 accounting
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
show interfaces GigabitEthernet0/0 stats

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

This guide provides comprehensive information for configuring, managing, and troubleshooting Cisco 2901 and 2911 routers, covering all essential topics for CCNA students and network administrators working with modern ISR G2 routing solutions.
