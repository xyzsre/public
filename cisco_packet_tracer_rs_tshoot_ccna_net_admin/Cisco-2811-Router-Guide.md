# Cisco 2811 Router - Comprehensive Guide

## Table of Contents
- [Overview](#overview)
- [2811 Series Models](#2811-series-models)
- [Hardware Capabilities](#hardware-capabilities)
- [Use Cases](#use-cases)
- [Routing Capabilities](#routing-capabilities)
- [Switching Capabilities](#switching-capabilities)
- [Security Features](#security-features)
- [Protocol Support](#protocol-support)
- [Command Reference](#command-reference)
- [Troubleshooting Guide](#troubleshooting-guide)

## Overview

The Cisco 2811 Integrated Services Router is a high-performance, modular router designed for medium to large branch offices and enterprise edge applications. It offers enhanced performance, more interface slots, and advanced features compared to the 1841 series, making it suitable for more demanding network environments and advanced CCNA/CCNP studies.

## 2811 Series Models

### Base Models
- **2811**: Base model with enhanced performance
- **2811/K9**: Base model with advanced security features
- **2811-V**: Voice-enabled model with DSP support
- **2811-V/K9**: Voice-enabled with advanced security
- **2811-SEC/K9**: Enhanced security model with additional features

### Key Features by Model
- **Base**: Enhanced routing and switching capabilities
- **K9**: Advanced security (VPN, firewall, intrusion prevention)
- **V**: Voice over IP capabilities with DSP modules
- **V/K9**: Combined voice and security features
- **SEC/K9**: Maximum security features including content filtering

### Hardware Variants
- **Memory Configurations**: 256MB-512MB DRAM, 64MB-128MB Flash
- **Interface Cards**: Enhanced WIC/HWIC support
- **Advanced Integration Modules (AIM)**: Hardware acceleration for specific tasks
- **PVDM (Packet Voice DSP Modules)**: Voice processing capabilities

## Hardware Capabilities

### Processing and Memory
- **CPU**: 350MHz PowerPC processor (enhanced from 1841)
- **DRAM**: 256MB-512MB (upgradeable to 1GB)
- **Flash Memory**: 64MB-128MB (upgradeable)
- **Packet Forwarding**: Up to 150,000 pps (vs 75,000 on 1841)
- **Throughput**: Up to 200 Mbps with encryption, 350 Mbps without

### Physical Interfaces
- **Fast Ethernet Ports**: 2 integrated 10/100/1000 Mbps ports (Gigabit support)
- **WIC Slots**: 4 slots for WAN Interface Cards (vs 2 on 1841)
- **HWIC Slots**: 4 slots for High-Speed WAN Interface Cards
- **AIM Slots**: 2 slots for Advanced Integration Modules (vs 1 on 1841)
- **PVDM Slots**: 3 slots for Voice DSP modules
- **Console Port**: RJ-45 serial management
- **Auxiliary Port**: RJ-45 for modem connections

### Enhanced Interface Card Support
- **WIC-1T/2T**: Serial interfaces
- **WIC-1ENET**: Ethernet interface
- **WIC-1B-S/T**: ISDN BRI interface
- **HWIC-1GE**: Gigabit Ethernet interface
- **HWIC-4ESW**: 4-port Ethernet switch module
- **HWIC-3G-CDMA**: 3G cellular WAN card
- **HWIC-AP**: Access Point module

### Power and Environmental
- **Power Consumption**: 40-80W typical (higher than 1841)
- **Operating Temperature**: 0°C to 40°C
- **Operating Humidity**: 10% to 85% (non-condensing)
- **Form Factor**: 1U rack-mountable or desktop
- **Power Supply Options**: AC, DC, PoE (with modules)

## Use Cases

### 1. Medium Branch Office Router
- **Primary Role**: Connect medium-sized branch office to central site
- **Typical Deployment**: 50-200 users per location
- **Key Benefits**: Higher performance, more interfaces, advanced features

### 2. Enterprise Edge Router
- **Primary Role**: Internet edge and WAN aggregation
- **Typical Deployment**: Corporate headquarters or data center edge
- **Key Benefits**: High throughput, advanced security, multiple WAN connections

### 3. Voice and Video Gateway
- **Primary Role**: VoIP and video conferencing gateway
- **Typical Deployment**: Unified communications deployment
- **Key Benefits**: DSP support, QoS capabilities, voice optimization

### 4. Security Appliance
- **Primary Role**: Network security and VPN concentration
- **Typical Deployment**: Perimeter security, remote access
- **Key Benefits**: Hardware encryption, firewall, intrusion prevention

### 5. WAN Aggregation
- **Primary Role**: Multiple WAN connection aggregation
- **Typical Deployment**: Multi-site connectivity, load balancing
- **Key Benefits**: Multiple interface slots, advanced routing, redundancy

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
 timers basic 30 90 180 270

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
 metric weights 0 1 1 1 1 1

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
 log-adjacency-changes

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

## Switching Capabilities

### Enhanced Switching Features
- **Layer 2 Switching**: Advanced switching with HWIC modules
- **VLAN Support**: Full VLAN support with switch modules
- **Bridge Groups**: Software bridging between interfaces
- **Switch Virtual Interfaces (SVI)**: Layer 3 interfaces for VLANs

### HWIC-4ESW Configuration
```bash
# Configure switch module
interface FastEthernet0/3/0
 switchport mode access
 switchport access vlan 10
 spanning-tree portfast

interface FastEthernet0/3/1
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
interface FastEthernet0/0
 bridge-group 1

interface FastEthernet0/1
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
interface FastEthernet0/3/0
 switchport mode access
 switchport port-security
 switchport port-security maximum 2
 switchport port-security violation shutdown
 switchport port-security mac-address sticky

# Verify port security
show port-security interface FastEthernet0/3/0
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

#### NAT with Route Maps
```bash
# Create route map for NAT
route-map NAT_MAP permit 10
 match ip address 101
 match interface GigabitEthernet0/1

# Apply route map to NAT
ip nat inside source route-map NAT_MAP interface GigabitEthernet0/1 overload

# Verify NAT with route maps
show ip nat translations
show route-map NAT_MAP
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

#### GRE Tunnel
```bash
# Create GRE tunnel
interface Tunnel0
 ip address 10.255.255.1 255.255.255.252
 tunnel source GigabitEthernet0/1
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
 ip nhrp holdtime  Fragments 300.
 ip n
``菜的
```
