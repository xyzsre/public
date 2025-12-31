# Keepalived LB1 Configuration File Documentation (`keepalived.lb1.conf`)

This document provides a detailed explanation of the `keepalived.lb1.conf` configuration file. This file configures the first load balancer (lb1) in a high-availability setup.

---

## `vrrp_script chk_haproxy` Section

This section defines a script that Keepalived will run to monitor the health of the HAProxy service.

```
vrrp_script chk_haproxy {
    script "killall -0 haproxy"
    interval 2
    weight 2
}
```

### Line-by-Line Explanation

- **`script "killall -0 haproxy"`**: Checks if the `haproxy` process is running without killing it.
- **`interval 2`**: Runs the script every 2 seconds.
- **`weight 2`**: If the script fails (HAProxy is down), the priority of this node is reduced by 2.

---

## `vrrp_instance VI_1` Section (VIP: 192.168.56.100)

This section configures the first virtual IP address. For this VIP, `lb1` is the **MASTER**.

```
vrrp_instance VI_1 {
    state MASTER
    interface enp0s8
    virtual_router_id 51
    priority 101
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

- **`state MASTER`**: This node is the primary (master) for this virtual IP.
- **`interface enp0s8`**: The network interface to use.
- **`virtual_router_id 51`**: Unique ID for this virtual router group. Must match on the backup server for this VIP.
- **`priority 101`**: The priority for this node. A higher number wins mastership. This is higher than the corresponding backup server's priority.
- **`advert_int 1`**: Sends VRRP advertisements every 1 second.
- **`authentication`**: Simple password authentication for security.
- **`virtual_ipaddress`**: The virtual IP address `192.168.56.100` is managed by this instance.
- **`track_script`**: Monitors the `chk_haproxy` script. If HAProxy fails, this node may yield mastership to the backup.

---

## `vrrp_instance VI_2` Section (VIP: 192.168.56.200)

This section configures the second virtual IP address. For this VIP, `lb1` is the **BACKUP**.

```
vrrp_instance VI_2 {
    state BACKUP
    interface enp0s8
    virtual_router_id 52
    priority 100
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

- **`state BACKUP`**: This node is the secondary (backup) for this virtual IP.
- **`interface enp0s8`**: The network interface to use.
- **`virtual_router_id 52`**: Unique ID for this virtual router group. Must match on the master server for this VIP.
- **`priority 100`**: The priority for this node. This is lower than the corresponding master server's priority.
- **`authentication`**: Simple password authentication. Note the different password for this VRRP group.
- **`virtual_ipaddress`**: The virtual IP address `192.168.56.200` is managed by this instance.
- **`track_script`**: Monitors the `chk_haproxy` script. If the master for this VIP fails, and this node's HAProxy is healthy, it can take over.
