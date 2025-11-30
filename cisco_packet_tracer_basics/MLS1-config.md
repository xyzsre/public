MLS1-config.md

MLS1#show run
Building configuration...

Current configuration : 1482 bytes
!
version 12.2(37)SE1
no service timestamps log datetime msec
no service timestamps debug datetime msec
no service password-encryption
!
hostname MLS1
!
!
enable secret 5 $1$mERr$NJdjwh5wX8Ia/X8aC4RIu.
!
!
!
!
!
ip routing
!
!
!
!
!
!
!
!
!
!
!
!
!
!
!
spanning-tree mode pvst
!
!
!
!
!
!
interface FastEthernet0/1
 description UPLINK
 switchport trunk encapsulation dot1q
 switchport mode trunk
!
interface FastEthernet0/2
!
interface FastEthernet0/3
!
interface FastEthernet0/4
!
interface FastEthernet0/5
!
interface FastEthernet0/6
!
interface FastEthernet0/7
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
 description DEP1
 ip address 192.168.1.254 255.255.255.0
!
interface Vlan2
 mac-address 0001.c738.9e01
 ip address 192.168.2.254 255.255.255.0
!
interface Vlan3
 mac-address 0001.c738.9e02
 ip address 192.168.3.254 255.255.255.0
!
ip classless
!
ip flow-export version 9
!
!
!
!
!
!
!
!
line con 0
!
line aux 0
!
line vty 0 4
 login
!
!
!
!
end


MLS1#  
MLS1#
