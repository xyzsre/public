SW1-config.md

SW1#show run
Building configuration...

Current configuration : 1617 bytes
!
version 15.0
no service timestamps log datetime msec
no service timestamps debug datetime msec
service password-encryption
!
hostname SW1
!
enable secret 5 $1$mERr$NJdjwh5wX8Ia/X8aC4RIu.
!
!
!
!
!
!
spanning-tree mode pvst
spanning-tree extend system-id
!
interface FastEthernet0/1
 no cdp enable
!
interface FastEthernet0/2
 no cdp enable
!
interface FastEthernet0/3
 description PC
 switchport access vlan 2
 switchport mode access
 no cdp enable
!
interface FastEthernet0/4
 description PC
 switchport access vlan 2
 switchport mode access
 no cdp enable
!
interface FastEthernet0/5
 description PC
 switchport access vlan 3
 switchport mode access
 no cdp enable
!
interface FastEthernet0/6
 description PC
 switchport access vlan 3
 switchport mode access
 no cdp enable
!
interface FastEthernet0/7
 description UPLInK
 switchport mode trunk
!
interface FastEthernet0/8
!
interface FastEthernet0/9
!
interface FastEthernet0/10
!
interface FastEthernet0/11
!
interface FastEthernet0/12
!
interface FastEthernet0/13
!
interface FastEthernet0/14
!
interface FastEthernet0/15
!
interface FastEthernet0/16
!
interface FastEthernet0/17
!
interface FastEthernet0/18
!
interface FastEthernet0/19
!
interface FastEthernet0/20
!
interface FastEthernet0/21
!
interface FastEthernet0/22
!
interface FastEthernet0/23
!
interface FastEthernet0/24
!
interface GigabitEthernet0/1
!
interface GigabitEthernet0/2
!
interface Vlan1
 ip address 192.168.1.200 255.255.255.0
!
!
!
!
line con 0
 password 7 0802657D2A36
 login
!
line vty 0 4
 password 7 0802657D2A36
 login
line vty 5 15
 password 7 0802657D2A36
 login
!
!
!
!
end


SW1#

