# Packet Tracer Complete Lab Guide: Multi-VLAN Network with Inter-VLAN Routing

## Lab Overview

This lab demonstrates a complete network topology with PCs, 2960 switches, 3560 multilayer switch, and router, including VLANs, inter-VLAN routing, EtherChannel, and routing protocols.

## Lab Topology

```
                    [Router-R1]
                         |G0/1
                 10.1.1.0/30
                         |G0/1
                    [MLS-3560]
               G0/2 |        | G0/3
         EtherChannel|        |EtherChannel
            Fa0/23-24|        |Fa0/23-24
                [SW1-2960]   [SW2-2960]
               Fa0/1-2     Fa0/1-2
                VLAN10      VLAN20
               [PC1][PC2]  [PC3][PC4]
```

### Network Design
- **VLANs**: 10 (Sales), 20 (Marketing), 30 (IT), 99 (Management)
- **Subnets**: 
  - VLAN 10: 192.168.10.0/24, VLAN 20: 192.168.20.0/24
  - VLAN 30: 192.168.30.0/24, VLAN 99: 192.168.99.0/24
  - Router-MLS: 10.1.1.0/30

## Device Configuration

### SW1 (2960) Configuration
```cisco
enable
configure terminal
hostname SW1

# Basic security
enable secret cisco123
line console 0
password console123
login
exit

# Create VLANs
vlan 10
name Sales
exit
vlan 20
name Marketing
exit
vlan 99
name Management
exit

# Configure access ports for VLAN 10
interface range fastethernet 0/1-2
switchport mode access
switchport access vlan 10
switchport port-security
spanning-tree portfast
no shutdown
exit

# Configure EtherChannel to MLS
interface range fastethernet 0/23-24
channel-group 1 mode active
switchport mode trunk
switchport trunk allowed vlan 10,20,99
no shutdown
exit

interface port-channel 1
switchport mode trunk
switchport trunk allowed vlan 10,20,99
no shutdown
exit

# Management interface
interface vlan 99
ip address 192.168.99.11 255.255.255.0
no shutdown
exit

ip default-gateway 192.168.99.1
spanning-tree mode rapid-pvst

end
copy running-config startup-config
```

### SW2 (2960) Configuration
```cisco
enable
configure terminal
hostname SW2

enable secret cisco123
line console 0
password console123
login
exit

# Create VLANs
vlan 10
name Sales
exit
vlan 20
name Marketing
exit
vlan 99
name Management
exit

# Configure access ports for VLAN 20
interface range fastethernet 0/1-2
switchport mode access
switchport access vlan 20
switchport port-security
spanning-tree portfast
no shutdown
exit

# Configure EtherChannel to MLS
interface range fastethernet 0/23-24
channel-group 2 mode active
switchport mode trunk
switchport trunk allowed vlan 10,20,99
no shutdown
exit

interface port-channel 2
switchport mode trunk
switchport trunk allowed vlan 10,20,99
no shutdown
exit

# Management interface
interface vlan 99
ip address 192.168.99.12 255.255.255.0
no shutdown
exit

ip default-gateway 192.168.99.1
spanning-tree mode rapid-pvst

end
copy running-config startup-config
```

### MLS (3560) Configuration
```cisco
enable
configure terminal
hostname MLS

# Enable IP routing
ip routing

enable secret cisco123
line console 0
password console123
login
exit

# Create VLANs and SVIs
vlan 10
name Sales
exit
vlan 20
name Marketing
exit
vlan 99
name Management
exit

# Configure SVIs for inter-VLAN routing
interface vlan 10
ip address 192.168.10.1 255.255.255.0
no shutdown
exit

interface vlan 20
ip address 192.168.20.1 255.255.255.0
no shutdown
exit

interface vlan 99
ip address 192.168.99.1 255.255.255.0
no shutdown
exit

# Configure routed interface to Router
interface gigabitethernet 0/1
no switchport
ip address 10.1.1.2 255.255.255.252
no shutdown
exit

# Configure EtherChannel from SW1
interface range gigabitethernet 0/2-3
channel-group 1 mode passive
switchport mode trunk
switchport trunk allowed vlan 10,20,99
no shutdown
exit

interface port-channel 1
switchport mode trunk
switchport trunk allowed vlan 10,20,99
no shutdown
exit

# Configure EtherChannel from SW2
interface range gigabitethernet 0/4-5
channel-group 2 mode passive
switchport mode trunk
switchport trunk allowed vlan 10,20,99
no shutdown
exit

interface port-channel 2
switchport mode trunk
switchport trunk allowed vlan 10,20,99
no shutdown
exit

# Configure OSPF
router ospf 1
router-id 10.1.1.2
network 192.168.10.0 0.0.0.255 area 0
network 192.168.20.0 0.0.0.255 area 0
network 192.168.99.0 0.0.0.255 area 0
network 10.1.1.0 0.0.0.3 area 0
passive-interface vlan 10
passive-interface vlan 20
passive-interface vlan 99
exit

# Static backup route
ip route 0.0.0.0 0.0.0.0 10.1.1.1 110

# Spanning tree root
spanning-tree mode rapid-pvst
spanning-tree vlan 10,20,99 priority 4096

end
copy running-config startup-config
```

