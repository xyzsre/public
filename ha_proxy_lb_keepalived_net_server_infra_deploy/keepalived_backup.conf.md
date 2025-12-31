# Keepalived Backup Configuration File Documentation (`keepalived_backup.conf`)

This document provides a detailed explanation of the `keepalived_backup.conf` configuration file. Keepalived is a routing software written in C. The main goal of this project is to provide simple and robust facilities for load balancing and high-availability to Linux system and Linux based infrastructures.

---

## `vrrp_script chk_haproxy` Section

This section defines a script that Keepalived will run to monitor the health of another service, in this case, HAProxy.

```
vrrp_script chk_haproxy {
    script "killall -0 haproxy"
    interval 2
    weight 2
}
```

### Line-by-Line Explanation

- **`script "killall -0 haproxy"`**
    - **What it is:** This is the command that will be executed. `killall -0 haproxy` sends a signal 0 to the `haproxy` process. This signal doesn't actually kill the process but is used to check if the process exists and is running.
    - **Why we use it:** It's a lightweight way to verify that the HAProxy service is still alive. If the command returns a success (exit code 0), Keepalived knows HAProxy is running. If it fails, HAProxy is considered down.

- **`interval 2`**
    - **What it is:** This sets the interval (in seconds) at which the script is executed.
    - **Why we use it:** Frequent checks ensure that a failure is detected quickly. An interval of 2 seconds provides a good balance between responsiveness and system load.

- **`weight 2`**
    - **What it is:** This value is used to adjust the priority of the Keepalived node. If this script fails, the priority of the node will be reduced by this weight.
    - **Why we use it:** This is crucial for failover. If HAProxy fails on the MASTER node, its priority will be reduced, allowing the BACKUP node (with a higher effective priority) to take over.

---

## `vrrp_instance VI_1` Section

This section defines a VRRP (Virtual Router Redundancy Protocol) instance. VRRP is a protocol that provides automatic failover of a router.

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

- **`state BACKUP`**
    - **What it is:** This sets the initial state of this Keepalived instance to `BACKUP`.
    - **Why we use it:** In a high-availability pair, one node is the `MASTER` and the other is the `BACKUP`. The `MASTER` is the active router, while the `BACKUP` is on standby, ready to take over if the `MASTER` fails.

- **`interface enp0s8`**
    - **What it is:** This specifies the network interface that Keepalived will use to send and receive VRRP advertisements.
    - **Why we use it:** Keepalived needs to be bound to a specific network interface to communicate with other Keepalived nodes.

- **`virtual_router_id 51`**
    - **What it is:** This is a unique identifier for the virtual router group. All Keepalived nodes in the same high-availability cluster must have the same `virtual_router_id`.
    - **Why we use it:** It allows Keepalived nodes to recognize each other as part of the same group.

- **`priority 100`**
    - **What it is:** This is the priority of this Keepalived instance. The node with the highest priority becomes the `MASTER`.
    - **Why we use it:** In this configuration, the `BACKUP` node has a priority of 100. The `MASTER` node will have a higher priority (e.g., 150). If the `MASTER` fails, this `BACKUP` node will take over.

- **`advert_int 1`**
    - **What it is:** This is the interval (in seconds) at which this node sends VRRP advertisements to other nodes in the cluster.
    - **Why we use it:** Frequent advertisements ensure that other nodes are aware of this node's status. If the `MASTER` stops sending advertisements, the `BACKUP` nodes will know that it has failed.

- **`authentication` block**
    - **What it is:** This block configures authentication for VRRP advertisements.
    - **`auth_type PASS`:** Uses a simple password for authentication.
    - **`auth_pass 1111`:** The password to use. All nodes in the cluster must use the same password.
    - **Why we use it:** It's a security measure to prevent unauthorized machines from participating in the VRRP cluster.

- **`virtual_ipaddress` block**
    - **What it is:** This block defines the virtual IP address (VIP) that is managed by Keepalived. This is the IP address that clients will connect to.
    - **`192.168.56.100`:** The VIP. This IP address will be assigned to the `MASTER` node's network interface.
    - **Why we use it:** The VIP provides a single, consistent entry point for clients, regardless of which physical server is currently active.

- **`track_script` block**
    - **What it is:** This block tells Keepalived to monitor the status of the script defined in the `vrrp_script` section.
    - **`chk_haproxy`:** The name of the script to track.
    - **Why we use it:** This is the key to application-level failover. If the `chk_haproxy` script fails (meaning the HAProxy service is down), Keepalived will trigger a failover, even if the server itself is still running.
