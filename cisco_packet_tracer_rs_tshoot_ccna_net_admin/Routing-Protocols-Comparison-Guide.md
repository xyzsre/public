# Routing Protocols Comparison Guide

## Table of Contents
- [Overview](#overview)
- [Static vs Dynamic Routing](#static-vs-dynamic-routing)
- [Routing Protocol Categories](#routing-protocol-categories)
- [Distance Vector Protocols](#distance-vector-protocols)
- [Link State Protocols](#link-state-protocols)
- [Path Vector Protocols](#path-vector-protocols)
- [Protocol Comparison Matrix](#protocol-comparison-matrix)
- [Configuration Examples](#configuration-examples)
- [Route Redistribution](#route-redistribution)
- [Troubleshooting Guide](#troubleshooting-guide)
- [Design Considerations](#design-considerations)

## Overview

Routing protocols are essential for network communication, determining how data packets travel across networks. This guide provides a comprehensive comparison of routing protocols, their characteristics, configuration examples, and troubleshooting procedures for Cisco devices.

## Static vs Dynamic Routing

### Static Routing
**Definition**: Manually configured routes that do not change unless modified by network administrator.

**Advantages**:
- Predictable behavior
- No routing protocol overhead
- Secure (no routing updates)
- Simple to configure in small networks
- Fast lookup and processing

**Disadvantages**:
- Manual configuration required
- No automatic failover
- Not scalable for large networks
- Cannot adapt to topology changes
- High administrative overhead

**Use Cases**:
- Small networks with simple topology
- Stub networks
- Default routes
- Backup routes
- Point-to-point connections

**Configuration Example**:
```bash
# Static route configuration
ip route 192.168.2.0 255.255.255.0 10.1.1.1
ip route 0.0.0.0 0.0.0.0 10.1.1.254
```

### Dynamic Routing
**Definition**: Routes learned automatically through routing protocol exchanges between routers.

**Advantages**:
- Automatic route discovery
- Automatic failover and convergence
- Scalable to large networks
- Adapts to topology changes
- Lower administrative overhead

**Disadvantages**:
- Routing protocol overhead
- Complex configuration
- Security considerations
- Slower initial convergence
- Resource utilization

**Use Cases**:
- Large enterprise networks
- Networks with redundant paths
- Dynamic environments
- Multi-vendor environments

## Routing Protocol Categories

### Distance Vector Protocols
- **Characteristics**: Make decisions based on distance (hop count) and direction (vector)
- **Operation**: Periodic updates of entire routing table
- **Convergence**: Slow, prone to routing loops
- **Memory Usage**: Low
- **CPU Usage**: Low to moderate

### Link State Protocols
- **Characteristics**: Maintain complete network topology database
- **Operation**: Triggered updates with changes only
- **Convergence**: Fast, loop-free
- **Memory Usage**: High
- **CPU Usage**: High

### Path Vector Protocols
- **Characteristics**: Track path attributes to destination
- **Operation**: Policy-based routing decisions
- **Convergence**: Variable, policy-dependent
- **Memory Usage**: Very high
- **CPU Usage**: Very high

## Distance Vector Protocols

### RIP (Routing Information Protocol)
**Type**: Distance Vector (Interior Gateway Protocol)
**Algorithm**: Bellman-Ford
**Metric**: Hop count (maximum 15 hops)
**Administrative Distance**: 120

**Characteristics**:
- Simple to configure
- Classful (RIP v1) / Classless (RIP v2)
- Maximum 15 hops (16 = unreachable)
- Broadcast updates (v1) / Multicast updates (v2)
- Periodic updates every 30 seconds
- Load balancing across equal-cost paths (max 4)

**Configuration Example**:
```bash
# RIP v2 Configuration
router rip
 version 2
 network 10.0.0.0
 network 192.168.1.0
 no auto-summary
 passive-interface default
 no passive-interface GigabitEthernet0/0

# Verification Commands
show ip protocols
show ip route rip
show ip rip database
debug ip rip
```

**Troubleshooting**:
```bash
# Check RIP neighbors
show ip protocols | include rip

# Check RIP database
show ip rip database

# Debug RIP updates
debug ip rip events
debug ip rip packets

# Common Issues:
# - Version mismatch between routers
# - Network statements missing
# - Passive interface blocking updates
# - Split horizon preventing updates
```

### IGRP (Interior Gateway Routing Protocol)
**Type**: Distance Vector (Interior Gateway Protocol) - **DEPRECATED**
**Algorithm**: Distance Vector with composite metric
**Metric**: Bandwidth, delay, reliability, load, MTU
**Administrative Distance**: 100

**Characteristics**:
- Cisco proprietary (deprecated)
- Classful routing protocol
- Maximum 255 hops
- Composite metric calculation
- Periodic updates every 90 seconds
- Load balancing across unequal-cost paths

**Note**: IGRP is deprecated and replaced by EIGRP.

### EIGRP (Enhanced Interior Gateway Routing Protocol)
**Type**: Advanced Distance Vector (Interior Gateway Protocol)
**Algorithm**: DUAL (Diffusing Update Algorithm)
**Metric**: Bandwidth, delay, reliability, load, MTU
**Administrative Distance**: 90 (internal), 170 (external)

**Characteristics**:
- Cisco proprietary
- Classless routing protocol
- Fast convergence
- Supports VLSM and CIDR
- Bounded updates (only changes)
- Feasible successor for backup routes
- Load balancing across unequal-cost paths

**Configuration Example**:
```bash
# Basic EIGRP Configuration
router eigrp 100
 network 10.0.0.0
 network 192.168.1.0
 eigrp router-id 1.1.1.1
 passive-interface default
 no passive-interface GigabitEthernet0/0

# EIGRP Authentication
interface GigabitEthernet0/0
 ip authentication mode eigrp 100 md5
 ip authentication key-chain EIGRP_KEY

key chain EIGRP_KEY
 key 1
  key-string cisco123

# EIGRP Manual Summarization
interface GigabitEthernet0/0
 ip summary-address eigrp 100 10.0.0.0 255.255.0.0

# Verification Commands
show ip eigrp neighbors
show ip eigrp topology
show ip eigrp interfaces
show ip eigrp traffic
debug eigrp packets
debug eigrp neighbors
```

**Troubleshooting**:
```bash
# Check EIGRP neighbors
show ip eigrp neighbors

# Check EIGRP topology
show ip eigrp topology

# Check EIGRP interfaces
show ip eigrp interfaces

# Debug EIGRP
debug eigrp packets
debug eigrp neighbors

# Common Issues:
# - AS number mismatch
# - K-value mismatch
# - Passive interface blocking updates
# - Authentication failures
# - Stuck in active routes
```

## Link State Protocols

### OSPF (Open Shortest Path First)
**Type**: Link State (Interior Gateway Protocol)
**Algorithm**: Dijkstra's Shortest Path First (SPF)
**Metric**: Cost (based on bandwidth)
**Administrative Distance**: 110

**Characteristics**:
- Open standard
- Classless routing protocol
- Hierarchical design (areas)
- Fast convergence
- Supports VLSM and CIDR
- Triggered updates only
- Loop-free operation

**OSPF Areas**:
- **Area 0 (Backbone)**: Central area, all other areas connect to it
- **Stub Area**: No external routes, default route only
- **Totally Stubby Area**: No external or inter-area routes
- **NSSA (Not-So-Stubby Area**: Can import external routes

**Configuration Example**:
```bash
# Basic OSPF Configuration
router ospf 1
 router-id 1.1.1.1
 network 10.0.0.0 0.0.0.255 area 0
 network 192.168.1.0 0.0.0.255 area 1
 passive-interface default
 no passive-interface GigabitEthernet0/0

# OSPF Authentication
interface GigabitEthernet0/0
 ip ospf authentication message-digest
 ip ospf message-digest-key 1 md5 cisco123

# OSPF Cost Configuration
interface GigabitEthernet0/0
 ip ospf cost 10

# OSPF Stub Area
router ospf 1
 area 1 stub
 area 1 stub no-summary

# OSPF NSSA
router ospf 1
 area 1 nssa
 area 1 nssa no-redistribution

# OSPF Summarization
interface GigabitEthernet0/0
 ip ospf cost 10

router ospf 1
 area 1 range 10.1.0.0 255.255.0.0

# Verification Commands
show ip ospf neighbor
show ip ospf database
show ip ospf interface
show ip ospf interface brief
show ip ospf route
debug ospf events
debug ospf adj
debug ospf lsa
```

**Troubleshooting**:
```bash
# Check OSPF neighbors
show ip ospf neighbor

# Check OSPF database
show ip ospf database

# Check OSPF interfaces
show ip ospf interface brief

# Debug OSPF
debug ospf events
debug ospf adj
debug ospf lsa

# Common Issues:
# - Area ID mismatch
# - Hello/dead timer mismatch
# - Subnet mask mismatch
# - Authentication failures
# - Network statement issues
```

### IS-IS (Intermediate System to Intermediate System)
**Type**: Link State (Interior Gateway Protocol)
**Algorithm**: Dijkstra's Shortest Path First (SPF)
**Metric**: Cost (configurable)
**Administrative Distance**: 115

**Characteristics**:
- ISO standard (originally for CLNP)
- Classless routing protocol
- Hierarchical design (areas)
- Fast convergence
- Supports both IP and CLNP
- Scalable to large networks
- Less common in IP networks

**Configuration Example**:
```bash
# Basic IS-IS Configuration
router isis
 net 49.0001.0000.0000.0001.00

interface GigabitEthernet0/0
 ip router isis
 isis metric 10

# IS-IS Authentication
interface GigabitEthernet0/0
 isis authentication mode md5
 isis authentication key-chain ISIS_KEY

key chain ISIS_KEY
 key 1
  key-string cisco123

# Verification Commands
show isis database
show isis neighbors
show isis topology
show isis interface
debug isis adj packets
debug isis lsp-generation
```

**Troubleshooting**:
```bash
# Check IS-IS neighbors
show isis neighbors

# Check IS-IS database
show isis database

# Debug IS-IS
debug isis adj packets
debug isis lsp-generation

# Common Issues:
# - System ID mismatch
# - Area address mismatch
# - Authentication failures
# - Interface level mismatch
```

## Path Vector Protocols

### BGP (Border Gateway Protocol)
**Type**: Path Vector (Exterior Gateway Protocol)
**Algorithm**: Path Vector algorithm
**Metric**: Path attributes (AS_PATH, MED, LOCAL_PREF, etc.)
**Administrative Distance**: 20 (external), 200 (internal)

**Characteristics**:
- Internet backbone protocol
- Policy-based routing
- Loop prevention using AS_PATH
- Incremental updates
- Supports CIDR and VLSM
- Highly configurable
- Slow convergence

**BGP Attributes**:
- **Well-Known Mandatory**: AS_PATH, NEXT_HOP, ORIGIN
- **Well-Known Discretionary**: LOCAL_PREF, ATOMIC_AGGREGATE
- **Optional Transitive**: MED, COMMUNITIES
- **Optional Non-Transitive**: CLUSTER_LIST, ORIGINATOR_ID

**Configuration Example**:
```bash
# Basic BGP Configuration
router bgp 65001
 neighbor 10.1.1.2 remote-as 65002
 neighbor 10.1.1.2 description "ISP Peer"
 neighbor 192.168.1.1 remote-as 65001
 neighbor 192.168.1.1 description "Internal Peer"
 network 10.0.0.0 mask 255.255.255.0
 network 192.168.1.0 mask 255.255.255.0

# BGP Authentication
neighbor 10.1.1.2 password cisco123

# BGP Route Filtering
neighbor 10.1.1.2 route-filter IN in
neighbor 10.1.1.2 route-filter OUT out

# BGP Prefix List
ip prefix-list BGP_IN seq 5 permit 10.0.0.0/8 le 24
neighbor 10.1.1.2 prefix-list BGP_IN in

# BGP AS_PATH Filtering
ip as-path access-list 1 permit ^65001$
neighbor 10.1.1.2 filter-list 1 in

# BGP MED Configuration
router bgp 65001
 default-metric 100
 neighbor 10.1.1.2 route-map SET_MED out

route-map SET_MED permit 10
 set metric 50

# BGP Local Preference
router bgp 65001
 bgp default local-preference 200
 neighbor 192.168.1.1 route-map SET_LOCAL_PREF in

route-map SET_LOCAL_PREF permit 10
 set local-preference 300

# BGP Communities
router bgp 65001
 neighbor 10.1.1.2 send-community
 neighbor 10.1.1.2 route-map SET_COMMUNITY out

route-map SET_COMMUNITY permit 10
 set community 65001:100

# Verification Commands
show ip bgp summary
show ip bgp neighbors
show ip bgp
show ip bgp routes
show ip bgp regexp
debug bgp events
debug bgp updates
```

**Troubleshooting**:
```bash
# Check BGP neighbors
show ip bgp summary

# Check BGP routes
show ip bgp

# Check BGP updates
debug bgp events
debug bgp updates

# Common Issues:
# - AS number mismatch
# - BGP version mismatch
# - Neighbor not reachable
# - Authentication failures
# - Route filtering issues
```

## Protocol Comparison Matrix

| Feature | Static | RIP | IGRP | EIGRP | OSPF | IS-IS | BGP |
|---------|--------|-----|------|-------|------|-------|-----|
| **Type** | Manual | Distance Vector | Distance Vector | Advanced Distance Vector | Link State | Link State | Path Vector |
| **Admin Distance** | 1/0 | 120 | 100 | 90/170 | 110 | 115 | 20/200 |
| **Metric** | Admin | Hop Count | Composite | Composite | Cost | Cost | Path Attributes |
| **Convergence** | N/A | Slow | Slow | Fast | Fast | Fast | Slow |
| **Scalability** | Poor | Poor | Poor | Good | Excellent | Excellent | Excellent |
| **Memory Usage** | Minimal | Low | Low | Medium | High | High | Very High |
| **CPU Usage** | Minimal | Low | Low | Medium | High | High | Very High |
| **VLSM Support** | N/A | v2 only | No | Yes | Yes | Yes | Yes |
| **Classless** | N/A | v2 only | No | Yes | Yes | Yes | Yes |
| **Hierarchical** | N/A | No | No | No | Yes | Yes | Yes |
| **Loop Prevention** | N/A | Split Horizon | Split Horizon | DUAL | SPF | SPF | AS_PATH |
| **Load Balancing** | Yes | Equal Cost | Unequal Cost | Unequal Cost | Equal Cost | Equal Cost | Policy-based |
| **Authentication** | N/A | v2 only | No | Yes | Yes | Yes | Yes |
| **Standard** | N/A | Yes | No | No | Yes | Yes | Yes |

## Configuration Examples

### Basic Router Setup
```bash
# Enable IP routing
ip routing

# Configure interfaces
interface GigabitEthernet0/0
 ip address 192.168.1.1 255.255.255.0
 no shutdown

interface GigabitEthernet0/1
 ip address 10.1.1.1 255.255.255.252
 no shutdown
```

### Static Routing Configuration
```bash
# Static routes
ip route 192.168.2.0 255.255.255.0 10.1.1.2
ip route 192.168.3.0 255.255.255.0 10.1.1.2
ip route 0.0.0.0 0.0.0.0 10.1.1.2

# Floating static route
ip route 192.168.4.0 255.255.255.0 10.1.1.3 100

# Verify static routes
show ip route static
show running-config | include ip route
```

### RIP Configuration
```bash
# RIP v2 configuration
router rip
 version 2
 network 192.168.1.0
 network 10.0.0.0
 no auto-summary
 passive-interface default
 no passive-interface GigabitEthernet0/1

# Verify RIP
show ip protocols
show ip route rip
show ip rip database
debug ip rip
```

### EIGRP Configuration
```bash
# EIGRP configuration
router eigrp 100
 network 192.168.1.0
 network 10.0.0.0
 eigrp router-id 1.1.1.1
 passive-interface default
 no passive-interface GigabitEthernet0/1

# EIGRP authentication
interface GigabitEthernet0/1
 ip authentication mode eigrp 100 md5
 ip authentication key-chain EIGRP_KEY

key chain EIGRP_KEY
 key 1
  key-string cisco123

# Verify EIGRP
show ip eigrp neighbors
show ip eigrp topology
show ip eigrp interfaces
debug eigrp packets
```

### OSPF Configuration
```bash
# OSPF configuration
router ospf 1
 router-id 1.1.1.1
 network 192.168.1.0 0.0.0.255 area 0
 network 10.0.0.0 0.0.0.255 area 0
 passive-interface default
 no passive-interface GigabitEthernet0/1

# OSPF authentication
interface GigabitEthernet0/1
 ip ospf authentication message-digest
 ip ospf message-digest-key 1 md5 cisco123

# Verify OSPF
show ip ospf neighbor
show ip ospf database
show ip ospf interface
debug ospf events
```

### BGP Configuration
```bash
# BGP configuration
router bgp 65001
 neighbor 10.1.1.2 remote-as 65002
 neighbor 10.1.1.2 description "ISP Peer"
 network 192.168.1.0 mask 255.255.255.0

# BGP authentication
neighbor 10.1.1.2 password cisco123

# Verify BGP
show ip bgp summary
show ip bgp neighbors
show ip bgp
debug bgp events
```

## Route Redistribution

### Redistribution Concepts
**Purpose**: Exchange routes between different routing protocols
**Considerations**: Metric translation, administrative distance, routing loops

### Redistribution Methods
1. **One-way redistribution**: Routes from one protocol to another
2. **Two-way redistribution**: Mutual exchange between protocols
3. **Multi-point redistribution**: Multiple protocols exchanging routes

### Redistribution Examples

#### RIP to OSPF Redistribution
```bash
# RIP to OSPF redistribution
router ospf 1
 redistribute rip metric 20 subnets
 distribute-list prefix OSPF_FROM_RIP in

# OSPF to RIP redistribution
router rip
 version 2
 redistribute ospf metric 5
 distribute-list prefix RIP_FROM_OSPF out

# Prefix lists for filtering
ip prefix-list OSPF_FROM_RIP seq 5 permit 192.168.0.0/16 le 24
ip prefix-list RIP_FROM_OSPF seq 5 permit 10.0.0.0/8 le 24
```

#### EIGRP to OSPF Redistribution
```bash
# EIGRP to OSPF redistribution
router ospf 1
 redistribute eigrp 100 metric 20 subnets
 redistribute connected metric 10
 redistribute static metric 20

# OSPF to EIGRP redistribution
router eigrp 100
 redistribute ospf 1 metric 10000 100 255 1 1500
 redistribute connected
 redistribute static
```

#### BGP to IGP Redistribution
```bash
# BGP to OSPF redistribution
router ospf 1
 redistribute bgp 65001 metric 20 subnets

# BGP to EIGRP redistribution
router eigrp 100
 redistribute bgp 65001 metric 10000 100 255 1 1500

# IGP to BGP redistribution
router bgp 65001
 redistribute ospf 1 metric 10
 redistribute eigrp 100 metric 10
```

### Redistribution with Route Maps
```bash
# Route map for redistribution
route-map REDIST_EIGRP_TO_OSPF permit 10
 match ip address prefix-list EIGRP_ROUTES
 set metric 20
 set route-tag 100

# Apply route map
router ospf 1
 redistribute eigrp 100 route-map REDIST_EIGRP_TO_OSPF

# Prefix list
ip prefix-list EIGRP_ROUTES seq 5 permit 192.168.0.0/16 le 24
```

### Redistribution Best Practices
1. **Use route maps** for filtering and metric control
2. **Apply distribute lists** to prevent routing loops
3. **Set appropriate metrics** for target protocol
4. **Use route tagging** to identify redistributed routes
5. **Monitor routing tables** for unexpected routes
6. **Test in lab environment** before production deployment

## Troubleshooting Guide

### General Troubleshooting Steps
1. **Verify basic connectivity**
2. **Check routing protocol configuration**
3. **Verify neighbor relationships**
4. **Check routing table**
5. **Verify route advertisement**
6. **Check for filtering**
7. **Debug specific issues**

### Static Routing Troubleshooting
```bash
# Check static routes
show ip route static
show running-config | include ip route

# Test connectivity
ping 192.168.2.1
traceroute 192.168.2.1

# Common Issues:
# - Incorrect next-hop IP
# - Interface down
# - Typographical errors
# - Missing default route
```

### RIP Troubleshooting
```bash
# Check RIP configuration
show ip protocols | include rip
show running-config | section router rip

# Check RIP neighbors
show ip protocols
show ip rip database

# Debug RIP
debug ip rip events
debug ip rip packets

# Common Issues:
# - Version mismatch
# - Network statement issues
# - Passive interface problems
# - Split horizon blocking
```

### EIGRP Troubleshooting
```bash
# Check EIGRP neighbors
show ip eigrp neighbors
show ip eigrp topology

# Check EIGRP interfaces
show ip eigrp interfaces
show ip eigrp traffic

# Debug EIGRP
debug eigrp packets
debug eigrp neighbors

# Common Issues:
# - AS number mismatch
# - K-value mismatch
# - Authentication failures
# - Stuck in active routes
```

### OSPF Troubleshooting
```bash
# Check OSPF neighbors
show ip ospf neighbor
show ip ospf interface

# Check OSPF database
show ip ospf database
show ip ospf route

# Debug OSPF
debug ospf events
debug ospf adj
debug ospf lsa

# Common Issues:
# - Area ID mismatch
# - Hello/dead timer mismatch
# - Subnet mask mismatch
# - Authentication failures
```

### BGP Troubleshooting
```bash
# Check BGP neighbors
show ip bgp summary
show ip bgp neighbors

# Check BGP routes
show ip bgp
show ip bgp regexp

# Debug BGP
debug bgp events
debug bgp updates

# Common Issues:
# - AS number mismatch
# - Neighbor not reachable
# - Authentication failures
# - Route filtering issues
```

### Redistribution Troubleshooting
```bash
# Check redistribution
show running-config | include redistribute
show ip protocols

# Check route maps
show route-map
show running-config | section route-map

# Check prefix lists
show ip prefix-list
show running-config | section ip prefix-list

# Common Issues:
# - Metric translation issues
# - Route filtering problems
# - Routing loops
# - Missing route tags
```

### Common Troubleshooting Commands
```bash
# General verification
show ip route
show ip interface brief
show ip protocols
show running-config

# Neighbor verification
show ip eigrp neighbors
show ip ospf neighbor
show ip bgp neighbors

# Database verification
show ip eigrp topology
show ip ospf database
show ip bgp

# Debug commands
debug ip routing
debug ip packet
debug ip protocols
```

## Design Considerations

### Protocol Selection Criteria
1. **Network Size**: Small vs Large networks
2. **Scalability Requirements**: Future growth considerations
3. **Performance Needs**: Convergence time requirements
4. **Vendor Requirements**: Multi-vendor environment
5. **Administrative Overhead**: Management complexity
6. **Security Requirements**: Authentication and encryption needs

### Network Design Best Practices
1. **Hierarchical Design**: Core, Distribution, Access layers
2. **Protocol Selection**: Appropriate protocols for each layer
3. **Redundancy**: Multiple paths for reliability
4. **Summarization**: Reduce routing table size
5. **Filtering**: Control route advertisement
6. **Security**: Authentication and encryption

### Performance Considerations
1. **Convergence Time**: How fast network adapts to changes
2. **Memory Usage**: Routing table and protocol overhead
3. **CPU Usage**: Protocol processing requirements
4. **Bandwidth Usage**: Routing update overhead
5. **Scalability**: Maximum network size supported

### Security Considerations
1. **Authentication**: Prevent unauthorized routing updates
2. **Encryption**: Protect routing information
3. **Filtering**: Control route advertisement
4. **Route Validation**: Verify route authenticity
5. **Access Control**: Limit management access

### Migration Strategies
1. **Phased Migration**: Gradual protocol transition
2. **Dual Stack**: Run multiple protocols simultaneously
3. **Redistribution**: Bridge between protocols
4. **Testing**: Validate in lab environment
5. **Rollback Plan**: Prepare for migration failures

---

This guide provides comprehensive information for understanding, configuring, and troubleshooting routing protocols in Cisco networks, serving as a complete reference for network engineers and CCNA/CCNP students.
