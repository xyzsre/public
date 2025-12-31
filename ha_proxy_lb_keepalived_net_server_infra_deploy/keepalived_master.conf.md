# Keepalived Master Configuration File Documentation (`keepalived_master.conf`)

This document provides a detailed explanation of the `keepalived_master.conf` configuration file. This file configures a Keepalived node to act as the primary `MASTER` in a simple high-availability setup.

---

## `vrrp_script chk_haproxy` Section

This section defines a script that Keepalived will use to monitor the health of the HAProxy service. This is a common pattern to ensure that the service being load-balanced is actually running on the active node.

```
vrrp_script chk_haproxy {
    script "killall -0 haproxy"
    interval 2
    weight 2
}
```

### Line-by-Line Explanation

- **`script "killall -0 haproxy"`**
    - **What it is:** This command checks for the existence of a running `haproxy` process. The `killall -0` command sends a signal 0, which doesn't harm the process but fails if the process does not exist.
    - **Why we use it:** It's a lightweight and reliable way to confirm that the HAProxy service is active. If HAProxy crashes, this script will fail, signaling a problem to Keepalived.

- **`interval 2`**
    - **What it is:** This specifies that the `script` should be executed every 2 seconds.
    - **Why we use it:** A short interval allows for quick detection of a service failure, enabling a fast failover.

- **`weight 2`**
    - **What it is:** If the `script` fails, the priority of this VRRP instance will be reduced by this amount (2 in this case).
    - **Why we use it:** This is a key mechanism for triggering a failover. When the master's priority drops below the backup's priority, the backup takes over.

---

## `vrrp_instance VI_1` Section

This section defines the VRRP instance, which is the core of the high-availability configuration.

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

- **`state MASTER`**
    - **What it is:** This explicitly sets the initial state of this node to `MASTER`.
    - **Why we use it:** This node is intended to be the primary server in the cluster. It will hold the virtual IP address as long as it is healthy and has the highest priority.

- **`interface enp0s8`**
    - **What it is:** The network interface on which Keepalived will manage the VRRP protocol.
    - **Why we use it:** Keepalived needs to bind to a physical network interface to send and receive VRRP advertisement packets.

- **`virtual_router_id 51`**
    - **What it is:** A unique number (from 0-255) that identifies this virtual router group. 
    - **Why we use it:** All nodes in the same failover cluster (e.g., this master and its corresponding backup) must share the same `virtual_router_id` to communicate.

- **`priority 101`**
    - **What it is:** The priority of this node within the virtual router group. The node with the highest priority becomes the `MASTER`.
    - **Why we use it:** By setting a higher priority (e.g., 101) than its backup peer (which might have a priority of 100), this node establishes itself as the default master.

- **`advert_int 1`**
    - **What it is:** The interval in seconds between sending VRRP advertisements.
    - **Why we use it:** The master sends these packets to let other nodes know it is still alive. If the backup node stops receiving these advertisements, it will assume the master has failed and initiate a failover.

- **`authentication` block**
    - **What it is:** Configures authentication for VRRP packets.
    - **`auth_type PASS`**: Uses a simple plain-text password.
    - **`auth_pass 1111`**: The password. This must be the same on all nodes in the virtual router group for them to accept each other's packets.
    - **Why we use it:** This is a basic security measure to prevent rogue devices on the network from participating in the VRRP election.

- **`virtual_ipaddress` block**
    - **What it is:** Defines the virtual IP address (VIP) that this VRRP instance will manage.
    - **`192.168.56.100`**: The shared IP address. This is the address that clients will use to access the service. It will be active on the current `MASTER` node.

- **`track_script` block**
    - **What it is:** This links the VRRP instance to a monitoring script.
    - **`chk_haproxy`**: The name of the `vrrp_script` to track.
    - **Why we use it:** This is what enables application-aware high availability. If the `chk_haproxy` script fails, Keepalived knows that the service (not just the server) is down. It will then lower its own priority by the `weight` amount, allowing a healthy backup node to take over the `MASTER` role.