### Router (R1) Configuration
```cisco
enable
configure terminal
hostname R1

enable secret cisco123

# Configure interface to MLS
interface gigabitethernet 0/1
ip address 10.1.1.1 255.255.255.252
no shutdown
exit

# Configure loopback for testing
interface loopback 0
ip address 8.8.8.8 255.255.255.255
exit

# Configure OSPF
router ospf 1
router-id 10.1.1.1
network 10.1.1.0 0.0.0.3 area 0
network 8.8.8.8 0.0.0.0 area 0
exit

# Static routes for internal networks
ip route 192.168.10.0 255.255.255.0 10.1.1.2
ip route 192.168.20.0 255.255.255.0 10.1.1.2
ip route 192.168.99.0 255.255.255.0 10.1.1.2

end
copy running-config startup-config
```

### PC Configuration
```
PC1: IP: 192.168.10.10, Mask: 255.255.255.0, Gateway: 192.168.10.1
PC2: IP: 192.168.10.11, Mask: 255.255.255.0, Gateway: 192.168.10.1
PC3: IP: 192.168.20.10, Mask: 255.255.255.0, Gateway: 192.168.20.1
PC4: IP: 192.168.20.11, Mask: 255.255.255.0, Gateway: 192.168.20.1
```

## Testing and Verification

### Test 1: Intra-VLAN Communication
```bash
# From PC1 to PC2 (same VLAN)
ping 192.168.10.11
# Expected: Success - Layer 2 switching

# From PC3 to PC4 (same VLAN)
ping 192.168.20.11
# Expected: Success - Layer 2 switching
```

### Test 2: Inter-VLAN Communication
```bash
# From PC1 to PC3 (different VLANs)
ping 192.168.20.10
# Expected: Success - Inter-VLAN routing on MLS

# Traceroute to see path
tracert 192.168.20.10
# Expected path: 192.168.10.1 → 192.168.20.10
```

### Test 3: Routing to External Networks
```bash
# From PC1 to Router loopback
ping 8.8.8.8
# Expected: Success - End-to-end routing

# Traceroute to router
tracert 8.8.8.8
# Expected path: 192.168.10.1 → 10.1.1.1 → 8.8.8.8
```

## Verification Commands

### VLAN Verification
```cisco
# On all switches
show vlan brief
show interfaces trunk
show interfaces switchport
```

### EtherChannel Verification
```cisco
# On all switches
show etherchannel summary
show etherchannel 1 detail
show lacp neighbor
```

### Spanning Tree Verification
```cisco
# On all switches
show spanning-tree
show spanning-tree summary
show spanning-tree root
```

### Layer 3 Verification
```cisco
# On MLS
show ip interface brief
show ip route
show ip ospf neighbor

# On Router
show ip route
show ip ospf neighbor
```

## Troubleshooting Guide

### Problem 1: Intra-VLAN Communication Fails
```cisco
# Check VLAN assignment
show vlan brief
show interfaces fa0/1 switchport

# Check spanning tree
show spanning-tree vlan 10

# Check port security
show port-security interface fa0/1
```

### Problem 2: Inter-VLAN Communication Fails
```cisco
# Check SVI status
show ip interface brief
show interface vlan 10

# Check routing
show ip route
ping 192.168.10.10

# Check trunk configuration
show interfaces trunk
```

### Problem 3: EtherChannel Issues
```cisco
# Check EtherChannel status
show etherchannel summary

# Check LACP neighbors
show lacp neighbor

# Debug if needed
debug etherchannel events
```

### Problem 4: Routing Issues
```cisco
# Check OSPF neighbors
show ip ospf neighbor

# Check routing table
show ip route ospf

# Test connectivity to router
ping 10.1.1.1
```

## Port Configuration Summary

### Access Ports
- **SW1 Fa0/1-2**: VLAN 10 access ports with port security
- **SW2 Fa0/1-2**: VLAN 20 access ports with port security
- **Features**: Portfast, BPDU guard, port security

### Trunk Ports
- **SW1 Fa0/23-24**: EtherChannel trunk to MLS
- **SW2 Fa0/23-24**: EtherChannel trunk to MLS
- **Allowed VLANs**: 10, 20, 99

### Routed Ports
- **MLS G0/1**: Layer 3 connection to router
- **Router G0/1**: Layer 3 connection to MLS

## Rapid PVST+ Configuration

### Root Bridge Selection
```cisco
# MLS as root bridge
spanning-tree mode rapid-pvst
spanning-tree vlan 10,20,99 priority 4096

# Access switches with default priority (32768)
spanning-tree mode rapid-pvst
```

### Port Optimization
```cisco
# Access ports
spanning-tree portfast
spanning-tree bpduguard enable

# Expected result: Fast convergence, loop prevention
```

## Lab Validation Checklist

- [ ] All devices have IP connectivity
- [ ] Intra-VLAN communication works
- [ ] Inter-VLAN communication works
- [ ] EtherChannel is functional
- [ ] Spanning tree has proper root
- [ ] OSPF neighbors are established
- [ ] Routing table is complete
- [ ] Port security is working
- [ ] Management access is configured