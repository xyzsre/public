# IP, Route, and DNS Configuration Guide - Multi-Platform

## Table of Contents
- [Overview](#overview)
- [Windows IP Configuration](#windows-ip-configuration)
- [Windows Route Configuration](#windows-route-configuration)
- [Windows DNS Configuration](#windows-dns-configuration)
- [Linux IP Configuration](#linux-ip-configuration)
- [Linux Route Configuration](#linux-route-configuration)
- [Linux DNS Configuration](#linux-dns-configuration)
- [macOS IP Configuration](#macos-ip-configuration)
- [macOS Route Configuration](#macos-route-configuration)
- [macOS DNS Configuration](#macos-dns-configuration)
- [Verification Commands](#verification-commands)
- [Troubleshooting](#troubleshooting)

## Overview

This guide focuses specifically on IP configuration, routing, and DNS/name server setup for Windows, Linux distributions, and macOS operating systems. It covers both server and client configurations with practical examples for network administrators and system administrators.

## Windows IP Configuration

### Windows 7/10/11 Client Configuration

#### GUI Configuration
1. **Network and Sharing Center**
   - Open Control Panel → Network and Sharing Center
   - Click "Change adapter settings"
   - Right-click network adapter → Properties
   - Select "Internet Protocol Version 4 (TCP/IPv4)"
   - Click "Properties"

#### Command Line Configuration
```cmd
# Show current IP configuration
ipconfig /all
ipconfig /displaydns

# Set static IP (requires elevated command prompt)
netsh interface ip set address "Ethernet" static 192.168.1.100 255.255.255.0 192.168.1.1

# Set multiple IP addresses
netsh interface ip add address "Ethernet" 192.168.1.101 255.255.255.0
netsh interface ip add address "Ethernet" 192.168.1.102 255.255.255.0

# Set DHCP
netsh interface ip set address "Ethernet" dhcp

# Reset IP configuration
netsh winsock reset
netsh int ip reset
ipconfig /release
ipconfig /renew
```

#### PowerShell Configuration
```powershell
# Show network adapters
Get-NetAdapter
Get-NetIPConfiguration

# Set static IP
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 192.168.1.100 -PrefixLength 24 -DefaultGateway 192.168.1.1

# Set multiple IP addresses
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 192.168.1.101 -PrefixLength 24
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 192.168.1.102 -PrefixLength 24

# Set DHCP
Set-NetIPInterface -InterfaceAlias "Ethernet" -Dhcp Enabled
Remove-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 192.168.1.100
```

### Windows Server 2008-2025 Configuration

#### Server Manager Configuration
1. **Server Manager → Local Server**
2. Click "Ethernet" or network interface
3. Configure IPv4/IPv6 settings
4. Set static or DHCP configuration

#### Advanced Server Configuration
```cmd
# Show advanced IP configuration
ipconfig /allcompartments /all
netsh interface ipv4 show config
netsh interface ipv6 show config

# Configure advanced settings
netsh interface ipv4 set subinterface "Ethernet" mtu=1500 store=persistent
netsh interface ipv4 set subinterface "Ethernet" metric=10 store=persistent

# Configure IPv6
netsh interface ipv6 add address "Ethernet" 2001:db8::1/64
netsh interface ipv6 add route 2001:db8::/32 "Ethernet" 2001:db8::1

# Configure interface metrics
netsh interface ipv4 set interface "Ethernet" metric=10
```

#### PowerShell Server Configuration
```powershell
# Configure multiple IP addresses
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 192.168.1.101 -PrefixLength 24
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 192.168.1.102 -PrefixLength 24

# Configure IPv6
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 2001:db8::1 -PrefixLength 64

# Configure interface metrics
Set-NetIPInterface -InterfaceAlias "Ethernet" -InterfaceMetric 10

# Configure DNS suffixes
Set-DnsClient -InterfaceAlias "Ethernet" -ConnectionSpecificSuffix "company.local"
Set-DnsClient -InterfaceAlias "Ethernet" -UseSuffixWhenRegistering $true
```

## Windows Route Configuration

### Static Routes
```cmd
# Show routing table
route print
netstat -rn

# Add static route
route add 192.168.2.0 mask 255.255.255.0 192.168.1.254
route add 10.0.0.0 mask 255.0.0.0 192.168.1.254 metric 10

# Add persistent route
route -p add 192.168.2.0 mask 255.255.255.0 192.168.1.254

# Add IPv6 route
netsh interface ipv6 add route 2001:db8::/32 "Ethernet" 2001:db8::1

# Delete route
route delete 192.168.2.0

# Modify route
route change 192.168.2.0 mask 255.255.255.0 192.168.1.253 metric 5
```

### PowerShell Routing
```powershell
# Show routing table
Get-NetRoute
Get-NetRoute -InterfaceAlias "Ethernet"

# Add static route
New-NetRoute -DestinationPrefix "192.168.2.0/24" -InterfaceAlias "Ethernet" -NextHop "192.168.1.254"

# Add IPv6 route
New-NetRoute -DestinationPrefix "2001:db8::/32" -InterfaceAlias "Ethernet" -NextHop "2001:db8::1"

# Remove route
Remove-NetRoute -DestinationPrefix "192.168.2.0/24" -InterfaceAlias "Ethernet"

# Configure interface metrics
Set-NetIPInterface -InterfaceAlias "Ethernet" -InterfaceMetric 10
```

### Windows Server Routing
```cmd
# Install Routing and Remote Access role
Install-WindowsFeature RemoteAccess -IncludeManagementTools

# Configure routing
netsh routing ip nat install
netsh routing ip nat add interface "Internal" private
netsh routing ip nat add interface "External" public

# Configure NAT
netsh routing ip nat add interface "External" private
netsh routing ip nat add interface "Internal" private
```

## Windows DNS Configuration

### DNS Client Configuration
```cmd
# Show DNS configuration
ipconfig /displaydns
nslookup
nslookup www.google.com
nslookup www.google.com 8.8.8.8

# Set DNS servers
netsh interface ip set dns "Ethernet" static 8.8.8.8 primary
netsh interface ip add dns "Ethernet" 8.8.4.4 index=2

# Set DNS suffix
netsh interface ip set dns "Ethernet" static 8.8.8.8 primary
netsh interface ip set dnsservers "Ethernet" static 8.8.8.8 primary

# Flush DNS cache
ipconfig /flushdns

# Set DHCP DNS
netsh interface ip set dns "Ethernet" dhcp
```

### PowerShell DNS Configuration
```powershell
# Configure DNS client
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses 8.8.8.8,8.8.4.4

# Configure DNS search suffix
Set-DnsClientGlobalSetting -SuffixSearchList "company.local","corp.company.com"

# Configure DNS registration
Set-DnsClient -InterfaceAlias "Ethernet" -RegisterThisConnectionsAddress $true

# Flush DNS cache
Clear-DnsClientCache
```

### DNS Server Configuration (Windows Server)
```cmd
# Install DNS Server role
Install-WindowsFeature DNS -IncludeManagementTools

# Create forward lookup zone
Add-DnsServerPrimaryZone -Name "company.local" -ZoneFile "company.local.dns"

# Create A record
Add-DnsServerResourceRecord -ZoneName "company.local" -Name "server1" -A -IPv4Address "192.168.1.10"

# Create CNAME record
Add-DnsServerResourceRecord -ZoneName "company.local" -Name "www" -CName -HostNameAlias "server1.company.local"

# Configure forwarders
Add-DnsServerForwarder -IPAddress 8.8.8.8 -IPAddress 8.8.4.4

# Show DNS zones
Get-DnsServerZone
Show-DnsServerZone -Name "company.local"
```

## Linux IP Configuration

### Ubuntu/Debian IP Configuration

#### NetworkManager Configuration
```bash
# Show network configuration
nmcli device status
nmcli connection show
nmcli device show eth0

# Configure static IP
nmcli connection modify "Wired connection 1" ipv4.addresses 192.168.1.100/24
nmcli connection modify "Wired connection 1" ipv4.gateway 192.168.1.1
nmcli connection modify "Wired connection 1" ipv4.method manual

# Configure multiple IP addresses
nmcli connection modify "Wired connection 1" ipv4.addresses "192.168.1.100/24,192.168.1.101/24"

# Configure DHCP
nmcli connection modify "Wired connection 1" ipv4.method auto

# Apply configuration
nmcli connection down "Wired connection 1"
nmcli connection up "Wired connection 1"
```

#### /etc/network/interfaces Configuration
```bash
# Edit interfaces file
sudo nano /etc/network/interfaces

# Static configuration
auto eth0
iface eth0 inet static
    address 192.168.1.100
    netmask 255.255.255.0
    gateway 192.168.1.1

# Multiple IP addresses
auto eth0
iface eth0 inet static
    address 192.168.1.100
    netmask 255.255.255.0
    gateway 192.168.1.1

auto eth0:1
iface eth0:1 inet static
    address 192.168.1.101
    netmask 255.255.255.0

# DHCP configuration
auto eth0
iface eth0 inet dhcp

# Apply configuration
sudo systemctl restart networking
sudo ifdown eth0 && sudo ifup eth0
```

#### systemd-networkd Configuration
```bash
# Create network configuration
sudo nano /etc/systemd/network/10-static.network

[Match]
Name=eth0

[Network]
Address=192.168.1.100/24
Gateway=192.168.1.1

# Multiple addresses
[Network]
Address=192.168.1.100/24
Address=192.168.1.101/24
Gateway=192.168.1.1

# Enable and start
sudo systemctl enable systemd-networkd
sudo systemctl start systemd-networkd
```

### CentOS/RHEL IP Configuration

#### NetworkManager Configuration
```bash
# Show network configuration
nmcli device status
nmcli connection show
nmcli device show eth0

# Configure static IP
nmcli connection modify "System eth0" ipv4.addresses 192.168.1.100/24
nmcli connection modify "System eth0" ipv4.gateway 192.168.1.1
nmcli connection modify "System eth0" ipv4.method manual

# Apply configuration
nmcli connection reload
nmcli connection up "System eth0"
```

#### ifcfg Files Configuration
```bash
# Edit network configuration
sudo nano /etc/sysconfig/network-scripts/ifcfg-eth0

# Static configuration
DEVICE=eth0
BOOTPROTO=static
ONBOOT=yes
IPADDR=192.168.1.100
NETMASK=255.255.255.0
GATEWAY=192.168.1.1

# Multiple IP addresses
DEVICE=eth0
BOOTPROTO=static
ONBOOT=yes
IPADDR=192.168.1.100
NETMASK=255.255.255.0
GATEWAY=192.168.1.1
IPADDR1=192.168.1.101
NETMASK1=255.255.255.0

# DHCP configuration
DEVICE=eth0
BOOTPROTO=dhcp
ONBOOT=yes

# Apply configuration
sudo systemctl restart network
```

### Linux IP Commands
```bash
# Show IP configuration
ip addr show
ip -4 addr show
ip -6 addr show
ifconfig -a

# Configure IP address
sudo ip addr add 192.168.1.100/24 dev eth0
sudo ip addr add 192.168.1.101/24 dev eth0
sudo ip addr del 192.168.1.100/24 dev eth0

# Configure IPv6
sudo ip addr add 2001:db8::1/64 dev eth0

# Show interface statistics
ip -s link show
cat /proc/net/dev

# Configure interface up/down
sudo ip link set eth0 up
sudo ip link set eth0 down
```

## Linux Route Configuration

### Static Routes
```bash
# Show routing table
ip route show
ip -6 route show
route -n
netstat -rn

# Add static route
sudo ip route add 192.168.2.0/24 via 192.168.1.254 dev eth0
sudo ip route add 10.0.0.0/8 via 192.168.1.254

# Add default route
sudo ip route add default via 192.168.1.254 dev eth0

# Add IPv6 route
sudo ip -6 route add 2001:db8::/32 via 2001:db8::1 dev eth0

# Delete route
sudo ip route del 192.168.2.0/24
```

### Persistent Routes
```bash
# Ubuntu/Debian persistent route
sudo nano /etc/network/interfaces

# Add to interface configuration
up ip route add 192.168.2.0/24 via 192.168.1.254
up ip route add 10.0.0.0/8 via 192.168.1.254

# CentOS/RHEL persistent route
sudo nano /etc/sysconfig/network-scripts/route-eth0

192.168.2.0/24 via 192.168.1.254
10.0.0.0/8 via 192.168.1.254

# Apply configuration
sudo systemctl restart network
```

### Advanced Routing
```bash
# Show routing policy
ip rule show
ip route show table all

# Add routing table
sudo ip route add table 100 default via 192.168.1.254
sudo ip rule add from 192.168.1.100 table 100

# Configure policy routing
sudo nano /etc/iproute2/rt_tables

100  custom_route

# Add rule
sudo ip rule add from 192.168.1.100 table custom_route
sudo ip route add default via 192.168.1.254 table custom_route
```

### Linux Router Configuration
```bash
# Enable IP forwarding
sudo nano /etc/sysctl.conf

net.ipv4.ip_forward=1
net.ipv6.conf.all.forwarding=1

# Apply changes
sudo sysctl -p

# Configure NAT
sudo iptables -t nat -A POSTROUTING -s 192.168.1.0/24 -o eth0 -j MASQUERADE

# Save iptables rules
sudo iptables-save > /etc/iptables/rules.v4
```

## Linux DNS Configuration

### resolv.conf Configuration
```bash
# Edit resolv.conf
sudo nano /etc/resolv.conf

# DNS configuration
nameserver 8.8.8.8
nameserver 8.8.4.4
search company.local
domain company.local

# Test DNS
nslookup www.google.com
dig www.google.com
host www.google.com
```

### systemd-resolved Configuration
```bash
# Configure systemd-resolved
sudo nano /etc/systemd/resolved.conf

[Resolve]
DNS=8.8.8.8 8.8.4.4
Domains=company.local
LLMNR=no
DNSSEC=no

# Enable and start
sudo systemctl enable systemd-resolved
sudo systemctl start systemd-resolved

# Create symlink for resolv.conf
sudo ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf

# Test DNS
systemd-resolve --status
systemd-resolve www.google.com
```

### NetworkManager DNS Configuration
```bash
# Configure DNS via NetworkManager
nmcli connection modify "Wired connection 1" ipv4.dns "8.8.8.8 8.8.4.4"
nmcli connection modify "Wired connection 1" ipv4.dns-search "company.local"

# Apply configuration
nmcli connection down "Wired connection 1"
nmcli connection up "Wired connection 1"
```

### DNS Server Configuration (BIND)
```bash
# Install BIND
sudo apt-get install bind9  # Ubuntu/Debian
sudo yum install bind9      # CentOS/RHEL

# Configure forward zone
sudo nano /etc/bind/db.company.local

$TTL 86400
@   IN  SOA ns1.company.local. admin.company.local. (
        2023120701  ; Serial
        3600        ; Refresh
        1800        ; Retry
        604800      ; Expire
        86400 )     ; Minimum TTL

; Name servers
@       IN  NS  ns1.company.local.
ns1     IN  A   192.168.1.10

; Host records
server1 IN  A   192.168.1.10
server2 IN  A   192.168.1.11
www     IN  CNAME   server1.company.local.

# Configure BIND options
sudo nano /etc/bind/named.conf.options

options {
    directory "/var/cache/bind";
    forwarders {
        8.8.8.8;
        8.8.4.4;
    };
    dnssec-validation auto;
    auth-nxdomain no;
    listen-on-v6 { any; };
}

# Test DNS configuration
named-checkzone company.local /etc/bind/db.company.local
systemctl restart bind9
```

## macOS IP Configuration

### System Preferences Configuration
1. **System Preferences → Network**
2. Select network interface
3. Configure IPv4: Manual/DHCP
4. Set IP address, subnet mask, router

### Command Line Configuration
```bash
# Show network configuration
ifconfig -a
netstat -rn
networksetup -listallhardwareports
networksetup -getinfo "Ethernet"

# Configure static IP
sudo networksetup -setmanual "Ethernet" 192.168.1.100 255.255.255.0 192.168.1.1

# Configure multiple IP addresses
sudo ifconfig en0 alias 192.168.1.101 netmask 255.255.255.0
sudo ifconfig en0 alias 192.168.1.102 netmask 255.255.255.0

# Configure DHCP
sudo networksetup -setdhcp "Ethernet"

# Show network service
networksetup -getinfo "Ethernet"
```

### macOS Advanced Configuration
```bash
# Configure IPv6
sudo ifconfig en0 inet6 add 2001:db8::1/64

# Show ARP table
arp -a
netstat -rn

# Configure interface metrics
sudo ifconfig en0 metric 10

# Remove IP alias
sudo ifconfig en0 -alias 192.168.1.101
```

## macOS Route Configuration

### Static Routes
```bash
# Show routing table
netstat -rn
route -n get default

# Add static route
sudo route add -net 192.168.2.0/24 192.168.1.254

# Add default route
sudo route add default 192.168.1.254

# Add IPv6 route
sudo route add -inet6 2001:db8::/32 2001:db8::1

# Delete route
sudo route delete -net 192.168.2.0/24
sudo route delete default

# Show route details
route -n get 192.168.2.0
netstat -rn | grep 192.168.2
```

### Persistent Routes
```bash
# Create startup script for persistent routes
sudo nano /Library/LaunchDaemons/com.company.staticroutes.plist

<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.company.staticroutes</string>
    <key>ProgramArguments</key>
    <array>
        <string>/bin/bash</string>
        <string>-c</string>
        <string>route add -net 192.168.2.0/24 192.168.1.254</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
</dict>
</plist>

# Load the launch daemon
sudo launchctl load /Library/LaunchDaemons/com.company.staticroutes.plist
```

## macOS DNS Configuration

### System Preferences DNS
1. **System Preferences → Network → Advanced → DNS**
2. Add/remove DNS servers
3. Configure search domains

### Command Line DNS Configuration
```bash
# Configure DNS servers
sudo networksetup -setdnsservers "Ethernet" 8.8.8.8 8.8.4.4

# Configure search domains
sudo networksetup -setsearchdomains "Ethernet" company.local

# Show DNS configuration
networksetup -getdnsservers "Ethernet"
networksetup -getsearchdomains "Ethernet"

# Flush DNS cache
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder
```

### scutil DNS Configuration
```bash
# Show DNS configuration
scutil --dns

# Configure DNS via scutil
sudo scutil
> open
> d.init
> d.add ServerAddresses * 8.8.8.8 8.8.4.4
> d.add SearchDomains * company.local
> set State:/Network/Service/eth0/DNS
> quit
```

### DNS Testing
```bash
# Test DNS resolution
nslookup www.google.com
dig www.google.com
host www.google.com

# Test with specific server
nslookup www.google.com 8.8.8.8
dig @8.8.8.8 www.google.com
```

## Verification Commands

### IP Configuration Verification
```bash
# Windows
ipconfig /all
netsh interface ipv4 show config
netsh interface ipv6 show config

# Linux
ip addr show
ifconfig -a
cat /proc/net/dev

# macOS
ifconfig -a
networksetup -getinfo "Ethernet"
```

### Route Verification
```bash
# Windows
route print
netstat -rn

# Linux
ip route show
route -n
netstat -rn

# macOS
netstat -rn
route -n get default
```

### DNS Verification
```bash
# Windows
ipconfig /displaydns
nslookup www.google.com

# Linux
systemd-resolve --status
dig www.google.com
cat /etc/resolv.conf

# macOS
scutil --dns
networksetup -getdnsservers "Ethernet"
```

### Connectivity Testing
```bash
# Ping tests
ping 192.168.1.1
ping www.google.com

# Traceroute tests
tracert 192.168.1.1  # Windows
traceroute 192.168.1.1  # Linux/macOS

# DNS tests
nslookup www.google.com
dig www.google.com
```

## Troubleshooting

### IP Configuration Issues
```bash
# Windows
ipconfig /release
ipconfig /renew
netsh winsock reset
netsh int ip reset

# Linux
sudo dhclient -r eth0
sudo dhclient eth0
sudo systemctl restart networking

# macOS
sudo ipconfig set en0 DHCP
sudo dscacheutil -flushcache
```

### Route Issues
```bash
# Windows
route delete 192.168.2.0
route add 192.168.2.0 mask 255.255.255.0 192.168.1.254

# Linux
sudo ip route del 192.168.2.0/24
sudo ip route add 192.168.2.0/24 via 192.168.1.254

# macOS
sudo route delete -net 192.168.2.0/24
sudo route add -net 192.168.2.0/24 192.168.1.254
```

### DNS Issues
```bash
# Windows
ipconfig /flushdns
nslookup www.google.com

# Linux
sudo systemd-resolve --flush-caches
dig www.google.com

# macOS
sudo dscacheutil -flushcache
nslookup www.google.com
```

### Network Interface Issues
```bash
# Windows
netsh interface set interface "Ethernet" enable
netsh interface reset

# Linux
sudo ip link set eth0 up
sudo systemctl restart networking

# macOS
sudo ifconfig en0 up
```

---

This guide provides focused IP configuration, routing, and DNS setup procedures for Windows, Linux distributions, and macOS, covering both server and client configurations with practical examples for network and system administrators.
