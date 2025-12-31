# Keepalived LB2 Configuration File Documentation (`keepalived.lb2.conf`)

This document provides a detailed explanation of the `keepalived.lb2.conf` configuration file. This file configures the second load balancer (lb2) in a high-availability setup, acting as a counterpart to `lb1`.

---

## `vrrp_script chk_haproxy` Section

This section is identical to the one in `keepalived.lb1.conf`. It defines a script to monitor the health of the HAProxy service.

```
vrrp_script chk_haproxy {
    script "killall -0 haproxy"
    interval 2
    weight 2
}
```

### Line-by-Line Explanation

- **`script "killall -0 haproxy"`**: Checks if the `haproxy` process is running.
- **`interval 2`**: Runs the check every 2 seconds.
- **`weight 2`**: Reduces the node's priority by 2 if the script fails, which can trigger a failover.

---

## `vrrp_instance VI_1` Section (VIP: 192.168.56.100)

This section configures the first virtual IP address. For this VIP, `lb2` is the **BACKUP**.

```
vrrp_instance VI_1 {
    state BACKUP
    interface enp0s8
    virtual_router_id 51
    priority 100
    advert_int 1
    authentication {
        auth_type PASS
        auth_pass 1111
    }
    virtual_ipaddress {
        192.168.56.100
    }
    track_script {
        chk_haproxy
    }
}
```

### Line-by-Line Explanation

- **`state BACKUP`**: This node is the secondary (backup) for this virtual IP.
- **`interface enp0s8`**: The network interface to use.
- **`virtual_router_id 51`**: Unique ID for this virtual router group. It matches the `virtual_router_id` in `lb1`'s configuration for this VIP, which is essential for them to work as a pair.
- **`priority 100`**: The priority for this node. It is lower than `lb1`'s priority (101) for this VIP, so `lb1` will be the master by default.
- **`authentication`**: Simple password authentication. The password must match the one used by `lb1` for this VRRP instance.
- **`virtual_ipaddress`**: The virtual IP address `192.168.56.100` is managed by this instance.
- **`track_script`**: Monitors the `chk_haproxy` script. If `lb1` fails, this node will take over as master, provided its own HAProxy is running.

---

## `vrrp_instance VI_2` Section (VIP: 192.168.56.200)

This section configures the second virtual IP address. For this VIP, `lb2` is the **MASTER**.

```
vrrp_instance VI_2 {
    state MASTER
    interface enp0s8
    virtual_router_id 52
    priority 101
    advert_int 1
    authentication {
        auth_type PASS
        auth_pass 2222
    }
    virtual_ipaddress {
        192.168.56.200
    }
    track_script {
        chk_haproxy
    }
}
```

### Line-by-Line Explanation

- **`state MASTER`**: This node is the primary (master) for this virtual IP.
- **`interface enp0s8`**: The network interface to use.
- **`virtual_router_id 52`**: Unique ID for this virtual router group. It matches the `virtual_router_id` in `lb1`'s configuration for this VIP.
- **`priority 101`**: The priority for this node. It is higher than `lb1`'s priority (100) for this VIP, so `lb2` will be the master by default for this VIP.
- **`authentication`**: Simple password authentication. The password must match the one used by `lb1` for this VRRP instance.
- **`virtual_ipaddress`**: The virtual IP address `192.168.56.200` is managed by this instance.
- **`track_script`**: Monitors the `chk_haproxy` script. If HAProxy on this node fails, its priority will be lowered, and `lb1` will take over as master for this VIP.
